AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.StartHealth = 100

ENT.VJC_Data = {
    CameraMode = 2,
    ThirdP_Offset = Vector(0, 0, -35),
    FirstP_Bone = "Bip01 Head",
    FirstP_Offset = Vector(4, 0, 1.5),
}

ENT.FootData = {
    ["lfoot"] = {Range = 9.36, OnGround = true},
    ["rfoot"] = {Range = 9.36, OnGround = true},
}

ENT.BloodColor = "Red"

ENT.PoseParameterLooking_InvertPitch = true
ENT.PoseParameterLooking_InvertYaw = true

ENT.UsePlayerModelMovement = true
ENT.HasMeleeAttack = true
ENT.TimeUntilMeleeAttackDamage = 0.25
ENT.CanCrouchOnWeaponAttack = false
ENT.Weapon_AimTurnDiff = 0.74

local moveslikejaggerfuckingkms = 21378944
ENT.AnimTbl_TakingCover = moveslikejaggerfuckingkms

ENT.GeneralSoundPitch1 = 97
ENT.GeneralSoundPitch2 = 103
ENT.DisableFootStepSoundTimer = true

ENT.HasFlashlight = true
ENT.HasMotionTracker = true
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GenderInit(gender)
	return "models/cpthazama/avp/marines/alex.mdl"
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPreInitialize()
	-- self.Gender = self.Gender or 1 // math.random(1,2)
	self.Model = self:GenderInit(self.Gender)

	if self.VJ_AVP_IsTech then
		self:SynthInitialize()
	elseif self.VJ_AVP_Colonist then
		self:ColonistInitialize()
	else
		self:MarineInitialize(self.Gender)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MarineInitialize(gender)
	local VO = self.VO or math.random(1,2)
	if gender == 1 then -- Male
		if VO == 1 then
			self.SoundTbl_LostEnemy = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/AGGRESSIVE_TO_ALERT_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/AGGRESSIVE_TO_ALERT_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/AGGRESSIVE_TO_ALERT_MAR01_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/AGGRESSIVE_TO_ALERT_MAR01_04.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/AGGRESSIVE_TO_ALERT_MAR01_05.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/AGGRESSIVE_TO_ALERT_MAR01_08.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/AGGRESSIVE_TO_ALERT_MAR01_10.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/ALERT_TO_PASSIVE_MAR01_04.ogg",
			}
			self.SoundTbl_Alert = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/ATTACKING_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/ATTACKING_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/ATTACKING_MAR01_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/ATTACKING_MAR01_04.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/ATTACKING_MAR01_05.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/ATTACKING_MAR01_06.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/ATTACKING_MAR01_08.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/ATTACKING_MAR01_09.ogg",
			}
			self.SoundTbl_SeeBody = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/DISCOVER_BODY_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/DISCOVER_BODY_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/DISCOVER_BODY_MAR01_03.ogg",
			}
			self.SoundTbl_DistractionSuccess = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/DISTRACTION_SUCCESS_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/DISTRACTION_SUCCESS_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/DISTRACTION_SUCCESS_MAR01_03.ogg",
			}
			self.SoundTbl_Suppressing = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/ENTERING_COVER_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/ENTERING_COVER_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/ENTERING_COVER_MAR01_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/ENTERING_COVER_MAR01_04.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/ENTERING_COVER_MAR01_05.ogg",
			}
			self.SoundTbl_OnReceiveOrder = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/FLANKING_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/FLANKING_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/FLANKING_MAR01_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/FLANKING_MAR01_04.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/FLANKING_MAR01_05.ogg",
			}
			self.SoundTbl_DamageByPlayer = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/FRIENDLY_FIRE_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/FRIENDLY_FIRE_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/FRIENDLY_FIRE_MAR01_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/FRIENDLY_FIRE_MAR01_04.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/FRIENDLY_FIRE_MAR01_05.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/FRIENDLY_FIRE_MAR01_06.ogg",
			}
			self.SoundTbl_InvestigateComplete = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/INVESTIGATE_ARRIVAL_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/INVESTIGATE_ARRIVAL_MAR01_04.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/INVESTIGATE_END_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/INVESTIGATE_END_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/INVESTIGATE_END_MAR01_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/INVESTIGATE_END_MAR01_04.ogg",
			}
			self.SoundTbl_OnKilledEnemy = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/KILLED_THREAT_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/KILLED_THREAT_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/KILLED_THREAT_MAR01_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/KILLED_THREAT_MAR01_04.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/KILLED_THREAT_MAR01_05.ogg",
			}
			self.SoundTbl_MotionTracker_Far = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/MOTION_TRACK_FAR_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/MOTION_TRACK_FAR_MAR01_02.ogg",
			}
			self.SoundTbl_MotionTracker_Mid = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/MOTION_TRACK_MID_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/MOTION_TRACK_MID_MAR01_02.ogg",
			}
			self.SoundTbl_MotionTracker_Close = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/MOTION_TRACK_NEAR_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/MOTION_TRACK_NEAR_MAR01_02.ogg",
			}
			self.SoundTbl_Pain = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/PAIN_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/PAIN_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/pain_mm01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/pain_mm01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/pain_mm01_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/pain_mm01_04.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/pain_mm01_05.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/pain_mar01_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/pain_mar01_04.ogg",
			}
			self.SoundTbl_Investigate = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/PASSIVE_TO_ALERT_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/PASSIVE_TO_ALERT_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/PASSIVE_TO_ALERT_MAR01_03.ogg",
			}
			self.SoundTbl_WeaponReload = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/RELOADING_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/RELOADING_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/RELOADING_MAR01_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/RELOADING_MAR01_05.ogg",
			}
			self.SoundTbl_Spot_XenoLarge = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_ALIEN_LARGE_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_ALIEN_LARGE_MAR01_02.ogg",
			}
			self.SoundTbl_Spot_Xeno = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_ALIEN_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_ALIEN_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_ALIEN_MAR01_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_ALIEN_MAR01_04.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_ALIEN_MAR01_05.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_ALIEN_MAR01_06.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_ALIEN_MAR01_07.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_ALIEN_MAR01_08.ogg",
			}
			self.SoundTbl_Spot_Android = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_ANDROID_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_ANDROID_MAR01_02.ogg",
			}
			self.SoundTbl_Spot_PredatorCloaked = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_CLOAKED_PREDATOR_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_CLOAKED_PREDATOR_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_CLOAKED_PREDATOR_MAR01_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_CLOAKED_PREDATOR_MAR01_04.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_CLOAKED_PREDATOR_MAR01_05.ogg",
			}
			self.SoundTbl_Spot_Predator = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_PREDATOR_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_PREDATOR_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_PREDATOR_MAR01_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_PREDATOR_MAR01_04.ogg",
			}
			self.SoundTbl_AllyDeath_Xeno = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/SQUAD_DEATH_BY_ALIEN_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SQUAD_DEATH_BY_ALIEN_MAR01_02.ogg",
			}
			self.SoundTbl_AllyDeath_Android = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/SQUAD_DEATH_BY_ANDROID_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SQUAD_DEATH_BY_ANDROID_MAR01_02.ogg",
			}
			self.SoundTbl_AllyDeath_Predator = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/SQUAD_DEATH_BY_PREDATOR_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SQUAD_DEATH_BY_PREDATOR_MAR01_02.ogg",
			}
			self.SoundTbl_AllyDeath = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/SQUAD_DEATH_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SQUAD_DEATH_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SQUAD_DEATH_MAR01_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SQUAD_DEATH_MAR01_04.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SQUAD_DEATH_MAR01_05.ogg",
			}
			self.SoundTbl_Surprised = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/SURPRISE_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SURPRISE_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SURPRISE_MAR01_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SURPRISE_MAR01_04.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SURPRISE_MAR01_05.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SURPRISE_MAR01_06.ogg",
			}
			self.SoundTbl_Alert_Horde = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/TARGETS_MANY_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/TARGETS_MANY_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/TARGETS_MANY_MAR01_03.ogg",
			}
			self.SoundTbl_Death = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/death_mar01_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/death_mar01_04.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/death_mm01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/death_mm01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/death_mm01_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/death_mm01_04.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/death_mm01_05.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/DEATH_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/DEATH_MAR01_02.ogg",
			}
		else
			self.SoundTbl_LostEnemy = {
				"cpthazama/avp/humans/vocals/Male_Marine_02/AGGRESSIVE_TO_ALERT_MAR02_06.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/AGGRESSIVE_TO_ALERT_MAR02_07.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/AGGRESSIVE_TO_ALERT_MAR02_08.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/ALERT_TO_PASSIVE_MAR02_04.ogg",
			}
			self.SoundTbl_Alert = {}
			self.SoundTbl_SeeBody = {
				"cpthazama/avp/humans/vocals/Male_Marine_02/DISCOVER_BODY_MAR02_04.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/DISCOVER_BODY_MAR02_06.ogg",
			}
			self.SoundTbl_DistractionSuccess = {
				"cpthazama/avp/humans/vocals/Male_Marine_02/DISTRACTION_SUCCESS_MAR02_04.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/DISTRACTION_SUCCESS_MAR02_05.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/DISTRACTION_SUCCESS_MAR02_06.ogg",
			}
			self.SoundTbl_Suppressing = {
				"cpthazama/avp/humans/vocals/Male_Marine_02/ATTACKING_MAR02_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/ATTACKING_MAR02_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/ATTACKING_MAR02_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/ATTACKING_MAR02_04.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/ATTACKING_MAR02_05.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/ATTACKING_MAR02_06.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/ATTACKING_MAR02_08.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/ATTACKING_MAR02_09.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/FLANKING_MAR02_06.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/FLANKING_MAR02_07.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/FLANKING_MAR02_08.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/FLANKING_MAR02_09.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/FLANKING_MAR02_10.ogg",
			}
			self.SoundTbl_OnReceiveOrder = {}
			self.SoundTbl_DamageByPlayer = {
				"cpthazama/avp/humans/vocals/Male_Marine_02/FRIENDLY_FIRE_MAR02_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/FRIENDLY_FIRE_MAR02_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/FRIENDLY_FIRE_MAR02_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/FRIENDLY_FIRE_MAR02_04.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/FRIENDLY_FIRE_MAR02_05.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/FRIENDLY_FIRE_MAR02_10.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/FRIENDLY_FIRE_MAR02_12.ogg",
			}
			self.SoundTbl_InvestigateComplete = {}
			self.SoundTbl_OnKilledEnemy = {
				"cpthazama/avp/humans/vocals/Male_Marine_02/KILLED_THREAT_MAR02_06.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/KILLED_THREAT_MAR02_07.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/KILLED_THREAT_MAR02_08.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/KILLED_THREAT_MAR02_09.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/KILLED_THREAT_MAR02_10.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/KILLED_THREAT_MAR02_11.ogg",
			}
			self.SoundTbl_MotionTracker_Far = {
				"cpthazama/avp/humans/vocals/Male_Marine_02/MOTION_TRACK_FAR_MAR02_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/MOTION_TRACK_FAR_MAR02_04.ogg",
			}
			self.SoundTbl_MotionTracker_Mid = {
				"cpthazama/avp/humans/vocals/Male_Marine_02/MOTION_TRACK_MID_MAR02_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/MOTION_TRACK_MID_MAR02_04.ogg",
			}
			self.SoundTbl_MotionTracker_Close = {
				"cpthazama/avp/humans/vocals/Male_Marine_02/MOTION_TRACK_NEAR_MAR02_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/MOTION_TRACK_NEAR_MAR02_04.ogg",
			}
			self.SoundTbl_Pain = {
				"cpthazama/avp/humans/vocals/Male_Marine_02/PAIN_MAR02_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/PAIN_MAR02_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/PAIN_MAR02_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/PAIN_MAR02_04.ogg",
			}
			self.SoundTbl_Investigate = {
				"cpthazama/avp/humans/vocals/Male_Marine_02/PASSIVE_TO_ALERT_MAR02_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/PASSIVE_TO_ALERT_MAR02_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/PASSIVE_TO_ALERT_MAR02_03.ogg",
			}
			self.SoundTbl_WeaponReload = {
				"cpthazama/avp/humans/vocals/Male_Marine_02/RELOADING_MAR02_06.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/RELOADING_MAR02_07.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/RELOADING_MAR02_08.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/RELOADING_MAR02_09.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/RELOADING_MAR02_10.ogg",
			}
			self.SoundTbl_Spot_XenoLarge = {
				"cpthazama/avp/humans/vocals/Male_Marine_02/SPOTTED_ALIEN_LARGE_MAR02_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/SPOTTED_ALIEN_LARGE_MAR02_04.ogg",
			}
			self.SoundTbl_Spot_Xeno = {
				"cpthazama/avp/humans/vocals/Male_Marine_02/SPOTTED_ALIEN_MAR02_09.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/SPOTTED_ALIEN_MAR02_10.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/SPOTTED_ALIEN_MAR02_11.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/SPOTTED_ALIEN_MAR02_12.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/SPOTTED_ALIEN_MAR02_13.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/SPOTTED_ALIEN_MAR02_14.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/SPOTTED_ALIEN_MAR02_16.ogg",
			}
			self.SoundTbl_Spot_Android = {
				"cpthazama/avp/humans/vocals/Male_Marine_02/SPOTTED_ANDROID_MAR02_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/SPOTTED_ANDROID_MAR02_03.ogg",
			}
			self.SoundTbl_Spot_PredatorCloaked = {
				"cpthazama/avp/humans/vocals/Male_Marine_02/SPOTTED_CLOAKED_PREDATOR_MAR02_06.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/SPOTTED_CLOAKED_PREDATOR_MAR02_07.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/SPOTTED_CLOAKED_PREDATOR_MAR02_08.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/SPOTTED_CLOAKED_PREDATOR_MAR02_10.ogg",
			}
			self.SoundTbl_Spot_Predator = {
				"cpthazama/avp/humans/vocals/Male_Marine_02/SPOTTED_PREDATOR_MAR02_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/SPOTTED_PREDATOR_MAR02_06.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/SPOTTED_PREDATOR_MAR02_07.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/SPOTTED_PREDATOR_MAR02_08.ogg",
			}
			self.SoundTbl_AllyDeath_Xeno = {
				"cpthazama/avp/humans/vocals/Male_Marine_02/SQUAD_DEATH_BY_ALIEN_MAR02_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/SQUAD_DEATH_BY_ALIEN_MAR02_04.ogg",
			}
			self.SoundTbl_AllyDeath_Android = {
				"cpthazama/avp/humans/vocals/Male_Marine_02/SQUAD_DEATH_BY_ANDROID_MAR02_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/SQUAD_DEATH_BY_ANDROID_MAR02_04.ogg",
			}
			self.SoundTbl_AllyDeath_Predator = {
				"cpthazama/avp/humans/vocals/Male_Marine_02/SQUAD_DEATH_BY_PREDATOR_MAR02_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/SQUAD_DEATH_BY_PREDATOR_MAR02_04.ogg",
			}
			self.SoundTbl_AllyDeath = {
				"cpthazama/avp/humans/vocals/Male_Marine_02/SQUAD_DEATH_MAR02_06.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/SQUAD_DEATH_MAR02_07.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/SQUAD_DEATH_MAR02_08.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/SQUAD_DEATH_MAR02_09.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/SQUAD_DEATH_MAR02_10.ogg",
			}
			self.SoundTbl_Surprised = {
				"cpthazama/avp/humans/vocals/Male_Marine_02/SURPRISE_MAR02_07.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/SURPRISE_MAR02_08.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/SURPRISE_MAR02_09.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/SURPRISE_MAR02_10.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/SURPRISE_MAR02_11.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/SURPRISE_MAR02_12.ogg",
			}
			self.SoundTbl_Alert_Horde = {
				"cpthazama/avp/humans/vocals/Male_Marine_02/TARGETS_MANY_MAR02_04.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/TARGETS_MANY_MAR02_05.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/TARGETS_MANY_MAR02_06.ogg",
			}
			self.SoundTbl_Death = {
				"cpthazama/avp/humans/vocals/Male_Marine_02/death_mar02_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/death_mar02_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/death_mar02_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_02/death_mar02_04.ogg",
			}
		end
	else -- Female
		if vo == 1 then
			self.SoundTbl_LostEnemy = {
				"cpthazama/avp/humans/vocals/Female_Marine_01/AGGRESSIVE_TO_ALERT_FEM01_01.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/AGGRESSIVE_TO_ALERT_FEM01_02.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/AGGRESSIVE_TO_ALERT_FEM01_03.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/AGGRESSIVE_TO_ALERT_FEM01_04.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/AGGRESSIVE_TO_ALERT_FEM01_05.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/AGGRESSIVE_TO_ALERT_FEM01_08.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/AGGRESSIVE_TO_ALERT_FEM01_10.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/ALERT_TO_PASSIVE_FEM01_04.ogg",
			}
			self.SoundTbl_Alert = {}
			self.SoundTbl_SeeBody = {
				"cpthazama/avp/humans/vocals/Female_Marine_01/DISCOVER_BODY_FEM01_01.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/DISCOVER_BODY_FEM01_02.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/DISCOVER_BODY_FEM01_03.ogg",
			}
			self.SoundTbl_DistractionSuccess = {
				"cpthazama/avp/humans/vocals/Female_Marine_01/DISTRACTION_SUCCESS_FEM01_01.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/DISTRACTION_SUCCESS_FEM01_02.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/DISTRACTION_SUCCESS_FEM01_03.ogg",
			}
			self.SoundTbl_Suppressing = {
				"cpthazama/avp/humans/vocals/Female_Marine_01/ATTACKING_FEM01_01.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/ATTACKING_FEM01_02.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/ATTACKING_FEM01_03.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/ATTACKING_FEM01_04.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/ATTACKING_FEM01_05.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/ATTACKING_FEM01_06.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/ATTACKING_FEM01_08.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/ATTACKING_FEM01_09.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/BLIND_FIRE_FEM01_01.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/BLIND_FIRE_FEM01_02.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/BLIND_FIRE_FEM01_03.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/FLANKING_FEM01_01.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/FLANKING_FEM01_02.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/FLANKING_FEM01_03.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/FLANKING_FEM01_04.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/FLANKING_FEM01_05.ogg",
			}
			self.SoundTbl_OnReceiveOrder = {}
			self.SoundTbl_DamageByPlayer = {
				"cpthazama/avp/humans/vocals/Female_Marine_01/FRIENDLY_FIRE_FEM01_01.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/FRIENDLY_FIRE_FEM01_02.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/FRIENDLY_FIRE_FEM01_04.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/FRIENDLY_FIRE_FEM01_06.ogg",
			}
			self.SoundTbl_InvestigateComplete = {
				"cpthazama/avp/humans/vocals/Female_Marine_01/INVESTIGATE_ARRIVAL_FEM01_02.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/INVESTIGATE_ARRIVAL_FEM01_04.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/INVESTIGATE_END_FEM01_01.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/INVESTIGATE_END_FEM01_02.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/INVESTIGATE_END_FEM01_03.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/INVESTIGATE_END_FEM01_04.ogg",
			}
			self.SoundTbl_OnKilledEnemy = {
				"cpthazama/avp/humans/vocals/Female_Marine_01/KILLED_THREAT_FEM01_01.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/KILLED_THREAT_FEM01_02.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/KILLED_THREAT_FEM01_03.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/KILLED_THREAT_FEM01_04.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/KILLED_THREAT_FEM01_05.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/KILLED_THREAT_FEM01_06.ogg",
			}
			self.SoundTbl_MotionTracker_Far = {
				"cpthazama/avp/humans/vocals/Female_Marine_01/MOTION_TRACK_FAR_FEM01_01.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/MOTION_TRACK_FAR_FEM01_02.ogg",
			}
			self.SoundTbl_MotionTracker_Mid = {
				"cpthazama/avp/humans/vocals/Female_Marine_01/MOTION_TRACK_MID_FEM01_01.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/MOTION_TRACK_MID_FEM01_02.ogg",
			}
			self.SoundTbl_MotionTracker_Close = {
				"cpthazama/avp/humans/vocals/Female_Marine_01/MOTION_TRACK_NEAR_FEM01_01.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/MOTION_TRACK_NEAR_FEM01_02.ogg",
			}
			self.SoundTbl_Pain = {
				"cpthazama/avp/humans/vocals/Female_Marine_01/pain_fem01_01.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/pain_fem01_02.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/pain_fem01_03.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/pain_fem01_04.ogg",
			}
			self.SoundTbl_Investigate = {
				"cpthazama/avp/humans/vocals/Female_Marine_01/PASSIVE_TO_ALERT_FEM01_01.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/PASSIVE_TO_ALERT_FEM01_02.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/PASSIVE_TO_ALERT_FEM01_03.ogg",
			}
			self.SoundTbl_WeaponReload = {
				"cpthazama/avp/humans/vocals/Female_Marine_01/RELOADING_FEM01_01.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/RELOADING_FEM01_02.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/RELOADING_FEM01_03.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/RELOADING_FEM01_04.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/RELOADING_FEM01_05.ogg",
			}
			self.SoundTbl_Spot_XenoLarge = {
				"cpthazama/avp/humans/vocals/Female_Marine_01/SPOTTED_ALIEN_LARGE_FEM01_01.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/SPOTTED_ALIEN_LARGE_FEM01_02.ogg",
			}
			self.SoundTbl_Spot_Xeno = {
				"cpthazama/avp/humans/vocals/Female_Marine_01/SPOTTED_ALIEN_FEM01_01.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/SPOTTED_ALIEN_FEM01_02.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/SPOTTED_ALIEN_FEM01_03.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/SPOTTED_ALIEN_FEM01_04.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/SPOTTED_ALIEN_FEM01_05.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/SPOTTED_ALIEN_FEM01_06.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/SPOTTED_ALIEN_FEM01_07.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/SPOTTED_ALIEN_FEM01_08.ogg",
			}
			self.SoundTbl_Spot_Android = {
				"cpthazama/avp/humans/vocals/Female_Marine_01/SPOTTED_ANDROID_FEM01_01.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/SPOTTED_ANDROID_FEM01_02.ogg",
			}
			self.SoundTbl_Spot_PredatorCloaked = {
				"cpthazama/avp/humans/vocals/Female_Marine_01/SPOTTED_CLOAKED_PREDATOR_FEM01_01.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/SPOTTED_CLOAKED_PREDATOR_FEM01_02.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/SPOTTED_CLOAKED_PREDATOR_FEM01_03.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/SPOTTED_CLOAKED_PREDATOR_FEM01_04.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/SPOTTED_CLOAKED_PREDATOR_FEM01_05.ogg",
			}
			self.SoundTbl_Spot_Predator = {
				"cpthazama/avp/humans/vocals/Female_Marine_01/SPOTTED_PREDATOR_FEM01_01.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/SPOTTED_PREDATOR_FEM01_02.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/SPOTTED_PREDATOR_FEM01_03.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/SPOTTED_PREDATOR_FEM01_04.ogg",
			}
			self.SoundTbl_AllyDeath_Xeno = {
				"cpthazama/avp/humans/vocals/Female_Marine_01/SQUAD_DEATH_BY_ALIEN_FEM01_01.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/SQUAD_DEATH_BY_ALIEN_FEM01_02.ogg",
			}
			self.SoundTbl_AllyDeath_Android = {
				"cpthazama/avp/humans/vocals/Female_Marine_01/SQUAD_DEATH_BY_ANDROID_FEM01_01.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/SQUAD_DEATH_BY_ANDROID_FEM01_02.ogg",
			}
			self.SoundTbl_AllyDeath_Predator = {
				"cpthazama/avp/humans/vocals/Female_Marine_01/SQUAD_DEATH_BY_PREDATOR_FEM01_01.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/SQUAD_DEATH_BY_PREDATOR_FEM01_02.ogg",
			}
			self.SoundTbl_AllyDeath = {
				"cpthazama/avp/humans/vocals/Female_Marine_01/SQUAD_DEATH_FEM01_01.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/SQUAD_DEATH_FEM01_02.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/SQUAD_DEATH_FEM01_03.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/SQUAD_DEATH_FEM01_04.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/SQUAD_DEATH_FEM01_05.ogg",
			}
			self.SoundTbl_Surprised = {
				"cpthazama/avp/humans/vocals/Female_Marine_01/SURPRISE_FEM01_01.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/SURPRISE_FEM01_02.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/SURPRISE_FEM01_03.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/SURPRISE_FEM01_04.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/SURPRISE_FEM01_05.ogg",
			}
			self.SoundTbl_Alert_Horde = {
				"cpthazama/avp/humans/vocals/Female_Marine_01/TARGETS_MANY_FEM01_01.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/TARGETS_MANY_FEM01_02.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/TARGETS_MANY_FEM01_03.ogg",
			}
			self.SoundTbl_Death = {
				"cpthazama/avp/humans/vocals/Female_Marine_01/death_fem01_01.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/death_fem01_02.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/death_fem01_03.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_01/death_fem01_04.ogg",
			}
		else
			self.SoundTbl_LostEnemy = {
				"cpthazama/avp/humans/vocals/Female_Marine_02/AGGRESSIVE_TO_ALERT_FEM02_06.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/AGGRESSIVE_TO_ALERT_FEM02_07.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/AGGRESSIVE_TO_ALERT_FEM02_08.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/AGGRESSIVE_TO_ALERT_FEM02_10.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/ALERT_TO_PASSIVE_FEM02_04.ogg",
			}
			self.SoundTbl_Alert = {}
			self.SoundTbl_SeeBody = {
				"cpthazama/avp/humans/vocals/Female_Marine_02/DISCOVER_BODY_FEM02_03.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/DISCOVER_BODY_FEM02_04.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/DISCOVER_BODY_FEM02_05.ogg",
			}
			self.SoundTbl_DistractionSuccess = {
				"cpthazama/avp/humans/vocals/Female_Marine_02/DISTRACTION_SUCCESS_FEM02_04.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/DISTRACTION_SUCCESS_FEM02_05.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/DISTRACTION_SUCCESS_FEM02_06.ogg",
			}
			self.SoundTbl_Suppressing = {
				"cpthazama/avp/humans/vocals/Female_Marine_02/ATTACKING_FEM02_01.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/ATTACKING_FEM02_02.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/ATTACKING_FEM02_03.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/ATTACKING_FEM02_04.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/ATTACKING_FEM02_05.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/ATTACKING_FEM02_06.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/ATTACKING_FEM02_08.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/ATTACKING_FEM02_09.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/BLIND_FIRE_FEM02_06.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/FLANKING_FEM02_06.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/FLANKING_FEM02_07.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/FLANKING_FEM02_08.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/FLANKING_FEM02_09.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/FLANKING_FEM02_10.ogg",
			}
			self.SoundTbl_OnReceiveOrder = {}
			self.SoundTbl_DamageByPlayer = {
				"cpthazama/avp/humans/vocals/Female_Marine_02/FRIENDLY_FIRE_FEM02_07.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/FRIENDLY_FIRE_FEM02_08.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/FRIENDLY_FIRE_FEM02_09.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/FRIENDLY_FIRE_FEM02_10.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/FRIENDLY_FIRE_FEM02_11.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/FRIENDLY_FIRE_FEM02_12.ogg",
			}
			self.SoundTbl_InvestigateComplete = {
				"cpthazama/avp/humans/vocals/Female_Marine_02/INVESTIGATE_ARRIVAL_FEM02_02.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/INVESTIGATE_ARRIVAL_FEM02_04.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/INVESTIGATE_END_FEM02_04.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/INVESTIGATE_END_FEM02_05.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/INVESTIGATE_END_FEM02_06.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/INVESTIGATE_END_FEM02_07.ogg",
			}
			self.SoundTbl_OnKilledEnemy = {
				"cpthazama/avp/humans/vocals/Female_Marine_02/KILLED_THREAT_FEM02_06.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/KILLED_THREAT_FEM02_07.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/KILLED_THREAT_FEM02_08.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/KILLED_THREAT_FEM02_09.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/KILLED_THREAT_FEM02_10.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/KILLED_THREAT_FEM02_11.ogg",
			}
			self.SoundTbl_MotionTracker_Far = {
				"cpthazama/avp/humans/vocals/Female_Marine_02/MOTION_TRACK_FAR_FEM02_03.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/MOTION_TRACK_FAR_FEM02_04.ogg",
			}
			self.SoundTbl_MotionTracker_Mid = {
				"cpthazama/avp/humans/vocals/Female_Marine_02/MOTION_TRACK_NEAR_FEM02_04.ogg",
			}
			self.SoundTbl_MotionTracker_Close = {
				"cpthazama/avp/humans/vocals/Female_Marine_02/MOTION_TRACK_NEAR_FEM02_03.ogg",
			}
			self.SoundTbl_Pain = {
				"cpthazama/avp/humans/vocals/Female_Marine_02/PAIN_FEM02_03.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/pain_fem02_01.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/pain_fem02_02.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/pain_fem02_04.ogg",
			}
			self.SoundTbl_Investigate = {
				"cpthazama/avp/humans/vocals/Female_Marine_02/PASSIVE_TO_ALERT_FEM02_01.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/PASSIVE_TO_ALERT_FEM02_02.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/PASSIVE_TO_ALERT_FEM02_03.ogg",
			}
			self.SoundTbl_WeaponReload = {
				"cpthazama/avp/humans/vocals/Female_Marine_02/RELOADING_FEM02_06.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/RELOADING_FEM02_07.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/RELOADING_FEM02_08.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/RELOADING_FEM02_09.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/RELOADING_FEM02_10.ogg",
			}
			self.SoundTbl_Spot_XenoLarge = {
				"cpthazama/avp/humans/vocals/Female_Marine_02/SPOTTED_ALIEN_LARGE_FEM02_03.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/SPOTTED_ALIEN_LARGE_FEM02_04.ogg",
			}
			self.SoundTbl_Spot_Xeno = {
				"cpthazama/avp/humans/vocals/Female_Marine_02/SPOTTED_ALIEN_FEM02_10.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/SPOTTED_ALIEN_FEM02_11.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/SPOTTED_ALIEN_FEM02_12.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/SPOTTED_ALIEN_FEM02_13.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/SPOTTED_ALIEN_FEM02_14.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/SPOTTED_ALIEN_FEM02_16.ogg",
			}
			self.SoundTbl_Spot_Android = {
				"cpthazama/avp/humans/vocals/Female_Marine_02/SPOTTED_ANDROID_FEM02_01.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/SPOTTED_ANDROID_FEM02_02.ogg",
			}
			self.SoundTbl_Spot_PredatorCloaked = {
				"cpthazama/avp/humans/vocals/Female_Marine_02/LOST_CLOAKED_PREDATOR_FEM02_07.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/SPOTTED_CLOAKED_PREDATOR_FEM02_06.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/SPOTTED_CLOAKED_PREDATOR_FEM02_07.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/SPOTTED_CLOAKED_PREDATOR_FEM02_08.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/SPOTTED_CLOAKED_PREDATOR_FEM02_09.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/SPOTTED_CLOAKED_PREDATOR_FEM02_10.ogg",
			}
			self.SoundTbl_Spot_Predator = {
				"cpthazama/avp/humans/vocals/Female_Marine_02/SPOTTED_PREDATOR_FEM02_04.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/SPOTTED_PREDATOR_FEM02_06.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/SPOTTED_PREDATOR_FEM02_07.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/SPOTTED_PREDATOR_FEM02_08.ogg",
			}
			self.SoundTbl_AllyDeath_Xeno = {
				"cpthazama/avp/humans/vocals/Female_Marine_02/SQUAD_DEATH_BY_ALIEN_FEM02_03.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/SQUAD_DEATH_BY_ALIEN_FEM02_04.ogg",
			}
			self.SoundTbl_AllyDeath_Android = {
				"cpthazama/avp/humans/vocals/Female_Marine_02/SQUAD_DEATH_BY_ANDROID_FEM02_03.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/SQUAD_DEATH_BY_ANDROID_FEM02_04.ogg",
			}
			self.SoundTbl_AllyDeath_Predator = {
				"cpthazama/avp/humans/vocals/Female_Marine_02/SQUAD_DEATH_BY_PREDATOR_FEM02_03.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/SQUAD_DEATH_BY_PREDATOR_FEM02_04.ogg",
			}
			self.SoundTbl_AllyDeath = {
				"cpthazama/avp/humans/vocals/Female_Marine_02/SQUAD_DEATH_FEM02_06.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/SQUAD_DEATH_FEM02_07.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/SQUAD_DEATH_FEM02_08.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/SQUAD_DEATH_FEM02_09.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/SQUAD_DEATH_FEM02_10.ogg",
			}
			self.SoundTbl_Surprised = {
				"cpthazama/avp/humans/vocals/Female_Marine_02/SURPRISE_FEM02_07.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/SURPRISE_FEM02_08.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/SURPRISE_FEM02_09.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/SURPRISE_FEM02_10.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/SURPRISE_FEM02_11.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/SURPRISE_FEM02_12.ogg",
			}
			self.SoundTbl_Alert_Horde = {
				"cpthazama/avp/humans/vocals/Female_Marine_02/TARGETS_MANY_FEM02_04.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/TARGETS_MANY_FEM02_05.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/TARGETS_MANY_FEM02_06.ogg",
			}
			self.SoundTbl_Death = {
				"cpthazama/avp/humans/vocals/Female_Marine_02/death_fem02_01.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/death_fem02_02.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/death_fem02_03.ogg",
				"cpthazama/avp/humans/vocals/Female_Marine_02/death_fem02_04.ogg",
			}
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAlert(ent)
	if #self.SoundTbl_Surprised > 0 && self:VJ_GetNearestPointToEntityDistance(ent,true) <= 250 then
		self:PlaySoundSystem("Alert", ent.SoundTbl_Surprised)
		-- self:PlayAnimation("ohwn_oh_shit",true,false,true)
		return
	end
	if ent:IsNPC() then
		if ent.VJ_AVP_Xenomorph && #self.SoundTbl_Spot_Xeno > 0 then
			self:PlaySoundSystem("Alert", ent.VJ_AVP_XenomorphLarge && self.SoundTbl_Spot_XenoLarge or self.SoundTbl_Spot_Xeno)
			return
		elseif ent.VJ_AVP_IsTech && #self.SoundTbl_Spot_Android > 0 then
			self:PlaySoundSystem("Alert", self.SoundTbl_Spot_Android)
			return
		elseif ent.VJ_AVP_Predator && #self.SoundTbl_Spot_Predator > 0 then
			self:PlaySoundSystem("Alert", ent:GetCloaked() && self.SoundTbl_Spot_PredatorCloaked or self.SoundTbl_Spot_Predator)
			return
		elseif ent.VJ_AVP_Marine && self.SoundTbl_Spot_Marine then
			self:PlaySoundSystem("Alert", self.SoundTbl_Spot_Marine)
			return
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local toAct = VJ.SequenceToActivity
--
function ENT:CustomOnInitialize()
	if self.OnInit then
		self:OnInit()
	end

	self.SprintT = 0
	self.NextSprintT = 0
	self.Moveset = 0
	self.Ping_ClosestDist = 0
	self.Ping_NextPingT = CurTime() +1
	self.NextHealT = CurTime() +1

    for attName, var in pairs(self.FootData) do
        var.AttID = self:LookupAttachment(attName)
    end

	self.AnimTbl_ScaredBehaviorMovement = {toAct(self,"nwn_Panic_run_fwd_look_fwd")}

	hook.Add("PlayerButtonDown", self, function(self, ply, button)
		if ply.VJTag_IsControllingNPC == true && IsValid(ply.VJ_TheControllerEntity) then
			local cent = ply.VJ_TheControllerEntity
            if cent.VJCE_NPC == self then
                cent.VJCE_NPC:OnKeyPressed(ply,button)
            end
        end
    end)

	if self:FindBodygroupByName("vest") > -1 && self:GetBodygroup(self:FindBodygroupByName("vest")) > 0 then return end

	self.FlashlightStatus = false
	local att = self:LookupAttachment("flashlight")
	if att > 0 && self.HasFlashlight then
		self.CanUseFlashlight = true
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:ToggleFlashlight(on)
	if !self.CanUseFlashlight then return end
	local att = self:LookupAttachment("flashlight")
	if att <= 0 then return end
	if self.FlashlightStatus == on then return end

	self.FlashlightEntities = self.FlashlightEntities or {}
	self.FlashlightStatus = on

	if on then
		local envLight = ents.Create("env_projectedtexture")
		envLight:SetLocalPos(self:GetPos())
		envLight:SetLocalAngles(self:GetAngles())
		envLight:SetKeyValue("lightcolor","255 247 206")
		envLight:SetKeyValue("lightfov","40")
		envLight:SetKeyValue("farz","1000")
		envLight:SetKeyValue("nearz","10")
		envLight:SetKeyValue("shadowquality","1")
		envLight:Input("SpotlightTexture",NULL,NULL,"effects/flashlight001")
		envLight:SetOwner(self)
		envLight:SetParent(self)
		envLight:Spawn()
		envLight:Fire("setparentattachment","flashlight")
		self:DeleteOnRemove(envLight)
		table.insert(self.FlashlightEntities,envLight)

		local spotlight = ents.Create("beam_spotlight")
		spotlight:SetPos(self:GetPos())
		spotlight:SetAngles(self:GetAngles())
		spotlight:SetKeyValue("spotlightlength",700)
		spotlight:SetKeyValue("spotlightwidth",30)
		spotlight:SetKeyValue("spawnflags","2")
		spotlight:Fire("Color","255 247 206")
		spotlight:SetParent(self)
		spotlight:Spawn()
		spotlight:Activate()
		spotlight:Fire("setparentattachment","flashlight")
		spotlight:Fire("lighton")
		spotlight:AddEffects(EF_PARENT_ANIMATES)
		self:DeleteOnRemove(spotlight)
		table.insert(self.FlashlightEntities,spotlight)

		local glow1 = ents.Create("env_sprite")
		glow1:SetKeyValue("model","sprites/light_ignorez.vmt")
		glow1:SetKeyValue("scale","0.2")
		glow1:SetKeyValue("rendermode","9")
		glow1:SetKeyValue("rendercolor","255 247 206")
		glow1:SetKeyValue("spawnflags","0.1")
		glow1:SetParent(self)
		glow1:SetOwner(self)
		glow1:Fire("SetParentAttachment","flashlight",0)
		glow1:Spawn()
		self:DeleteOnRemove(glow1)
		table.insert(self.FlashlightEntities,glow1)

		-- local glowLight = ents.Create("light_dynamic")
		-- glowLight:SetKeyValue("brightness","1.4")
		-- glowLight:SetKeyValue("distance","70")
		-- glowLight:SetLocalPos(self:GetPos() +self:OBBCenter())
		-- glowLight:SetLocalAngles(self:GetAngles())
		-- glowLight:Fire("Color", "255 247 206")
		-- glowLight:SetParent(self)
		-- glowLight:SetOwner(self)
		-- glowLight:Spawn()
		-- glowLight:Fire("TurnOn","",0)
		-- glowLight:Fire("SetParentAttachment","flashlight",0)
		-- self:DeleteOnRemove(glowLight)

		-- self.Light = envLight
		-- self.LightGlow = glow1
		-- self.LightGlowDynamic = glowLight

		VJ.EmitSound(self,"cpthazama/avp/weapons/human/torch/torch_01_switch_on.ogg",70)
	else
		for _,v in ipairs(self.FlashlightEntities) do
			if IsValid(v) then
				v:Remove()
			end
		end
		self.FlashlightEntities = {}
		VJ.EmitSound(self,"cpthazama/avp/weapons/human/torch/torch_01_switch_off.ogg",70)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Controller_Initialize(ply,controlEnt)
	controlEnt.VJC_Player_DrawHUD = false

	function controlEnt:CustomOnThink()
		self.VJC_NPC_CanTurn = self.VJC_Camera_Mode == 2
		self.VJC_BullseyeTracking = self.VJC_Camera_Mode == 2
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnKeyPressed(ply,key)
    if key == KEY_E then
		local tr = util.TraceLine({
			start = self:EyePos(),
			endpos = self:EyePos() +ply:GetAimVector() *125,
			filter = {self,ply}
		})
		local ent = tr.Entity
		if tr.Hit && IsValid(ent) then
			ent:Fire("Use",nil,0,ply,self)
		end
    elseif key == KEY_G then
		if self:Health() < self:GetMaxHealth() && CurTime() > self.NextHealT then
			self:UseStimpack()
			self.NextHealT = CurTime() +3
		end
    elseif key == KEY_V && self.EntityClass == AVP_ENTITYCLASS_ANDROID then
		if !self.AllowCloaking or self.HasFallen then return end
		if self:GetState() == VJ_STATE_NONE && CurTime() > self.NextCloakT then
			self:Camo(!self:GetCloaked())
			self.NextCloakT = CurTime() +1
		end
    elseif key == KEY_F then
		if (!self.CanUseFlashlight or self:LookupAttachment("flashlight") <= 0) && !IsValid(self:GetFlare()) && !self:IsBusy() then
			-- self:PlayAnimation("vjges_THWA_Stand_Throw_Flare",true,false,false)
			-- self.NextChaseTime = 0
			local flare = ents.Create("obj_vj_avp_flare")
			flare:SetPos(self:GetShootPos() +self:GetUp() *-5)
			flare:SetAngles(self:EyeAngles() +Angle(90,25,0))
			flare:SetOwner(self)
			flare:Spawn()
			flare:Activate()
			local phys = flare:GetPhysicsObject()
			if IsValid(phys) then
				phys:Wake()
				phys:SetVelocity(self:GetAimVector() *850)
			end
			self:SetFlare(flare)
			return
		end
		self:ToggleFlashlight(!self.FlashlightStatus)
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:UseStimpack()
	if self.InFatality or self.DoingFatality or self.VJ_AVP_IsTech or self:IsBusy() then return end
	self:PlayAnimation("vjges_ohwa_pistol_stim",true,false,false,0,{OnFinish=function(interrupted,anim)
		if self.LastActivity != anim then return end
		self:SetHealth(self:GetMaxHealth())
	end})
	self.NextChaseTime = 0
end
---------------------------------------------------------------------------------------------------------------------------------------------
local string_find = string.find
--
function ENT:PlayAnimation(animation, stopActivities, stopActivitiesTime, faceEnemy, animDelay, extraOptions, customFunc)
	animation = VJ.PICK(animation)
	if stopActivitiesTime == false && (string_find(animation,"vjges_") or extraOptions && extraOptions.AlwaysUseGesture) then
		stopActivitiesTime = self:DecideAnimationLength(animation, false) *0.5
	end
	local anim,animDur = self:VJ_ACT_PLAYACTIVITY(animation,stopActivities,stopActivitiesTime,faceEnemy,animDelay,extraOptions,customFunc)
	if extraOptions && extraOptions.AlwaysUseGesture && !extraOptions.DisableChaseFix then
		self.NextChaseTime = 0
	end
	self.LastActivity = anim
	self.LastSequence = self:GetSequenceName(self:LookupSequence(animation))
	return anim,animDur
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:TranslateActivity(act)
	if self.Moveset == 1 then
		if act == ACT_RUN then
			act = ACT_WALK
		end
	elseif self.Moveset == 2 then
		if act == ACT_RUN then
			return ACT_SPRINT
		end
		if act == ACT_WALK then
			act = ACT_RUN
		end
	elseif self.Moveset == 3 && CurTime() < self.NextSprintT then
		if act == ACT_WALK then
			act = ACT_RUN
		end
	end

	if act == ACT_IDLE then
		if self.NoWeapon_UseScaredBehavior_Active == true then
			return ACT_COWER
		elseif self.Alerted && self:GetWeaponState() != VJ.NPC_WEP_STATE_HOLSTERED && IsValid(self:GetActiveWeapon()) then
			return ACT_IDLE_ANGRY
		end
	elseif act == ACT_RUN && self.NoWeapon_UseScaredBehavior_Active == true && !self.VJ_IsBeingControlled then
		return ACT_RUN_PROTECTED
	elseif (act == ACT_RUN or act == ACT_WALK) && self.Weapon_ShootWhileMoving == true && IsValid(self:GetEnemy()) then
		if (self.EnemyData.IsVisible or (self.EnemyData.LastVisibleTime + 5) > CurTime()) && self.CurrentSchedule != nil && self.CurrentSchedule.CanShootWhenMoving == true && self:IsAbleToShootWeapon(true, false) == true then
			local anim = self:TranslateActivity(act == ACT_RUN and ACT_RUN_AIM or ACT_WALK_AIM)
			if VJ.AnimExists(self, anim) == true then
				self.DoingWeaponAttack = true
				self.DoingWeaponAttack_Standing = false
				return anim
			end
		end
	end
	
	local translation = self.AnimationTranslations[act]
	if translation then
		if istable(translation) then
			if act == ACT_IDLE then
				return self:ResolveAnimation(translation)
			end
			return translation[math.random(1, #translation)] or act -- "or act" = To make sure it doesn't return nil when the table is empty!
		else
			return translation
		end
	end
	return act
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetAnimationTranslations(hType)
	self.AnimationTranslations[ACT_COWER] 								= {toAct(self, "nwa_Cower1"),toAct(self, "nwa_stand_alert_PanicA"),toAct(self, "nwa_panic_idle")}
	if hType == "pistol" then
		self.AnimationTranslations[ACT_RANGE_ATTACK1] 					= toAct(self, "ohwa_pistol_idle")
		self.AnimationTranslations[ACT_GESTURE_RANGE_ATTACK1] 			= "vjges_ohwa_pistol_shoot"
		self.AnimTbl_WeaponReload 										= "vjges_ohwa_pistol_reload"

		self.AnimationTranslations[ACT_MELEE_ATTACK1] 					= toAct(self, "ohwa_melee_light_attack")
		
		self.AnimationTranslations[ACT_IDLE] 							= toAct(self, "ohwn_pistol_idle")
		self.AnimationTranslations[ACT_IDLE_ANGRY] 						= toAct(self, "ohwa_pistol_idle")
		-- self.AnimationTranslations[ACT_IDLE_ANGRY] 						= {toAct(self, "ohwa_alert_idle_1"),toAct(self, "ohwa_alert_panic"),toAct(self, "ohwa_alert_watchfulA")}
		
		self.AnimationTranslations[ACT_WALK] 							= toAct(self, "ohwn_Walk")
		self.AnimationTranslations[ACT_WALK_AIM] 						= toAct(self, "OHWA_Walk")
		
		self.AnimationTranslations[ACT_RUN] 							= toAct(self, "ohwn_Run")
		self.AnimationTranslations[ACT_RUN_AIM] 						= toAct(self, "ohwa_Run_fwd_Look_fwd")

		self.PoseParameterLooking_Names = {pitch={"pp_ohw_pitch"}, yaw={"pp_ohw_yaw"}, roll={}}
	elseif hType == "crossbow" then
		// Smartgun

		self.PoseParameterLooking_Names = {pitch={"pp_smartgun_pitch"}, yaw={"pp_smartgun_yaw"}, roll={}}
	else
		self.AnimationTranslations[ACT_RANGE_ATTACK1] 					= ACT_HL2MP_IDLE_AR2
		self.AnimationTranslations[ACT_GESTURE_RANGE_ATTACK1] 			= ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2
		self.AnimTbl_WeaponReload 										= "vjges_THWA_Stand_reload"
		
		self.AnimationTranslations[ACT_MELEE_ATTACK1] 					= toAct(self, "thwa_melee_light_attack")
		
		self.AnimationTranslations[ACT_IDLE] 							= ACT_HL2MP_SWIM_IDLE_AR2
		self.AnimationTranslations[ACT_IDLE_ANGRY] 						= ACT_HL2MP_IDLE_AR2
		
		self.AnimationTranslations[ACT_WALK] 							= ACT_HL2MP_WALK_AR2
		self.AnimationTranslations[ACT_WALK_AIM] 						= ACT_HL2MP_RUN_AR2
		
		self.AnimationTranslations[ACT_RUN] 							= ACT_HL2MP_WALK_CROUCH_AR2
		self.AnimationTranslations[ACT_RUN_AIM] 						= ACT_HL2MP_RUN_AR2

		self.PoseParameterLooking_Names = {pitch={"pp_thw_pitch"}, yaw={"pp_thw_yaw"}, roll={}}
	end
	return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnWeaponReload()
	self.NextChaseTime = 0
end
---------------------------------------------------------------------------------------------------------------------------------------------
local table_insert = table.insert
local math_abs = math.abs
local math_cos = math.cos
local math_rad = math.rad
--
function ENT:CustomOnThink_AIEnabled()
	local curTime = CurTime()
	self.HasPoseParameterLooking = !self.InFatality
	if self.InFatality then
		if IsValid(self.FatalityKiller) && self.FatalityKiller:Health() <= 0 or !IsValid(self.FatalityKiller) then
			self:ResetFatality()
			self:SetHealth(0)
			self:TakeDamage(AVP.fFatalDamageAmount,self,self)
			-- self:SetCycle(self.FatalityKiller:GetCycle())
		end
		return
	end

	local cont = self.VJ_TheController
	if IsValid(cont) then
		local walk = cont:KeyDown(IN_WALK)
		local sprint = cont:KeyDown(IN_SPEED)
		if walk && self.Moveset != 1 then
			self.Moveset = 1
		elseif !walk && self.Moveset != 2 then
			self.Moveset = 2
		elseif !walk && self.Moveset != 3 && curTime < self.NextSprintT then
			self.Moveset = 3
			sprint = false
		end
		self:SetSprinting(sprint)
	else
		-- if self.Moveset != 0 then
		-- 	self.Moveset = 0
		-- 	self:SetSprinting(false)
		-- end

		if !self.VJ_AVP_IsTech && self:Health() < self:GetMaxHealth() *0.5 && CurTime() > self.NextHealT && math.random(1,30) == 1 && !self:IsBusy() then
			self:UseStimpack()
			self.NextHealT = CurTime() +math.Rand(45,60)
		end
	end
	if self:GetSprinting() then
		self.SprintT = self.SprintT +0.1
		if self.SprintT >= 4 then
			self.NextSprintT = curTime +3
		end
	else
		if self.SprintT > 0 then
			self.SprintT = self.SprintT -0.2
		end
	end

	if self.OnThink then
		self:OnThink(curTime)
	end

	if self.FootData then
		local checkPos = self:GetPos()
		for attName, var in pairs(self.FootData) do
			if !var.AttID then continue end
	
			local footPos = self:GetAttachment(var.AttID).Pos
			checkPos.x = footPos.x
			checkPos.y = footPos.y	
			if ((footPos -checkPos):LengthSqr()) > (var.Range *var.Range) then
				var.OnGround = false
			elseif !var.OnGround then
				var.OnGround = true
				self:FootStep(footPos, attName)
			end
		end
	end

	local darkness = self.DarknessLevel
	-- print(darkness,CurTime())
	if !IsValid(self.VJ_TheController) && VJ_AVP_CVAR_FLASHLIGHT && darkness && self.CanUseFlashlight then
		if darkness <= 0.2 then
			self:ToggleFlashlight(true)
		else
			self:ToggleFlashlight(false)
		end
	end

	if self.HasMotionTracker then
		VJ_AVP_MotionTracker(self)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.SoundTbl_FootSteps = {
	[MAT_DIRT] = {
		"cpthazama/avp/humans/human/footsteps/footsteps_dirt_run/footsteps_dirt_run_01.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_dirt_run/footsteps_dirt_run_02.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_dirt_run/footsteps_dirt_run_03.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_dirt_run/footsteps_dirt_run_04.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_dirt_run/footsteps_dirt_run_05.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_dirt_run/footsteps_dirt_run_06.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_dirt_run/footsteps_dirt_run_07.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_dirt_run/footsteps_dirt_run_08.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_dirt_run/footsteps_dirt_run_09.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_dirt_run/footsteps_dirt_run_10.ogg",
	},
	[MAT_GRASS] = {
		"cpthazama/avp/humans/human/footsteps/footsteps_dirt_run/footsteps_dirt_run_01.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_dirt_run/footsteps_dirt_run_02.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_dirt_run/footsteps_dirt_run_03.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_dirt_run/footsteps_dirt_run_04.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_dirt_run/footsteps_dirt_run_05.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_dirt_run/footsteps_dirt_run_06.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_dirt_run/footsteps_dirt_run_07.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_dirt_run/footsteps_dirt_run_08.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_dirt_run/footsteps_dirt_run_09.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_dirt_run/footsteps_dirt_run_10.ogg",
	},
	[MAT_FOLIAGE] = {
		"cpthazama/avp/humans/human/footsteps/footsteps_dirt_run/footsteps_dirt_run_01.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_dirt_run/footsteps_dirt_run_02.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_dirt_run/footsteps_dirt_run_03.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_dirt_run/footsteps_dirt_run_04.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_dirt_run/footsteps_dirt_run_05.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_dirt_run/footsteps_dirt_run_06.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_dirt_run/footsteps_dirt_run_07.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_dirt_run/footsteps_dirt_run_08.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_dirt_run/footsteps_dirt_run_09.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_dirt_run/footsteps_dirt_run_10.ogg",
	},
	[MAT_CONCRETE] = {
		"cpthazama/avp/humans/human/footsteps/footsteps_concrete_run/footsteps_concrete_run_01.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_concrete_run/footsteps_concrete_run_02.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_concrete_run/footsteps_concrete_run_03.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_concrete_run/footsteps_concrete_run_04.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_concrete_run/footsteps_concrete_run_05.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_concrete_run/footsteps_concrete_run_06.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_concrete_run/footsteps_concrete_run_07.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_concrete_run/footsteps_concrete_run_08.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_concrete_run/footsteps_concrete_run_09.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_concrete_run/footsteps_concrete_run_10.ogg"
	},
	[MAT_METAL] = {
		"cpthazama/avp/humans/human/footsteps/footsteps_metal_solid_walk/footsteps_metal_walk_01.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_metal_solid_walk/footsteps_metal_walk_02.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_metal_solid_walk/footsteps_metal_walk_03.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_metal_solid_walk/footsteps_metal_walk_04.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_metal_solid_walk/footsteps_metal_walk_05.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_metal_solid_walk/footsteps_metal_walk_06.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_metal_solid_walk/footsteps_metal_walk_07.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_metal_solid_walk/footsteps_metal_walk_08.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_metal_solid_walk/footsteps_metal_walk_09.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_metal_solid_walk/footsteps_metal_walk_10.ogg"
	},
	[MAT_GRATE] = {
		"cpthazama/avp/humans/human/footsteps/footsteps_metal_solid_walk/footsteps_metal_walk_01.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_metal_solid_walk/footsteps_metal_walk_02.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_metal_solid_walk/footsteps_metal_walk_03.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_metal_solid_walk/footsteps_metal_walk_04.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_metal_solid_walk/footsteps_metal_walk_05.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_metal_solid_walk/footsteps_metal_walk_06.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_metal_solid_walk/footsteps_metal_walk_07.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_metal_solid_walk/footsteps_metal_walk_08.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_metal_solid_walk/footsteps_metal_walk_09.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_metal_solid_walk/footsteps_metal_walk_10.ogg"
	},
	[MAT_GLASS] = {
		"cpthazama/avp/humans/human/footsteps/footsteps_metal_solid_walk/footsteps_metal_walk_01.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_metal_solid_walk/footsteps_metal_walk_02.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_metal_solid_walk/footsteps_metal_walk_03.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_metal_solid_walk/footsteps_metal_walk_04.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_metal_solid_walk/footsteps_metal_walk_05.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_metal_solid_walk/footsteps_metal_walk_06.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_metal_solid_walk/footsteps_metal_walk_07.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_metal_solid_walk/footsteps_metal_walk_08.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_metal_solid_walk/footsteps_metal_walk_09.ogg",
		"cpthazama/avp/humans/human/footsteps/footsteps_metal_solid_walk/footsteps_metal_walk_10.ogg"
	}
}
--
function ENT:FootStep(pos,name)
	if !self:IsOnGround() then return end
	local tbl = self.SoundTbl_FootSteps
	if !tbl then return end
	local tr = util.TraceLine({
		start = self:GetPos(),
		endpos = self:GetPos() +Vector(0,0,-150),
		filter = {self}
	})
	local mat = tr.MatType
	if mat && tbl[mat] == nil then
		mat = MAT_CONCRETE
	end
	if tr.Hit && tbl[mat] then
		VJ.EmitSound(self,VJ.PICK(tbl[mat]),self:GetCloaked() && 55 or (self.FootStepSoundLevel or 65),self:VJ_DecideSoundPitch(self.FootStepPitch1,self.FootStepPitch2))
	end
	if self:WaterLevel() > 0 && self:WaterLevel() < 3 then
		VJ.EmitSound(self,"player/footsteps/wade" .. math.random(1,8) .. ".wav",self.FootStepSoundLevel,self:VJ_DecideSoundPitch(self.FootStepPitch1,self.FootStepPitch2))
	end
	if self.OnStep then
		self:OnStep(pos,name)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local bit_band = bit.band
--
function ENT:CustomOnTakeDamage_OnBleed(dmginfo,hitgroup)
	local explosion = dmginfo:IsExplosionDamage()
	if !self.InFatality && self:Health() > 0 && (explosion or dmginfo:GetDamage() >= 75 or bit_band(dmginfo:GetDamageType(),DMG_SNIPER) == DMG_SNIPER or (bit_band(dmginfo:GetDamageType(),DMG_BUCKSHOT) == DMG_BUCKSHOT && dmginfo:GetDamage() >= 65) or (!self.VJ_IsHugeMonster && bit_band(dmginfo:GetDamageType(),DMG_VEHICLE) == DMG_VEHICLE) or (dmginfo:GetAttacker().VJ_IsHugeMonster)) then
		if CurTime() < (self.NextKnockdownT or 0) then return end
		local dmgAng = ((explosion && dmginfo:GetDamagePosition() or dmginfo:GetAttacker():GetPos()) -self:GetPos()):Angle()
		dmgAng.p = 0
		dmgAng.r = 0
		self:TaskComplete()
		self:StopMoving()
		self:ClearSchedule()
		self:ClearGoal()
		self:SetAngles(dmgAng)
		self:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK)
		-- local dmgDir = self:GetDamageDirection(dmginfo)
		local _,dur = self:VJ_ACT_PLAYACTIVITY("ohwa_big_flinch_back",true,false,false,0,{OnFinish=function(interrupted)
			if interrupted then return end
			self:SetState()
		end})
		self.NextKnockdownT = CurTime() +(dur *0.5)
		self.NextCallForBackUpOnDamageT = CurTime() +(dur *0.8)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local math_atan2 = math.atan2
--
function ENT:GetDamageDirection(dmginfo)
	local dir = (self:GetPos() +self:OBBCenter()) -dmginfo:GetDamagePosition()
	dir:Normalize()
	dir.z = 0.5

	local hitDir = 1
	local forward = self:GetForward()
	local angle = math_deg(math_atan2(dir:Dot(forward:Cross(Vector(0,0,1))),dir:Dot(forward)))
	if angle >= 45 and angle <= 135 then
		-- print("NPC was hit from the left")
		hitDir = 2
	elseif angle >= -135 and angle <= -45 then
		-- print("NPC was hit from the right")
		hitDir = 3
	elseif angle >= 135 or angle <= -135 then
		-- print("NPC was hit from the front")
		hitDir = 1
	else
		-- print("NPC was hit from the back")
		hitDir = 4
	end

	return hitDir
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnKilled()
	if self:GetState() == VJ_STATE_NONE then
		for i = 1,self:GetBoneCount() -1 do
			if math.random(1,4) <= 3 then continue end
			local bone = self:GetBonePosition(i)
			if bone then
				local particle = ents.Create("info_particle_system")
				particle:SetKeyValue("effect_name", VJ.PICK(self.CustomBlood_Particle))
				particle:SetPos(bone +VectorRand() *15)
				particle:Spawn()
				particle:Activate()
				particle:Fire("Start")
				particle:Fire("Kill", "", 0.1)
			end
		end
	end

	self.StoredWeapon = IsValid(self:GetActiveWeapon()) && self:GetActiveWeapon():GetClass()

	if self.WhenKilled then
		self:WhenKilled()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo, hitgroup, ent)
	ent.OnHeadAte = function(corpse,xeno)
		corpse:SetBodygroup(corpse:FindBodygroupByName("head"),1)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
	if self.WhenRemoved then
		self:WhenRemoved()
	end

	-- if IsValid(self.Flashlight) then
	-- 	self.Flashlight:Fire("TurnOff","",0)
	-- 	self.Flashlight:Fire("Kill","",0)
	-- 	SafeRemoveEntity(self.Flashlight)
	-- end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnChangeActivity(newAct)
	local funcCustom = self.CustomOnChangeActivity; if funcCustom then funcCustom(self, newAct) end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local angY45 = Angle(0, 45, 0)
local angYN45 = Angle(0, -45, 0)
local angY90 = Angle(0, 90, 0)
local angYN90 = Angle(0, -90, 0)
local angY135 = Angle(0, 135, 0)
local angYN135 = Angle(0, -135, 0)
local angY180 = Angle(0, 180, 0)
local defAng = Angle(0, 0, 0)
--
function ENT:Controller_Movement(cont, ply, bullseyePos)
	if self.MovementType != VJ_MOVETYPE_STATIONARY then
		local gerta_lef = ply:KeyDown(IN_MOVELEFT)
		local gerta_rig = ply:KeyDown(IN_MOVERIGHT)
		local gerta_arak = ply:KeyDown(IN_SPEED)
		local aimVector = ply:GetAimVector()
		local FT = FrameTime() *(self.TurningSpeed *2.25)

		self.VJC_Data.TurnAngle = self.VJC_Data.TurnAngle or defAng
		
		if ply:KeyDown(IN_FORWARD) then
			if self.MovementType == VJ_MOVETYPE_AERIAL or self.MovementType == VJ_MOVETYPE_AQUATIC then
				self:AA_MoveTo(cont.VJCE_Bullseye, true, gerta_arak and "Alert" or "Calm", {IgnoreGround=true})
			else
				self.VJC_Data.TurnAngle = LerpAngle(FT, self.VJC_Data.TurnAngle, gerta_lef && angY45 or gerta_rig && angYN45 or defAng)
				cont:StartMovement(aimVector, self.VJC_Data.TurnAngle)
			end
		elseif ply:KeyDown(IN_BACK) then
			self.VJC_Data.TurnAngle = LerpAngle(FT, self.VJC_Data.TurnAngle, gerta_lef && angY135 or gerta_rig && angYN135 or angY180)
			cont:StartMovement(aimVector, self.VJC_Data.TurnAngle)
		elseif gerta_lef then
			self.VJC_Data.TurnAngle = LerpAngle(FT, self.VJC_Data.TurnAngle, angY90)
			cont:StartMovement(aimVector, self.VJC_Data.TurnAngle)
		elseif gerta_rig then
			self.VJC_Data.TurnAngle = LerpAngle(FT, self.VJC_Data.TurnAngle, angYN90)
			cont:StartMovement(aimVector, self.VJC_Data.TurnAngle)
		else
			self:StopMoving()
			if self.MovementType == VJ_MOVETYPE_AERIAL or self.MovementType == VJ_MOVETYPE_AQUATIC then
				self:AA_StopMoving()
			end
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:StartMovement(cont, Dir, Rot)
	local self = cont.VJCE_NPC
	local ply = cont.VJCE_Player
	if self:GetState() != VJ_STATE_NONE then return end

	local DEBUG = ply:GetInfoNum("vj_npc_cont_devents", 0) == 1
	local plyAimVec = Dir
	plyAimVec.z = 0
	plyAimVec:Rotate(Rot)
	local selfPos = self:GetPos()
	local centerToPos = self:OBBCenter():Distance(self:OBBMins()) + 20 // self:OBBMaxs().z
	local NPCPos = selfPos + self:GetUp()*centerToPos
	local groundSpeed = math.Clamp(self:GetSequenceGroundSpeed(self:GetSequence()), 300, 9999)
	local defaultFilter = {cont, self, ply}
	local forwardTr = util.TraceHull({start = NPCPos, endpos = NPCPos + plyAimVec * groundSpeed, filter = defaultFilter, mins = Vector(-4,-4,-4), maxs = Vector(4,4,4)})
	local forwardDist = NPCPos:Distance(forwardTr.HitPos)
	local wallToSelf = forwardDist - (self:OBBMaxs().y *2.5) -- Use Y instead of X because X is left/right whereas Y is forward/backward
	if DEBUG then
		VJ.DEBUG_TempEnt(NPCPos, cont:GetAngles(), Color(0, 255, 255)) -- NPC's calculated position
		VJ.DEBUG_TempEnt(forwardTr.HitPos, cont:GetAngles(), Color(255, 255, 0)) -- forward trace position
	end
	if forwardDist >= 25 then
		local finalPos = Vector((selfPos + plyAimVec * wallToSelf).x, (selfPos + plyAimVec * wallToSelf).y, forwardTr.HitPos.z)
		local downTr = util.TraceLine({start = finalPos, endpos = finalPos + cont:GetUp()*-(200 + centerToPos), filter = defaultFilter})
		local downDist = (finalPos.z - centerToPos) - downTr.HitPos.z
		if downDist >= 150 then -- If the drop is this big, then don't move!
			//wallToSelf = wallToSelf - downDist -- No need, we are returning anyway
			return
		end
		if forwardDist <= 225 && !forwardTr.Hit then
			finalPos = Vector((selfPos + plyAimVec * groundSpeed).x, (selfPos + plyAimVec * groundSpeed).y, forwardTr.HitPos.z)
		else
			finalPos = Vector((selfPos + plyAimVec * wallToSelf).x, (selfPos + plyAimVec * wallToSelf).y, forwardTr.HitPos.z)
		end
		if DEBUG then
			VJ.DEBUG_TempEnt(downTr.HitPos, cont:GetAngles(), Color(255, 0, 255)) -- Down trace position
			VJ.DEBUG_TempEnt(finalPos, cont:GetAngles(), Color(0, 255, 0)) -- Final move position
		end
		self:SetLastPosition(finalPos)
		self:VJ_TASK_GOTO_LASTPOS(ply:KeyDown(IN_SPEED) and "TASK_RUN_PATH" or "TASK_WALK_PATH", function(x)
			if ply:KeyDown(IN_ATTACK2) && self.IsVJBaseSNPC_Human then
				x.FaceData = {Type = VJ.NPC_FACE_ENEMY}
				x.CanShootWhenMoving = true
			else
				if cont.VJC_BullseyeTracking then
					x.FaceData = {Type = VJ.NPC_FACE_ENEMY}
				else
					x:EngTask("TASK_FACE_LASTPOSITION", 0)
				end
			end
		end)
	end
end