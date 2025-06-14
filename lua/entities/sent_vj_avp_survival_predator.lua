AddCSLuaFile()

ENT.Base 			= "base_gmodentity"
ENT.Type 			= "anim"
ENT.PrintName 		= "Mutators"
ENT.Author 			= "Cpt. Hazama"
ENT.Contact 		= ""
ENT.Purpose 		= "A configurable entity that allows you to define your Resistance SNPCs experience through scripted events."
ENT.Instructions 	= ""
ENT.Category		= ""

ENT.Spawnable = false
ENT.AdminOnly = true
ENT.AutomaticFrameAdvance = true

ENT.VJ_AVP_SurvivalSpawner = true
ENT.VJ_AVP_PredatorSurvivalSpawner = true

local math_Clamp = math.Clamp
local useDebug = false
local function debugMessage(...)
	if useDebug == true then
		print(...)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetupDataTables()
	self:NetworkVar("Int",0,"Wave")
	self:NetworkVar("Int",1,"WaveSwitchVolTime")
	self:NetworkVar("Int",2,"CurrentTotalNPCs")
	self:NetworkVar("Int",3,"KillsRemaining")
	self:NetworkVar("Bool",0,"WaveSwitching")
	self:NetworkVar("Bool",1,"SpecialRound")
end
---------------------------------------------------------------------------------------------------------------------------------------------
if CLIENT then
	function ENT:Draw()
		return false
	end
	
	function ENT:DrawTranslucent()
		return false
	end

	ENT.Tracks = {
		"cpthazama/avp/music/predator/Ancient Tournament Ground.mp3",
		"cpthazama/avp/music/predator/Decimation.mp3",
		"cpthazama/avp/music/predator/Predator Rhythm A.mp3",
		"cpthazama/avp/music/predator/Predator Rhythm B.mp3",
		"cpthazama/avp/music/predator/Youngblood.mp3",
	}

	ENT.BossTracks = {
		"cpthazama/avp/music/boss/Annihilation.mp3",
	}

	local function StopTrack(ply,trk)
		if trk == nil then
			if IsValid(ply) && ply.MutatorTrack && ply.MutatorTrack:IsValid() then
				ply.MutatorTrack:Stop()
				ply.MutatorTrack = nil
				ply.MutatorTrackT = 0
			end
			if IsValid(ply) && ply.BossTrack && ply.BossTrack:IsValid() then
				ply.BossTrack:Stop()
				ply.BossTrack = nil
				ply.BossTrackT = 0
			end
			return
		elseif trk == 1 then
			if IsValid(ply) && ply.MutatorTrack && ply.MutatorTrack:IsValid() then
				ply.MutatorTrack:Stop()
				ply.MutatorTrack = nil
				ply.MutatorTrackT = 0
			end
		elseif trk == 2 then
			if IsValid(ply) && ply.BossTrack && ply.BossTrack:IsValid() then
				ply.BossTrack:Stop()
				ply.BossTrack = nil
				ply.BossTrackT = 0
			end
		end
	end

	local function PlayTrack(ply,snd,trk)
		StopTrack(ply)
		-- print(snd)
		sound.PlayFile("sound/" .. snd,"noplay noblock",function(soundchannel,errCode,errStr)
			if IsValid(soundchannel) then
				soundchannel:EnableLooping(true)
				soundchannel:SetVolume(0)
				soundchannel:SetPlaybackRate(1)
				soundchannel:Play()
				if trk == 1 then
					ply.MutatorTrack = soundchannel
					ply.MutatorTrackT = CurTime() +soundchannel:GetLength()
				elseif trk == 2 then
					ply.BossTrack = soundchannel
					ply.BossTrackT = CurTime() +soundchannel:GetLength()
				end
				//print("Playing sound!",snd,soundchannel:GetLength())
			else
				print("Error playing sound!",errCode,errStr)
			end
		end)
	end
	
	local col_survivor = Color(177,253,251)
	local halo_Add = halo.Add
	local table_insert = table.insert
	function ENT:Initialize()
		local ply = LocalPlayer()
		ply.MutatorTrackT = 0
		ply.BossTrackT = 0

		hook.Add("PreDrawHalos",self,function(self)
			local ply = LocalPlayer()
			if !IsValid(ply) or IsValid(ply) && ply:GetNW2Bool("AVP_DiedInSurvival",false) then return end
			for _,v in ents.Iterator() do
				if !IsValid(v) then continue end
				if (v:IsNPC() && v:GetClass() == "npc_vj_test_player") or (v:IsPlayer() && v != ply && !v:GetNW2Bool("AVP_DiedInSurvival",false) && !v.VJ_IsControllingNPC) then
					if !VJ.HasValue(VJ_AVP_HALOS.Survival,v) then
						table_insert(VJ_AVP_HALOS.Survival,v)
					end
					-- if IsValid(v:GetActiveWeapon()) && !VJ.HasValue(VJ_AVP_HALOS.Survival,v:GetActiveWeapon()) then
					-- 	table_insert(VJ_AVP_HALOS.Survival,v:GetActiveWeapon())
					-- end
				end
			end

			halo_Add(VJ_AVP_HALOS.Survival,col_survivor,0.25,0.25,1,true,true)
		end)

		hook.Add("Think",self,function(self)
			local ply = LocalPlayer()
			if !IsValid(ply) then return end

			ply.MutatorTrackT = ply.MutatorTrackT or 0
			ply.BossTrackT = ply.BossTrackT or 0

			if GetConVar("vj_avp_survival_music"):GetInt() == 1 then
				local specialRound = self:GetSpecialRound()
				if specialRound != true && ply.BossTrackT > 0 then
					StopTrack(ply,2)
					return
				elseif specialRound == true && ply.MutatorTrackT > 0 then
					StopTrack(ply,1)
					return
				end
				if ply.MutatorTrack then
					local FT = FrameTime() *2
					if CurTime() < self:GetWaveSwitchVolTime() then
						ply.MutatorTrack:SetVolume(Lerp(FT,ply.MutatorTrack:GetVolume(),0.05))
					else
						ply.MutatorTrack:SetVolume(Lerp(FT,ply.MutatorTrack:GetVolume(),0.4))
					end
				end
				if ply.BossTrack then
					local FT = FrameTime() *2
					if CurTime() < self:GetWaveSwitchVolTime() then
						ply.BossTrack:SetVolume(Lerp(FT,ply.BossTrack:GetVolume(),0.05))
					else
						ply.BossTrack:SetVolume(Lerp(FT,ply.BossTrack:GetVolume(),0.4))
					end
				end
				if specialRound then
					if !ply.BossTrack or ply.BossTrack && ply.BossTrackT < CurTime() then
						PlayTrack(ply,VJ.PICK(self.BossTracks),2)
					end
				else
					if !ply.MutatorTrack or ply.MutatorTrack && ply.MutatorTrackT < CurTime() then
						PlayTrack(ply,VJ.PICK(self.Tracks),1)
					end
				end
			else
				StopTrack(ply)
			end
		end)
	end
	
	function ENT:OnRemove()
		StopTrack(LocalPlayer())
	end
	return
end
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.MaxNPCs = 4
ENT.IncrementAmount = 4
ENT.PredatorModels = {
	"alien",
	"celtic",
	"claw",
	"spartan",
	"stalker",
	"tech",
	"youngblood",
}
---------------------------------------------------------------------------------------------------------------------------------------------
local marineList = {
	"npc_vj_avp_hum_connor",
	"npc_vj_avp_hum_franco",
	"npc_vj_avp_hum_gibson",
	"npc_vj_avp_hum_johnson",
	"npc_vj_avp_hum_moss",
	"npc_vj_avp_hum_youngwhite",
	"npc_vj_avp_hum_hispanic",
	"npc_vj_avp_hum_youngwhite",
	"npc_vj_avp_hum_butch",
	"npc_vj_avp_hum_blonde",
	"npc_vj_avp_hum_black",
	"npc_vj_avp_hum_black2",
	"npc_vj_avp_hum_van",
	"npc_vj_avp_hum_tequila",
	"npc_vj_avp_hum_rookie",
	-- "npc_vj_avp_hum_kaneko",

	"npc_vj_avp_hum_secuirty",
}
local marineWepList = {
	"weapon_vj_avp_pulserifle","weapon_vj_avp_pulserifle","weapon_vj_avp_pulserifle","weapon_vj_avp_pulserifle","weapon_vj_avp_pulserifle","weapon_vj_avp_pulserifle",
	"weapon_vj_avp_shotgun","weapon_vj_avp_shotgun","weapon_vj_avp_shotgun",
	"weapon_vj_avp_scopedrifle",
	"weapon_vj_avp_flamethrower",
	-- "weapon_vj_avp_smartgun",
	-- "weapon_vj_avp_pistol",
}
--
function ENT:SpawnBot(count,respawn)
	local plys = player.GetAll()
	local preds = self.IsPredatorPlayers
	for i = 1,count do
		timer.Simple(i *0.1,function()
			if !IsValid(self) then return end
			local pos = VJ.PICK(plys):GetPos()
			pos = pos +VectorRand() *math.Rand(0,1024)
			local spawnPoint = VJ_Nodegraph:GetNearestNode(pos,2).pos
			if spawnPoint == nil then
				debugMessage("Bot - ",i,"spawnPoint is nil, not spawning!")
			else
				local randOffset = VectorRand() *math.Rand(0,256)
				randOffset.z = 8
				if !preds then
					if self.VJ_PlayerBots then
						local bot = ents.Create("npc_vj_test_player")
						self:SetProperPos(bot,spawnPoint +randOffset)
						bot:SetAngles(Angle(0,AngleRand().y,0))
						bot.WeaponInventory_AntiArmorList = {}
						bot.WeaponInventory_MeleeList = {"weapon_vj_avp_pistol"}
						bot:Spawn()
						bot:Activate()
						bot:CapabilitiesAdd(bit.bor(CAP_AUTO_DOORS,CAP_OPEN_DOORS,CAP_USE))
						-- bot:Give(VJ.PICK(list.Get("NPC")["npc_vj_test_player"].Weapons))
						bot:Give(VJ.PICK({
							"weapon_vj_avp_pulserifle",
							"weapon_vj_avp_pulserifle",
							"weapon_vj_avp_pulserifle",
							"weapon_vj_avp_pulserifle",
							"weapon_vj_avp_shotgun",
							"weapon_vj_avp_shotgun",
							"weapon_vj_avp_shotgun",
							"weapon_vj_avp_scopedrifle",
							"weapon_vj_avp_scopedrifle",
							"weapon_vj_avp_flamethrower",
							"weapon_vj_avp_smartgun",
						}))
						-- bot:Give("weapon_vj_avp_pulserifle")
						bot:SetNW2Int("AVP_Score",0)
						self:DeleteOnRemove(bot)
						debugMessage("Bot - ",i,"Successfully spawned!")
						table.insert(self.Bots,bot)
					else
						local bot = ents.Create(VJ.PICK(marineList))
						self:SetProperPos(bot,spawnPoint +randOffset)
						bot:SetAngles(Angle(0,AngleRand().y,0))
						bot.VJ_NPC_Class = {"CLASS_PLAYER_ALLY"}
						bot.AlliedWithPlayerAllies = true
						bot.StartHealth = 100
						bot.HealthRegenParams.Enabled = false
						bot:Spawn()
						bot:Activate()
						bot:CapabilitiesAdd(bit.bor(CAP_AUTO_DOORS,CAP_OPEN_DOORS,CAP_USE))
						bot:Give(VJ.PICK(marineWepList))
						bot:SetNW2Int("AVP_Score",0)
						self:DeleteOnRemove(bot)
						debugMessage("Bot - ",i,"Successfully spawned!")
						table.insert(self.Bots,bot)
					end
				else
					local bot = ents.Create("npc_vj_avp_pred")
					self:SetProperPos(bot,spawnPoint +randOffset)
					bot:SetAngles(Angle(0,AngleRand().y,0))
					bot:Spawn()
					bot:Activate()
					bot.VJ_NPC_Class = {"CLASS_PLAYER_ALLY","CLASS_PREDATOR","CLASS_YAUTJA"}
					bot.AlliedWithPlayerAllies = true
					bot:SetNW2Int("AVP_Score",0)
					self:DeleteOnRemove(bot)
					debugMessage("Bot - ",i,"Successfully spawned!")
					table.insert(self.Bots,bot)
				end
			end
			
			if i == count then
				for _,v in pairs(plys) do
					if respawn then
						v:ChatPrint(count .. " allied bots have been respawned near you!")
					else
						v:ChatPrint(#self.Bots .. " allied bots have been deployed to assist you!")
					end
				end
			end
		end)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local math_ceil = math.ceil
--
function ENT:Initialize()
	self:SetSolid(SOLID_NONE)
	self:DrawShadow(false)

	self.NodegraphExists = VJ_Nodegraph:Exists()
	if !self.NodegraphExists then
		for _,v in pairs(player.GetAll()) do
			v:ChatPrint("Nodegraph does not exist!")
		end
		self:Remove()
		return
	end

	local plys = player.GetAll()

	self.BotsToRespawn = 0
	self.NextBotsRefreshT = 0
	self.NextCheckForStuckAITime = CurTime() +20
	self.NextBotsWaveRespawnT = CurTime() +120

	self.AllowBots = GetConVar("vj_avp_survival_bots"):GetInt() == 1
	self.VJ_PlayerBots = GetConVar("vj_avp_survival_plybots"):GetBool()
	self.MaxBosses = 0
	self.Bosses = {}
	self.Bots = {}
	self.Entities = {}
	self:SetWaveSwitching(true)
	self:SetWave(0)
	self:SetWaveSwitchVolTime(CurTime() +10)
	self.CurrentMaxNPCs = self.IncrementAmount
	self.KillsToNextWave = self.IncrementAmount
	self.KillsLeft = 0
	self.BossKillsLeft = 0
	self.NextSpawnAttemptT = CurTime() +math.Rand(2,6)

	timer.Simple(10,function()
		if IsValid(self) then
			self:SetSpecialRound(false)
			self:SetWaveSwitching(false)
			self.CurrentMaxNPCs = math_Clamp(self.IncrementAmount,1,self.MaxNPCs)
			self:SetWave(self:GetWave() +1)
			self.KillsLeft = self.IncrementAmount *self:GetWave()
			for _,v in pairs(player.GetAll()) do
				VJ_AVP_CSound(v,"cpthazama/avp/shared/grapple/grapple_sting_04.ogg")
				v:ChatPrint("Wave ".. self:GetWave() .. " has started...")
			end
		end
	end)

	for _,v in pairs(plys) do
		v:SetNW2Int("AVP_Score",0)
		v:SetNW2Entity("AVP_SurvivalEntity",self)
		v:SetNW2Bool("AVP_DiedInSurvival",false)
		v:ChatPrint("Survival will begin in 10 seconds...")
		-- VJ_AVP_CSound(v,"cpthazama/avp/shared/MP_ANNOUNCE_37.ogg")

		if !self.IsPredatorPlayers then
			v:StripWeapons()
			v:Give("weapon_vj_avp_pistol")
			v:Give("weapon_vj_avp_pulserifle")
		end
	end

	self.RespawnAsAI = GetConVar("vj_avp_survival_respawn"):GetInt() == 1

	hook.Add("PlayerSpawn",self,function(self,ply)
		if self.RespawnAsAI != true then return end
		timer.Simple(0.01,function()
			if IsValid(self) && IsValid(ply) && !IsValid(ply.VJ_TheControllerEntity) then
				self:RespawnPlayerAsAI(ply)
			end
		end)
	end)

	hook.Add("PlayerDeath",self,function(self,ply)
		-- ply:SetNW2Bool("AVP_DiedInSurvival",true)
		ply:SetNW2Int("AVP_Score",0)
	end)

	hook.Add("PlayerDeathThink",self,function(self,ply)
		if self:GetWaveSwitching() == true or self:GetCurrentTotalNPCs() <= 0 then
			ply.NextSpawnTime = CurTime() +0.5
			return
		end
	
		if (ply.NextSpawnTime && ply.NextSpawnTime > CurTime()) then return end
		if (ply:IsBot() || ply:KeyPressed(IN_ATTACK) || ply:KeyPressed(IN_ATTACK2) || ply:KeyPressed(IN_JUMP)) then
			ply:Spawn()
		end
	end)

	if self.AllowBots then
		local maxBots = GetConVar("vj_avp_survival_maxbots"):GetInt()
		local botCount = maxBots != 0 && maxBots or (game.SinglePlayer() && 3 or math_Clamp((game.MaxPlayers() -#plys) /2,1,4))
		self.MaxBots = botCount
		self:SpawnBot(botCount)
	end

	hook.Add("OnNPCKilled",self,function(self,npc,attacker,inflictor)
		if !IsValid(npc) then return end
		if VJ.HasValue(self.Entities,npc) then
			table.RemoveByValue(self.Entities,npc)
			if VJ.HasValue(self.Bosses,npc) then
				self.BossKillsLeft = self.BossKillsLeft -1
				table.RemoveByValue(self.Bosses,npc)
			end
			self.KillsLeft = self.KillsLeft -1
			if attacker:IsPlayer() then
				attacker:SetNW2Int("AVP_Score",attacker:GetNW2Int("AVP_Score") +(npc:GetMaxHealth() *0.1))
			end
			self:CheckNextRoundAvailability()
		elseif VJ.HasValue(self.Bots,npc) then
			table.RemoveByValue(self.Bots,npc)
			self.BotsToRespawn = self.BotsToRespawn +1
		end
	end)

	local function isDoorOpen(ent)
		if ent:GetClass() == "prop_door_rotating" then
			local state = ent:GetInternalVariable("m_eDoorState")
			return state == 2
		elseif ent:GetClass() == "func_door" or ent:GetClass() == "func_door_rotating" then
			return ent:GetInternalVariable("m_toggle_state") == 0
		end
		return false
	end
    for _, ent in pairs(ents.GetAll()) do
        if ent:GetClass() == "prop_door_rotating" or ent:GetClass() == "func_door" or ent:GetClass() == "func_door_rotating" then
            ent:Fire("Unlock", "", 0)
            if !isDoorOpen(ent) then
                ent:Fire("Open", "", 0)
            end
        end
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CheckNextRoundAvailability()
	if self.KillsLeft <= 0 then
		self:SetWaveSwitching(true)
		self:SetWaveSwitchVolTime(CurTime() +20)
		for _,v in pairs(player.GetAll()) do
			VJ_AVP_CSound(v,"cpthazama/avp/music/survival/survivor_wave_cleared_03.mp3")
			v:ChatPrint("Wave " .. self:GetWave() .. " has ended, next wave in 10 seconds...")
		end

		for _,v in pairs(self.Entities) do
			if IsValid(v) then
				v:Remove()
			end
		end

		if self.AllowBots then
			//local bots = self.Bots
			local deadBots = self.BotsToRespawn
			if deadBots > 0 then
				self:SpawnBot(deadBots,true)
				self.BotsToRespawn = 0
			end
		end

		timer.Simple(10,function()
			if IsValid(self) then
				self:NextRound()
			end
		end)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:NextRound()
	local wave = self:GetWave()
	local newWave = wave +1
	self.Queen = nil
	if newWave %5 == 0 then
		self.MaxBosses = newWave /5
		self:SetSpecialRound(true)
		self:SetWaveSwitching(false)
		self.CurrentMaxNPCs = math_Clamp(self.IncrementAmount *newWave,1,self.MaxNPCs)
		-- self.CurrentMaxNPCs = math_Clamp(self.CurrentMaxNPCs +self.IncrementAmount,1,self.MaxNPCs)
		self:SetWave(newWave)
		self.KillsLeft = self.IncrementAmount *newWave
		self.BossKillsLeft = math_ceil(newWave *0.5)
		for _,v in pairs(player.GetAll()) do
			VJ_AVP_CSound(v,"cpthazama/avp/music/sting/dead prey sting 02.ogg")
			VJ_AVP_CSound(v,"cpthazama/avp/shared/MP_ANNOUNCE_38.ogg")
			v:ChatPrint("Wave ".. newWave .. " has started...")
		end
	else
		self:SetSpecialRound(false)
		self:SetWaveSwitching(false)
		self.CurrentMaxNPCs = math_Clamp(self.IncrementAmount *newWave,1,self.MaxNPCs)
		self:SetWave(newWave)
		self.KillsLeft = self.IncrementAmount *newWave
		for _,v in pairs(player.GetAll()) do
			VJ_AVP_CSound(v,"cpthazama/avp/shared/grapple/grapple_sting_04.ogg")
			VJ_AVP_CSound(v,"cpthazama/avp/shared/MP_ANNOUNCE_23.ogg")
			v:ChatPrint("Wave ".. newWave .. " has started...")
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RespawnPlayerAsAI(ply)
	local predator = VJ.PICK(self.Bosses)
	if !IsValid(predator) then
		predator = VJ.PICK(self.Entities)
	end
	if IsValid(predator) && !predator.VJ_IsBeingControlled then
		local SpawnControllerObject = ents.Create("obj_vj_controller")
		SpawnControllerObject.VJCE_Player = ply
		SpawnControllerObject:SetControlledNPC(predator)
		SpawnControllerObject:Spawn()
		SpawnControllerObject:StartControlling()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GetTotalAmount(class)
	local total = 0
	for _,v in pairs(self.Entities) do
		if !IsValid(v) then
			table.remove(self.Entities,_)
			continue
		end
		if (class == nil or v:GetClass() == class) then
			total = total +1
		end
	end
	return total
end
---------------------------------------------------------------------------------------------------------------------------------------------
local math_abs = math.abs
--
function ENT:FindSpawnPoint(total,data)
    local data = data or {}
    local nodeType = data.NodeType or 2
    local nodeZone = data.NodeZone or 3
    local flagData = data.NodeFlags
    local spawnReq = data.SpawnReq
    local minDist = data.MinSpawnDist or 1000
    local maxDist = data.MaxSpawnDist or 3250
    local savedPoints = {}

	local function TestIsVisible(pos,ent)
		local test = ents.Create("prop_dynamic")
		test:SetModel("models/Humans/Group01/Male_Cheaple.mdl")
		test:SetPos(pos)
		test:Spawn()
		test:Activate()
		test:SetRenderMode(RENDERMODE_TRANSALPHA)
		test:SetColor(Color(255,255,255,1))
		-- test:SetNoDraw(true)
		-- test:SetSolid(SOLID_NONE)
		test:DrawShadow(false)
		test:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
		SafeRemoveEntityDelayed(test,0.01)

		return test:Visible(ent)
	end

    local function IsNodeValid(node)
        if node.type != nodeType then return false end
        if flagData && flagData != node.flags then return false end

        for _, v in ipairs(ents.GetAll()) do
            if (v:IsNPC() && (!v.VJ_NPC_Class or !table.HasValue(v.VJ_NPC_Class,"CLASS_YAUTJA"))) or (v:IsPlayer() && !VJ_CVAR_IGNOREPLAYERS && v:Alive()) then
                local heightDif = math_abs(v:GetPos().z - node.pos.z)
                local dist = v:GetPos():Distance(node.pos)
                if heightDif <= 500 then
                    minDist = minDist * 0.5
                end
                if dist < minDist or dist > maxDist or TestIsVisible(node.pos,v) then
                -- if dist < minDist or dist > maxDist or v:VisibleVec(node.pos) then
                    return false
                end
            end
        end
        if spawnReq then
            local minspawnReq = -spawnReq
            if util.TraceHull({
                start = node.pos,
                endpos = node.pos,
                mins = minspawnReq,
                maxs = spawnReq,
            }).Hit then
                return false
            end
        end
        return true
    end

    local nodegraph = table.Copy(VJ_Nodegraph.Data.Nodes)
    for _ = 1, total do
        local node = table.remove(nodegraph,math.random(#nodegraph))
        if IsNodeValid(node) then
            table.insert(savedPoints,node.pos)
        end
    end

    return #savedPoints > 0 && savedPoints or false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RespawnNPC(ent) // WHAT IS THIS USED FOR???????????????
	if !IsValid(ent) then return end
	if !VJ.HasValue(self.Entities,ent) then return end
	local spawnPoint = self:FindSpawnPoint(1)
	if spawnPoint == false then
		return
	end
	ent:SetPos(spawnPoint[1])
	ent:SetAngles(Angle(0,math.random(0,360),0))
	ent:DoSpawnCode()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RespawnEntity(ent)
	local spawnPoint = self:FindSpawnPoint(5)
	if spawnPoint == false then
		return
	end
	ent:SetPos(VJ.PICK(spawnPoint))
	ent:SetAngles(Angle(0,math.random(0,360),0))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:ClearCurrentWave()
	for _,v in pairs(self.Entities) do
		if IsValid(v) then
			v:Remove()
		end
	end
	self.Entities = {}
	self.Bosses = {}
	self.KillsLeft = 0
	self.BossKillsLeft = 0
	self:CheckNextRoundAvailability()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Think()
	-- if !self.NodegraphExists then
	-- 	for _,v in pairs(player.GetAll()) do
	-- 		v:ChatPrint("Nodegraph does not exist!")
	-- 	end
	-- 	self:Remove()
	-- 	return
	-- end
	
	local totalNPCs = self:GetTotalAmount()
	local curTime = CurTime()

	if !VJ_CVAR_IGNOREPLAYERS then
		if self.AllowBots then
			local bots = self.Bots
			if #bots > 0 && curTime >= self.NextBotsRefreshT then
				self.NextBotsRefreshT = curTime + math.Rand(2,12)
				for _,v in pairs(bots) do
					if IsValid(v) && !v.IsFollowing then
						if !v:IsInWorld() then
							self:RespawnEntity(v)
						end
						local closestPlayer = NULL
						local closestDist = 999999
						for _,v2 in pairs(player.GetAll()) do
							if v2:Alive() && !v2.VJ_IsControllingNPC && !v2:IsFlagSet(FL_NOTARGET) then
								local dist = v2:GetPos():Distance(v:GetPos())
								if dist < closestDist then
									closestPlayer = v2
									closestDist = dist
								end
							end
						end
						if IsValid(closestPlayer) && closestDist > (v:Visible(closestPlayer) && 750 or 350) then
							v:SetLastPosition(closestPlayer:GetPos() + Vector(math.random(-512,512),math.random(-512,512),0))
							v:SCHEDULE_GOTO_POSITION(closestDist <= 400 && "TASK_WALK_PATH" or "TASK_RUN_PATH",function(x)
								x.CanShootWhenMoving = true
								x.ConstantlyFaceEnemy = true
							end)
						end
					end
				end
			end
		end
		if self.RespawnAsAI then
			for _,v in player.Iterator() do
				if !v:GetNW2Bool("AVP_DiedInSurvival") then continue end
				if v:Alive() && (self:GetWaveSwitching() or totalNPCs <= 0 or v:GetNW2Int("AVP_SurvivalRespawn",0) > curTime) then
					v:KillSilent()
					continue
				end
				if v:Alive() && !IsValid(v.VJ_TheControllerEntity) then
					self:RespawnPlayerAsAI(v)
				end
			end
		end
	end

	self:SetCurrentTotalNPCs(totalNPCs)
	self:SetKillsRemaining(self.KillsLeft)
	local wave = self:GetWave()

	if self.NextSpawnAttemptT < curTime then
		if curTime > self.NextCheckForStuckAITime then
			self.NextCheckForStuckAITime = curTime +math.Rand(9,18)
			for _,v in pairs(self.Entities) do
				if IsValid(v) && v.VJ_IsBeingControlled != true && (v:IsUnreachable(v:GetEnemy() or self) or !v:IsInWorld()) then
					self:RespawnEntity(v)
				end
			end
		end
		self:SetPos(VJ.PICK(player.GetAll()):GetPos())
		if self.KillsLeft <= 0 or totalNPCs >= self.KillsLeft or totalNPCs >= self.CurrentMaxNPCs or self:GetWaveSwitching() then
			self.NextSpawnAttemptT = curTime + math.Rand(1,3)
			return
		end
		local totalSpawned = 0
		local spawnPoint = self:FindSpawnPoint(math_Clamp(self:GetWave(),1,4))
		if spawnPoint == false then
			return
		end
		RunConsoleCommand("ai_clear_bad_links")
		for _,s in pairs(spawnPoint) do
			if totalNPCs >= self.KillsLeft then continue end
			local boss = (self:GetSpecialRound() && #self.Bosses < self.MaxBosses && self.BossKillsLeft > 0)
			local bossType = (wave >= 30 && "npc_vj_avp_pred_predlord" or (wave < 30 && wave >= 20) && "npc_vj_avp_pred_wolf") or "npc_vj_avp_pred_dark"
			local npc = ents.Create(boss && bossType or "npc_vj_avp_pred")
			if !boss then
				npc.Model = "models/cpthazama/avp/predators/" .. VJ.PICK(self.PredatorModels) .. ".mdl"
			end
			npc:SetPos(s)
			npc:SetAngles(Angle(0,math.random(0,360),0))
			npc.SpawnedUsingMutator = true
			npc.Mutator = self
			npc.StartHealth = npc.StartHealth +(boss && 0 or (wave > 5 && wave *4 or 0))
			npc:Spawn()
			npc:Activate()
			npc:CapabilitiesAdd(bit.bor(CAP_AUTO_DOORS,CAP_OPEN_DOORS,CAP_USE))
			npc:DrawShadow(false)
			npc.AnimMovementType = wave > 3 && math.random(1,2) or wave > 5 && math.random(1,3) or wave > 7 && 3 or 1
			npc.EnemyXRayDetection = true
			npc.SightAngle = 360
			npc.SightDistance = 16000
			table.insert(self.Entities,npc)
			if boss then
				table.insert(self.Bosses,npc)
				if bossType == "npc_vj_avp_pred_dark" && wave >= 15 then
					npc:SetBodygroup(npc:FindBodygroupByName("mask"),2)
				end
			end
			totalSpawned = totalSpawned + 1
			if useDebug then Entity(1):ChatPrint("Spawned " .. class .. " at " .. tostring(s) .. "!") end
			if self:GetTotalAmount() > self.KillsLeft then
				SafeRemoveEntity(npc)
				break
			end
		end
		self.NextSpawnAttemptT = curTime +math.Rand(1,3)
	end

	self:NextThink(curTime)
	return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:ForceRound(round) -- Developer function to force a specific round | lua_run for _,v in pairs(ents.FindByClass("sent_vj_avp_survival")) do v:ForceRound(30) end
	if self:GetWaveSwitching() then return end
	self.KillsLeft = 0
	for _,v in pairs(self.Entities) do
		if IsValid(v) then
			v:Remove()
		end
	end

	self:SetWaveSwitching(true)
	self:SetWaveSwitchVolTime(CurTime() +20)
	for _,v in pairs(player.GetAll()) do
		VJ_AVP_CSound(v,"cpthazama/avp/music/survival/survivor_wave_cleared_03.mp3")
		v:ChatPrint("Wave " .. self:GetWave() .. " has ended, next wave in 10 seconds...")
	end

	if self.AllowBots then
		//local bots = self.Bots
		local deadBots = self.BotsToRespawn
		if deadBots > 0 then
			self:SpawnBot(deadBots,true)
			self.BotsToRespawn = 0
		end
	end

	timer.Simple(10,function()
		if IsValid(self) then
			self:SetWave(round -1)
			self:NextRound()
		end
	end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnRemove()
	for _,v in pairs(self.Entities) do
		if IsValid(v) then
			v:Remove()
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetProperPos(setEnt,origin)
	local mins = setEnt:OBBMins()
	local maxs = setEnt:OBBMaxs()
	local pos = origin || setEnt:GetPos()
	local nearents = ents.FindInBox(pos +mins,pos +maxs)
	maxs.x = maxs.x *2
	maxs.y = maxs.y *2
	local zMax = 0
	local entTgt
	for _,ent in ipairs(nearents) do
		if(ent != setEnt && ent:GetSolid() != SOLID_NONE && ent:GetSolid() != SOLID_BSP && gamemode.Call("ShouldCollide",setEnt,ent) != false) then
			local obbMaxs = ent:OBBMaxs()
			if(obbMaxs.z > zMax) then
				zMax = obbMaxs.z
				entTgt = ent
			end
		end
	end
	local tbl_filter = {setEnt,entTgt}
	local stayaway = zMax > 0
	if(!stayaway) then
		pos.z = pos.z +10
	else
		zMax = zMax +10
	end
	local left = Vector(0,1,0)
	local right = left *-1
	local forward = Vector(1,0,0)
	local back = forward *-1
	local trace_left = util.TraceLine({
		start = pos,
		endpos = pos +left *maxs.y,
		filter = tbl_filter
	})
	local trace_right = util.TraceLine({
		start = pos,
		endpos = pos +right *maxs.y,
		filter = tbl_filter
	})
	if(trace_left.Hit || trace_right.Hit) then
		if(trace_left.Fraction < trace_right.Fraction) then
			pos = pos +right *((trace_right.Fraction -trace_left.Fraction) *maxs.y)
		elseif(trace_right.Fraction < trace_left.Fraction) then
			pos = pos +left *((trace_left.Fraction -trace_right.Fraction) *maxs.y)
		end
	elseif(stayaway) then
		pos = pos +(math.random(1,2) == 1 && left || right) *maxs.y *1.8
		stayaway = false
	end
	local trace_forward = util.TraceLine({
		start = pos,
		endpos = pos +forward *maxs.x,
		filter = tbl_filter
	})
	local trace_backward = util.TraceLine({
		start = pos,
		endpos = pos +back *maxs.x,
		filter = tbl_filter
	})
	if(trace_forward.Hit || trace_backward.Hit) then
		if(trace_forward.Fraction < trace_backward.Fraction) then
			pos = pos +back *((trace_backward.Fraction -trace_forward.Fraction) *maxs.x)
		elseif(trace_backward.Fraction < trace_forward.Fraction) then
			pos = pos +forward *((trace_forward.Fraction -trace_backward.Fraction) *maxs.x)
		end
	elseif(stayaway) then
		pos = pos +(math.random(1,2) == 1 && forward || back) *maxs.x *1.8
		stayaway = false
	end
	if(stayaway) then -- We can't avoid whatever it is we're stuck in, let's try to spawn on top of it
		local start = entTgt:GetPos()
		start.z = start.z +zMax
		local endpos = start
		endpos.z = endpos.z +maxs.z
		local tr = util.TraceLine({
			start = start,
			endpos = endpos,
			filter = tbl_filter
		})
		if(!tr.Hit || (!tr.HitWorld && gamemode.Call("ShouldCollide",setEnt,tr.Entity) == false)) then
			pos.z = start.z
			stayaway = false
		else -- Just try to move to whatever direction seems best
			local trTgt = trace_left
			if(trace_right.Fraction < trTgt.Fraction) then trTgt = trace_right end
			if(trace_forward.Fraction < trTgt.Fraction) then trTgt = trace_forward end
			if(trace_backward.Fraction < trTgt.Fraction) then trTgt = trace_backward end
			pos = pos +trTgt.Normal *maxs.x
		end
	end
	setEnt:SetPos(pos)
end