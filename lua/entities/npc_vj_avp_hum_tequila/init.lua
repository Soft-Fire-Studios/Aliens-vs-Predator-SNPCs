AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.StartHealth = 200
ENT.Gender = 2

ENT.VJ_NPC_Class = {"CLASS_PLAYER_ALLY"}
ENT.FriendsWithAllPlayerAllies = true

ENT.HasHealthRegeneration = true
ENT.HealthRegenerationAmount = 2
ENT.HealthRegenerationDelay = VJ.SET(0.1,0.1)
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GenderInit(gender)
	return "models/cpthazama/avp/marines/tequila.mdl"
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnInit2()
	self:SetBodygroup(self:FindBodygroupByName("vest"),1)
	self.SoundTbl_LostEnemy = {}
	self.SoundTbl_Alert = {
		"cpthazama/avp/humans/vocals/Tequila/ENTERING_AGGRESSIVE_TEQ_01.ogg",
		"cpthazama/avp/humans/vocals/Tequila/ENTERING_AGGRESSIVE_TEQ_02.ogg",
		"cpthazama/avp/humans/vocals/Tequila/ENTERING_AGGRESSIVE_TEQ_03.ogg",
		"cpthazama/avp/humans/vocals/Tequila/ENTERING_AGGRESSIVE_TEQ_04.ogg",
		"cpthazama/avp/humans/vocals/Tequila/ENTERING_AGGRESSIVE_TEQ_05.ogg",
		"cpthazama/avp/humans/vocals/Tequila/ENTERING_AGGRESSIVE_TEQ_06.ogg",
		"cpthazama/avp/humans/vocals/Tequila/ENTERING_AGGRESSIVE_TEQ_07.ogg",
		"cpthazama/avp/humans/vocals/Tequila/ENTERING_AGGRESSIVE_TEQ_08.ogg",
		"cpthazama/avp/humans/vocals/Tequila/ENTERING_AGGRESSIVE_TEQ_09.ogg",
		"cpthazama/avp/humans/vocals/Tequila/ENTERING_AGGRESSIVE_TEQ_10.ogg",
		"cpthazama/avp/humans/vocals/Tequila/ENTERING_AGGRESSIVE_TEQ_11.ogg",
		"cpthazama/avp/humans/vocals/Tequila/ENTERING_AGGRESSIVE_TEQ_12.ogg",
	}
	self.SoundTbl_SeeBody = {}
	self.SoundTbl_DistractionSuccess = {}
	self.SoundTbl_Suppressing = {
		"cpthazama/avp/humans/vocals/Tequila/ATTACKING_TEQ_01.ogg",
		"cpthazama/avp/humans/vocals/Tequila/ATTACKING_TEQ_02.ogg",
		"cpthazama/avp/humans/vocals/Tequila/ATTACKING_TEQ_03.ogg",
		"cpthazama/avp/humans/vocals/Tequila/ATTACKING_TEQ_04.ogg",
		"cpthazama/avp/humans/vocals/Tequila/ATTACKING_TEQ_05.ogg",
		"cpthazama/avp/humans/vocals/Tequila/ATTACKING_TEQ_06.ogg",
		"cpthazama/avp/humans/vocals/Tequila/ATTACKING_TEQ_07.ogg",
		"cpthazama/avp/humans/vocals/Tequila/ATTACKING_TEQ_08.ogg",
		"cpthazama/avp/humans/vocals/Tequila/ATTACKING_TEQ_09.ogg",
		"cpthazama/avp/humans/vocals/Tequila/ATTACKING_TEQ_10.ogg",
		"cpthazama/avp/humans/vocals/Tequila/ATTACKING_TEQ_11.ogg",
	}
	self.SoundTbl_OnReceiveOrder = {}
	self.SoundTbl_DamageByPlayer = {}
	self.SoundTbl_InvestigateComplete = {}
	self.SoundTbl_OnKilledEnemy = {
		"cpthazama/avp/humans/vocals/Tequila/KILLED_THREAT_TEQ_03.ogg",
		"cpthazama/avp/humans/vocals/Tequila/KILLED_THREAT_TEQ_04.ogg",
		"cpthazama/avp/humans/vocals/Tequila/KILLED_THREAT_TEQ_05.ogg",
		"cpthazama/avp/humans/vocals/Tequila/KILLED_THREAT_TEQ_06.ogg",
		"cpthazama/avp/humans/vocals/Tequila/KILLED_THREAT_TEQ_07.ogg",
	}
	self.SoundTbl_MotionTracker_Far = {}
	self.SoundTbl_MotionTracker_Mid = {}
	self.SoundTbl_MotionTracker_Close = {}
	self.SoundTbl_Pain = {
		"cpthazama/avp/humans/human/vocals/tequila_sick/tq_groan_01.ogg",
		"cpthazama/avp/humans/human/vocals/tequila_sick/tq_groan_02.ogg",
		"cpthazama/avp/humans/human/vocals/tequila_sick/tq_groan_03.ogg",
		"cpthazama/avp/humans/human/vocals/tequila_sick/tq_groan_04.ogg",
	}
	self.SoundTbl_Investigate = {}
	self.SoundTbl_WeaponReload = {
		"cpthazama/avp/humans/vocals/Tequila/RELOADING_TEQ_01.ogg",
		"cpthazama/avp/humans/vocals/Tequila/RELOADING_TEQ_02.ogg",
		"cpthazama/avp/humans/vocals/Tequila/RELOADING_TEQ_03.ogg",
		"cpthazama/avp/humans/vocals/Tequila/RELOADING_TEQ_04.ogg",
		"cpthazama/avp/humans/vocals/Tequila/RELOADING_TEQ_05.ogg",
		"cpthazama/avp/humans/vocals/Tequila/RELOADING_TEQ_06.ogg",
		"cpthazama/avp/humans/vocals/Tequila/RELOADING_TEQ_07.ogg",
		"cpthazama/avp/humans/vocals/Tequila/RELOADING_TEQ_08.ogg",
		"cpthazama/avp/humans/vocals/Tequila/RELOADING_TEQ_09.ogg",
		"cpthazama/avp/humans/vocals/Tequila/RELOADING_TEQ_10.ogg",
	}
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
		"cpthazama/avp/humans/human/vocals/tequila_sick/tq_watch_fight_01.ogg",
		"cpthazama/avp/humans/human/vocals/tequila_sick/tq_watch_fight_02.ogg",
		"cpthazama/avp/humans/human/vocals/tequila_sick/tq_watch_fight_03.ogg",
	}
end