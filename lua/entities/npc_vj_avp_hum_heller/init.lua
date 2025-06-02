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

ENT.HasFlashlight = false
ENT.HasMotionTracker = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GenderInit(gender)
	return "models/cpthazama/avp/marines/heller.mdl"
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnInit()
	self.SoundTbl_Idle = {}
	self.SoundTbl_IdleDialogue = {
		"cpthazama/avp/humans/vocals/Heller/A01_Tutorial_REVISED_11.ogg",
		"cpthazama/avp/humans/vocals/Heller/A01_Tutorial_REVISED_44.ogg",
	}
	self.SoundTbl_IdleDialogueAnswer = {
		"cpthazama/avp/humans/vocals/Heller/A01_Tutorial_REVISED_43.ogg",
	}
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
	self.SoundTbl_Pain = {}
	self.SoundTbl_Investigate = {
		"cpthazama/avp/humans/vocals/Heller/A01_Tutorial_REVISED_16.ogg",
		"cpthazama/avp/humans/vocals/Heller/A01_Tutorial_REVISED_19.ogg",
	}
	self.SoundTbl_WeaponReload = {}
	self.SoundTbl_Spot_XenoLarge = {}
	self.SoundTbl_Spot_Xeno = {
		"cpthazama/avp/humans/vocals/Heller/A01_Tutorial_REVISED_01.ogg",
		"cpthazama/avp/humans/vocals/Heller/A01_Tutorial_REVISED_04.ogg",
	}
	self.SoundTbl_Spot_Android = {}
	self.SoundTbl_Spot_PredatorCloaked = {}
	self.SoundTbl_Spot_Predator = {}
	self.SoundTbl_AllyDeath_Xeno = {
		"cpthazama/avp/humans/vocals/Heller/A01_Tutorial_REVISED_13.ogg",
		"cpthazama/avp/humans/vocals/Heller/A01_Tutorial_REVISED_14.ogg",
		"cpthazama/avp/humans/vocals/Heller/A01__Tut_Groves_11.ogg",
	}
	self.SoundTbl_AllyDeath_Android = {}
	self.SoundTbl_AllyDeath_Predator = {}
	self.SoundTbl_AllyDeath = {}
	self.SoundTbl_Surprised = {}
	self.SoundTbl_Alert_Horde = {}
	self.SoundTbl_Death = {
		"cpthazama/avp/humans/vocals/Civilian_01/DEATH_CIV01_03.ogg",
	}
end