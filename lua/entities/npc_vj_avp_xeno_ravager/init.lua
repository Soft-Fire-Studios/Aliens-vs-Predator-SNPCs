AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/avp/xeno/ravager.mdl"} -- Model(s) to spawn with | Picks a random one if it's a table
ENT.StartHealth = 1600
ENT.VJ_IsHugeMonster = true
ENT.HullType = HULL_LARGE

ENT.VJC_Data = {
    CameraMode = 2,
    ThirdP_Offset = Vector(0, 0, -35),
    FirstP_Bone = "Bip01 Head",
    FirstP_Offset = Vector(20, 0, 0),
    FirstP_ShrinkBone = false
}

ENT.HasBreath = true
ENT.FootStepSoundLevel = 95
ENT.FootStepPitch1 = 60
ENT.FootStepPitch2 = 68
ENT.GeneralSoundPitch1 = 70
ENT.GeneralSoundPitch2 = 75

ENT.FlinchChance = 60

ENT.AttackDamageMultiplier = 3
ENT.BulletDamageReductionRequirement = 80
ENT.CanSpit = false
ENT.CanScreamForHelp = false
ENT.CanLeap = false
ENT.CanLeapAttack = false
ENT.AlwaysStand = true
ENT.ReactsToFire = false
ENT.AnimTranslations = {
	[ACT_IDLE] = ACT_HL2MP_IDLE_SMG1,
	[ACT_WALK] = ACT_HL2MP_WALK_SMG1,
	[ACT_RUN] = ACT_HL2MP_WALK_CROUCH_SMG1,
	[ACT_MP_SPRINT] = ACT_HL2MP_RUN_SMG1,
	[ACT_TURN_LEFT] = ACT_ROLL_LEFT,
	[ACT_TURN_RIGHT] = ACT_ROLL_RIGHT,
}
ENT.FaceEnemyMovements = {ACT_HL2MP_WALK_SMG1,ACT_HL2MP_WALK_CROUCH_SMG1,ACT_HL2MP_RUN_SMG1,ACT_VM_SPRINT_IDLE}

ENT.StandingBounds = Vector(16,16,125)
ENT.CrawlingBounds = Vector(16,16,125)

ENT.DistractionSound = "cpthazama/avp/xeno/praetorian/vocal/praetorian_trophy_struggle_01.ogg"
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnInit()
	self.FootData = {
		["lfoot"] = {Range=20.5,OnGround=true},
		["rfoot"] = {Range=19.5,OnGround=true},
	}
	self.GeneralSoundPitch1 = 70
	self.GeneralSoundPitch2 = 75

	self.HitGroups = {}
	self.SoundTbl_Alert = {
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_taunt_01.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_taunt_02.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_taunt_03.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_taunt_04.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_taunt_05.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_taunt_06.ogg",
	}
	self.SoundTbl_Attack = {
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_trophy_struggle_01.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_trophy_struggle_02.ogg",
	}
	self.SoundTbl_CombatIdle = {
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_taunt_01.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_taunt_02.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_taunt_03.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_taunt_04.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_taunt_05.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_taunt_06.ogg",
	}
	self.SoundTbl_BeforeRangeAttack = {
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_trophy_struggle_01.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_trophy_struggle_02.ogg",
	}
	self.SoundTbl_RangeAttack = {}
	self.SoundTbl_Jump = {
		"cpthazama/avp/xeno/alien/vocals/alien_jump_grunt_01.ogg",
		"cpthazama/avp/xeno/alien/vocals/alien_jump_grunt_02.ogg",
		"cpthazama/avp/xeno/alien/vocals/alien_jump_grunt_03.ogg",
		"cpthazama/avp/xeno/alien/vocals/alien_jump_grunt_04.ogg",
	}
	self.SoundTbl_Pain = {
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_pain_01.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_pain_02.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_pain_04.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_pain_05.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_pain_06.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_pain_07.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_pain_08.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_pain_09.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_pain_10.ogg",
	}
	self.SoundTbl_Death = {
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_death_scream_01.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_death_scream_03.ogg",
	}

	self:SetStepHeight(40)
	self:CapabilitiesRemove(CAP_MOVE_JUMP)

	local bounds = self.StandingBounds or defStandingBounds
	local collisionMin, collisionMax = -bounds, bounds
	self:SetSurroundingBounds(Vector(collisionMin.x *3.4, collisionMin.y *3.4, collisionMin.z *1.2), Vector(collisionMax.x *3.4, collisionMax.y *3.4, collisionMax.z *1.2))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnStep(pos,name)
	util.ScreenShake(pos,9,100,0.35,800)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Breathe()
	if CurTime() > (self.NextBreathT or 0) then
		local snd = "cpthazama/avp/xeno/alien queen/alien_queen_breathe_in_0" .. math.random(1,3) .. ".ogg"
		local sndB = "cpthazama/avp/xeno/alien queen/alien_queen_breathe_out_0" .. math.random(1,3) .. ".ogg"
		VJ_CreateSound(self,snd,65,84)
		timer.Simple(1.5,function()
			if IsValid(self) then
				VJ_CreateSound(self,sndB,65,84)
			end
		end)
		self.NextBreathT = CurTime() +2.8
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SelectIdleActivity(act)
	return ACT_IDLE
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:BeforeRunDamage()
	self.AttackDamageType = bit.bor(DMG_SLASH,DMG_CRUSH)
end
---------------------------------------------------------------------------------------------------------------------------------------------
-- function ENT:MeleeAttackKnockbackVelocity(hitEnt)
-- 	return self:GetForward() *math.random(700,850) +self:GetUp() *100
-- end
---------------------------------------------------------------------------------------------------------------------------------------------
-- function ENT:OnHitEntity(ent,isProp)
-- 	if isProp then
-- 		local phys = ent:GetPhysicsObject()
-- 		if IsValid(phys) then
-- 			phys:ApplyForceCenter(self:GetForward() *1000 +self:GetUp() *250)
-- 		end
-- 	else
-- 		if ent.MovementType != VJ_MOVETYPE_STATIONARY && (!ent.VJ_IsHugeMonster or ent.IsVJBaseSNPC_Tank) then
-- 			ent:SetGroundEntity(NULL)
-- 			ent:SetVelocity(self:MeleeAttackKnockbackVelocity(ent))
-- 		end
-- 	end
-- end