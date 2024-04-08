AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/avp/xeno/chestburster.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 25
ENT.HullType = HULL_TINY
ENT.FindEnemy_CanSeeThroughWalls = true
ENT.Behavior = VJ_BEHAVIOR_NEUTRAL
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.BloodColor = "Yellow" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.CustomBlood_Particle = {"vj_avp_blood_xeno"}
ENT.CustomBlood_Decal = {"VJ_AVP_BloodXenomorph"}
ENT.VJ_NPC_Class = {"CLASS_XENOMORPH"} -- NPCs with the same class with be allied to each other

ENT.HasMeleeAttack = true
ENT.MeleeAttackDamage = 5
ENT.AnimTbl_MeleeAttack = {"vjges_vjseq_bite"}
ENT.MeleeAttackAnimationAllowOtherTasks = true
ENT.MeleeAttackDistance = 15
ENT.MeleeAttackDamageDistance = 60
ENT.TimeUntilMeleeAttackDamage = false

ENT.VJC_Data = {
    CameraMode = 2,
    ThirdP_Offset = Vector(0, 0, 10),
    FirstP_Bone = "Head",
    FirstP_Offset = Vector(3, 0, 4.5),
    FirstP_ShrinkBone = true
}

ENT.GeneralSoundPitch1 = 100
ENT.HasExtraMeleeAttackSounds = true
ENT.FootStepSoundLevel = 38
ENT.FootStepPitch = VJ.SET(110, 115)
ENT.FootStepTimeWalk = 0.2
ENT.FootStepTimeRun = 0.1

ENT.SoundTbl_FootStep = {
	"cpthazama/avp/xeno/facehugger/foley/fhg_squelch1.ogg",
	"cpthazama/avp/xeno/facehugger/foley/fhg_squelch2.ogg",
	"cpthazama/avp/xeno/facehugger/foley/fhg_squelch3.ogg",
	"cpthazama/avp/xeno/facehugger/foley/fhg_squelch4.ogg",
	"cpthazama/avp/xeno/facehugger/foley/fhg_squelch5.ogg",
	"cpthazama/avp/xeno/facehugger/foley/fhg_squelch6.ogg",
	"cpthazama/avp/xeno/facehugger/foley/fhg_squelch7.ogg",
}

ENT.SoundTbl_Idle = {
	"cpthazama/avp/xeno/chestburster/chestburster_skitter_01.ogg",
}
ENT.SoundTbl_Pain = {
	"cpthazama/avp/xeno/chestburster/chestburster_vocal_03.ogg",
	"cpthazama/avp/xeno/chestburster/chestburster_vocal_07.ogg",
}
ENT.SoundTbl_Death = {
	"cpthazama/avp/xeno/chestburster/chestburster_vocal_01.ogg",
	"cpthazama/avp/xeno/chestburster/chestburster_vocal_02.ogg",
}
ENT.SoundTbl_MeleeAttackMiss = {
	"cpthazama/avp/weapons/alien/claws/alien_claw_impact_flesh_01.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_impact_flesh_02.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_impact_flesh_03.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_impact_flesh_04.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_impact_flesh_05.ogg",
}
ENT.SoundTbl_MeleeAttackExtra = {
	"cpthazama/avp/weapons/alien/jaw/alien_jaw_impale_01.ogg",
	"cpthazama/avp/weapons/alien/jaw/alien_jaw_impale_02.ogg",
	"cpthazama/avp/weapons/alien/jaw/alien_jaw_impale_03.ogg",
	"cpthazama/avp/weapons/alien/jaw/alien_jaw_impale_04.ogg",
	"cpthazama/avp/weapons/alien/jaw/alien_jaw_impale_05.ogg",
}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Controller_Initialize(ply,controlEnt)
    net.Start("VJ_AVP_Xeno_Client")
		net.WriteBool(false)
		net.WriteEntity(self)
		net.WriteEntity(ply)
    net.Send(ply)

	controlEnt.VJC_Player_DrawHUD = false

	function controlEnt:CustomOnThink()
		self.VJC_NPC_CanTurn = self.VJC_Camera_Mode == 2
		self.VJC_BullseyeTracking = self.VJC_Camera_Mode == 2
	end

	function controlEnt:CustomOnStopControlling()
		net.Start("VJ_AVP_Xeno_Client")
			net.WriteBool(true)
			net.WriteEntity(self)
			net.WriteEntity(ply)
		net.Send(ply)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(4,4,6),Vector(-4,-4,0))
	sound.Play("cpthazama/avp/xeno/chestburster/chestburster_fleshrip_long_0" .. math.random(1,3) .. ".ogg",self:GetPos(),72)
	VJ.CreateSound(self,"cpthazama/avp/xeno/chestburster/chestburster_scream_0" .. math.random(1,3) .. ".ogg",80)
	local pred = self:GetOwner().VJ_AVP_Predator == true
	-- local pred = true
	for i = 1,5 do
		ParticleEffect(pred && "vj_avp_blood_predator" or "blood_impact_red_01",self:GetPos() +self:GetForward() *math.Rand(-10,10) +self:GetRight() *math.Rand(-10,10) +self:GetUp() *-(i *10),Angle())
	end
	if pred then
		self:SetSkin(1)
	end
	self:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK)
	timer.Simple(0,function()
		if IsValid(self) then
			self:VJ_ACT_PLAYACTIVITY("burst",true,false,false,0,{OnFinish=function(i)
				if i then return end
				self:SetState()
			end})
		end
	end)

	self:SetCollisionGroup(COLLISION_GROUP_PUSHAWAY)
	self.GrowT = CurTime() +60
	self.DidGrow = false
	self:SetModelScale(2.5,60)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == "step" then
		self:FootStepSoundCode()
	end
	if key == "bite" then
		self:MeleeAttackCode()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:VJ_TASK_COVER_FROM_ENEMY(moveType, customFunc)
	if self.MovementType == VJ_MOVETYPE_AERIAL or self.MovementType == VJ_MOVETYPE_AQUATIC then self:AA_IdleWander() return end
	moveType = moveType or "TASK_RUN_PATH"
	local schedCoverFromEnemy = vj_ai_schedule.New("vj_cover_from_enemy")
	schedCoverFromEnemy:EngTask("TASK_SET_ROUTE_SEARCH_TIME", 2)
	schedCoverFromEnemy:EngTask("TASK_GET_PATH_TO_RANDOM_NODE", 2500)
	schedCoverFromEnemy:EngTask(moveType or "TASK_RUN_PATH", 0)
	schedCoverFromEnemy:EngTask("TASK_WAIT_FOR_MOVEMENT", 0)
	schedCoverFromEnemy.RunCode_OnFail = function()
		//print("Cover from enemy failed!")
		local schedFailCoverFromEnemy = vj_ai_schedule.New("vj_cover_from_enemy_fail")
		schedFailCoverFromEnemy:EngTask("TASK_SET_ROUTE_SEARCH_TIME", 2)
		schedFailCoverFromEnemy:EngTask("TASK_GET_PATH_TO_RANDOM_NODE", 1500)
		schedFailCoverFromEnemy:EngTask(moveType or "TASK_RUN_PATH", 0)
		schedFailCoverFromEnemy:EngTask("TASK_WAIT_FOR_MOVEMENT", 0)
		if (customFunc) then customFunc(schedFailCoverFromEnemy) end
		self:StartSchedule(schedFailCoverFromEnemy)
	end
	if (customFunc) then customFunc(schedCoverFromEnemy) end
	self:StartSchedule(schedCoverFromEnemy)
end
---------------------------------------------------------------------------------------------------------------------------------------------
local animClass = {
	["npc_vj_avp_xeno_predalien"] = "predalien_hybrid_getup",
	["npc_vj_avp_kxeno_predalien"] = "predalien_hybrid_getup",
	["npc_vj_avp_xeno_praetorian"] = "praetorian_stand_summon",
	["npc_vj_avp_xeno_carrier"] = "praetorian_stand_summon",
	["npc_vj_avp_kxeno_carrier"] = "praetorian_stand_summon",
}
--
function ENT:CustomOnThink_AIEnabled()
	if self.Dead then return end

	self:SetHP(self:Health())
	self:SetGroundAngle()

	if !IsValid(self.VJ_TheController) && !self:IsBusy() && (self.CurrentSchedule == nil or self.CurrentSchedule != nil && self.CurrentSchedule.Name != "vj_cover_from_enemy") then
		self:VJ_TASK_COVER_FROM_ENEMY("TASK_RUN_PATH")
	end

	local remainingTime = self.GrowT -CurTime()
	if remainingTime <= 0 && !self.DidGrow then
		self.DidGrow = true
		local class = self.XenoClass or (self.VJ_AVP_K_Xenomorph && "npc_vj_avp_kxeno_drone" or "npc_vj_avp_xeno_drone")
		local ent = ents.Create(class)
		ent:SetPos(self:GetPos())
		ent:SetAngles(self:GetAngles())
		ent:SetOwner(self:GetOwner())
		ent:Spawn()
		ent:Activate()
		ent:SetModelScale(0.75)
		ent:SetModelScale(1,1)
		ent:VJ_ACT_PLAYACTIVITY(animClass[class] or "climb_stop",true,false,false)
		local cont = self.VJ_TheController
		undo.ReplaceEntity(self,ent)
		self:Remove()
		timer.Simple(0.12,function()
			if IsValid(cont) && IsValid(ent) then
				local SpawnControllerObject = ents.Create("obj_vj_npccontroller")
				SpawnControllerObject.VJCE_Player = cont
				SpawnControllerObject:SetControlledNPC(ent)
				SpawnControllerObject:Spawn()
				SpawnControllerObject:StartControlling()
			end
		end)
		return
	end
	if self.VJ_AVP_K_Xenomorph then
		self:SetColor(Color(167 *(1 -(remainingTime /120)),134 *(1 -(remainingTime /120)),44 *(1 -(remainingTime /120))))
	else
		local col = math.Clamp((remainingTime /120) *255,65,255)
		self:SetColor(Color(col,col,col))
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_OnBleed(dmginfo,hitgroup)
	self:Acid(dmginfo:GetDamagePosition(),125,3)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnKilled()
	self:Acid(self:GetPos(),200,15)
end
---------------------------------------------------------------------------------------------------------------------------------------------
local math_acos = math.acos
local math_deg = math.deg
local math_rad = math.rad
local math_abs = math.abs
--
function ENT:SetGroundAngle()
	local pos = self:GetPos()
	local len = self:GetUp() *50
	local ang = self:GetAngles()
	local ang_y = Angle(0,ang.y,0)
	local refreshRate = FrameTime() *20
	if self:OnGround() then
		local mins, maxs = self:GetCollisionBounds()
		local posForward, posBackward, posRight, posLeft
		local directionVectors = {
			forward = ang_y:Forward(),
			backward = ang_y:Forward() * -1,
			right = ang_y:Right(),
			left = ang_y:Right() * -1,
		}
		local hits = {}
		for direction, vector in pairs(directionVectors) do
			local startPos = pos + vector * ((vector == directionVectors.right or vector == directionVectors.left) and maxs.y or maxs.x)
			local tr = util.TraceLine({
				start = startPos,
				endpos = startPos - len,
				filter = self
			})
			hits[direction] = tr.HitPos
			if direction == "forward" then
				posForward = startPos
			elseif direction == "backward" then
				posBackward = startPos
			elseif direction == "right" then
				posRight = startPos
			elseif direction == "left" then
				posLeft = startPos
			end
		end

		local hitForward = hits.forward
		local hitBackward = hits.backward
		local hitRight = hits.right
		local hitLeft = hits.left
		local pitch
		local roll
		local pitchDif = math_abs(hitForward.z -hitBackward.z)
		local rollDif = math_abs(hitLeft.z -hitRight.z)
		if posForward:Distance(hitForward) > posBackward:Distance(hitBackward) then
			pitch = 90 -math_deg(math_acos(pitchDif /hitForward:Distance(posBackward)))
		else
			pitch = -(90 -math_deg(math_acos(pitchDif /hitBackward:Distance(posForward))))
		end
		if posLeft:Distance(hitLeft) > posRight:Distance(hitRight) then
			roll = -(90 -math_deg(math_acos(rollDif /hitLeft:Distance(posRight))))
		else
			roll = 90 -math_deg(math_acos(rollDif /hitRight:Distance(posLeft)))
		end

		local tr = util.TraceLine({
			start = pos,
			endpos = pos -len,
			filter = self
		})

		self.Incline = pitch
		-- self:ManipulateBonePosition(0,Vector(0,0,Lerp(refreshRate,self:GetManipulateBonePosition(0).z,-(tr.HitPos +tr.HitNormal):Distance(pos))))
		self:SetAngles(LerpAngle(refreshRate,self:GetAngles(),Angle(pitch,ang.y,roll)))
	else
		self.Incline = 0
		-- self:ManipulateBonePosition(0,Vector(0,0,Lerp(refreshRate,self:GetManipulateBonePosition(0).z,0)))
		self:SetAngles(LerpAngle(refreshRate,self:GetAngles(),Angle(0,ang.y,0)))
	end
end