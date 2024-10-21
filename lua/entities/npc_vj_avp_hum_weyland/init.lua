AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.StartHealth = 700
ENT.Gender = 1

ENT.BloodColor = "White"

ENT.VJ_NPC_Class = {"CLASS_WEYLAND_YUTANI"}

ENT.HasFlashlight = false
ENT.HasMotionTracker = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GenderInit(gender)
	return "models/cpthazama/avp/marines/weyland.mdl"
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SynthInitialize()
	self.SoundTbl_LostEnemy = {}
	self.SoundTbl_Alert = {}
	self.SoundTbl_SeeBody = {}
	self.SoundTbl_DistractionSuccess = {}
	self.SoundTbl_Suppressing = {}
	self.SoundTbl_OnReceiveOrder = {}
	self.SoundTbl_DamageByPlayer = {}
	self.SoundTbl_InvestigateComplete = {}
	self.SoundTbl_OnKilledEnemy = {}
	self.SoundTbl_MotionTracker_Far = {}
	self.SoundTbl_MotionTracker_Mid = {}
	self.SoundTbl_MotionTracker_Close = {}
	self.SoundTbl_Pain = {
		"cpthazama/avp/humans/weyland/pain_wey_01.ogg",
		"cpthazama/avp/humans/weyland/pain_wey_02.ogg",
		"cpthazama/avp/humans/weyland/pain_wey_03.ogg",
		"cpthazama/avp/humans/weyland/pain_wey_04.ogg",
		"cpthazama/avp/humans/weyland/pain_wey_05.ogg",
		"cpthazama/avp/humans/weyland/pain_wey_06.ogg",
	}
	self.SoundTbl_Investigate = {}
	self.SoundTbl_WeaponReload = {}
	self.SoundTbl_Spot_XenoLarge = {}
	self.SoundTbl_Spot_Xeno = {}
	self.SoundTbl_Spot_Android = {}
	self.SoundTbl_Spot_PredatorCloaked = {}
	self.SoundTbl_Spot_Predator = {}
	self.SoundTbl_Spot_Marine = {}
	self.SoundTbl_AllyDeath_Xeno = {}
	self.SoundTbl_AllyDeath_Android = {}
	self.SoundTbl_AllyDeath_Predator = {}
	self.SoundTbl_AllyDeath = {}
	self.SoundTbl_Surprised = {}
	self.SoundTbl_Alert_Horde = {}
	self.SoundTbl_Death = {
		"cpthazama/avp/humans/weyland/death_wey_01.ogg",
		"cpthazama/avp/humans/weyland/death_wey_02.ogg",
		"cpthazama/avp/humans/weyland/death_wey_03.ogg",
		"cpthazama/avp/humans/weyland/death_wey_04.ogg",
	}

	if GetConVar("vj_avp_bosstheme_m"):GetBool() then
		self.HasSoundTrack = true
		self.SoundTbl_SoundTrack = {"cpthazama/avp/music/boss/Annihilation.mp3"}
	end
end