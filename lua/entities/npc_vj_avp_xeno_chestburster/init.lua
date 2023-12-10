AddCSLuaFile("shared.lua")
include('shared.lua')
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
    ThirdP_Offset = Vector(0, 0, -15),
    FirstP_Bone = "Head",
    FirstP_Offset = Vector(3, 0, 3.35),
    FirstP_ShrinkBone = true
}

ENT.GeneralSoundPitch1 = 100
ENT.HasExtraMeleeAttackSounds = true

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
ENT.SoundTbl_MeleeAttackExtra = {
	"cpthazama/avp/weapons/alien/claws/alien_claw_impact_flesh_01.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_impact_flesh_02.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_impact_flesh_03.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_impact_flesh_04.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_impact_flesh_05.ogg",
}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Controller_Initialize(ply)
    net.Start("VJ_AVP_Xeno_Client")
		net.WriteBool(false)
		net.WriteEntity(self)
		net.WriteEntity(ply)
    net.Send(ply)

	function self.VJ_TheControllerEntity:CustomOnStopControlling()
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
	VJ.EmitSound(self,"cpthazama/avp/xeno/chestburster/chestburster_fleshrip_long_0" .. math.random(1,3) .. ".ogg",72)
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
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	self:SetGroundAngle()
end