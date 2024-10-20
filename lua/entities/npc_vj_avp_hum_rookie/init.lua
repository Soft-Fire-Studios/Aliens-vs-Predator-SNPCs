AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.StartHealth = 200
ENT.Gender = 1
ENT.VO = 2

ENT.VJ_NPC_Class = {"CLASS_PLAYER_ALLY"}
ENT.FriendsWithAllPlayerAllies = true

ENT.HasHealthRegeneration = true
ENT.HealthRegenerationAmount = 2
ENT.HealthRegenerationDelay = VJ.SET(0.1,0.1)
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GenderInit(gender)
	return "models/cpthazama/avp/marines/rookie.mdl"
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnInit2()
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
end