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
	self:NetworkVar("Int",0,"TotalPacks")
	self:NetworkVar("Int",1,"FoundPacks")
	self:NetworkVar("Int",2,"RemainingTime")
	self:NetworkVar("Bool",0,"EndingSequence")
	self:NetworkVar("Bool",1,"FullyInitialized")
end
---------------------------------------------------------------------------------------------------------------------------------------------
if CLIENT then
	function ENT:Draw()
		return false
	end
	
	function ENT:DrawTranslucent()
		return false
	end

	local trackStartPred = "cpthazama/avp/music/hunt/Let The Hunt Begin.mp3"
	local trackStartHuman = "cpthazama/avp/music/hunt/OWLF Inbound.mp3"
	local trackRushEnd = "cpthazama/avp/music/hunt/Chopper Inbound.mp3"
	ENT.Tracks = {
		"cpthazama/avp/music/hunt/Amidst The Jungle.mp3",
		"cpthazama/avp/music/hunt/Approaching Guerrillas Camp.mp3",
		"cpthazama/avp/music/hunt/Cloaked & Stealthy.mp3",
		"cpthazama/avp/music/hunt/First Blood.mp3",
		"cpthazama/avp/music/hunt/Jungle Heat.mp3",
		"cpthazama/avp/music/hunt/Striking The Camp.mp3",
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
		print(ply,snd)
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
	
	local col_survivor = Color(253,220,177)
	local halo_Add = halo.Add
	local table_insert = table.insert
	function ENT:Initialize()
		local ply = LocalPlayer()
		ply.MutatorTrackT = 0
		ply.DidIntroTrack = false
		ply.StartedEndingTrack = false
		ply.VJ_AVP_PredatorNextNoiseT = CurTime() +6
		ply.VJ_AVP_PredatorNoiseT = 0
		ply.VJ_AVP_PredatorNoisePos = nil

		local noise = Material("hud/cpthazama/avp/hunt/noise.png","smooth mips")
		local arrow = Material("hud/cpthazama/avp/hunt/arrow.png","smooth mips")
		hook.Add("HUDPaint",self,function(self)
			local ply = LocalPlayer()
			if !IsValid(ply) then return end
			if ply.VJ_IsControllingNPC then
				if ply.VJ_AVP_PredatorNextNoiseT < CurTime() then
					ply.VJ_AVP_PredatorNoiseT = CurTime() +5
					ply.VJ_AVP_PredatorNextNoiseT = CurTime() +30
					
					local closestEnt = NULL
					local closestDist = 999999
					for _,v in ents.Iterator() do
						if (v:IsNPC() && v:GetClass() == "npc_vj_test_player") or (v:IsPlayer() && v != ply && !v.VJ_IsControllingNPC) then
							local dist = v:GetPos():Distance(ply:GetPos())
							if dist < closestDist then
								closestEnt = v
								closestDist = dist
							end
						end
					end
					ply.VJ_AVP_PredatorNoisePos = IsValid(closestEnt) && closestEnt:GetPos() +closestEnt:OBBCenter()
				end
				if ply.VJ_AVP_PredatorNoisePos && CurTime() < ply.VJ_AVP_PredatorNoiseT then
					local dist = ply:GetPos():Distance(ply.VJ_AVP_PredatorNoisePos)
					if dist <= 8000 && dist > 750 then
						local remainingRenderTime = ply.VJ_AVP_PredatorNoiseT -CurTime()
						local entPos = ply.VJ_AVP_PredatorNoisePos:ToScreen()
						local size = 500
						local a = math.Clamp(dist /8000,0,1)
						a = a *remainingRenderTime
						surface.SetDrawColor(Color(255,0,0,a *255))
						surface.SetMaterial(noise)
						surface.DrawTexturedRect(entPos.x -(size /2),entPos.y -(size /2),size,size)
					end
				elseif CurTime() >= ply.VJ_AVP_PredatorNoiseT then
					ply.VJ_AVP_PredatorNoisePos = nil
				end
			else
				for _,v in ents.Iterator() do
					if v.VJ_AVP_HuntPack then
						local entPos = (v:GetPos() +v:GetUp() *(v:OBBMaxs().z *2)):ToScreen()
						local size = 100 +math.sin(CurTime() *10) *10
						local a = math.Clamp(v:GetPos():Distance(ply:GetPos()) /750,0,1)
						surface.SetDrawColor(Color(185,244,255,a *255))
						surface.SetMaterial(arrow)
						surface.DrawTexturedRect(entPos.x -(size /2),entPos.y -(size /2),size,size)
					end
				end
			end
		end)

		hook.Add("CalcView",self,function(self,ply,pos,ang,fov,nearZ,farZ)
			if !IsValid(ply) then return end
			if ply.VJ_IsControllingNPC then return end
			if ply:Alive() then return end
			
			local tgt = ply:GetObserverTarget()
			if IsValid(tgt) then
				local start = tgt:GetPos() +tgt:GetUp() *(tgt:OBBMaxs().z *0.75)
				local tr = util.TraceHull({
					start = start,
					endpos = start +ang:Forward() *-100,
					filter = {ply,tgt},
					mins = Vector(-5,-5,-5),
					maxs = Vector(5,5,5),
					mask = MASK_SHOT,
				})
				pos = tr.HitPos +tr.HitNormal *2
				return {
					origin = pos,
					angles = ang,
					fov = fov,
					nearZ = nearZ,
					farZ = farZ,
				}
			end
		end)

		hook.Add("PreDrawHalos",self,function(self)
			local ply = LocalPlayer()
			if !IsValid(ply) or IsValid(ply) && ply.VJ_IsControllingNPC then return end
			for _,v in ents.Iterator() do
				if !IsValid(v) then continue end
				if (v:IsNPC() && v:GetClass() == "npc_vj_test_player") or (v:IsPlayer() && v != ply && ply:Alive() && !v.VJ_IsControllingNPC) then
					if !VJ_HasValue(VJ_AVP_HALOS.Hunt,v) then
						table_insert(VJ_AVP_HALOS.Hunt,v)
					end
				end
			end

			halo_Add(VJ_AVP_HALOS.Hunt,col_survivor,0.25,0.25,1,true,true)
		end)

		hook.Add("Think",self,function(self)
			local ply = LocalPlayer()
			if !IsValid(ply) then return end
			if !self:GetFullyInitialized() then return end

			ply.MutatorTrackT = ply.MutatorTrackT or 0

			if self:GetEndingSequence() && !ply.StartedEndingTrack && ply.MutatorTrack && ply.MutatorTrackT > CurTime() then
				StopTrack(ply)
				ply.StartedEndingTrack = true
			end

			if GetConVar("vj_avp_survival_music"):GetInt() == 1 then
				-- print("a")
				if ply.MutatorTrack then
					local FT = FrameTime() *2
					ply.MutatorTrack:SetVolume(Lerp(FT,ply.MutatorTrack:GetVolume(),0.4))
				end
				if !ply.MutatorTrack or ply.MutatorTrack && ply.MutatorTrackT < CurTime() then
					if ply.StartedEndingTrack then
						PlayTrack(ply,trackRushEnd)
					elseif !ply.DidIntroTrack then
						PlayTrack(ply,(ply.VJ_IsControllingNPC && ply.VJCE_NPC.VJ_AVP_Predator) && trackStartPred or trackStartHuman)
						ply.DidIntroTrack = true
					else
						PlayTrack(ply,VJ_PICK(self.Tracks))
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
function ENT:SpawnBot(count,respawn)
	local plys = player.GetAll()
	for i = 1,count do
		timer.Simple(i *0.01,function()
			if !IsValid(self) then return end
			local pos = VJ.PICK(plys):GetPos()
			local spawnPoint = pos
			if respawn then
				pos = pos +VectorRand() *math.Rand(0,1024)
				spawnPoint = VJ_Nodegraph:GetNearestNode(pos,2).pos
			else
				spawnPoint = self:FindNodesNearPoint(pos,8,256)
				if spawnPoint then
					spawnPoint = VJ.PICK(spawnPoint)
				end
				-- spawnPoint = VJ_Nodegraph:GetNearestNode(pos,2).pos
			end
			if !spawnPoint then
				debugMessage("Bot - ",i,"spawnPoint is nil, not spawning!")
			else
				local randOffset = VectorRand() *math.Rand(0,128)
				randOffset.z = 8
				local bot = ents.Create("npc_vj_test_player")
				-- bot:SetPos(spawnPoint +randOffset)
				self:SetProperPos(bot,spawnPoint +randOffset)
				bot:SetAngles(Angle(0,AngleRand().y,0))
				bot.WeaponInventory_AntiArmorList = {}
				bot.WeaponInventory_MeleeList = {"weapon_vj_glock17","weapon_vj_357"}
				bot.EntitiesToNoCollide = {"npc_vj_test_player"}
				bot:Spawn()
				bot:Activate()
				bot.VJ_AVP_HuntBot = true
				bot:Give(VJ.PICK({"weapon_vj_m16a1","weapon_vj_smg1","weapon_vj_k3","weapon_vj_spas12","weapon_vj_ssg08"}))
				self:DeleteOnRemove(bot)
				debugMessage("Bot - ",i,"Successfully spawned!")
				table.insert(self.Bots,bot)
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
local GM_END_TIME = 1
local GM_END_PRED_KILLED = 2
local GM_END_HUMANS_KILLED = 3
local GM_END_HUMAN_WIN = 4
--
function ENT:Initialize()
	self:SetSolid(SOLID_NONE)
	self:DrawShadow(false)

	local map = game.GetMap()
	if VJ_AVP_HuntData && !VJ_AVP_HuntData[map] then
		for _,v in pairs(player.GetAll()) do
			v:ChatPrint("This map does not have any Hunt Mode data!")
		end
		print("To make this map compatible with Hunt Mode, please add the map data to VJ_AVP_HuntData in an autorun file!")
		print("Example:")
		print("VJ_AVP_HuntData = VJ_AVP_HuntData or {}")
		print("VJ_AVP_HuntData['gm_construct'] = {}")
		print("VJ_AVP_HuntData['gm_construct'].InsurgentPoints = {")
		print("	Vector(0,0,0),")
		print("}")
		print("VJ_AVP_HuntData['gm_construct'].PlayerSpawn = {")
		print("	Vector(0,0,0),")
		print("}")
		print("VJ_AVP_HuntData['gm_construct'].PredatorSpawn = {")
		print("	{Pos=Vector(0,0,0),Ang=Angle(0,0,0)},")
		print("}")
		print("VJ_AVP_HuntData['gm_construct'].DataSpawn = {")
		print("	Vector(0,0,0),")
		print("}")
		print("VJ_AVP_HuntData['gm_construct'].Extract = Vector(0,0,0)")
		self:Remove()
		return
	elseif VJ_AVP_HuntData && VJ_AVP_HuntData[map] then
		local data = VJ_AVP_HuntData[map]
		self.InsurgentPoints = data.InsurgentPoints
		self.PlayerSpawn = data.PlayerSpawn
		self.PredatorSpawn = data.PredatorSpawn
		self.DataSpawn = data.DataSpawn
		self.Extract = data.Extract

		if !self.PlayerSpawn or !self.PredatorSpawn or !self.DataSpawn or !self.Extract then
			for _,v in pairs(player.GetAll()) do
				v:ChatPrint("This map does not have all the required Hunt Mode data!")
			end
			self:Remove()
			return
		end
	end

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
	self.NextRefreshSelfT = 0
	self.NextCheckForStuckAITime = CurTime() +20

	self.AllowBots = GetConVar("vj_avp_survival_bots"):GetInt() == 1
	self.Bots = {}
	self.Entities = {}

	hook.Add("PlayerDeath",self,function(self,ply)
		ply:SetNW2Bool("AVP_DiedInHunt",true)
		ply.VJ_AVP_SpectateEntity = nil
	end)

	hook.Add("PlayerDeathThink",self,function(self,ply)
		if ply:GetNW2Bool("AVP_DiedInHunt",false) then
			ply.NextSpawnTime = CurTime() +0.5
			local switchEnt = ply:KeyDown(IN_ATTACK)
			local switchTo
			if !IsValid(ply.VJ_AVP_SpectateEntity) then
				ply:SpectateEntity(nil)
				local plys = player.GetAll()
				for x,v in pairs(plys) do
					if v == ply then continue end
					if !v:Alive() then
						table.remove(plys,x)
					end
				end
				table.Merge(plys,self.Bots)
				table.insert(plys,self.Predator)
				switchTo = VJ.PICK(plys)
			end
			if switchEnt && CurTime() > (ply.VJ_AVP_SpectateSwitchT or 0) then
				local plys = player.GetAll()
				for x,v in pairs(plys) do
					if v == ply then continue end
					if !v:Alive() then
						table.remove(plys,x)
					end
				end
				table.Merge(plys,self.Bots)
				table.insert(plys,self.Predator)
				local curEnt = ply.VJ_AVP_SpectateEntity or plys[1]
				for x,v in pairs(plys) do
					if v == curEnt then
						if x == #plys then
							switchTo = plys[1]
						else
							switchTo = plys[x +1]
						end
						break
					end
				end

				ply.VJ_AVP_SpectateSwitchT = CurTime() +0.5
			end
			if IsValid(switchTo) then
				if !IsValid(ply:GetObserverTarget()) or ply.VJ_AVP_SpectateEntity != switchTo then
					ply:SetObserverMode(OBS_MODE_CHASE)
					ply:SpectateEntity(switchTo)
					-- ply:Spectate(OBS_MODE_CHASE)
					ply.VJ_AVP_SpectateEntity = switchTo
				end
				ply:SetPos(switchTo:GetPos() +switchTo:OBBCenter())
			end
			return
		end
	
		if (ply.NextSpawnTime && ply.NextSpawnTime > CurTime()) then return end
		if (ply:IsBot() || ply:KeyPressed(IN_ATTACK) || ply:KeyPressed(IN_ATTACK2) || ply:KeyPressed(IN_JUMP)) then
			ply:Spawn()
		end
	end)


	timer.Simple(0,function()
		if !IsValid(self) then return end
		for _,v in pairs(plys) do
			v:ChatPrint("[Predator Hunt] Please be patient while the mode initializes everything...")
			v:SetNW2Bool("AVP_DiedInHunt",false)
			self:SetProperPos(v,VJ.PICK(self.PlayerSpawn))
			v:SetHealth(100)
			v:SetArmor(100)
		end

		if self.AllowBots then
			local maxBots = GetConVar("vj_avp_survival_maxbots"):GetInt()
			local botCount = maxBots != 0 && maxBots or (game.SinglePlayer() && 3 or math.Clamp((game.MaxPlayers() -#plys) /2,1,4))
			self.MaxBots = botCount
			self:SpawnBot(botCount)
		end
	end)

	local debugPlayAsPredator = true
	local spawn = VJ.PICK(self.PredatorSpawn)
	local pred = ents.Create("npc_vj_avp_pred")
	pred:SetPos(spawn.Pos)
	pred:SetAngles(spawn.Ang)
	pred.SpawnedUsingMutator = true
	-- pred.FindEnemy_CanSeeThroughWalls = true
	-- pred.SightAngle = 360
	-- pred.SightDistance = 30000
	pred.DisableWandering = true
	pred:Spawn()
	pred:Activate()
	self:DeleteOnRemove(pred)
	self.Predator = pred
	table.insert(self.Entities,pred)

	timer.Simple(0.2,function()
		if !IsValid(self) then return end
		self:SetFullyInitialized(true)
	end)

	timer.Simple(0.15,function()
		if !IsValid(self) then return end
		if debugPlayAsPredator then
			local ply = VJ.PICK(plys)
			local SpawnControllerObject = ents.Create("obj_vj_controller")
			SpawnControllerObject.VJCE_Player = ply
			SpawnControllerObject:SetControlledNPC(pred)
			SpawnControllerObject:Spawn()
			SpawnControllerObject:StartControlling()
			ply:SetNW2Bool("AVP_DiedInHunt",true)
			ply.VJ_AVP_SpectateEntity = nil
		end

		local totalData = self.DataSpawn
		local totalToSpawn = math_Clamp(#totalData /2,1,4)
		self:SetTotalPacks(totalToSpawn)
		self:SetFoundPacks(0)
		self.DataPacks = {}
		for i = 1,totalToSpawn do
			local spawnPoint = self:FindNodesNearPoint(VJ.PICK(totalData),4,768)
			if spawnPoint == false then
				spawnPoint = VJ.PICK(totalData)
			else
				spawnPoint = VJ.PICK(spawnPoint)
			end
			local data = ents.Create("sent_vj_avp_huntpack")
			data:SetModel("models/props_c17/BriefCase001a.mdl")
			data:SetPos(spawnPoint +Vector(0,0,8))
			data:Spawn()
			data:Activate()
			self:DeleteOnRemove(data)
			table.insert(self.Entities,data)
			table.insert(self.DataPacks,data)

			data.Use = function(data,activator,caller)
				if !IsValid(activator) then return end
				if activator:IsPlayer() or activator.VJ_AVP_HuntBot then
					self:SetFoundPacks(self:GetFoundPacks() +1)
					if self:GetFoundPacks() >= self:GetTotalPacks() then
						self:NextPhase()
						for _,v in pairs(player.GetAll()) do
							v:ChatPrint("Final data pack has been found! Extraction point has been marked!")
						end
					else
						for _,v in pairs(player.GetAll()) do
							v:ChatPrint(activator.VJ_AVP_HuntBot && "A bot has found a data pack!" or "A data pack has been found!")
						end
					end
					data:Remove()
				end
			end
		end

		if self.InsurgentPoints then
			local totalSpawned = 0
			local maxInsurgents = 24
			local spawnAttempts = 0
			while spawnAttempts < 100 do
				local spawnPoint = self:FindNodesNearPoint(VJ.PICK(self.InsurgentPoints),1,2048)
				if spawnPoint == false then
					spawnAttempts = spawnAttempts +1
					continue
				end
				local ent = ents.Create("npc_vj_avp_hunt_enemy")
				ent:SetPos(VJ.PICK(spawnPoint))
				ent:SetAngles(Angle(0,math.random(0,360),0))
				ent:Spawn()
				ent:Activate()
				ent:Give("weapon_vj_ak47")
				self:DeleteOnRemove(ent)
				table.insert(self.Entities,ent)
				totalSpawned = totalSpawned +1
				if totalSpawned >= maxInsurgents then
					break
				end
			end
		end
	end)

	hook.Add("OnNPCKilled",self,function(self,npc,attacker,inflictor)
		if !IsValid(npc) then return end
		if VJ_HasValue(self.Entities,npc) then
			if self.Predator == npc then
				self:EndGame(GM_END_PRED_KILLED)
			end
			table.RemoveByValue(self.Entities,npc)
		elseif VJ_HasValue(self.Bots,npc) then
			table.RemoveByValue(self.Bots,npc)
			self.BotsToRespawn = self.BotsToRespawn +1
		end
		
		local humans = self:GetHumans()
		if #humans == 0 then
			self:EndGame(GM_END_HUMANS_KILLED)
		end
	end)

	self.GameLength = CurTime() +600
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:NextPhase()
	self.ExtractionPoint = self.Extract
	self:SetEndingSequence(true)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:EndGame(gmEn)
	if gmEn == GM_END_TIME then
		for _,v in pairs(player.GetAll()) do
			v:ChatPrint("Time is up, the game is a draw!")
		end
	elseif gmEn == GM_END_PRED_KILLED then
		for _,v in pairs(player.GetAll()) do
			v:ChatPrint("The Hunter has been slain!")
		end
	elseif gmEn == GM_END_HUMANS_KILLED then
		for _,v in pairs(player.GetAll()) do
			v:ChatPrint("The Hunter has completed its' hunt!")
		end
	elseif gmEn == GM_END_HUMAN_WIN then
		for _,v in pairs(player.GetAll()) do
			v:ChatPrint("Extraction successful, all leaked intel has been recovered!")
		end
	end
	self:Remove()
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
	local findNearPos = data.CheckPos or false
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

		if findNearPos then
			local dist = findNearPos:Distance(node.pos)
			if dist < minDist then
				return false
			end
		else
			for _, v in ipairs(ents.GetAll()) do
				if (v:IsNPC() && (!v.VJ_NPC_Class or !table.HasValue(v.VJ_NPC_Class,"CLASS_XENOMORPH"))) or (v:IsPlayer() && !VJ_CVAR_IGNOREPLAYERS && v:Alive()) then
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
function ENT:FindNodesNearPoint(checkPos,total,dist)
	local nodegraph = table.Copy(VJ_Nodegraph.Data.Nodes)
	local closestNode = NULL
	local closestDist = 999999
	for _,v in pairs(nodegraph) do
		local dist = v.pos:Distance(checkPos)
		if dist < closestDist then
			closestNode = v
			closestDist = dist
		end
	end
	local savedPoints = {}
	for _,v in pairs(nodegraph) do
		if v.pos:Distance(closestNode.pos) <= (dist or 1024) then
			table.insert(savedPoints,v.pos)
		end
	end
	return #savedPoints > 0 && savedPoints or false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RespawnNPC(ent) // WHAT IS THIS USED FOR???????????????
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
function ENT:RespawnEntity(ent)
	local spawnPoint = self:FindSpawnPoint(5)
	if spawnPoint == false then
		return
	end
	ent:SetPos(VJ.PICK(spawnPoint))
	ent:SetAngles(Angle(0,math.random(0,360),0))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GetHumans()
	local humans = {}
	for _,v in pairs(player.GetAll()) do
		if v:Alive() && !v.VJ_IsControllingNPC then
			table.insert(humans,v)
		end
	end
	table.Merge(humans,self.Bots)
	return humans
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Think()
	local curTime = CurTime()

	if !self:GetFullyInitialized() then return end

	if self:GetEndingSequence() then
		local humans = self:GetHumans()
		local totalInExtract = 0
		for _,v in pairs(humans) do
			if v:GetPos():Distance(self.ExtractionPoint) <= 250 then
				totalInExtract = totalInExtract +1
			end
		end
		if totalInExtract == #humans then
			self:EndGame(GM_END_HUMAN_WIN)
		end
	end

	-- if !VJ_CVAR_IGNOREPLAYERS then
		if self.AllowBots then
			if curTime >= self.NextBotsRefreshT then
				self.NextBotsRefreshT = curTime +math.Rand(2,12)
				local pred = self.Predator
				local bots = self.Bots
				if IsValid(pred) && !pred.VJ_IsBeingControlled then
					if math.random(1,3) == 1 && !pred:IsBusy() && IsValid(pred:GetEnemy()) && pred.NearestPointToEnemyDistance > 1000 then
						if self.ExtractionPoint then
							pred:SetLastPosition(self.ExtractionPoint +VectorRand() *math.Rand(0,512))
							pred:SCHEDULE_GOTO_POSITION("TASK_RUN_PATH",function(x)
								x.CanShootWhenMoving = true
								x.ConstantlyFaceEnemy = true
							end)
						else
							local dataPacks = self.DataPacks
							if #dataPacks > 0 then
								local closestPack = NULL
								local closestDist = 999999
								for _,v2 in pairs(dataPacks) do
									if IsValid(v2) then
										local dist = v2:GetPos():Distance(pred:GetPos())
										if dist < closestDist then
											closestPack = v2
											closestDist = dist
										end
									end
								end
								if IsValid(closestPack) then
									pred:SetLastPosition(closestPack:GetPos() +VectorRand() *math.Rand(0,512))
									pred:SCHEDULE_GOTO_POSITION("TASK_RUN_PATH",function(x)
										x.CanShootWhenMoving = true
										x.ConstantlyFaceEnemy = true
									end)
								end
							end
						end
					else
						local humans = self:GetHumans()
						if #humans > 0 then
							local human = VJ.PICK(humans)
							if human then
								if !pred:IsBusy() && ((IsValid(pred:GetEnemy()) && math.random(1,4) == 1) or !IsValid(pred:GetEnemy())) then
									local pos = self:FindNodesNearPoint(VJ.PICK(human:GetPos()),4,768)
									if pos then
										pred:SetLastPosition(VJ.PICK(pos))
										pred:SCHEDULE_GOTO_POSITION("TASK_RUN_PATH",function(x)
											x.CanShootWhenMoving = true
											x.ConstantlyFaceEnemy = true
										end)
									end
								end
							end
						end
					end
				end
				if #bots > 0 then
					for _,v in pairs(bots) do
						if IsValid(v) && !v.IsFollowing then
							if !v:IsInWorld() then
								self:RespawnEntity(v)
							end
							local closestPlayer = NULL
							local closestDist = 999999
							for _,v2 in pairs(player.GetAll()) do
								if v2:Alive() && !v2.VJ_IsControllingNPC then
									local dist = v2:GetPos():Distance(v:GetPos())
									if dist < closestDist then
										closestPlayer = v2
										closestDist = dist
									end
								end
							end
							local doObjective = math.random(1,2) == 1
							if !IsValid(closestPlayer) then
								doObjective = true
							end
							if !doObjective && IsValid(closestPlayer) && closestDist > (v:Visible(closestPlayer) && 750 or 350) then
								v:SetLastPosition(closestPlayer:GetPos() + Vector(math.random(-512,512),math.random(-512,512),0))
								v:SCHEDULE_GOTO_POSITION(closestDist <= 400 && "TASK_WALK_PATH" or "TASK_RUN_PATH",function(x)
									x.CanShootWhenMoving = true
									x.ConstantlyFaceEnemy = true
								end)
							elseif doObjective or !IsValid(closestPlayer) then
								if self.ExtractionPoint then
									v:SetLastPosition(self.ExtractionPoint)
									v:SCHEDULE_GOTO_POSITION("TASK_RUN_PATH",function(x)
										x.CanShootWhenMoving = true
										x.ConstantlyFaceEnemy = true
									end)
								else
									if v.Alerted then continue end
									local dataPacks = self.DataPacks
									if #dataPacks > 0 then
										local closestPack = NULL
										local closestDist = 999999
										for _,v2 in pairs(dataPacks) do
											if IsValid(v2) then
												local dist = v2:GetPos():Distance(v:GetPos())
												if dist < closestDist then
													closestPack = v2
													closestDist = dist
												end
											end
										end
										if IsValid(closestPack) then
											print(v,"Investigating data pack!",closestPack)
											if closestDist <= 80 then
												closestPack:Use(v)
											else
												v:SetLastPosition(closestPack:GetPos())
												v:SCHEDULE_GOTO_POSITION("TASK_RUN_PATH",function(x)
													x.CanShootWhenMoving = true
													x.ConstantlyFaceEnemy = true
												end)
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	-- end

	if curTime > self.NextRefreshSelfT then
		self:SetPos(VJ.PICK(player.GetAll()):GetPos())
		self.NextRefreshSelfT = curTime +math.Rand(3,6)
	end

	if curTime > self.GameLength then
		self:EndGame(GM_END_TIME)
	end

	self:NextThink(curTime)
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