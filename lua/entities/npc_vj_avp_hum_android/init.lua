AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.StartHealth = 200
ENT.Gender = 1

ENT.BloodColor = "White"

ENT.VJ_NPC_Class = {"CLASS_WEYLAND_YUTANI"}

ENT.HasFlashlight = false
ENT.HasMotionTracker = true
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GenderInit(gender)
	return "models/cpthazama/avp/marines/android.mdl"
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SynthInitialize()
	self.SoundTbl_LostEnemy = {
		"cpthazama/avp/humans/vocals/Android_01/AGGRESSIVE_TO_ALERT_AND01_04.ogg",
		"cpthazama/avp/humans/vocals/Android_01/ALERT_TO_PASSIVE_AND01_02.ogg",
	}
	self.SoundTbl_Alert = {
		"cpthazama/avp/humans/vocals/Android_01/ENTERING_AGGRESSIVE_AND01_02.ogg",
	}
	self.SoundTbl_SeeBody = {}
	self.SoundTbl_DistractionSuccess = {}
	self.SoundTbl_Suppressing = {
		"cpthazama/avp/humans/vocals/Android_01/ATTACKING_AND01_04.ogg",
	}
	self.SoundTbl_OnReceiveOrder = {}
	self.SoundTbl_DamageByPlayer = {}
	self.SoundTbl_InvestigateComplete = {}
	self.SoundTbl_OnKilledEnemy = {
		"cpthazama/avp/humans/vocals/Android_01/KILLED_THREAT_AND01_04.ogg",
	}
	self.SoundTbl_MotionTracker_Far = {}
	self.SoundTbl_MotionTracker_Mid = {}
	self.SoundTbl_MotionTracker_Close = {}
	self.SoundTbl_Pain = {
		"cpthazama/avp/humans/vocals/Android_01/pain_and01_01.ogg",
		"cpthazama/avp/humans/vocals/Android_01/pain_and01_02.ogg",
		"cpthazama/avp/humans/vocals/Android_01/pain_and01_03.ogg",
		"cpthazama/avp/humans/vocals/Android_01/pain_and01_04.ogg",
		"cpthazama/avp/humans/vocals/Android_01/pain_and01_05.ogg",
	}
	self.SoundTbl_Investigate = {
		"cpthazama/avp/humans/vocals/Android_01/PASSIVE_TO_ALERT_AND01_03.ogg",
	}
	self.SoundTbl_WeaponReload = {
		"cpthazama/avp/humans/vocals/Android_01/RELOADING_AND01_04.ogg",
	}
	self.SoundTbl_Spot_XenoLarge = {}
	self.SoundTbl_Spot_Xeno = {
		"cpthazama/avp/humans/vocals/Android_01/HISS_SUCCESS_AND01_02.ogg",
		"cpthazama/avp/humans/vocals/Android_01/SPOTTED_ALIEN_AND01_01.ogg",
		"cpthazama/avp/humans/vocals/Android_01/SPOTTED_ALIEN_AND01_02.ogg",
		"cpthazama/avp/humans/vocals/Android_01/SPOTTED_ALIEN_AND01_03.ogg",
		"cpthazama/avp/humans/vocals/Android_01/SPOTTED_ALIEN_AND01_04.ogg",
	}
	self.SoundTbl_Spot_Android = {}
	self.SoundTbl_Spot_PredatorCloaked = {}
	self.SoundTbl_Spot_Predator = {
		"cpthazama/avp/humans/vocals/Android_01/SPOTTED_PREDATOR_AND01_01.ogg",
		"cpthazama/avp/humans/vocals/Android_01/SPOTTED_PREDATOR_AND01_02.ogg",
		"cpthazama/avp/humans/vocals/Android_01/SPOTTED_PREDATOR_AND01_03.ogg",
		"cpthazama/avp/humans/vocals/Android_01/SPOTTED_PREDATOR_AND01_04.ogg",
	}
	self.SoundTbl_Spot_Marine = {
		"cpthazama/avp/humans/vocals/Android_01/SPOTTED_MARINE_AND01_01.ogg",
		"cpthazama/avp/humans/vocals/Android_01/SPOTTED_MARINE_AND01_02.ogg",
		"cpthazama/avp/humans/vocals/Android_01/SPOTTED_MARINE_AND01_03.ogg",
	}
	self.SoundTbl_AllyDeath_Xeno = {}
	self.SoundTbl_AllyDeath_Android = {}
	self.SoundTbl_AllyDeath_Predator = {}
	self.SoundTbl_AllyDeath = {
		"cpthazama/avp/humans/vocals/Android_01/SQUAD_DEATH_AND01_02.ogg",
	}
	self.SoundTbl_Surprised = {
		"cpthazama/avp/humans/vocals/Android_01/SURPRISE_AND01_02.ogg",
	}
	self.SoundTbl_Alert_Horde = {
		"cpthazama/avp/humans/vocals/Android_01/TARGETS_MANY_AND01_02.ogg",
	}
	self.SoundTbl_Death = {
		"cpthazama/avp/humans/vocals/Android_01/death_and01_01.ogg",
		"cpthazama/avp/humans/vocals/Android_01/death_and01_02.ogg",
		"cpthazama/avp/humans/vocals/Android_01/death_and01_03.ogg",
		"cpthazama/avp/humans/vocals/Android_01/death_and01_04.ogg",
	}
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo, hitgroup, ent)
	ent.VJ_AVP_IsTech = true
	ent:SetNW2Bool("AVP.IsTech",true)
	ent.OnHeadAte = function(corpse,xeno)
		corpse:SetBodygroup(corpse:FindBodygroupByName("head"),1)
	end

	timer.Simple(1.25,function()
		if IsValid(ent) then
			sound.EmitHint(SOUND_DANGER, ent:GetPos(), 250, 3.75, ent)
			ParticleEffectAttach("vj_avp_android_death_charge",PATTACH_ABSORIGIN_FOLLOW,ent,0)
		end
	end)

	timer.Simple(5,function()
		if IsValid(ent) then
			local fakeNPC = ents.Create("npc_vj_avp_hum_android")
			fakeNPC:SetPos(ent:GetPos())
			fakeNPC:SetAngles(ent:GetAngles())
			fakeNPC:Spawn()
			fakeNPC:Activate()
			ent:StopParticles()
			VJ.ApplyRadiusDamage(fakeNPC, fakeNPC, ent:GetPos(), 200, 50, bit.bor(DMG_BLAST,DMG_SHOCK), false, true)
			ParticleEffect("vj_avp_android_death",ent:GetPos(),Angle())
			sound.Play("cpthazama/avp/weapons/predator/mine/prd_mine_explosion_01.ogg",ent:GetPos(),90)
	
			local FireLight1 = ents.Create("light_dynamic")
			FireLight1:SetKeyValue("brightness","4")
			FireLight1:SetKeyValue("distance","350")
			FireLight1:SetPos(ent:GetPos())
			FireLight1:SetLocalAngles(ent:GetAngles())
			FireLight1:Fire("Color","220 180 255")
			FireLight1:SetParent(ent)
			FireLight1:Spawn()
			FireLight1:Activate()
			FireLight1:Fire("TurnOn","",0)
			FireLight1:Fire("Kill","",0.9)
			ent:DeleteOnRemove(FireLight1)

			SafeRemoveEntity(fakeNPC)
		end
	end)
end