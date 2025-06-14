AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/avp/xeno/chestburster.mdl"}
ENT.StartHealth = 25
ENT.HullType = HULL_TINY
ENT.EnemyXRayDetection = true
ENT.Behavior = VJ_BEHAVIOR_NEUTRAL
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.BloodColor = VJ.BLOOD_COLOR_YELLOW
ENT.BloodParticle = {"vj_avp_blood_xeno"}
ENT.BloodDecal = {"VJ_AVP_BloodXenomorph"}
ENT.VJ_NPC_Class = {"CLASS_XENOMORPH"}

ENT.HasMeleeAttack = true
ENT.MeleeAttackDamage = 5
ENT.AnimTbl_MeleeAttack = {"vjges_vjseq_bite"}
ENT.MeleeAttackDistance = 15
ENT.MeleeAttackDamageDistance = 60
ENT.TimeUntilMeleeAttackDamage = false

ENT.ControllerParams = {
    CameraMode = 2,
    ThirdP_Offset = Vector(0, 0, 10),
    FirstP_Bone = "Head",
    FirstP_Offset = Vector(3, 0, 4.5),
    FirstP_ShrinkBone = true
}

ENT.MainSoundPitch = 100
ENT.HasExtraMeleeAttackSounds = true
ENT.FootstepSoundLevel = 38
ENT.FootstepSoundPitch = VJ.SET(110, 115)
ENT.FootstepSoundTimerWalk = 0.2
ENT.FootstepSoundTimerRun = 0.1

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

	function controlEnt:OnThink()
		self.VJC_NPC_CanTurn = self.VJC_Camera_Mode == 2
		self.VJC_BullseyeTracking = self.VJC_Camera_Mode == 2
	end

	function controlEnt:OnStopControlling()
		net.Start("VJ_AVP_Xeno_Client")
			net.WriteBool(true)
			net.WriteEntity(self)
			net.WriteEntity(ply)
		net.Send(ply)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local table_insert = table.insert
--
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(4,4,6),Vector(-4,-4,0))
	sound.Play("cpthazama/avp/xeno/chestburster/chestburster_fleshrip_long_0" .. math.random(1,3) .. ".ogg",self:GetPos(),72)
	VJ.CreateSound(self,"cpthazama/avp/xeno/chestburster/chestburster_scream_0" .. math.random(1,3) .. ".ogg",80)
	local pred = IsValid(self:GetOwner()) && self:GetOwner().VJ_AVP_Predator == true
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
			self:PlayAnim("burst",true,false,false,0,{OnFinish=function(i)
				if i then return end
				self:SetState()
			end})
		end
	end)

	self:SetCollisionGroup(COLLISION_GROUP_PUSHAWAY)
	self:SetPhysicsDamageScale(0)
	self.GrowT = CurTime() +60
	self.DidGrow = false
	self:SetModelScale(2.5,60)

	if self.VJ_AVP_K_Xenomorph then
		self.VJ_NPC_Class = {"CLASS_XENOMORPH_KSERIES"}
		if GetConVar("vj_avp_kseries_ally"):GetBool() then
			table_insert(self.VJ_NPC_Class,"CLASS_WEYLAND_YUTANI")
		end
	end

	hook.Add("PlayerButtonDown", self, function(self, ply, button)
		if ply.VJ_IsControllingNPC == true && IsValid(ply.VJ_TheControllerEntity) then
			local cent = ply.VJ_TheControllerEntity
            if cent.VJCE_NPC == self then
                cent.VJCE_NPC:OnKeyPressed(ply,button)
            end
        end
    end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MaintainRelationships()
	local memories = self.RelationshipMemory
	local spawnedAsMutator = self.SpawnedUsingMutator
	local sightDist = self:GetMaxLookDistance()
	for _,ent in ipairs(self.RelationshipEnts) do
		if !IsValid(ent) then continue end
		if !spawnedAsMutator && !ent:Visible(self) && self:GetPos():Distance(ent:GetPos()) > sightDist *0.23 then
			self:SetRelationshipMemory(ent, VJ.MEM_OVERRIDE_DISPOSITION, D_NU)
			self:SetRelationshipMemory(ent, "avp_xeno_dispoverridden", true)
		elseif memories[ent]["avp_xeno_dispoverridden"] then
			self:SetRelationshipMemory(ent, VJ.MEM_OVERRIDE_DISPOSITION, nil)
			self:SetRelationshipMemory(ent, "avp_xeno_dispoverridden", false)
		end
	end
	baseclass.Get("npc_vj_creature_base").MaintainRelationships(self)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnKeyPressed(ply,key)
	if key == KEY_SPACE && !self:IsBusy() then
		local ply = self.VJ_TheController
		if self:GetNavType() != NAV_GROUND then return end

		local moving = self:IsMoving()
		local moveDir, moveAng = self:GetMovementDirection()
		local ang = ply:EyeAngles()
		ang:RotateAroundAxis(ang:Up(), moveAng.y)
		self:SetGroundEntity(NULL)
		self:StopCurrentSchedule()
		local jumpPos
		if moving then
			jumpPos = self:GetPos() +ang:Forward() *1 +ang:Up() *1
		else
			jumpPos = self:GetPos() +ang:Up() *1
		end
		local trajectory = VJ.CalculateTrajectory(self,nil,"CurveOld",self:GetPos(),jumpPos,moving && 400 or 350)
		self:ForceMoveJump(trajectory)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnInput(key,activator,caller,data)
	if key == "step" then
		self:PlayFootstepSound()
	end
	if key == "bite" then
		self:ExecuteMeleeAttack()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SCHEDULE_COVER_ENEMY(moveType, customFunc)
	if self.MovementType == VJ_MOVETYPE_AERIAL or self.MovementType == VJ_MOVETYPE_AQUATIC then self:AA_IdleWander() return end
	moveType = moveType or "TASK_RUN_PATH"
	local schedCoverFromEnemy = vj_ai_schedule.New("SCHEDULE_COVER_ENEMY")
	schedCoverFromEnemy:EngTask("TASK_SET_ROUTE_SEARCH_TIME", 2)
	schedCoverFromEnemy:EngTask("TASK_GET_PATH_TO_RANDOM_NODE", 2500)
	schedCoverFromEnemy:EngTask(moveType or "TASK_RUN_PATH", 0)
	schedCoverFromEnemy:EngTask("TASK_WAIT_FOR_MOVEMENT", 0)
	schedCoverFromEnemy.RunCode_OnFail = function()
		//print("Cover from enemy failed!")
		local schedFailCoverFromEnemy = vj_ai_schedule.New("SCHEDULE_COVER_ENEMY_FAIL")
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
	["npc_vj_avp_xeno_royal"] = "praetorian_stand_summon",
	["npc_vj_avp_kxeno_royal"] = "praetorian_stand_summon",
}
--
function ENT:OnThinkActive()
	if self.Dead then return end

	self:SetHP(self:Health())
	self:SetGroundAngle()

	if !IsValid(self.VJ_TheController) && !self:IsBusy() && (self.CurrentSchedule == nil or self.CurrentSchedule != nil && self.CurrentSchedule.Name != "SCHEDULE_COVER_ENEMY") then
		self:SCHEDULE_COVER_ENEMY("TASK_RUN_PATH")
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
		ent:PlayAnim(animClass[class] or "climb_stop",true,false,false)
		local cont = self.VJ_TheController
		undo.ReplaceEntity(self,ent)
		self:Remove()
		timer.Simple(0.12,function()
			if IsValid(cont) && IsValid(ent) then
				local SpawnControllerObject = ents.Create("obj_vj_controller")
				SpawnControllerObject.VJCE_Player = cont
				SpawnControllerObject:SetControlledNPC(ent)
				SpawnControllerObject:Spawn()
				SpawnControllerObject:StartControlling()
			end
		end)
		if (class == "npc_vj_avp_kxeno_predalien" or class == "npc_vj_avp_xeno_predalien" or class == "npc_vj_avp_xeno_superpredalien") then
			for _,v in pairs(ents.FindByClass("npc_vj_avp_pred*")) do
				if IsValid(v) && IsValid(v.VJ_TheController) then
					v.VJ_TheController:ChatPrint("[Incoming Transmission] An Abomination has been detected in your area. Dispatch of the foul creature immediately!")
				end
			end
		end
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
function ENT:OnDamaged(dmginfo, hitgroup, status)
	if status == "PreDamage" then
		local dmgInflictor = dmginfo:GetInflictor()
		local dmgAttacker = dmginfo:GetAttacker()
		local isFireDmg = self:IsOnFire() && IsValid(dmgInflictor) && IsValid(dmgAttacker) && dmgInflictor:GetClass() == "entityflame" && dmgAttacker:GetClass() == "entityflame"
		if isFireDmg then
			dmginfo:ScaleDamage(2)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnBleed(dmginfo,hitgroup)
	self:Acid(dmginfo:GetDamagePosition(),125,3)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnDeath(dmginfo, hitgroup, status)
	if status == "Finish" then
		self:Acid(self:GetPos(),200,15)
	end
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