AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/avp/xeno/royal_spitter.mdl"}
ENT.StartHealth = 800
ENT.VJ_ID_Boss = true
ENT.HullType = HULL_LARGE

ENT.ControllerParams = {
    CameraMode = 2,
    ThirdP_Offset = Vector(0, 0, -35),
    FirstP_Bone = "Bip01 Head",
    FirstP_Offset = Vector(20, 0, 0),
    FirstP_ShrinkBone = false
}

ENT.HasBreath = true
ENT.FootstepSoundLevel = 82
ENT.FootstepSoundPitch = VJ.SET(75, 85)
ENT.MainSoundPitch = VJ.SET(80, 88)

ENT.AttackDamageMultiplier = 1.2
ENT.AlwaysStand = false
ENT.CanSpit = true
ENT.AnimTranslations = {
	[ACT_IDLE] = ACT_HL2MP_IDLE_SMG1,
	[ACT_WALK] = ACT_HL2MP_WALK_SMG1,
	[ACT_RUN] = ACT_HL2MP_WALK_CROUCH_SMG1,
	[ACT_MP_SPRINT] = ACT_HL2MP_RUN_SMG1,
	[ACT_TURN_LEFT] = ACT_ROLL_LEFT,
	[ACT_TURN_RIGHT] = ACT_ROLL_RIGHT,
}
ENT.FaceEnemyMovements = {ACT_HL2MP_WALK_SMG1,ACT_HL2MP_WALK_CROUCH_SMG1,ACT_HL2MP_RUN_SMG1,ACT_VM_SPRINT_IDLE}

ENT.StandingBounds = Vector(16,16,84)
ENT.CrawlingBounds = Vector(16,16,65)
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnInit()
	self.FootData = {
		["lfoot"] = {Range=15.5,OnGround=true},
		["rfoot"] = {Range=15,OnGround=true},
		["lhand"] = {Range=12.5,OnGround=true},
		["rhand"] = {Range=12.5,OnGround=true}
	}
	self.MainSoundPitch = VJ.SET(115, 125)

	self.HitGroups = {}
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnStep(pos,name)
	util.ScreenShake(pos,5,100,0.35,500)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Breathe()
	if CurTime() > (self.NextBreathT or 0) then
		local snd = "cpthazama/avp/xeno/alien queen/alien_queen_breathe_in_0" .. math.random(1,3) .. ".ogg"
		local sndB = "cpthazama/avp/xeno/alien queen/alien_queen_breathe_out_0" .. math.random(1,3) .. ".ogg"
		VJ.CreateSound(self,snd,65,84)
		timer.Simple(1.5,function()
			if IsValid(self) then
				VJ.CreateSound(self,sndB,65,84)
			end
		end)
		self.NextBreathT = CurTime() +2.8
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SelectIdleActivity(act)
	return ACT_IDLE
end