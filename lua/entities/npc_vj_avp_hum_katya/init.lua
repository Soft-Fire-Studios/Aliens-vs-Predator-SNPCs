AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.StartHealth = 200
ENT.Gender = 2

ENT.BloodColor = VJ.BLOOD_COLOR_WHITE

ENT.VJ_NPC_Class = {"CLASS_PLAYER_ALLY"}
ENT.AlliedWithPlayerAllies = true

ENT.HasFlashlight = false
ENT.HasMotionTracker = false
ENT.CanUseStimpacks = false
ENT.HasOnPlayerSight = true
ENT.OnPlayerSightOnlyOnce = false
ENT.OnPlayerSightNextTime = VJ.SET(60, 120)

ENT.HealthRegenParams = {
	Enabled = true,
	Amount = 2,
	Delay = VJ.SET(0.1, 0.1),
}

ENT.NoWeaponOverrides = {
	[ACT_IDLE] = ACT_VM_IDLE_LOWERED,
	[ACT_WALK] = ACT_VM_RECOIL1,
}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GenderInit(gender)
	return "models/cpthazama/avp/marines/katya.mdl"
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SynthInitialize() end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnInit()
	self.BecomeEnemyToPlayer = 15
	self.SoundTbl_LostEnemy = {}
	self.SoundTbl_Alert = {}
	self.SoundTbl_SeeBody = {}
	self.SoundTbl_DistractionSuccess = {}
	self.SoundTbl_Suppressing = {}
	self.SoundTbl_ReceiveOrder = {}
	self.SoundTbl_DamageByPlayer = {}
	self.SoundTbl_InvestigateComplete = {}
	self.SoundTbl_KilledEnemy = {}
	self.SoundTbl_MotionTracker_Far = {}
	self.SoundTbl_MotionTracker_Mid = {}
	self.SoundTbl_MotionTracker_Close = {}
	self.SoundTbl_Pain = {
		"cpthazama/avp/humans/vocals/Katya/PAIN_KAT_01.ogg",
		"cpthazama/avp/humans/vocals/Katya/PAIN_KAT_02.ogg",
		"cpthazama/avp/humans/vocals/Katya/PAIN_KAT_03.ogg",
		"cpthazama/avp/humans/vocals/Katya/PAIN_KAT_04.ogg",
	}
	self.SoundTbl_Investigate = {}
	self.SoundTbl_WeaponReload = {}
	self.SoundTbl_OnPlayerSight = {"cpthazama/avp/humans/vocals/Katya/M05mid_b_01.ogg","cpthazama/avp/humans/vocals/Katya/M05mid_b_02.ogg"}
	self.SoundTbl_Spot_XenoLarge = {}
	self.SoundTbl_Spot_Xeno = {"cpthazama/avp/humans/vocals/Katya/M05_PostKatya_03.ogg"}
	self.SoundTbl_Spot_Android = {}
	self.SoundTbl_Spot_PredatorCloaked = {}
	self.SoundTbl_Spot_Predator = {}
	self.SoundTbl_Spot_Marine = {}
	self.SoundTbl_AllyDeath_Xeno = {}
	self.SoundTbl_AllyDeath_Android = {}
	self.SoundTbl_AllyDeath_Predator = {}
	self.SoundTbl_AllyDeath = {"cpthazama/avp/humans/vocals/Katya/M05mid_a_03.ogg"}
	self.SoundTbl_Surprised = {}
	self.SoundTbl_Alert_Horde = {}
	self.SoundTbl_Death = {
		"cpthazama/avp/humans/vocals/Katya/PAIN_KAT_01.ogg",
		"cpthazama/avp/humans/vocals/Katya/PAIN_KAT_02.ogg",
		"cpthazama/avp/humans/vocals/Katya/PAIN_KAT_03.ogg",
		"cpthazama/avp/humans/vocals/Katya/PAIN_KAT_04.ogg",
	}
end