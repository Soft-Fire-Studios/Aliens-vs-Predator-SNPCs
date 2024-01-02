AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/avp/xeno/queen.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 3000
ENT.HullType = HULL_LARGE

ENT.VJC_Data = {
    CameraMode = 2,
    ThirdP_Offset = Vector(0, 0, 20),
    FirstP_Bone = "Bip01 Head",
    FirstP_Offset = Vector(25, 0, -3),
    FirstP_ShrinkBone = false
}

ENT.HasBreath = true

ENT.CanLeap = false
ENT.CanSetGroundAngle = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnInit()
	if VJ_AVP_QueenExists(self) then
		self:Remove()
		if game.SinglePlayer() then
			Entity(1):ChatPrint("There can only be one Queen at a time!")
		else
			if IsValid(self:GetCreator()) then
				self:GetCreator():ChatPrint("There can only be one Queen at a time!")
			end
		end
		return
	end
	self.CurrentSet = 2
	self.SoundTbl_FootStep = {
		"cpthazama/avp/xeno/queen/alien_queen_footstep_01.wav",
		"cpthazama/avp/xeno/queen/alien_queen_footstep_02.wav",
		"cpthazama/avp/xeno/queen/alien_queen_footstep_03.wav",
	}
	if GetConVar("vj_avp_bosstheme_a"):GetBool() then
		self.HasSoundTrack = true
		self.SoundTbl_SoundTrack = {"cpthazama/avp/music/boss/Full Tilt Rampage.mp3"}
	end

	self.InBirth = false
	self.NextLookForBirthT = CurTime() +5
	self.NextSpawnEggT = 0
	self.NextCommandXenosT = 0
	self.Eggs = {}
end
---------------------------------------------------------------------------------------------------------------------------------------------
local table_Count = table.Count
local table_insert = table.insert
--
function ENT:OnThink()
	local curTime = CurTime()
	if self.Alerted then
		self.NextLookForBirthT = curTime +60
	end
	if !self.InBirth && curTime > self.NextLookForBirthT then
		if !self:IsBusy() && !self:IsMoving() then
			local vsched = vj_ai_schedule.New("vj_idle_wander")
			vsched:EngTask("TASK_GET_PATH_TO_RANDOM_NODE", 2000)
			vsched:EngTask("TASK_WAIT_FOR_MOVEMENT", 0)
			vsched.IsMovingTask = true
			self:SetMovementActivity(VJ.PICK(self.AnimTbl_Run))
			vsched.MoveType = 1
			if (customFunc) then customFunc(vsched) end
			self:StartSchedule(vsched)
		end
		local check = Vector(self:OBBMaxs().x *4,self:OBBMaxs().y *4,0)
		local trHull = util.TraceHull({
			start = self:GetPos(),
			endpos = self:GetPos(),
			filter = self,
			mins = check *-1,
			maxs = check,
		})
		if !trHull.Hit then
			self.InBirth = true
		end
	elseif self.InBirth then
		if !IsValid(self.EggSack) then
			local eggsack = ents.Create("prop_vj_animatable")
			eggsack:SetModel("models/cpthazama/avp/xeno/queen_eggsack.mdl")
			eggsack:SetPos(self:GetPos() +self:GetForward() *18 +self:GetUp() *-10)
			eggsack:SetAngles(self:GetAngles())
			eggsack:SetOwner(self)
			eggsack:SetParent(self)
			eggsack:Spawn()
			eggsack:Activate()
			eggsack:SetRenderMode(RENDERMODE_TRANSALPHA)
			eggsack:SetColor(Color(255,255,255,0))
			eggsack:SetRenderFX(kRenderFxSolidSlow)
			eggsack:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
			eggsack:AddEffects(EF_PARENT_ANIMATES)
			eggsack:ResetSequence("idle")
			self:DeleteOnRemove(eggsack)
			self.EggSack = eggsack
			self:VJ_ACT_PLAYACTIVITY("Alien_Queen_eggsack_enter",true,false,false)
			self:PlaySound({"^cpthazama/avp/xeno/alien/hud/queen_message_new_objective_01.ogg","^cpthazama/avp/xeno/alien/hud/queen_message_objective_complete_01.ogg"},150)
			self:SetIdleAnimation({ACT_IDLE_RELAXED},true)
			self.NextSpawnEggT = curTime +5
			self.NextCommandXenosT = curTime +math.random(5,10)
		end
		if self:IsMoving() then
			self:StopMoving()
		end
		self:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK)
		if curTime > self.NextCommandXenosT && math.random(1,20) == 1 then
			self.NextCommandXenosT = curTime +math.random(20,40)
			local command = {}
			local tbl = {}
			tbl.Drones = {}
			tbl.Warriors = {}
			tbl.Praetorian = {}

			for _,v in ents.Iterator() do
				if v.VJ_AVP_Xenomorph && v != self && !v.VJ_AVP_Xenomorph_Queen && self:CheckRelationship(v) == D_LI then
					if v.VJ_AVP_XenomorphID == "drone" then
						table_insert(tbl.Drones,v)
						command.Drone = true
						-- print("Found drone",v)
					elseif v.VJ_AVP_XenomorphID == "warrior" then
						table_insert(tbl.Warriors,v)
						command.Warrior = true
						-- print("Found warrior",v)
					elseif v.VJ_AVP_XenomorphID == "praetorian" then
						table_insert(tbl.Praetorian,v)
						command.Praetorian = true
						-- print("Found praetorian",v)
					end
				end
			end

			if !command.Drone && !command.Warrior && !command.Praetorian then return end

			self:PlaySound({"^cpthazama/avp/xeno/alien/hud/queen_message_new_objective_01.ogg","^cpthazama/avp/xeno/alien/hud/queen_message_objective_complete_01.ogg"},150)
			RunConsoleCommand("ai_clear_bad_links")

			local nodegraph = table.Copy(VJ_Nodegraph.Data.Nodes)
			if command.Drone then
				local possibleNodes = {}
				for _,node in pairs(nodegraph) do
					local dist = self:GetPos():Distance(node.pos)
					if node.type == 2 && dist < 1500 && dist > 500 then
						table_insert(possibleNodes,node.pos)
					end
				end
				for _,v in pairs(tbl.Drones) do
					local node = VJ.PICK(possibleNodes)
					if node then
						-- print("Sending ",v," to ",node)
						v:StopMoving()
						v:SetLastPosition(node)
						v:VJ_TASK_GOTO_LASTPOS((self:GetPos():Distance(node) > 500 && math.random(1,3) == 1) && "TASK_RUN_PATH" or "TASK_WALK_PATH", function(x)
							x.FaceData = {Type = VJ.NPC_FACE_ENEMY_VISIBLE}
							x.CanShootWhenMoving = true
						end)
					end
				end
			end
			if command.Warrior then
				local possibleNodes = {}
				for _,node in pairs(nodegraph) do
					local dist = self:GetPos():Distance(node.pos)
					if node.type == 2 && dist >= 1500 then
						table_insert(possibleNodes,node.pos)
					end
				end
				for _,v in pairs(tbl.Warriors) do
					local node = VJ.PICK(possibleNodes)
					if node then
						-- print("Sending ",v," to ",node)
						v:StopMoving()
						v:SetLastPosition(node)
						v:VJ_TASK_GOTO_LASTPOS((self:GetPos():Distance(node) > 500 && math.random(1,3) == 1) && "TASK_RUN_PATH" or "TASK_WALK_PATH", function(x)
							x.FaceData = {Type = VJ.NPC_FACE_ENEMY_VISIBLE}
							x.CanShootWhenMoving = true
						end)
					end
				end
			end
			if command.Praetorian then
				local possibleNodes = {}
				for _,node in pairs(nodegraph) do
					local dist = self:GetPos():Distance(node.pos)
					if node.type == 2 && dist <= 750 && dist > 400 then
						table_insert(possibleNodes,node.pos)
					end
				end
				for _,v in pairs(tbl.Praetorian) do
					local node = VJ.PICK(possibleNodes)
					if node then
						-- print("Sending ",v," to ",node)
						v:StopMoving()
						v:SetLastPosition(node)
						v:VJ_TASK_GOTO_LASTPOS((self:GetPos():Distance(node) > 500 && math.random(1,3) == 1) && "TASK_RUN_PATH" or "TASK_WALK_PATH", function(x)
							x.FaceData = {Type = VJ.NPC_FACE_ENEMY_VISIBLE}
							x.CanShootWhenMoving = true
						end)
					end
				end
			end
		end
		if curTime > self.NextSpawnEggT && table_Count(self.Eggs) < VJ_AVP_MAX_EGGS then
			self.NextSpawnEggT = curTime +math.random(5,15)
			local didSpawn = false
			local attempts = 0
			local goodPos = true
			local eggSack = self.EggSack
			local eggSackPos = eggSack:GetAttachment(1).Pos
			local filters = {self,eggSack}
			while didSpawn != true do
				attempts = attempts +1
				if attempts >= 50 then break end

				local vecRand = VectorRand() *750
				vecRand.z = self:GetPos().z
				local tr = util.TraceLine({
					start = self:GetPos() +self:GetUp() *150,
					endpos = self:GetPos() +VectorRand() *750,
					filter = filters,
					mask = MASK_SOLID_BRUSHONLY
				})
				local tr2 = util.TraceLine({
					start = tr.HitPos +tr.HitNormal *18,
					endpos = tr.HitPos +tr.HitNormal *18 +self:GetUp() *-750,
					filter = filters,
					mask = MASK_SOLID_BRUSHONLY
				})
				local trBox = util.TraceHull({
					start = tr2.HitPos +tr2.HitNormal *20,
					endpos = tr2.HitPos +tr2.HitNormal *20,
					mins = Vector(-15,-15,-15),
					maxs = Vector(15,15,15),
					mask = MASK_NPCSOLID,
					filter = filters
				})

				if !util.IsInWorld(tr2.HitPos) then continue end

				for _,v in pairs(ents.FindInSphere(tr2.HitPos, 50)) do
					if v:GetClass() == "npc_vj_avp_xeno_egg" then
						goodPos = false
						-- Entity(1):ChatPrint("Egg too close to this point!")
						break
					end
				end

				if goodPos && tr2.Hit && tr2.HitPos:Distance(self:GetPos()) > 150 && !trBox.Hit then
					local particle = ents.Create("info_particle_system")
					particle:SetKeyValue("effect_name", "vj_avp_xeno_spit")
					particle:SetPos(eggSackPos)
					particle:Spawn()
					particle:Activate()
					particle:SetParent(eggSack)
					particle:Fire("SetParentAttachment", "egg")
					particle:Fire("Start")
					particle:Fire("Kill", "", 1)

					local egg = ents.Create("npc_vj_avp_xeno_egg")
					egg:SetPos(tr2.HitPos)
					egg:SetAngles(self:GetAngles())
					egg:SetOwner(self)
					egg:Spawn()
					egg:Activate()
					egg:SetRenderMode(RENDERMODE_TRANSALPHA)
					egg:SetColor(Color(255,255,255,0))
					egg:SetRenderFX(kRenderFxSolidSlow)

					local particle = ents.Create("info_particle_system")
					particle:SetKeyValue("effect_name", "vj_avp_xeno_spit_impact")
					particle:SetPos(egg:GetPos())
					particle:Spawn()
					particle:Activate()
					particle:Fire("Start")
					particle:Fire("Kill", "", 0.1)

					egg.Queen = self
					table_insert(self.Eggs,egg)
					didSpawn = true
					-- Entity(1):ChatPrint("Egg spawned! [" .. egg:EntIndex() .. "] Attempts: " .. attempts .. " | Total Eggs: " .. table_Count(self.Eggs) .. "/" .. VJ_AVP_MAX_EGGS)
				end
			end
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Breathe()
	if CurTime() > (self.NextBreathT or 0) then
		local snd = "cpthazama/avp/xeno/alien queen/queen_breath_2.wav"
		VJ_CreateSound(self,snd,72)
		self.NextBreathT = CurTime() +SoundDuration(snd)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SelectMovementActivity()
	local act = ACT_RUN
	local ply = self.VJ_TheController
	if IsValid(ply) then
		if ply:KeyDown(IN_WALK) then
			act = ACT_WALK
		elseif self.Charging then
			act = ACT_SPRINT
		end
		return act
	end
	if self.Charging then
		act = ACT_SPRINT
	else
		local currentSchedule = self.CurrentSchedule
		if currentSchedule != nil then
			act = currentSchedule.MoveType == 0 && ACT_WALK or ACT_RUN
		end
	end
	return act
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SelectIdleActivity()
	return ACT_IDLE
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SelectTurnActivity(inAct)
	return inAct
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:WhenRemoved()
	if !self.Dead then
		for _, v in ipairs(self.Eggs) do
			if IsValid(v) then
				v:Remove()
			end
		end
	end
end