AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Gender = 1
ENT.VO = 0

ENT.VJ_NPC_Class = {"CLASS_WEYLAND_YUTANI"}
ENT.Weapon_IgnoreSpawnMenu = true
ENT.Behavior = VJ_BEHAVIOR_PASSIVE

ENT.HasFlashlight = false
ENT.HasMotionTracker = false
ENT.CanUseStimpacks = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GenderInit(gender)
	return "models/cpthazama/avp/marines/scientist.mdl"
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnInit()
	self.BecomeEnemyToPlayer = 2
	self.SoundTbl_Idle = {}
	self.SoundTbl_Alert = {}
	self.SoundTbl_SeeBody = {}
	self.SoundTbl_CombatIdle = {}
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
		"cpthazama/avp/humans/vocals/Civilian_02/PAIN_CIV02_01.ogg",
		"cpthazama/avp/humans/vocals/Civilian_02/PAIN_CIV02_03.ogg",
		"cpthazama/avp/humans/vocals/Civilian_02/PAIN_CIV02_04.ogg",
	}
	self.SoundTbl_Investigate = {}
	self.SoundTbl_WeaponReload = {}
	self.SoundTbl_Spot_XenoLarge = {}
	self.SoundTbl_Spot_Xeno = {}
	self.SoundTbl_Spot_Android = {}
	self.SoundTbl_Spot_PredatorCloaked = {}
	self.SoundTbl_Spot_Predator = {}
	self.SoundTbl_AllyDeath_Xeno = {}
	self.SoundTbl_AllyDeath_Android = {}
	self.SoundTbl_AllyDeath_Predator = {}
	self.SoundTbl_AllyDeath = {}
	self.SoundTbl_Surprised = {}
	self.SoundTbl_Alert_Horde = {}
	self.SoundTbl_Death = {
		"cpthazama/avp/humans/vocals/Civilian_02/DEATH_CIV02_01.ogg",
		"cpthazama/avp/humans/vocals/Civilian_02/DEATH_CIV02_02.ogg",
		"cpthazama/avp/humans/vocals/Civilian_02/DEATH_CIV02_03.ogg",
		"cpthazama/avp/humans/vocals/Civilian_02/DEATH_CIV02_04.ogg",
	}
end