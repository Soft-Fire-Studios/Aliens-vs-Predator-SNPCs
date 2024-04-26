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
		"cpthazama/avp/music/survival/Full Tilt Rampage (Variant).mp3",
	}

	local function StopTrack(ply)
		if IsValid(ply) && ply.MutatorTrack && ply.MutatorTrack:IsValid() then
			ply.MutatorTrack:Stop()
			ply.MutatorTrack = nil
			ply.MutatorTrackT = 0
		end
	end

	local function PlayTrack(ply,snd)
		StopTrack(ply)
		-- print(snd)
		sound.PlayFile("sound/" .. snd,"noplay noblock",function(soundchannel,errCode,errStr)
			if IsValid(soundchannel) then
				soundchannel:EnableLooping(true)
				soundchannel:SetVolume(0)
				soundchannel:SetPlaybackRate(1)
				soundchannel:Play()
				ply.MutatorTrack = soundchannel
				ply.MutatorTrackT = CurTime() +soundchannel:GetLength()
				print("Playing sound!",snd,soundchannel:GetLength())
			else
				print("Error playing sound!",errCode,errStr)
			end
		end)
	end
	
	function ENT:Initialize()
		hook.Add("Think",self,function(self)
			local ply = LocalPlayer()
			if !IsValid(ply) then return end

			ply.MutatorTrackT = ply.MutatorTrackT or 0

			if GetConVar("vj_avp_survival_music"):GetInt() == 1 then
				if self:GetSpecialRound() != true then
					StopTrack(ply)
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
				if !ply.MutatorTrack or ply.MutatorTrack && ply.MutatorTrackT < CurTime() then
					PlayTrack(ply,VJ_PICK(self.Tracks))
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
ENT.MaxNPCs = 2
ENT.IncrementAmount = 4
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SpawnBot(count,respawn)
	local plys = player.GetAll()
	local preds = self.IsPredatorPlayers
	for i = 1,count do
		timer.Simple(i *0.1,function()
			if !IsValid(self) then return end
			local pos = VJ_PICK(plys):GetPos()
			pos = pos +VectorRand() *math.Rand(0,1024)
			local spawnPoint = VJ_Nodegraph:GetNearestNode(pos,2).pos
			if spawnPoint == nil then
				debugMessage("Bot - ",i,"spawnPoint is nil, not spawning!")
			else
				local randOffset = VectorRand() *math.Rand(0,256)
				randOffset.z = 8
				if !preds then
					local bot = ents.Create("npc_vj_test_humanply")
					-- bot:SetPos(spawnPoint +randOffset)
					self:SetProperPos(bot,spawnPoint +randOffset)
					bot:SetAngles(Angle(0,AngleRand().y,0))
					bot:Spawn()
					bot:Activate()
					-- bot:Give(VJ_PICK(list.Get("NPC")["npc_vj_test_humanply"].Weapons))
					bot:Give("weapon_vj_avp_pulserifle")
					bot:SetNW2Int("AVP_Score",0)
					self:DeleteOnRemove(bot)
					debugMessage("Bot - ",i,"Successfully spawned!")
					table.insert(self.Bots,bot)
				else
					local bot = ents.Create("npc_vj_avp_pred")
					self:SetProperPos(bot,spawnPoint +randOffset)
					bot:SetAngles(Angle(0,AngleRand().y,0))
					bot:Spawn()
					bot:Activate()
					bot.VJ_NPC_Class = {"CLASS_PLAYER_ALLY","CLASS_PREDATOR","CLASS_YAUTJA"}
					bot.PlayerFriendly = true
					bot.FriendsWithAllPlayerAllies = true
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
function ENT:Initialize()
	self:SetSolid(SOLID_NONE)
	self:DrawShadow(false)

	self.NodegraphExists = VJ_Nodegraph:Exists()

	local plys = player.GetAll()

	self.BotsToRespawn = 0
	self.NextBotsRefreshT = 0
	self.NextBotsWaveRespawnT = CurTime() +120

	self.AllowBots = GetConVar("vj_avp_survival_bots"):GetInt() == 1
	self.AlwaysAlerted = true
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
	self.NextSpawnAttemptT = CurTime() +math.Rand(2,6)

	self.XenoType = math.random(1,100) == 1 && "kxeno" or "xeno"
	self.IsPredatorPlayers = false

	timer.Simple(10,function()
		if IsValid(self) then
			self:SetSpecialRound(false)
			self:SetWaveSwitching(false)
			self.CurrentMaxNPCs = math.Clamp(self.CurrentMaxNPCs +self.IncrementAmount,1,self.MaxNPCs)
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
		v:ChatPrint("Survival will begin in 10 seconds...")
		VJ_AVP_CSound(v,"cpthazama/avp/shared/MP_ANNOUNCE_37.ogg")
		local cEnt = v.VJ_TheControllerEntity
		if IsValid(cEnt) && cEnt.VJCE_NPC.VJ_AVP_Predator then
			self.IsPredatorPlayers = true
		end
	end

	if self.IsPredatorPlayers then
		for _,v in pairs(plys) do
			if !IsValid(v.VJ_TheControllerEntity) then
				local Predator = ents.Create("npc_vj_avp_pred")
				Predator:SetPos(v:GetPos() +Vector(0,0,4))
				Predator:SetAngles(v:GetAngles())
				Predator:Spawn()
				Predator:Activate()
				Predator:SetOwner(v)
				Predator.VJ_NPC_Class = {"CLASS_PLAYER_ALLY","CLASS_PREDATOR","CLASS_YAUTJA"}
				Predator.PlayerFriendly = true
				Predator.FriendsWithAllPlayerAllies = true
				local SpawnControllerObject = ents.Create("obj_vj_npccontroller")
				SpawnControllerObject.VJCE_Player = v
				SpawnControllerObject:SetControlledNPC(chestburster)
				SpawnControllerObject:Spawn()
				SpawnControllerObject:StartControlling()
			end
		end

		hook.Add("PlayerSpawn",self,function(self,ply)
			if !IsValid(ply) then return end
			if !IsValid(ply.VJ_TheControllerEntity) then
				local Predator = ents.Create("npc_vj_avp_pred")
				Predator:SetPos(ply:GetPos() +Vector(0,0,4))
				Predator:SetAngles(ply:GetAngles())
				Predator:Spawn()
				Predator:Activate()
				Predator:SetOwner(ply)
				Predator.VJ_NPC_Class = {"CLASS_PLAYER_ALLY","CLASS_PREDATOR","CLASS_YAUTJA"}
				Predator.PlayerFriendly = true
				Predator.FriendsWithAllPlayerAllies = true
				local SpawnControllerObject = ents.Create("obj_vj_npccontroller")
				SpawnControllerObject.VJCE_Player = ply
				SpawnControllerObject:SetControlledNPC(chestburster)
				SpawnControllerObject:Spawn()
				SpawnControllerObject:StartControlling()
			end
		end)
	end

	if self.AllowBots then
		local maxBots = GetConVar("vj_avp_survival_maxbots"):GetInt()
		local botCount = maxBots != 0 && maxBots or (game.SinglePlayer() && 3 or math.Clamp((game.MaxPlayers() -#plys) /2,1,4))
		self.MaxBots = botCount
		self:SpawnBot(botCount)
	end

	hook.Add("OnNPCKilled",self,function(self,npc,attacker,inflictor)
		if !IsValid(npc) then return end
		if VJ_HasValue(self.Entities,npc) then
			table.RemoveByValue(self.Entities,npc)
			if VJ_HasValue(self.Bosses,npc) then
				table.RemoveByValue(self.Bosses,npc)
			end
			self.KillsLeft = self.KillsLeft -1
			if self.KillsLeft > 0 then
				for _,v in pairs(player.GetAll()) do
					v:ChatPrint("Aliens Remaining: ".. self.KillsLeft)
				end
			end
			if self.KillsLeft <= 0 then
				self:SetWaveSwitching(true)
				self:SetWaveSwitchVolTime(CurTime() +20)
				for _,v in pairs(player.GetAll()) do
					VJ_AVP_CSound(v,"cpthazama/avp/music/survival/survivor_wave_cleared_03.mp3")
					v:ChatPrint("Wave " .. self:GetWave() .. " has ended, next wave in 10 seconds...")
				end

				if self.AllowBots then
					local bots = self.Bots
					-- if CurTime() > self.NextBotsWaveRespawnT then
						local deadBots = self.BotsToRespawn
						if deadBots > 0 then
							self:SpawnBot(deadBots,true)
							self.BotsToRespawn = 0
						end
						-- self.NextBotsWaveRespawnT = CurTime() +120
					-- end
				end

				timer.Simple(10,function()
					if IsValid(self) then
						if (self:GetWave() +1) %5 == 0 then
							self.MaxBosses = self.MaxBosses +1
							self:SetSpecialRound(true)
							self:SetWaveSwitching(false)
							self.CurrentMaxNPCs = math.Clamp(self.CurrentMaxNPCs +self.IncrementAmount,1,self.MaxNPCs)
							self:SetWave(self:GetWave() +1)
							self.KillsLeft = self.IncrementAmount *self:GetWave()
							for _,v in pairs(player.GetAll()) do
								VJ_AVP_CSound(v,"cpthazama/avp/xeno/alien/vocals/alien_call_scream_01.ogg")
								VJ_AVP_CSound(v,"cpthazama/avp/music/sting/dead prey sting 02.ogg")
								VJ_AVP_CSound(v,"cpthazama/avp/shared/MP_ANNOUNCE_38.ogg")
								v:ChatPrint("Wave ".. self:GetWave() .. " has started...")
							end
						else
							self:SetSpecialRound(false)
							self:SetWaveSwitching(false)
							self.CurrentMaxNPCs = math.Clamp(self.CurrentMaxNPCs +self.IncrementAmount,1,self.MaxNPCs)
							self:SetWave(self:GetWave() +1)
							self.KillsLeft = self.IncrementAmount *self:GetWave()
							for _,v in pairs(player.GetAll()) do
								VJ_AVP_CSound(v,"cpthazama/avp/shared/grapple/grapple_sting_04.ogg")
								VJ_AVP_CSound(v,"cpthazama/avp/shared/MP_ANNOUNCE_23.ogg")
								v:ChatPrint("Wave ".. self:GetWave() .. " has started...")
							end
						end
					end
				end)
			end
		elseif VJ_HasValue(self.Bots,npc) then
			table.RemoveByValue(self.Bots,npc)
			self.BotsToRespawn = self.BotsToRespawn +1
		end
	end)
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
function ENT:FindSpawnPoint(total, data)
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
            if (v:IsNPC() && (!v.VJ_NPC_Class or !table.HasValue(v.VJ_NPC_Class, "CLASS_XENOMORPH"))) or (v:IsPlayer() && !VJ_CVAR_IGNOREPLAYERS && v:Alive()) then
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
        local node = table.remove(nodegraph, math.random(#nodegraph))
        if IsNodeValid(node) then
            table.insert(savedPoints, node.pos)
        end
    end

    return #savedPoints > 0 && savedPoints or false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RespawnNPC(ent) // This is called when a NPC is stuck and needs to respawn at a new node position, this should take away from the kill count
	if !IsValid(ent) then return end
	if !VJ_HasValue(self.Entities,ent) then return end
	local spawnPoint = self:FindSpawnPoint(1)
	if spawnPoint == false then
		return
	end
	ent:SetPos(spawnPoint[1])
	ent:SetAngles(Angle(0,math.random(0,360),0))
	ent:DoSpawnCode()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Think()
	if !self.NodegraphExists then
		for _,v in pairs(player.GetAll()) do
			v:ChatPrint("Nodegraph does not exist!")
		end
		self:Remove()
		return
	end

	if self.AllowBots && !VJ_CVAR_IGNOREPLAYERS then
		local bots = self.Bots
		if #bots > 0 && CurTime() >= self.NextBotsRefreshT then
			self.NextBotsRefreshT = CurTime() + math.Rand(2, 12)
			for _,v in pairs(bots) do
				if IsValid(v) && !v.IsFollowing then
					local closestPlayer = NULL
					local closestDist = 999999
					for _,v2 in pairs(player.GetAll()) do
						if v2:Alive() then
							local dist = v2:GetPos():Distance(v:GetPos())
							if dist < closestDist then
								closestPlayer = v2
								closestDist = dist
							end
						end
					end
					if IsValid(closestPlayer) && closestDist > (v:Visible(closestPlayer) && 750 or 350) then
						v:SetLastPosition(closestPlayer:GetPos() + Vector(math.random(-512, 512), math.random(-512, 512), 0))
						v:VJ_TASK_GOTO_LASTPOS(closestDist <= 400 && "TASK_WALK_PATH" or "TASK_RUN_PATH", function(x)
							x.CanShootWhenMoving = true
							x.ConstantlyFaceEnemy = true
						end)
					end
				end
			end
		end
	end

	self:SetCurrentTotalNPCs(self:GetTotalAmount())
	local wave = self:GetWave()

	if self.NextSpawnAttemptT < CurTime() then
		self:SetPos(VJ_PICK(player.GetAll()):GetPos())
		if self.KillsLeft <= 0 or self:GetCurrentTotalNPCs() >= self.KillsLeft or self:GetCurrentTotalNPCs() >= self.CurrentMaxNPCs or self:GetWaveSwitching() then
			self.NextSpawnAttemptT = CurTime() + math.Rand(1, 3)
			return
		end
		local totalSpawned = 0
		local spawnPoint = self:FindSpawnPoint(math.Clamp(self:GetWave(), 1, 4))
		if spawnPoint == false then
			return
		end
		RunConsoleCommand("ai_clear_bad_links")
		local xenoType = self.XenoType
		for _,s in pairs(spawnPoint) do
			if self:GetTotalAmount() >= self.KillsLeft then continue end
			local boss = (self:GetSpecialRound() && #self.Bosses < self.MaxBosses)
			local xeno = "npc_vj_avp_" .. xenoType .. "_drone"
			if wave >= 3 && wave < 5 then
				xeno = VJ.PICK({"npc_vj_avp_" .. xenoType .. "_drone","npc_vj_avp_" .. xenoType .. "_jungle"})
			elseif wave >= 5 && wave < 10 then
				xeno = VJ.PICK({"npc_vj_avp_" .. xenoType .. "_drone","npc_vj_avp_" .. xenoType .. "_jungle","npc_vj_avp_" .. xenoType .. "_warrior","npc_vj_avp_" .. xenoType .. "_warrior","npc_vj_avp_" .. xenoType .. "_warrior","npc_vj_avp_" .. xenoType .. "_warrior"})
			elseif wave >= 10 && wav < 15 then
				xeno = VJ.PICK({"npc_vj_avp_" .. xenoType .. "_warrior","npc_vj_avp_" .. xenoType .. "_warrior","npc_vj_avp_" .. xenoType .. "_ridged"})
			elseif wave >= 15 then
				xeno = VJ.PICK({"npc_vj_avp_" .. xenoType .. "_warrior","npc_vj_avp_" .. xenoType .. "_warrior","npc_vj_avp_" .. xenoType .. "_warrior","npc_vj_avp_" .. xenoType .. "_ridged","npc_vj_avp_" .. xenoType .. "_ridged","npc_vj_avp_" .. xenoType .. "_carrier"})
			end
			local npc = ents.Create(boss && ((wave >= 15 && math.random(1,50) == 1) && "npc_vj_avp_" .. xenoType .. "_predalien" or "npc_vj_avp_" .. xenoType .. "_praetorian") or xeno)
			npc:SetPos(s)
			npc:SetAngles(Angle(0, math.random(0, 360), 0))
			npc.SpawnedUsingMutator = true
			npc.Mutator = self
			npc.StartHealth = npc.StartHealth +(boss && 0 or (wave > 5 && wave *4 or 0))
			npc:Spawn()
			npc:Activate()
			npc:DrawShadow(false)
			npc.AnimMovementType = wave > 3 && math.random(1, 2) or wave > 5 && math.random(1,3) or wave > 7 && 3 or 1
			if self.AlwaysAlerted then
				npc.FindEnemy_UseSphere = true
				npc.FindEnemy_CanSeeThroughWalls = true
				npc.SightAngle = 180
			end
			if wave < 4 then
				npc.CanSpit = false
				npc.HasRangeAttack = false
			end
			table.insert(self.Entities, npc)
			if boss then
				table.insert(self.Bosses, npc)
			end
			totalSpawned = totalSpawned + 1
			if useDebug then Entity(1):ChatPrint("Spawned " .. class .. " at " .. tostring(s) .. "!") end
		end
		self.NextSpawnAttemptT = CurTime() + math.Rand(1, 3)
	end

	self:NextThink(CurTime())
	return true
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