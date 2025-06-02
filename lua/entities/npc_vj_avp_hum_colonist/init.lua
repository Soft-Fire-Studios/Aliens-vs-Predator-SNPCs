AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Gender = 1

ENT.VJ_NPC_Class = {"CLASS_PLAYER_ALLY","CLASS_WEYLAND_YUTANI"}
ENT.AlliedWithPlayerAllies = true
ENT.Weapon_IgnoreSpawnMenu = true
ENT.Behavior = VJ_BEHAVIOR_PASSIVE

ENT.HasFlashlight = false
ENT.HasMotionTracker = false
ENT.CanUseStimpacks = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GenderInit(gender)
	return VJ.PICK({
		"models/cpthazama/avp/marines/colonist.mdl",
		"models/cpthazama/avp/marines/colonist.mdl",
		"models/cpthazama/avp/marines/colonist.mdl",
		"models/cpthazama/avp/marines/worker.mdl",
	})
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:ColonistInitialize()
	self:SetSkin(math.random(0,2))
	self.BecomeEnemyToPlayer = 2
	self.SoundTbl_Idle = {
		"cpthazama/avp/humans/vocals/Civilian_02/IDLE_CHATTER_CIV02_09.ogg",
		"cpthazama/avp/humans/vocals/Civilian_02/IDLE_CHATTER_CIV02_10.ogg",
		"cpthazama/avp/humans/vocals/Civilian_02/IDLE_CHATTER_CIV02_11.ogg",
		"cpthazama/avp/humans/vocals/Civilian_02/IDLE_CHATTER_CIV02_12.ogg",
		"cpthazama/avp/humans/vocals/Civilian_02/IDLE_CHATTER_CIV02_13.ogg",
		"cpthazama/avp/humans/vocals/Civilian_02/IDLE_CHATTER_CIV02_14.ogg",
		"cpthazama/avp/humans/vocals/Civilian_02/IDLE_CHATTER_CIV02_15.ogg",
		"cpthazama/avp/humans/vocals/Civilian_02/IDLE_CHATTER_CIV02_16.ogg",
	}
	self.SoundTbl_Alert = {
		"cpthazama/avp/humans/vocals/Civilian_02/ENTERING_AGGRESSIVE_CIV02_04.ogg",
		"cpthazama/avp/humans/vocals/Civilian_02/ENTERING_AGGRESSIVE_CIV02_05.ogg",
		"cpthazama/avp/humans/vocals/Civilian_02/ENTERING_AGGRESSIVE_CIV02_06.ogg",
		"cpthazama/avp/humans/vocals/Civilian_02/ENTERING_AGGRESSIVE_CIV02_07.ogg",
		"cpthazama/avp/humans/vocals/Civilian_02/PANIC_SCREAM_CIV02_01.ogg",
		"cpthazama/avp/humans/vocals/Civilian_02/PANIC_SCREAM_CIV02_02.ogg",
		"cpthazama/avp/humans/vocals/Civilian_02/PANIC_SCREAM_CIV02_03.ogg",
		"cpthazama/avp/humans/vocals/Civilian_02/PANIC_SCREAM_CIV02_04.ogg",
		"cpthazama/avp/humans/vocals/Civilian_02/PANIC_SCREAM_CIV02_05.ogg",
	}
	self.SoundTbl_SeeBody = {
		"cpthazama/avp/humans/vocals/Civilian_02/DISCOVER_BODY_CIV02_05.ogg",
		"cpthazama/avp/humans/vocals/Civilian_02/DISCOVER_BODY_CIV02_06.ogg",
		"cpthazama/avp/humans/vocals/Civilian_02/DISCOVER_BODY_CIV02_07.ogg",
	}
	self.SoundTbl_CombatIdle = {
		"cpthazama/avp/humans/vocals/Civilian_02/FLEEING_CIV02_13.ogg",
		"cpthazama/avp/humans/vocals/Civilian_02/FLEEING_CIV02_14.ogg",
		"cpthazama/avp/humans/vocals/Civilian_02/FLEEING_CIV02_15.ogg",
		"cpthazama/avp/humans/vocals/Civilian_02/FLEEING_CIV02_16.ogg",
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
		"cpthazama/avp/humans/vocals/Civilian_02/PAIN_CIV02_01.ogg",
		"cpthazama/avp/humans/vocals/Civilian_02/PAIN_CIV02_03.ogg",
		"cpthazama/avp/humans/vocals/Civilian_02/PAIN_CIV02_04.ogg",
	}
	self.SoundTbl_Investigate = {
		"cpthazama/avp/humans/vocals/Civilian_02/PASSIVE_TO_ALERT_CIV02_04.ogg",
		"cpthazama/avp/humans/vocals/Civilian_02/PASSIVE_TO_ALERT_CIV02_05.ogg",
		"cpthazama/avp/humans/vocals/Civilian_02/PASSIVE_TO_ALERT_CIV02_06.ogg",
		"cpthazama/avp/humans/vocals/Civilian_02/PASSIVE_TO_ALERT_CIV02_07.ogg",
	}
	self.SoundTbl_WeaponReload = {}
	self.SoundTbl_Spot_XenoLarge = {}
	self.SoundTbl_Spot_Xeno = {}
	self.SoundTbl_Spot_Android = {}
	self.SoundTbl_Spot_PredatorCloaked = {}
	self.SoundTbl_Spot_Predator = {}
	self.SoundTbl_AllyDeath_Xeno = {}
	self.SoundTbl_AllyDeath_Android = {}
	self.SoundTbl_AllyDeath_Predator = {}
	self.SoundTbl_AllyDeath = {
		"cpthazama/avp/humans/vocals/Civilian_02/MARINE_DEATH_BY_ALIEN_CIV02_03.ogg",
		"cpthazama/avp/humans/vocals/Civilian_02/MARINE_DEATH_BY_ALIEN_CIV02_04.ogg",
		"cpthazama/avp/humans/vocals/Civilian_02/MARINE_DEATH_CIV02_04.ogg",
		"cpthazama/avp/humans/vocals/Civilian_02/MARINE_DEATH_CIV02_05.ogg",
		"cpthazama/avp/humans/vocals/Civilian_02/MARINE_DEATH_CIV02_06.ogg",
		"cpthazama/avp/humans/vocals/Civilian_02/TEAM_MATE_KILLED_CIV02_04.ogg",
		"cpthazama/avp/humans/vocals/Civilian_02/TEAM_MATE_KILLED_CIV02_05.ogg",
		"cpthazama/avp/humans/vocals/Civilian_02/TEAM_MATE_KILLED_CIV02_06.ogg",
		"cpthazama/avp/humans/vocals/Civilian_02/TEAM_MATE_KILLED_CIV02_07.ogg",
	}
	self.SoundTbl_Surprised = {
		"cpthazama/avp/humans/vocals/Civilian_02/SURPRISE_CIV02_01.ogg",
		"cpthazama/avp/humans/vocals/Civilian_02/SURPRISE_CIV02_02.ogg",
		"cpthazama/avp/humans/vocals/Civilian_02/SURPRISE_CIV02_03.ogg",
		"cpthazama/avp/humans/vocals/Civilian_02/SURPRISE_CIV02_04.ogg",
	}
	self.SoundTbl_Alert_Horde = {}
	self.SoundTbl_Death = {
		"cpthazama/avp/humans/vocals/Civilian_02/DEATH_CIV02_01.ogg",
		"cpthazama/avp/humans/vocals/Civilian_02/DEATH_CIV02_02.ogg",
		"cpthazama/avp/humans/vocals/Civilian_02/DEATH_CIV02_03.ogg",
		"cpthazama/avp/humans/vocals/Civilian_02/DEATH_CIV02_04.ogg",
	}
end