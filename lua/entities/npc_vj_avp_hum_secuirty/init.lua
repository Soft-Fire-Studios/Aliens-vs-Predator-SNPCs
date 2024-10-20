AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Gender = 1

ENT.VJ_NPC_Class = {"CLASS_WEYLAND_YUTANI"}

ENT.HasFlashlight = false
ENT.HasMotionTracker = true
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GenderInit(gender)
	return "models/cpthazama/avp/marines/security.mdl"
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnInit2()
	self.SoundTbl_LostEnemy = {}
	self.SoundTbl_Alert = {}
	self.SoundTbl_SeeBody = {
		"cpthazama/avp/humans/vocals/Red_Shirt_01/DISCOVER_BODY_RED01_01.ogg",
		"cpthazama/avp/humans/vocals/Red_Shirt_01/DISCOVER_BODY_RED01_02.ogg",
		"cpthazama/avp/humans/vocals/Red_Shirt_01/DISCOVER_BODY_RED01_03.ogg",
		"cpthazama/avp/humans/vocals/Red_Shirt_01/DISCOVER_BODY_RED01_04.ogg",
	}
	self.SoundTbl_DistractionSuccess = {
		"cpthazama/avp/humans/vocals/Red_Shirt_01/DISTRACTION_SUCCESS_RED01_01.ogg",
		"cpthazama/avp/humans/vocals/Red_Shirt_01/DISTRACTION_SUCCESS_RED01_02.ogg",
		"cpthazama/avp/humans/vocals/Red_Shirt_01/DISTRACTION_SUCCESS_RED01_03.ogg",
		"cpthazama/avp/humans/vocals/Red_Shirt_01/DISTRACTION_SUCCESS_RED01_04.ogg",
		"cpthazama/avp/humans/vocals/Red_Shirt_01/DISTRACTION_SUCCESS_RED01_05.ogg",
	}
	self.SoundTbl_Suppressing = {
		"cpthazama/avp/humans/vocals/Red_Shirt_01/ATTACKING_RED01_01.ogg",
		"cpthazama/avp/humans/vocals/Red_Shirt_01/ATTACKING_RED01_02.ogg",
		"cpthazama/avp/humans/vocals/Red_Shirt_01/ATTACKING_RED01_03.ogg",
	}
	self.SoundTbl_OnReceiveOrder = {}
	self.SoundTbl_DamageByPlayer = {}
	self.SoundTbl_InvestigateComplete = {
		"cpthazama/avp/humans/vocals/Red_Shirt_01/INVESTIGATE_ARRIVAL_RED01_01.ogg",
		"cpthazama/avp/humans/vocals/Red_Shirt_01/INVESTIGATE_ARRIVAL_RED01_02.ogg",
		"cpthazama/avp/humans/vocals/Red_Shirt_01/INVESTIGATE_END_RED01_01.ogg",
		"cpthazama/avp/humans/vocals/Red_Shirt_01/INVESTIGATE_END_RED01_02.ogg",
		"cpthazama/avp/humans/vocals/Red_Shirt_01/INVESTIGATE_END_RED01_03.ogg",
	}
	self.SoundTbl_OnKilledEnemy = {
		"cpthazama/avp/humans/vocals/Red_Shirt_01/KILLED_THREAT_RED01_01.ogg",
		"cpthazama/avp/humans/vocals/Red_Shirt_01/KILLED_THREAT_RED01_02.ogg",
	}
	self.SoundTbl_MotionTracker_Far = {}
	self.SoundTbl_MotionTracker_Mid = {}
	self.SoundTbl_MotionTracker_Close = {}
	self.SoundTbl_Pain = {
		"cpthazama/avp/humans/vocals/Red_Shirt_01/PAIN_RED01_01.ogg",
	}
	self.SoundTbl_Investigate = {}
	self.SoundTbl_WeaponReload = {
		"cpthazama/avp/humans/vocals/Red_Shirt_01/RELOADING_RED01_01.ogg",
		"cpthazama/avp/humans/vocals/Red_Shirt_01/RELOADING_RED01_02.ogg",
		"cpthazama/avp/humans/vocals/Red_Shirt_01/RELOADING_RED01_03.ogg",
	}
	self.SoundTbl_Spot_XenoLarge = {}
	self.SoundTbl_Spot_Xeno = {
		"cpthazama/avp/humans/vocals/Red_Shirt_01/SPOTTED_ALIEN_RED01_01.ogg",
		"cpthazama/avp/humans/vocals/Red_Shirt_01/SPOTTED_ALIEN_RED01_02.ogg",
		"cpthazama/avp/humans/vocals/Red_Shirt_01/SPOTTED_ALIEN_RED01_03.ogg",
		"cpthazama/avp/humans/vocals/Red_Shirt_01/SPOTTED_ALIEN_RED01_04.ogg",
	}
	self.SoundTbl_Spot_Android = {}
	self.SoundTbl_Spot_PredatorCloaked = {
		"cpthazama/avp/humans/vocals/Red_Shirt_01/SPOTTED_CLOAKED_PREDATOR_RED01_01.ogg",
		"cpthazama/avp/humans/vocals/Red_Shirt_01/SPOTTED_CLOAKED_PREDATOR_RED01_02.ogg",
		"cpthazama/avp/humans/vocals/Red_Shirt_01/SPOTTED_CLOAKED_PREDATOR_RED01_03.ogg",
	}
	self.SoundTbl_Spot_Predator = {
		"cpthazama/avp/humans/vocals/Red_Shirt_01/SPOTTED_PREDATOR_RED01_01.ogg",
		"cpthazama/avp/humans/vocals/Red_Shirt_01/SPOTTED_PREDATOR_RED01_02.ogg",
		"cpthazama/avp/humans/vocals/Red_Shirt_01/SPOTTED_PREDATOR_RED01_03.ogg",
	}
	self.SoundTbl_Spot_Marine = {}
	self.SoundTbl_AllyDeath_Xeno = {}
	self.SoundTbl_AllyDeath_Android = {}
	self.SoundTbl_AllyDeath_Predator = {}
	self.SoundTbl_AllyDeath = {
		"cpthazama/avp/humans/vocals/Red_Shirt_01/SQUAD_DEATH_RED01_01.ogg",
		"cpthazama/avp/humans/vocals/Red_Shirt_01/SQUAD_DEATH_RED01_02.ogg",
		"cpthazama/avp/humans/vocals/Red_Shirt_01/SQUAD_DEATH_RED01_03.ogg",
		"cpthazama/avp/humans/vocals/Red_Shirt_01/SQUAD_DEATH_RED01_04.ogg",
	}
	self.SoundTbl_Surprised = {
		"cpthazama/avp/humans/vocals/Red_Shirt_01/SURPRISE_RED01_01.ogg",
		"cpthazama/avp/humans/vocals/Red_Shirt_01/SURPRISE_RED01_02.ogg",
		"cpthazama/avp/humans/vocals/Red_Shirt_01/SURPRISE_RED01_03.ogg",
		"cpthazama/avp/humans/vocals/Red_Shirt_01/SURPRISE_RED01_04.ogg",
	}
	self.SoundTbl_Alert_Horde = {
		"cpthazama/avp/humans/vocals/Red_Shirt_01/TARGETS_MANY_RED01_01.ogg",
		"cpthazama/avp/humans/vocals/Red_Shirt_01/TARGETS_MANY_RED01_02.ogg",
		"cpthazama/avp/humans/vocals/Red_Shirt_01/TARGETS_MANY_RED01_03.ogg",
	}
	self.SoundTbl_Death = {
		"cpthazama/avp/humans/vocals/Red_Shirt_01/DEATH_RED01_01.ogg",
	}

	self:SetBodygroup(self:FindBodygroupByName("helmet"),1)
end