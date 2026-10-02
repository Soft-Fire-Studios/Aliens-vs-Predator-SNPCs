AddCSLuaFile()

if !AVP or !AVP.TDM then
    include("autorun/vj_avp_tdm_shared.lua")
end

ENT.Base = "base_gmodentity"
ENT.Type = "anim"
ENT.PrintName = "Species Team Deathmatch"
ENT.Author = "Cpt. Hazama"
ENT.Category = "Aliens vs Predator"
ENT.Spawnable = false
ENT.AdminOnly = true
ENT.AutomaticFrameAdvance = true

ENT.VJ_AVP_TDM = true

local TDM = AVP.TDM
local TDM_SPAWN_CAMP_RADIUS_SQR = 1024 * 1024
local TDM_SAFE_RESPAWN_ENEMY_DIST_SQR = 1400 * 1400
local TDM_SAFE_RESPAWN_OCCUPIED_DIST_SQR = 160 * 160
local TDM_NEUTRAL_NODE_SPAWN_CLEARANCE_SQR = 600 * 600
local TDM_SPAWN_RESERVATION_TIME = 1.0
local TDM_SPAWN_MIN_SEPARATION_SQR = 112 * 112
local TDM_SPAWN_FLOOR_NORMAL_Z = 0.60
local TDM_SPAWN_SEARCH_RADII = {0, 48, 80, 112, 144}

function ENT:SetupDataTables()
    self:NetworkVar("Bool", "MatchActive")
    self:NetworkVar("Bool", "LobbyReadyLocked")
    self:NetworkVar("Float", "LobbyEndTime")
    self:NetworkVar("Float", "MatchEndTime")
    self:NetworkVar("Int", "MarineScore")
    self:NetworkVar("Int", "XenoScore")
    self:NetworkVar("Int", "PredatorScore")
end

function ENT:UpdateTransmitState()
    return TRANSMIT_ALWAYS
end

if CLIENT then
    function ENT:Draw()
        return false
    end

    function ENT:DrawTranslucent()
        return false
    end

    local function StopMatchTrack(ent)
        if IsValid(ent._AVPTDMTrack) then
            ent._AVPTDMTrack:Stop()
        end
        ent._AVPTDMTrack = nil
        ent._AVPTDMTrackPath = nil
        ent._AVPTDMTrackEnds = 0
    end

    local function PlayMatchTrack(ent, path, volume, looped)
        if ent._AVPTDMTrackPath == path && IsValid(ent._AVPTDMTrack) then return end
        StopMatchTrack(ent)
        ent._AVPTDMTrackPath = path

        sound.PlayFile("sound/" .. path, "noplay noblock", function(station, errCode, errStr)
            if !IsValid(ent) then
                if IsValid(station) then station:Stop() end
                return
            end
            if ent._AVPTDMTrackPath != path then
                if IsValid(station) then station:Stop() end
                return
            end
            if !IsValid(station) then
                print("[AVP TDM] Error playing match music!", errCode, errStr)
                return
            end
            station:EnableLooping(looped == true)
            station:SetPlaybackRate(1)
            station:SetVolume(volume or 0.4)
            station:Play()
            ent._AVPTDMTrack = station
            local len = station:GetLength()
            ent._AVPTDMTrackEnds = CurTime() + ((len && len > 0) && len or 300)
        end)
    end

    function ENT:Think()
        local ply = LocalPlayer()
        local participating = IsValid(ply) && ply:GetNW2Bool("AVP_TDM_Participant", false)
        local musicEnabled = !GetConVar("vj_avp_survival_music") or GetConVar("vj_avp_survival_music"):GetBool()

        if !self:GetMatchActive() or !participating or !musicEnabled then
            StopMatchTrack(self)
            return
        end

        local remaining = math.max(0, self:GetMatchEndTime() - CurTime())
        if remaining <= 60 then
            PlayMatchTrack(self, TDM.FinalMinuteTrack, 0.4, true)
            return
        end

        if !IsValid(self._AVPTDMTrack) or CurTime() >= (self._AVPTDMTrackEnds or 0) then
            local track = TDM.SurvivalTracks[math.random(1, #TDM.SurvivalTracks)]
            PlayMatchTrack(self, track, 0.4, false)
        end
    end

    function ENT:OnRemove()
        StopMatchTrack(self)
    end

    return
end

util.AddNetworkString("VJ.AVP.TDM.OpenLobby")
util.AddNetworkString("VJ.AVP.TDM.LobbyState")
util.AddNetworkString("VJ.AVP.TDM.Action")
util.AddNetworkString("VJ.AVP.TDM.MatchStart")
util.AddNetworkString("VJ.AVP.TDM.Results")

ENT.MaxPickups = {
    [1] = 2, -- Stimpack
    [2] = 2, -- Pulse Rifle
    [3] = 2, -- Pistol
    [4] = 1, -- Shotgun
    [5] = 1, -- Flamethrower
    [6] = 1, -- Scoped Rifle
    [7] = 1, -- Smartgun
    [8] = 1, -- Grenades
}

local TEAM_SETTERS = {
    marine = function(ent, value) ent:SetMarineScore(value) end,
    xeno = function(ent, value) ent:SetXenoScore(value) end,
    predator = function(ent, value) ent:SetPredatorScore(value) end,
}

local TEAM_GETTERS = {
    marine = function(ent) return ent:GetMarineScore() end,
    xeno = function(ent) return ent:GetXenoScore() end,
    predator = function(ent) return ent:GetPredatorScore() end,
}

local function CopyAngle(ang)
    return Angle(ang.p, ang.y, ang.r)
end

local function CopyVector(vec)
    return Vector(vec.x, vec.y, vec.z)
end

local function OrderedBounds(mins, maxs)
    return Vector(
        math.min(mins.x, maxs.x),
        math.min(mins.y, maxs.y),
        math.min(mins.z, maxs.z)
    ), Vector(
        math.max(mins.x, maxs.x),
        math.max(mins.y, maxs.y),
        math.max(mins.z, maxs.z)
    )
end

function ENT:GetSpawnHull(teamID, setEnt)
    local radius = teamID == "marine" && 20 or 22
    local height = 76

    if IsValid(setEnt) then
        local mins, maxs = setEnt:GetCollisionBounds()
        if mins && maxs then
            mins, maxs = OrderedBounds(mins, maxs)
            local ex = math.max(math.abs(mins.x), math.abs(maxs.x))
            local ey = math.max(math.abs(mins.y), math.abs(maxs.y))
            local zSpan = maxs.z - mins.z
            if ex >= 8 && ex <= 40 then radius = math.max(radius, ex) end
            if ey >= 8 && ey <= 40 then radius = math.max(radius, ey) end
            if zSpan >= 24 && zSpan <= 96 then height = math.max(height, zSpan) end
        end
    end

    radius = math.Clamp(radius, 18, 32)
    height = math.Clamp(height, 56, 92)
    return Vector(-radius, -radius, 0), Vector(radius, radius, height)
end

function ENT:CleanupSpawnReservations()
    self.SpawnReservations = self.SpawnReservations or {}
    local curTime = CurTime()
    for i = #self.SpawnReservations, 1, -1 do
        if (self.SpawnReservations[i].Expires or 0) <= curTime then
            table.remove(self.SpawnReservations, i)
        end
    end
end

function ENT:ReserveSpawnPosition(pos)
    self:CleanupSpawnReservations()
    self.SpawnReservations[#self.SpawnReservations + 1] = {
        Pos = CopyVector(pos),
        Expires = CurTime() + TDM_SPAWN_RESERVATION_TIME,
    }
end

function ENT:IsSpawnAreaOccupied(pos, mins, maxs, ignoreEnt)
    self:CleanupSpawnReservations()
    for _, reservation in ipairs(self.SpawnReservations) do
        if reservation.Pos:DistToSqr(pos) < TDM_SPAWN_MIN_SEPARATION_SQR then
            return true
        end
    end

    local pad = Vector(8, 8, 4)
    local boxMins = pos + mins - pad
    local boxMaxs = pos + maxs + pad
    for _, ent in ipairs(ents.FindInBox(boxMins, boxMaxs)) do
        if ent != ignoreEnt && IsValid(ent) && (ent:IsNPC() or ent:IsNextBot() or ent:IsPlayer()) then
            if ent:IsPlayer() then
                if ent:Alive() && !ent:GetNoDraw() && ent:GetMoveType() != MOVETYPE_OBSERVER then return true end
            elseif ent:Health() > 0 && ent:GetSolid() != SOLID_NONE then
                return true
            end
        end
    end
    return false
end

function ENT:ResolveSpawnFloor(origin, teamID, setEnt, checkOccupancy)
    if !origin or !util.IsInWorld(origin) then return nil end
    local mins, maxs = self:GetSpawnHull(teamID, setEnt)

    local floorTr = util.TraceLine({
        start = origin + Vector(0, 0, 12),
        endpos = origin - Vector(0, 0, 128),
        filter = setEnt,
        mask = MASK_NPCSOLID_BRUSHONLY,
    })
    if !floorTr.Hit or floorTr.HitSky or floorTr.HitNormal.z < TDM_SPAWN_FLOOR_NORMAL_Z then return nil end

    local candidate = floorTr.HitPos + Vector(0, 0, 3)
    if !util.IsInWorld(candidate) or !util.IsInWorld(candidate + Vector(0, 0, maxs.z * 0.5)) then return nil end

    local clearTr = util.TraceHull({
        start = candidate,
        endpos = candidate,
        mins = mins,
        maxs = maxs,
        filter = setEnt,
        mask = MASK_NPCSOLID_BRUSHONLY,
    })
    if clearTr.StartSolid or clearTr.AllSolid then return nil end
    if checkOccupancy != false && self:IsSpawnAreaOccupied(candidate, mins, maxs, setEnt) then return nil end
    return candidate
end

function ENT:FindClearSpawnPosition(origin, teamID, setEnt, allowOffsets)
    if !origin then return nil end
    allowOffsets = allowOffsets != false

    local baseYaw = math.random(0, 359)
    for _, radius in ipairs(TDM_SPAWN_SEARCH_RADII) do
        local steps = radius == 0 && 1 or 8
        if radius > 0 && !allowOffsets then break end
        for step = 1, steps do
            local probe = CopyVector(origin)
            if radius > 0 then
                local a = math.rad(baseYaw + (step - 1) * (360 / steps))
                probe = probe + Vector(math.cos(a) * radius, math.sin(a) * radius, 0)

                local los = util.TraceLine({
                    start = origin + Vector(0, 0, 36),
                    endpos = probe + Vector(0, 0, 36),
                    filter = setEnt,
                    mask = MASK_NPCSOLID_BRUSHONLY,
                })
                if los.Hit then continue end
            end

            local candidate = self:ResolveSpawnFloor(probe, teamID, setEnt)
            if candidate then return candidate end
        end
    end
    return nil
end

function ENT:FindAnyClearMapSpawn(teamID, setEnt)
    local nodes = self.MapSpawnNodes or self:CollectSpawnNodes()
    if #nodes == 0 then return nil end

    local start = math.random(1, #nodes)
    for offset = 0, #nodes - 1 do
        local index = ((start + offset - 1) % #nodes) + 1
        local candidate = self:FindClearSpawnPosition(nodes[index], teamID, setEnt, false)
        if candidate then return candidate end
    end

    local attempts = math.min(#nodes, 24)
    for offset = 0, attempts - 1 do
        local index = ((start + offset - 1) % #nodes) + 1
        local candidate = self:FindClearSpawnPosition(nodes[index], teamID, setEnt, true)
        if candidate then return candidate end
    end
    return nil
end

local function IsWorldEntity(ent)
    return IsValid(ent) && ent:IsWorld()
end

function ENT:GetTeamHumanCount(teamID)
    local count = 0
    for _, entry in pairs(self.LobbyPlayers or {}) do
        if entry.Team == teamID then
            count = count + 1
        end
    end
    return count
end

function ENT:GetLobbyHumanCount()
    local count = 0
    for _ in pairs(self.LobbyPlayers or {}) do
        count = count + 1
    end
    return count
end

function ENT:AreAllLobbyPlayersReady()
    local count = 0
    for ply, entry in pairs(self.LobbyPlayers or {}) do
        if IsValid(ply) then
            count = count + 1
            if entry.Ready != true then
                return false
            end
        end
    end
    return count > 0
end

function ENT:CheckReadyFastStart()
    if self.MatchStarted or self.Ending or self:GetLobbyReadyLocked() then return end
    if !self:AreAllLobbyPlayersReady() then return end

    self:SetLobbyReadyLocked(true)
    self:SetLobbyEndTime(math.min(self:GetLobbyEndTime(), CurTime() + 5))
end

function ENT:FindLeastPopulatedTeam()
    local bestTeam = nil
    local bestCount = math.huge
    for _, teamID in ipairs(TDM.TeamOrder) do
        local count = self:GetTeamHumanCount(teamID)
        if count < TDM.TeamSize && count < bestCount then
            bestTeam = teamID
            bestCount = count
        end
    end
    return bestTeam
end

function ENT:AddLobbyPlayer(ply)
    if !IsValid(ply) or !ply:IsPlayer() then return false end
    if self.MatchStarted or self.Ending or self:GetLobbyReadyLocked() then return false end
    if self.LobbyPlayers[ply] then return true end
    if self:GetLobbyHumanCount() >= TDM.MaxSlots then return false end

    local teamID = self:FindLeastPopulatedTeam()
    if !teamID then return false end
    local defaultSkin = TDM.GetDefaultSkin(teamID)

    self.LobbyPlayers[ply] = {
        Player = ply,
        Name = ply:Nick(),
        SteamID64 = ply:SteamID64(),
        Team = teamID,
        Skin = defaultSkin && defaultSkin.ID or "",
        Ready = false,
    }
    return true
end

function ENT:RemoveLobbyPlayer(ply)
    self.LobbyPlayers[ply] = nil
end

function ENT:BuildLobbySlots()
    local slots = {}

    for _, teamID in ipairs(TDM.TeamOrder) do
        local humans = {}
        for ply, entry in pairs(self.LobbyPlayers) do
            if IsValid(ply) && entry.Team == teamID then
                humans[#humans + 1] = entry
            end
        end
        table.sort(humans, function(a, b)
            return (a.Name or "") < (b.Name or "")
        end)

        local teamSlots = 0
        for _, entry in ipairs(humans) do
            if teamSlots >= TDM.TeamSize then break end
            slots[#slots + 1] = {
                Name = entry.Name,
                SteamID64 = entry.SteamID64,
                Team = teamID,
                Skin = entry.Skin,
                Ready = entry.Ready == true,
                IsAI = false,
            }
            teamSlots = teamSlots + 1
        end

        local skins = TDM.Skins[teamID] or {}
        while teamSlots < TDM.TeamSize do
            local aiIndex = teamSlots + 1
            local skin = skins[((aiIndex - 1) % math.max(#skins, 1)) + 1]
            slots[#slots + 1] = {
                Name = string.format("%s AI %02d", TDM.TeamData[teamID].Singular, aiIndex),
                SteamID64 = "",
                Team = teamID,
                Skin = skin && skin.ID or "",
                Ready = true,
                IsAI = true,
            }
            teamSlots = teamSlots + 1
        end
    end

    return slots
end

function ENT:BroadcastLobbyState(target)
    if !IsValid(self) or self.MatchStarted then return end
    net.Start("VJ.AVP.TDM.LobbyState")
        net.WriteEntity(self)
        net.WriteTable(self:BuildLobbySlots())
    if IsValid(target) then
        net.Send(target)
    else
        net.Broadcast()
    end
end

function ENT:OpenLobbyFor(ply)
    if !IsValid(ply) then return end
    net.Start("VJ.AVP.TDM.OpenLobby")
        net.WriteEntity(self)
    net.Send(ply)
    self:BroadcastLobbyState(ply)
end

function ENT:InitializeHooks()
    hook.Add("PlayerInitialSpawn", self, function(ent, ply)
        if !IsValid(ent) or ent.MatchStarted or ent.Ending then return end
        timer.Simple(1, function()
            if !IsValid(ent) or !IsValid(ply) or ent.MatchStarted then return end
            ent:AddLobbyPlayer(ply)
            ent:OpenLobbyFor(ply)
            ent:BroadcastLobbyState()
        end)
    end)

    hook.Add("PlayerDisconnected", self, function(ent, ply)
        if !IsValid(ent) then return end
        ent:RemoveLobbyPlayer(ply)
        ent:CheckReadyFastStart()
        local record = ent.PlayerRecords && ent.PlayerRecords[ply]
        if record then
            ent.PlayerRecords[ply] = nil
            record.Player = nil
            record.IsAI = true
            if IsValid(record.NPC) then
                record.NPC:SetOwner(NULL)
            end
        end
        ent:BroadcastLobbyState()
    end)

    hook.Add("OnNPCKilled", self, function(ent, npc, attacker, inflictor)
        if !IsValid(ent) or !ent:GetMatchActive() then return end
        ent:HandleCombatantDeath(npc, attacker, inflictor)
    end)

    hook.Add("PlayerButtonDown", self, function(ent, ply, button)
        if !IsValid(ent) or !ent:GetMatchActive() then return end
        ent:HandleParticipantButton(ply, button)
    end)

    hook.Add("StartCommand", self, function(ent, ply, cmd)
        if !IsValid(ent) or !ent:GetMatchActive() or !IsValid(ply) then return end
        if !ply:GetNW2Bool("AVP_TDM_Participant", false) then return end
        if ply:GetNW2Float("AVP_TDM_RespawnAt", 0) <= CurTime() then return end
        cmd:ClearButtons()
        cmd:ClearMovement()
    end)
end

function ENT:Initialize()
    self:SetModel("models/hunter/blocks/cube025x025x025.mdl")
    self:SetNoDraw(true)
    self:SetSolid(SOLID_NONE)
    self:DrawShadow(false)

    self.LobbyPlayers = {}
    self.Participants = {}
    self.PlayerRecords = {}
    self.Combatants = {}
    self.Pickups = {}
    self.OriginalPlayerStates = {}
    self.TeamSpawnPoints = {}
    self.SpawnReservations = {}
    self.TeamSpawnCursor = {}
    self.MatchStarted = false
    self.Ending = false
    self.NextPickupCheck = 0
    self.NextBalanceThink = 0

    self:SetMatchActive(false)
    self:SetLobbyReadyLocked(false)
    self:SetMarineScore(0)
    self:SetXenoScore(0)
    self:SetPredatorScore(0)
    self:SetLobbyEndTime(CurTime() + TDM.LobbyDuration)
    self:SetMatchEndTime(0)

    if !VJ_Nodegraph or !VJ_Nodegraph.Exists or !VJ_Nodegraph:Exists() then
        for _, ply in ipairs(player.GetAll()) do
            ply:ChatPrint("Species Team Deathmatch requires a valid nodegraph on this map.")
        end
        self:Remove()
        return
    end

    for _, other in ipairs(ents.FindByClass("sent_vj_avp_tdm")) do
        if other != self && IsValid(other) then
            other:Remove()
        end
    end

    for _, ply in ipairs(player.GetAll()) do
        self:AddLobbyPlayer(ply)
    end

    self:InitializeHooks()

    timer.Simple(0.15, function()
        if !IsValid(self) then return end
        for _, ply in ipairs(player.GetAll()) do
            self:OpenLobbyFor(ply)
        end
        self:BroadcastLobbyState()
    end)
end

function ENT:HandleLobbyAction(ply, action, value, extra)
    if self.MatchStarted or self.Ending then return end
    local entry = self.LobbyPlayers[ply]

    if action == "leave" then
        if entry then
            self:RemoveLobbyPlayer(ply)
            self:CheckReadyFastStart()
            self:BroadcastLobbyState()
        end
        return
    end

    if !entry then return end

    if action == "ready" then
        if self:GetLobbyReadyLocked() then return end
        entry.Ready = !entry.Ready
    elseif action == "faction" then
        local requested = value
        if TDM.IsValidTeam(requested) && requested != entry.Team && self:GetTeamHumanCount(requested) < TDM.TeamSize then
            entry.Team = requested
            local requestedSkin = TDM.GetSkin(requested, extra or "")
            local defaultSkin = TDM.GetDefaultSkin(requested)
            entry.Skin = requestedSkin && requestedSkin.ID or (defaultSkin && defaultSkin.ID or "")
            if !self:GetLobbyReadyLocked() then
                entry.Ready = false
            end
        end
    elseif action == "skin" then
        local skin = TDM.GetSkin(entry.Team, value)
        if skin then
            entry.Skin = skin.ID
        end
    end

    self:CheckReadyFastStart()
    self:BroadcastLobbyState()
end

net.Receive("VJ.AVP.TDM.Action", function(_, ply)
    local ent = net.ReadEntity()
    local action = net.ReadString()
    local value = net.ReadString()
    local extra = net.ReadString()
    if !IsValid(ent) or ent:GetClass() != "sent_vj_avp_tdm" then return end
    ent:HandleLobbyAction(ply, action, value, extra)
end)

function ENT:CollectSpawnNodes()
    local nodes = (VJ_Nodegraph && VJ_Nodegraph.Data && VJ_Nodegraph.Data.Nodes) or {}
    local preferred = {}
    local fallback = {}

    for _, node in pairs(nodes) do
        if node.pos && util.IsInWorld(node.pos) then
            fallback[#fallback + 1] = node.pos
            local nodeType = node.type or node.Type
            if nodeType == nil or nodeType == 2 then
                preferred[#preferred + 1] = node.pos
            end
        end
    end

    if #preferred >= TDM.MaxSlots then
        return preferred
    end
    return fallback
end

function ENT:BuildTeamSpawnPoints()
    local rawNodes = self:CollectSpawnNodes()
    if #rawNodes == 0 then return false end

    local nodes = {}
    for _, nodePos in ipairs(rawNodes) do
        local resolved = self:ResolveSpawnFloor(nodePos, "xeno", nil, false)
        if resolved then nodes[#nodes + 1] = resolved end
    end
    if #nodes < 3 then return false end
    self.MapSpawnNodes = nodes

    local first = nodes[math.random(1, #nodes)]
    local second = first
    local bestSecond = -1
    for _, pos in ipairs(nodes) do
        local dist = pos:DistToSqr(first)
        if dist > bestSecond then
            bestSecond = dist
            second = pos
        end
    end

    local third = first
    local bestThird = -1
    for _, pos in ipairs(nodes) do
        local score = math.min(pos:DistToSqr(first), pos:DistToSqr(second))
        if score > bestThird then
            bestThird = score
            third = pos
        end
    end

    local anchors = {marine = first, xeno = second, predator = third}
    local used = {}
    for _, teamID in ipairs(TDM.TeamOrder) do
        local anchor = anchors[teamID]
        self.TeamSpawnPoints[teamID] = {CopyVector(anchor)}
        local key = string.format("%.0f:%.0f:%.0f", anchor.x, anchor.y, anchor.z)
        used[key] = true
    end

    for _, teamID in ipairs(TDM.TeamOrder) do
        local candidates = table.Copy(nodes)
        table.sort(candidates, function(a, b)
            return a:DistToSqr(anchors[teamID]) < b:DistToSqr(anchors[teamID])
        end)

        for _, pos in ipairs(candidates) do
            if #self.TeamSpawnPoints[teamID] >= TDM.TeamSize then break end
            local key = string.format("%.0f:%.0f:%.0f", pos.x, pos.y, pos.z)
            if !used[key] then
                local spaced = true
                for _, chosen in ipairs(self.TeamSpawnPoints[teamID]) do
                    if chosen:DistToSqr(pos) < (160 * 160) then
                        spaced = false
                        break
                    end
                end
                if spaced then
                    used[key] = true
                    self.TeamSpawnPoints[teamID][#self.TeamSpawnPoints[teamID] + 1] = CopyVector(pos)
                end
            end
        end
    end

    return true
end

function ENT:IsTeamSpawnContested(teamID)
    local list = self.TeamSpawnPoints[teamID] or {}
    if #list == 0 then return false end

    for npc, record in pairs(self.Combatants or {}) do
        if IsValid(npc) && npc:Health() > 0 && record.Team != teamID then
            local enemyPos = npc:GetPos()
            for _, spawnPos in ipairs(list) do
                if enemyPos:DistToSqr(spawnPos) <= TDM_SPAWN_CAMP_RADIUS_SQR then
                    return true
                end
            end
        end
    end

    return false
end

function ENT:IsNearFactionSpawnArea(pos)
    for _, otherTeam in ipairs(TDM.TeamOrder) do
        for _, spawnPos in ipairs(self.TeamSpawnPoints[otherTeam] or {}) do
            if pos:DistToSqr(spawnPos) <= TDM_NEUTRAL_NODE_SPAWN_CLEARANCE_SQR then
                return true
            end
        end
    end
    return false
end

function ENT:GetRandomSafeMapSpawn(teamID, setEnt)
    local nodes = self.MapSpawnNodes or self:CollectSpawnNodes()
    if #nodes == 0 then return nil end

    local enemies = {}
    local living = {}
    for npc, record in pairs(self.Combatants or {}) do
        if IsValid(npc) && npc:Health() > 0 then
            local pos = npc:GetPos()
            living[#living + 1] = pos
            if record.Team != teamID then enemies[#enemies + 1] = pos end
        end
    end

    local safeNeutral = {}
    local safeAny = {}
    for _, nodePos in ipairs(nodes) do
        local resolved = self:FindClearSpawnPosition(nodePos, teamID, setEnt, false)
        if !resolved then continue end

        local enemySafe = true
        for _, enemyPos in ipairs(enemies) do
            if resolved:DistToSqr(enemyPos) < TDM_SAFE_RESPAWN_ENEMY_DIST_SQR then
                enemySafe = false
                break
            end
        end
        if !enemySafe then continue end

        local occupied = false
        for _, livingPos in ipairs(living) do
            if resolved:DistToSqr(livingPos) < TDM_SAFE_RESPAWN_OCCUPIED_DIST_SQR then
                occupied = true
                break
            end
        end
        if occupied then continue end

        safeAny[#safeAny + 1] = resolved
        if !self:IsNearFactionSpawnArea(resolved) then safeNeutral[#safeNeutral + 1] = resolved end
    end

    local pool = #safeNeutral > 0 && safeNeutral or safeAny
    if #pool > 0 then return CopyVector(pool[math.random(1, #pool)]) end

    local best = nil
    local bestEnemyDist = -1
    for _, nodePos in ipairs(nodes) do
        local resolved = self:FindClearSpawnPosition(nodePos, teamID, setEnt, false)
        if !resolved then continue end
        local nearestEnemy = math.huge
        for _, enemyPos in ipairs(enemies) do
            nearestEnemy = math.min(nearestEnemy, resolved:DistToSqr(enemyPos))
        end
        if nearestEnemy > bestEnemyDist then
            bestEnemyDist = nearestEnemy
            best = resolved
        end
    end
    return best && CopyVector(best) or nil
end

function ENT:GetSpawnPoint(teamID, setEnt)
    local list = self.TeamSpawnPoints[teamID] or {}
    if #list == 0 then
        local fallback = self:FindAnyClearMapSpawn(teamID, setEnt)
        return fallback
    end

    if self:IsTeamSpawnContested(teamID) then
        local safePos = self:GetRandomSafeMapSpawn(teamID, setEnt)
        if safePos then return safePos end
    end

    self.TeamSpawnCursor = self.TeamSpawnCursor or {}
    local startIndex = ((self.TeamSpawnCursor[teamID] or 0) % #list) + 1
    local best = nil
    local bestScore = -math.huge
    local bestIndex = startIndex

    for offset = 0, #list - 1 do
        local index = ((startIndex + offset - 1) % #list) + 1
        local candidate = self:FindClearSpawnPosition(list[index], teamID, setEnt, true)
        if !candidate then continue end

        local nearestEnemy = math.huge
        local nearestMate = math.huge
        for npc, record in pairs(self.Combatants or {}) do
            if IsValid(npc) && npc:Health() > 0 then
                local dist = candidate:DistToSqr(npc:GetPos())
                if record.Team == teamID then
                    nearestMate = math.min(nearestMate, dist)
                else
                    nearestEnemy = math.min(nearestEnemy, dist)
                end
            end
        end

        local enemyScore = nearestEnemy == math.huge && 0 or math.min(nearestEnemy, 4096 * 4096)
        local mateScore = nearestMate == math.huge && (512 * 512) or math.min(nearestMate, 512 * 512)
        local score = enemyScore + mateScore * 2
        if score > bestScore then
            bestScore = score
            best = candidate
            bestIndex = index
        end
    end

    if !best then best = self:GetRandomSafeMapSpawn(teamID, setEnt) end
    if !best then best = self:FindAnyClearMapSpawn(teamID, setEnt) end
    if best then
        self.TeamSpawnCursor[teamID] = bestIndex
        return CopyVector(best)
    end
    return nil
end

function ENT:SetProperPos(setEnt, origin, teamID)
    if !IsValid(setEnt) or !origin then return nil end
    local pos = self:FindClearSpawnPosition(origin, teamID, setEnt, true)
    if !pos then pos = self:FindAnyClearMapSpawn(teamID, setEnt) end
    if !pos then return nil end
    setEnt:SetPos(pos)
    return pos
end

function ENT:EnsureParticipantSpawnClear(npc, teamID, preferredPos)
    if !IsValid(npc) then return false end
    local mins, maxs = self:GetSpawnHull(teamID, npc)
    local pos = npc:GetPos()
    local worldTr = util.TraceHull({
        start = pos,
        endpos = pos,
        mins = mins,
        maxs = maxs,
        filter = npc,
        mask = MASK_NPCSOLID_BRUSHONLY,
    })

    local blocked = worldTr.StartSolid or worldTr.AllSolid or self:IsSpawnAreaOccupied(pos, mins, maxs, npc)
    if !blocked then return true end

    local safePos = self:FindClearSpawnPosition(preferredPos or pos, teamID, npc, true)
    if !safePos then safePos = self:FindAnyClearMapSpawn(teamID, npc) end
    if !safePos then return false end

    npc:SetPos(safePos)
    npc:SetLocalVelocity(Vector(0, 0, 0))
    return true
end

function ENT:SavePlayerState(ply)
    if !IsValid(ply) or self.OriginalPlayerStates[ply] then return end
    local state = {
        Pos = CopyVector(ply:GetPos()),
        Ang = CopyAngle(ply:EyeAngles()),
        Health = ply:Health(),
        Armor = ply:Armor(),
        MoveType = ply:GetMoveType(),
        God = ply.HasGodMode && ply:HasGodMode() or false,
        NoTarget = ply.GetNoTarget && ply:GetNoTarget() or false,
        Weapons = {},
        Ammo = {},
        ActiveWeapon = IsValid(ply:GetActiveWeapon()) && ply:GetActiveWeapon():GetClass() or nil,
    }

    for _, wep in ipairs(ply:GetWeapons()) do
        state.Weapons[#state.Weapons + 1] = wep:GetClass()
        local pAmmo = wep:GetPrimaryAmmoType()
        local sAmmo = wep:GetSecondaryAmmoType()
        if pAmmo && pAmmo >= 0 then state.Ammo[pAmmo] = ply:GetAmmoCount(pAmmo) end
        if sAmmo && sAmmo >= 0 then state.Ammo[sAmmo] = ply:GetAmmoCount(sAmmo) end
    end

    self.OriginalPlayerStates[ply] = state
end

function ENT:StopPlayerController(ply)
    if !IsValid(ply) then return end
    local controller = ply.VJ_TheControllerEntity
    if IsValid(controller) then
        if controller.StopControlling then
            controller:StopControlling()
        else
            controller:Remove()
        end
    end
end

function ENT:RestorePlayer(ply)
    if !IsValid(ply) then return end
    self:StopPlayerController(ply)
    ply:UnSpectate()
    ply:SetNW2Bool("AVP_TDM_Participant", false)
    ply:SetNW2Float("AVP_TDM_RespawnAt", 0)
    ply:SetNW2Entity("AVP_TDM_SpectateTarget", NULL)
    ply:SetNW2Entity("AVP_TDM_Entity", NULL)
    ply:DrawViewModel(true)
    ply:DrawWorldModel(true)
    ply:SetNoDraw(false)
    ply:DrawShadow(true)

    local state = self.OriginalPlayerStates[ply]
    if !state then return end

    ply:Spawn()
    ply:StripWeapons()
    ply:RemoveAllAmmo()
    for _, class in ipairs(state.Weapons) do
        ply:Give(class)
    end
    for ammoID, amount in pairs(state.Ammo) do
        if amount > 0 then
            ply:GiveAmmo(amount, tonumber(ammoID) or ammoID, true)
        end
    end
    if state.ActiveWeapon && ply:HasWeapon(state.ActiveWeapon) then
        ply:SelectWeapon(state.ActiveWeapon)
    end

    ply:SetHealth(math.max(1, state.Health or 100))
    ply:SetArmor(math.max(0, state.Armor or 0))
    ply:SetPos(state.Pos)
    ply:SetEyeAngles(state.Ang)
    if state.MoveType then ply:SetMoveType(state.MoveType) end
    if state.God then
        ply:GodEnable()
    else
        ply:GodDisable()
    end
    if ply.SetNoTarget then ply:SetNoTarget(state.NoTarget == true) end

    self.OriginalPlayerStates[ply] = nil
end

function ENT:BuildParticipantRecords()
    self.Participants = {}
    self.PlayerRecords = {}

    local slots = self:BuildLobbySlots()
    local aiCounter = {marine = 0, xeno = 0, predator = 0}

    for _, slot in ipairs(slots) do
        local playerEnt = nil
        if !slot.IsAI && slot.SteamID64 != "" then
            for ply, entry in pairs(self.LobbyPlayers) do
                if IsValid(ply) && entry.SteamID64 == slot.SteamID64 then
                    playerEnt = ply
                    break
                end
            end
        end

        local id
        if IsValid(playerEnt) then
            id = "PLY:" .. slot.SteamID64
        else
            aiCounter[slot.Team] = aiCounter[slot.Team] + 1
            id = string.format("AI:%s:%02d", slot.Team, aiCounter[slot.Team])
        end

        local record = {
            ID = id,
            Name = IsValid(playerEnt) && playerEnt:Nick() or slot.Name,
            Team = slot.Team,
            Skin = slot.Skin,
            IsAI = !IsValid(playerEnt),
            Player = playerEnt,
            Kills = 0,
            Deaths = 0,
            NPC = nil,
            RespawnSerial = 0,
        }
        self.Participants[#self.Participants + 1] = record
        if IsValid(playerEnt) then
            self.PlayerRecords[playerEnt] = record
        end
    end
end

function ENT:SetTeamScore(teamID, value)
    local setter = TEAM_SETTERS[teamID]
    if setter then setter(self, math.max(0, value or 0)) end
end

function ENT:GetTeamScore(teamID)
    local getter = TEAM_GETTERS[teamID]
    return getter && getter(self) or 0
end

function ENT:AddTeamScore(teamID, amount)
    self:SetTeamScore(teamID, self:GetTeamScore(teamID) + (amount or 1))
end

function ENT:FindRecordFromEntity(ent)
    if !IsValid(ent) then return nil end
    if self.Combatants[ent] then return self.Combatants[ent] end
    if ent.VJ_AVP_TDMRecord then return ent.VJ_AVP_TDMRecord end
    if ent:IsPlayer() && self.PlayerRecords[ent] then return self.PlayerRecords[ent] end

    local owner = ent.GetOwner && ent:GetOwner() or nil
    if IsValid(owner) then
        if self.Combatants[owner] then return self.Combatants[owner] end
        if owner.VJ_AVP_TDMRecord then return owner.VJ_AVP_TDMRecord end
        if owner:IsPlayer() && self.PlayerRecords[owner] then return self.PlayerRecords[owner] end
    end

    local parent = ent.GetParent && ent:GetParent() or nil
    if IsValid(parent) then
        if self.Combatants[parent] then return self.Combatants[parent] end
        if parent.VJ_AVP_TDMRecord then return parent.VJ_AVP_TDMRecord end
    end

    return nil
end

function ENT:FilterMatchDamage(victim, dmginfo)
    local victimRecord = self:FindRecordFromEntity(victim)
    local attacker = dmginfo:GetAttacker()
    local inflictor = dmginfo:GetInflictor()
    local attackerRecord = self:FindRecordFromEntity(attacker) or self:FindRecordFromEntity(inflictor)

    if victimRecord && attackerRecord && victimRecord.Team == attackerRecord.Team then
        dmginfo:SetDamage(0)
        return true
    end

    if victimRecord && !attackerRecord then
        if IsValid(attacker) && !IsWorldEntity(attacker) then
            dmginfo:SetDamage(0)
            return true
        end
    elseif attackerRecord && !victimRecord then
        if IsValid(victim) && (victim:IsPlayer() or victim:IsNPC() or victim:IsNextBot()) then
            dmginfo:SetDamage(0)
            return true
        end
    end
end

function ENT:EquipMarineWeapon(npc, class)
    if !IsValid(npc) or !npc.VJ_AVP_TDMInventory or !npc.VJ_AVP_TDMInventory[class] then return false end
    local current = npc:GetActiveWeapon()
    if IsValid(current) && current:GetClass() == class then
        local maxClip = current.GetMaxClip1 && current:GetMaxClip1() or -1
        if maxClip && maxClip > 0 then current:SetClip1(maxClip) end
        return true
    end

    if IsValid(current) then
        current:Remove()
    end
    local weapon = npc:Give(class)
    npc.VJ_AVP_TDMCurrentWeapon = class

    if IsValid(weapon) && class == "weapon_vj_avp_pulserifle" && (npc.VJ_AVP_TDMGrenades or 0) > 0 then
        local max2 = weapon.GetMaxClip2 && weapon:GetMaxClip2() or 0
        if max2 && max2 > 0 then
            local give = math.min(max2, npc.VJ_AVP_TDMGrenades)
            weapon:SetClip2(give)
            npc.VJ_AVP_TDMGrenades = npc.VJ_AVP_TDMGrenades - give
        end
    end

    return IsValid(weapon)
end

function ENT:SetupMarine(npc)
    -- npc.CanUseStimpacks = false
    if istable(npc.HealthRegenParams) then
        npc.HealthRegenParams = table.Copy(npc.HealthRegenParams)
        npc.HealthRegenParams.Enabled = false
    end
    npc.VJ_AVP_TDMInventory = {
        ["weapon_vj_avp_pistol"] = true,
        ["weapon_vj_avp_pulserifle"] = true,
    }
    npc.VJ_AVP_TDMStims = 0
    npc.VJ_AVP_TDMGrenades = 0
    npc.VJ_AVP_TDMNextStim = 0
    timer.Simple(0, function()
        if !IsValid(self) or !IsValid(npc) then return end
        self:EquipMarineWeapon(npc, "weapon_vj_avp_pulserifle")
    end)
end

function ENT:CreateController(record, npc)
    local ply = record.Player
    if !IsValid(ply) or !IsValid(npc) or !self:GetMatchActive() then return end

    self:StopPlayerController(ply)
    ply:UnSpectate()
    ply:StripWeapons()
    ply:GodEnable()
    if ply.SetNoTarget then ply:SetNoTarget(true) end
    ply:SetNW2Bool("AVP_TDM_Participant", true)
    ply:SetNW2Float("AVP_TDM_RespawnAt", 0)
    ply:SetNW2Entity("AVP_TDM_SpectateTarget", NULL)
    ply:SetNW2Entity("AVP_TDM_Entity", self)

    local controller = ents.Create("obj_vj_controller")
    if !IsValid(controller) then return end
    controller.VJCE_Player = ply
    controller:SetControlledNPC(npc)
    controller:Spawn()
    controller:StartControlling()
    record.Controller = controller
end

function ENT:SpawnParticipant(record)
    if !record or !self:GetMatchActive() then return end
    local skin = TDM.GetSkin(record.Team, record.Skin) or TDM.GetDefaultSkin(record.Team)
    if !skin then return end

    local npc = ents.Create(skin.Class)
    if !IsValid(npc) then
        ErrorNoHalt("[AVP TDM] Failed to create " .. tostring(skin.Class) .. "\n")
        return
    end

    local teamData = TDM.TeamData[record.Team]
    local targetHealth = teamData.Health
    npc.StartHealth = targetHealth

    local pos = self:GetSpawnPoint(record.Team, npc)
    if !pos then
        ErrorNoHalt("[AVP TDM] Failed to find a clear spawn for " .. tostring(skin.Class) .. "\n")
        npc:Remove()
        return
    end
    pos = self:SetProperPos(npc, pos, record.Team) or pos
    npc:SetAngles(Angle(0, math.random(0, 359), 0))
    if skin.Class == "npc_vj_avp_xeno_praetorian" then
        npc.VJ_AVP_XenomorphLarge = false
    end
    npc:Spawn()
    npc:Activate()
    if !self:EnsureParticipantSpawnClear(npc, record.Team, pos) then
        ErrorNoHalt("[AVP TDM] Spawn became blocked after initialization for " .. tostring(skin.Class) .. "\n")
        npc:Remove()
        return
    end
    self:ReserveSpawnPosition(npc:GetPos())

    npc.VJ_AVP_TDM = true
    npc.VJ_AVP_TDMTeam = record.Team
    npc.VJ_AVP_TDMOwner = self
    npc.VJ_AVP_TDMRecord = record
    npc.CanSpit = false
    npc.HasRangeAttack = false
    npc.EnemyXRayDetection = true
    npc.SightAngle = 360
    npc.SightDistance = 32000
    npc.AttackDamageMultiplier = 1
	-- npc.SpawnedUsingMutator = true
    npc:SetMaxHealth(targetHealth)
    npc:SetHealth(targetHealth)
    npc:CapabilitiesAdd(bit.bor(CAP_AUTO_DOORS, CAP_OPEN_DOORS, CAP_USE))
	npc:DrawShadow(false)
    if npc.VJ_AVP_Xenomorph then
        npc.CanScreamForHelp = false
        npc.ReactsToFire = false
        npc.CanDodge = false
        npc.BulletDamageReduction = 0.2
        npc.BulletDamageReductionRequirement = 20
    elseif npc.VJ_AVP_Predator then
        npc.AttackDamage = 25
	    npc:SetStimCount(1)
    elseif npc.VJ_AVP_Marine then
        if npc:FindBodygroupByName("vest") > -1 then
            npc:SetBodygroup(npc:FindBodygroupByName("vest"),0)
        end
        local att = npc:LookupAttachment(npc.FlashLightAttachment or "flashlight")
        if att > 0 && npc.HasFlashlight then
            npc.CanUseFlashlight = true
        end
    end
    if skin.Class == "npc_vj_avp_xeno_praetorian" then
        npc.StandingBounds = Vector(15,15,72)
        npc.CrawlingBounds = Vector(15,15,72)
        npc:SetModelScale(0.8)
        npc:SetCollisionBounds(Vector(15,15,72), Vector(-15,-15,0))
        npc.VJ_AVP_XenomorphLarge = false
        npc.TDM = true
        npc.AlwaysStand = false
        npc.DoSummon = function() end
        -- npc.DoLeapAttack = function() return npc.TDMLeapAttack() end
    end

    if record.Team == "marine" then
        self:SetupMarine(npc)
    end

    record.NPC = npc
    self.Combatants[npc] = record
    self:DeleteOnRemove(npc)

    if IsValid(record.Player) then
        timer.Simple(0.05, function()
            if IsValid(self) && IsValid(npc) && self:GetMatchActive() && record.NPC == npc then
                self:CreateController(record, npc)
            end
        end)
    end
end

function ENT:FindSpectateTarget(teamID, excludeNPC)
    local candidates = {}
    for npc, record in pairs(self.Combatants) do
        if IsValid(npc) && npc != excludeNPC && record.Team == teamID && npc:Health() > 0 then
            candidates[#candidates + 1] = npc
        end
    end
    if #candidates == 0 then return nil end
    return candidates[math.random(1, #candidates)]
end

function ENT:ApplyRespawnSpectatorState(ply, teamID, excludeNPC)
    if !IsValid(ply) or !self:GetMatchActive() then return end

    local target = ply:GetNW2Entity("AVP_TDM_SpectateTarget")
    if !IsValid(target) or target:Health() <= 0 or !self.Combatants[target] or self.Combatants[target].Team != teamID then
        target = self:FindSpectateTarget(teamID, excludeNPC)
        ply:SetNW2Entity("AVP_TDM_SpectateTarget", IsValid(target) && target or NULL)
    end

    if #ply:GetWeapons() > 0 then ply:StripWeapons() end
    ply:DrawViewModel(false)
    ply:DrawWorldModel(false)
    ply:DrawShadow(false)
    ply:SetNoDraw(true)
    ply:GodEnable()
    if ply.SetNoTarget then ply:SetNoTarget(true) end

    if IsValid(target) then
        if ply:GetObserverTarget() != target or ply:GetObserverMode() != OBS_MODE_CHASE then
            ply:Spectate(OBS_MODE_CHASE)
            ply:SpectateEntity(target)
        end
    elseif ply:GetObserverMode() != OBS_MODE_ROAMING then
        ply:Spectate(OBS_MODE_ROAMING)
    end
    ply:SetMoveType(MOVETYPE_OBSERVER)
end

function ENT:HandleCombatantDeath(npc, attacker, inflictor)
    local record = self.Combatants[npc]
    if !record or record._DeathHandled then return end
    record._DeathHandled = true
    self.Combatants[npc] = nil
    record.Deaths = record.Deaths + 1
    record.NPC = nil

    local killer = self:FindRecordFromEntity(attacker) or self:FindRecordFromEntity(inflictor)
    if killer && killer != record && killer.Team != record.Team then
        killer.Kills = killer.Kills + 1
        self:AddTeamScore(killer.Team, 1)
    end

    record.RespawnSerial = (record.RespawnSerial or 0) + 1
    local serial = record.RespawnSerial

    if IsValid(record.Player) then
        local ply = record.Player
        timer.Simple(0.05, function()
            if !IsValid(self) or !IsValid(ply) or !self:GetMatchActive() then return end
            self:StopPlayerController(ply)
            ply:GodEnable()
            ply:SetNW2Float("AVP_TDM_RespawnAt", CurTime() + TDM.RespawnDelay)
            ply:SetNW2Entity("AVP_TDM_SpectateTarget", NULL)
            self:ApplyRespawnSpectatorState(ply, record.Team, npc)

            timer.Simple(0, function()
                if IsValid(self) && IsValid(ply) && self:GetMatchActive() && record.RespawnSerial == serial then
                    self:ApplyRespawnSpectatorState(ply, record.Team, npc)
                end
            end)
            timer.Simple(0.15, function()
                if IsValid(self) && IsValid(ply) && self:GetMatchActive() && record.RespawnSerial == serial then
                    self:ApplyRespawnSpectatorState(ply, record.Team, npc)
                end
            end)
        end)
    end

    timer.Simple(TDM.RespawnDelay, function()
        if !IsValid(self) or !self:GetMatchActive() or record.RespawnSerial != serial then return end
        record._DeathHandled = false
        self:SpawnParticipant(record)
    end)
end

function ENT:HandleParticipantButton(ply, button)
    local record = self.PlayerRecords[ply]
    if !record or record.Team != "marine" then return end
    local npc = record.NPC
    if !IsValid(npc) then return end

    local keyToSlot = {
        [KEY_1] = 1,
        [KEY_2] = 2,
        [KEY_3] = 3,
        [KEY_4] = 4,
        [KEY_5] = 5,
        [KEY_6] = 6,
    }
    local slot = keyToSlot[button]
    if !slot then return end
    local data = TDM.MarineWeapons[slot]
    if data && npc.VJ_AVP_TDMInventory && npc.VJ_AVP_TDMInventory[data.Class] then
        self:EquipMarineWeapon(npc, data.Class)
    end
end

function ENT:HandleMarinePickup(npc, pickup)
    if !IsValid(npc) or !IsValid(pickup) or npc.VJ_AVP_TDMTeam != "marine" then return end
    if pickup.Disabled or pickup:GetResetTime() > CurTime() then return end

    local typeID = pickup:GetPickupType()
    local soundPath = "cpthazama/avp/shared/pickup_ammo.ogg"

    local record = self.Combatants[npc]
    local controlledPlayer = record && record.Player or nil

    if typeID == 0 then
        npc.VJ_AVP_TDMStims = math.min((npc.VJ_AVP_TDMStims or 0) + 1, 3)
        soundPath = "cpthazama/avp/shared/pickup_health.ogg"
        if IsValid(controlledPlayer) then controlledPlayer:ChatPrint("Picked up a Stimpack! Press G to use it.") end
    elseif typeID >= 1 && typeID <= 6 then
        local class = TDM.PickupToWeapon[typeID]
        if class then
            npc.VJ_AVP_TDMInventory = npc.VJ_AVP_TDMInventory or {}
            local wasOwned = npc.VJ_AVP_TDMInventory[class] == true
            npc.VJ_AVP_TDMInventory[class] = true
            if !wasOwned then
                self:EquipMarineWeapon(npc, class)
                soundPath = "cpthazama/avp/shared/pickup_weapon.ogg"
                if IsValid(controlledPlayer) then controlledPlayer:ChatPrint("Picked up " .. class .. "!") end
            else
                local active = npc:GetActiveWeapon()
                if IsValid(active) && active:GetClass() == class then
                    local maxClip = active.GetMaxClip1 && active:GetMaxClip1() or -1
                    if maxClip && maxClip > 0 then active:SetClip1(maxClip) end
                end
                soundPath = "cpthazama/avp/shared/pickup_ammo.ogg"
                if IsValid(controlledPlayer) then controlledPlayer:ChatPrint("Picked up ammo for " .. class .. "!") end
            end
        end
    elseif typeID == 7 then
        npc.VJ_AVP_TDMGrenades = math.min((npc.VJ_AVP_TDMGrenades or 0) + 2, 8)
        local wep = npc:GetActiveWeapon()
        if IsValid(wep) && wep:GetClass() == "weapon_vj_avp_pulserifle" then
            local max2 = wep.GetMaxClip2 && wep:GetMaxClip2() or 0
            if max2 && max2 > 0 then
                local add = math.min(2, max2 - math.max(0, wep:Clip2()))
                if add > 0 then
                    wep:SetClip2(math.max(0, wep:Clip2()) + add)
                    npc.VJ_AVP_TDMGrenades = math.max(0, npc.VJ_AVP_TDMGrenades - add)
                end
            end
        end
        soundPath = "cpthazama/avp/shared/pickup_tool.ogg"
        if IsValid(controlledPlayer) then controlledPlayer:ChatPrint("Picked up 2 underbarrel grenades!") end
    end

    pickup:SetResetTime(CurTime() + (TDM.PickupResetTimes[typeID] or 60))
    pickup.Disabled = true
    pickup:StopParticles()
    if VJ && VJ.EmitSound then VJ.EmitSound(npc, soundPath, 70) end
end

function ENT:CheckMarinePickups()
    for _, pickup in ipairs(self.Pickups) do
        if IsValid(pickup) && !pickup.Disabled && pickup:GetResetTime() <= CurTime() then
            for _, nearby in ipairs(ents.FindInSphere(pickup:GetPos(), 28)) do
                if IsValid(nearby) && nearby.VJ_AVP_TDM && nearby.VJ_AVP_TDMTeam == "marine" then
                    self:HandleMarinePickup(nearby, pickup)
                    break
                end
            end
        end
    end
end

function ENT:SpawnAmmoPickups()
    local ammoCounts = {}
    local goodPositions = {}
    local nodes = (VJ_Nodegraph && VJ_Nodegraph.Data && VJ_Nodegraph.Data.Nodes) or {}
    local minDistSqr = 368 * 368

    for _, node in RandomPairs(nodes) do
        local pos = node.pos
        if pos then
            local ok = true
            for _, existing in ipairs(goodPositions) do
                if existing:DistToSqr(pos) < minDistSqr then
                    ok = false
                    break
                end
            end
            if ok then goodPositions[#goodPositions + 1] = pos end
        end
    end

    local function allMaxed()
        for i = 1, 8 do
            if (ammoCounts[i] or 0) < (self.MaxPickups[i] or 0) then return false end
        end
        return true
    end

    for _, basePos in ipairs(goodPositions) do
        if allMaxed() then break end
        if math.random(2) == 1 then
            local pos = basePos + VectorRand() * math.Rand(0, 256)
            local tr = util.TraceLine({
                start = pos,
                endpos = pos + Vector(0, 0, -256),
                filter = self,
                mask = MASK_SOLID_BRUSHONLY,
            })
            if tr.Hit && util.IsInWorld(tr.HitPos) then
                local typeID = math.random(0, 7)
                local idx = typeID + 1
                if (ammoCounts[idx] or 0) < (self.MaxPickups[idx] or 0) then
                    local pickup = ents.Create("sent_vj_avp_tdm_pickup")
                    if IsValid(pickup) then
                        pickup:SetPos(tr.HitPos + Vector(0, 0, 2))
                        pickup.PickupType = typeID
                        pickup:Spawn()
                        pickup:Activate()
                        pickup.VJ_AVP_TDMPickup = true
                        self.Pickups[#self.Pickups + 1] = pickup
                        self:DeleteOnRemove(pickup)
                        ammoCounts[idx] = (ammoCounts[idx] or 0) + 1
                    end
                end
            end
        end
    end
end

function ENT:StartMatch()
    if self.MatchStarted or self.Ending then return end
    self.MatchStarted = true

    if !self:BuildTeamSpawnPoints() then
        for _, ply in ipairs(player.GetAll()) do
            ply:ChatPrint("Species Team Deathmatch could !find usable nodegraph spawn points.")
        end
        self:Remove()
        return
    end

    self:BuildParticipantRecords()
    self:SetMarineScore(0)
    self:SetXenoScore(0)
    self:SetPredatorScore(0)
    self:SetMatchActive(true)
    self:SetMatchEndTime(CurTime() + TDM.MatchDuration)

    for _, record in ipairs(self.Participants) do
        if IsValid(record.Player) then
            self:SavePlayerState(record.Player)
            record.Player:SetNW2Bool("AVP_TDM_Participant", true)
            record.Player:SetNW2Float("AVP_TDM_RespawnAt", 0)
            record.Player:SetNW2Entity("AVP_TDM_SpectateTarget", NULL)
            record.Player:SetNW2Entity("AVP_TDM_Entity", self)
            record.Player:GodEnable()
            if record.Player.SetNoTarget then record.Player:SetNoTarget(true) end
        end
    end

    net.Start("VJ.AVP.TDM.MatchStart")
        net.WriteEntity(self)
        net.WriteFloat(self:GetMatchEndTime())
    net.Broadcast()

    for index, record in ipairs(self.Participants) do
        timer.Simple((index - 1) * 0.04, function()
            if IsValid(self) && self:GetMatchActive() then
                self:SpawnParticipant(record)
            end
        end)
    end

    timer.Simple(0.5, function()
        if IsValid(self) && self:GetMatchActive() then
            self:SpawnAmmoPickups()
        end
    end)
end

function ENT:BuildResults()
    local rows = {}
    for _, record in ipairs(self.Participants or {}) do
        rows[#rows + 1] = {
            Name = record.Name,
            Team = record.Team,
            Skin = record.Skin,
            IsAI = record.IsAI,
            Kills = record.Kills or 0,
            Deaths = record.Deaths or 0,
        }
    end

    table.sort(rows, function(a, b)
        if a.Team != b.Team then
            local order = {marine = 1, xeno = 2, predator = 3}
            return (order[a.Team] or 99) < (order[b.Team] or 99)
        end
        if a.Kills != b.Kills then return a.Kills > b.Kills end
        return a.Deaths < b.Deaths
    end)

    local scores = {
        marine = self:GetMarineScore(),
        xeno = self:GetXenoScore(),
        predator = self:GetPredatorScore(),
    }
    local high = math.max(scores.marine, scores.xeno, scores.predator)
    local winners = {}
    for _, teamID in ipairs(TDM.TeamOrder) do
        if scores[teamID] == high then winners[#winners + 1] = teamID end
    end

    local winnerText = "Draw"
    if #winners == 1 then
        winnerText = TDM.TeamData[winners[1]].Name
    end

    return {
        Winner = winnerText,
        WinnerTeam = #winners == 1 && winners[1] or "",
        Scores = scores,
        Rows = rows,
    }
end

function ENT:EndMatch()
    if self.Ending then return end
    self.Ending = true
    self:SetMatchActive(false)

    local results = self:BuildResults()

    for _, record in ipairs(self.Participants or {}) do
        record.RespawnSerial = (record.RespawnSerial or 0) + 1
        if IsValid(record.NPC) then
            self.Combatants[record.NPC] = nil
            record.NPC:Remove()
            record.NPC = nil
        end
        if IsValid(record.Player) then
            self:RestorePlayer(record.Player)
        end
    end

    for _, pickup in ipairs(self.Pickups or {}) do
        if IsValid(pickup) then pickup:Remove() end
    end
    self.Pickups = {}

    net.Start("VJ.AVP.TDM.Results")
        net.WriteTable(results)
    net.Broadcast()

    timer.Simple(1, function()
        if IsValid(self) then self:Remove() end
    end)
end

function ENT:Think()
    if self.Ending then return end

    if !self.MatchStarted then
        if CurTime() >= self:GetLobbyEndTime() then
            self:StartMatch()
        end
        self:NextThink(CurTime() + 0.1)
        return true
    end

    if self:GetMatchActive() then
        if CurTime() >= self:GetMatchEndTime() then
            self:EndMatch()
            return
        end

        for ply, record in pairs(self.PlayerRecords or {}) do
            if IsValid(ply) && record && !IsValid(record.NPC) && ply:GetNW2Float("AVP_TDM_RespawnAt", 0) > CurTime() then
                self:ApplyRespawnSpectatorState(ply, record.Team)
            end
        end

        if CurTime() >= self.NextPickupCheck then
            self:CheckMarinePickups()
            self.NextPickupCheck = CurTime() + 0.15
        end
    end

    self:NextThink(CurTime() + 0.05)
    return true
end

function ENT:OnRemove()
    if self._AVPTDMCleaning then return end
    self._AVPTDMCleaning = true
    self:SetMatchActive(false)

    for _, record in ipairs(self.Participants or {}) do
        record.RespawnSerial = (record.RespawnSerial or 0) + 1
        if IsValid(record.Player) then
            self:RestorePlayer(record.Player)
        end
        if IsValid(record.NPC) then
            record.NPC:Remove()
        end
    end

    for _, pickup in ipairs(self.Pickups or {}) do
        if IsValid(pickup) then pickup:Remove() end
    end
end
