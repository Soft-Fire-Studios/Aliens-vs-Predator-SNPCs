AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Gender = 1
ENT.VO = 1

ENT.VJ_NPC_Class = {"CLASS_PLAYER_ALLY","CLASS_WEYLAND_YUTANI"}
ENT.AlliedWithPlayerAllies = true
ENT.Weapon_IgnoreSpawnMenu = true
ENT.Behavior = VJ_BEHAVIOR_PASSIVE

-- ENT.HasFlashlight = false
ENT.FlashLightAttachment = "bodylamp"
ENT.HasMotionTracker = false
ENT.CanUseStimpacks = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GenderInit(gender)
	return "models/cpthazama/avp/marines/archa.mdl"
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:ColonistInitialize()
	self.BecomeEnemyToPlayer = 2
	self.SoundTbl_Idle = {
		"cpthazama/avp/humans/vocals/Civilian_01/IDLE_CHATTER_CIV01_01.ogg",
		"cpthazama/avp/humans/vocals/Civilian_01/IDLE_CHATTER_CIV01_02.ogg",
		"cpthazama/avp/humans/vocals/Civilian_01/IDLE_CHATTER_CIV01_03.ogg",
		"cpthazama/avp/humans/vocals/Civilian_01/IDLE_CHATTER_CIV01_04.ogg",
		"cpthazama/avp/humans/vocals/Civilian_01/IDLE_CHATTER_CIV01_05.ogg",
		"cpthazama/avp/humans/vocals/Civilian_01/IDLE_CHATTER_CIV01_06.ogg",
		"cpthazama/avp/humans/vocals/Civilian_01/IDLE_CHATTER_CIV01_07.ogg",
		"cpthazama/avp/humans/vocals/Civilian_01/IDLE_CHATTER_CIV01_08.ogg",
	}
	self.SoundTbl_Alert = {
		"cpthazama/avp/humans/vocals/Civilian_01/ENTERING_AGGRESSIVE_CIV01_01.ogg",
		"cpthazama/avp/humans/vocals/Civilian_01/ENTERING_AGGRESSIVE_CIV01_02.ogg",
		"cpthazama/avp/humans/vocals/Civilian_01/ENTERING_AGGRESSIVE_CIV01_03.ogg",
		"cpthazama/avp/humans/vocals/Civilian_01/ENTERING_AGGRESSIVE_CIV01_04.ogg",
		"cpthazama/avp/humans/vocals/Civilian_01/PANIC_SCREAM_CIV01_01.ogg",
		"cpthazama/avp/humans/vocals/Civilian_01/PANIC_SCREAM_CIV01_02.ogg",
		"cpthazama/avp/humans/vocals/Civilian_01/PANIC_SCREAM_CIV01_03.ogg",
		"cpthazama/avp/humans/vocals/Civilian_01/PANIC_SCREAM_CIV01_04.ogg",
	}
	self.SoundTbl_SeeBody = {
		"cpthazama/avp/humans/vocals/Civilian_01/DISCOVER_BODY_CIV01_01.ogg",
		"cpthazama/avp/humans/vocals/Civilian_01/DISCOVER_BODY_CIV01_02.ogg",
		"cpthazama/avp/humans/vocals/Civilian_01/DISCOVER_BODY_CIV01_03.ogg",
		"cpthazama/avp/humans/vocals/Civilian_01/DISCOVER_BODY_CIV01_04.ogg",
	}
	self.SoundTbl_CombatIdle = {
		"cpthazama/avp/humans/vocals/Civilian_01/FLEEING_CIV01_01.ogg",
		"cpthazama/avp/humans/vocals/Civilian_01/FLEEING_CIV01_06.ogg",
		"cpthazama/avp/humans/vocals/Civilian_01/FLEEING_CIV01_08.ogg",
		"cpthazama/avp/humans/vocals/Civilian_01/FLEEING_CIV01_13.ogg",
		"cpthazama/avp/humans/vocals/Civilian_01/FLEEING_CIV01_14.ogg",
	}
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
		"cpthazama/avp/humans/vocals/Civilian_01/PAIN_CIV01_01.ogg",
		"cpthazama/avp/humans/vocals/Civilian_01/PAIN_CIV01_02.ogg",
		"cpthazama/avp/humans/vocals/Civilian_01/PAIN_CIV01_03.ogg",
		"cpthazama/avp/humans/vocals/Civilian_01/PAIN_CIV01_04.ogg",
	}
	self.SoundTbl_Investigate = {
		"cpthazama/avp/humans/vocals/Civilian_01/PASSIVE_TO_ALERT_CIV01_01.ogg",
		"cpthazama/avp/humans/vocals/Civilian_01/PASSIVE_TO_ALERT_CIV01_02.ogg",
		"cpthazama/avp/humans/vocals/Civilian_01/PASSIVE_TO_ALERT_CIV01_03.ogg",
		"cpthazama/avp/humans/vocals/Civilian_01/PASSIVE_TO_ALERT_CIV01_04.ogg",
	}
	self.SoundTbl_WeaponReload = {}
	self.SoundTbl_Spot_XenoLarge = {}
	self.SoundTbl_Spot_Xeno = {}
	self.SoundTbl_Spot_Android = {}
	self.SoundTbl_Spot_PredatorCloaked = {}
	self.SoundTbl_Spot_Predator = {}
	self.SoundTbl_AllyDeath_Xeno = {
		"cpthazama/avp/humans/vocals/Civilian_01/MARINE_DEATH_BY_ALIEN_CIV01_01.ogg",
		"cpthazama/avp/humans/vocals/Civilian_01/MARINE_DEATH_BY_ALIEN_CIV01_02.ogg",
	}
	self.SoundTbl_AllyDeath_Android = {
		"cpthazama/avp/humans/vocals/Civilian_01/MARINE_DEATH_BY_ANDROID_CIV01_01.ogg",
		"cpthazama/avp/humans/vocals/Civilian_01/MARINE_DEATH_BY_ANDROID_CIV01_02.ogg",
		"cpthazama/avp/humans/vocals/Civilian_01/MARINE_DEATH_BY_ANDROID_CIV01_03.ogg",
		"cpthazama/avp/humans/vocals/Civilian_01/MARINE_DEATH_BY_ANDROID_CIV01_04.ogg",
	}
	self.SoundTbl_AllyDeath_Predator = {
		"cpthazama/avp/humans/vocals/Civilian_01/MARINE_DEATH_BY_PREDATOR_CIV01_01.ogg",
		"cpthazama/avp/humans/vocals/Civilian_01/MARINE_DEATH_BY_PREDATOR_CIV01_02.ogg",
		"cpthazama/avp/humans/vocals/Civilian_01/MARINE_DEATH_BY_PREDATOR_CIV01_03.ogg",
		"cpthazama/avp/humans/vocals/Civilian_01/MARINE_DEATH_BY_PREDATOR_CIV01_04.ogg",
	}
	self.SoundTbl_AllyDeath = {
		"cpthazama/avp/humans/vocals/Civilian_01/MARINE_DEATH_CIV01_01.ogg",
		"cpthazama/avp/humans/vocals/Civilian_01/MARINE_DEATH_CIV01_02.ogg",
		"cpthazama/avp/humans/vocals/Civilian_01/MARINE_DEATH_CIV01_03.ogg",
		"cpthazama/avp/humans/vocals/Civilian_01/MARINE_DEATH_CIV01_04.ogg",
		"cpthazama/avp/humans/vocals/Civilian_01/TEAM_MATE_KILLED_CIV01_01.ogg",
		"cpthazama/avp/humans/vocals/Civilian_01/TEAM_MATE_KILLED_CIV01_02.ogg",
		"cpthazama/avp/humans/vocals/Civilian_01/TEAM_MATE_KILLED_CIV01_03.ogg",
		"cpthazama/avp/humans/vocals/Civilian_01/TEAM_MATE_KILLED_CIV01_04.ogg",
		"cpthazama/avp/humans/vocals/Civilian_01/TEAM_MATE_KILLED_CIV01_05.ogg",
		"cpthazama/avp/humans/vocals/Civilian_01/TEAM_MATE_KILLED_CIV01_06.ogg",
		"cpthazama/avp/humans/vocals/Civilian_01/TEAM_MATE_KILLED_CIV01_07.ogg",
	}
	self.SoundTbl_Surprised = {
		"cpthazama/avp/humans/vocals/Civilian_01/SURPRISE_CIV01_01.ogg",
		"cpthazama/avp/humans/vocals/Civilian_01/SURPRISE_CIV01_02.ogg",
		"cpthazama/avp/humans/vocals/Civilian_01/SURPRISE_CIV01_03.ogg",
		"cpthazama/avp/humans/vocals/Civilian_01/SURPRISE_CIV01_04.ogg",
	}
	self.SoundTbl_Alert_Horde = {}
	self.SoundTbl_Death = {
		"cpthazama/avp/humans/vocals/Civilian_01/DEATH_CIV01_01.ogg",
		"cpthazama/avp/humans/vocals/Civilian_01/DEATH_CIV01_02.ogg",
		"cpthazama/avp/humans/vocals/Civilian_01/DEATH_CIV01_03.ogg",
		"cpthazama/avp/humans/vocals/Civilian_01/DEATH_CIV01_04.ogg",
	}
end