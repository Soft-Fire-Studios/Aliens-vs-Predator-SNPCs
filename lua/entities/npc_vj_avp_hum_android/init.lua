AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.StartHealth = 200
ENT.Gender = 1

ENT.BloodColor = VJ.BLOOD_COLOR_WHITE

ENT.VJ_NPC_Class = {"CLASS_WEYLAND_YUTANI"}

ENT.HasFlashlight = false
ENT.HasMotionTracker = true

ENT.AllowCloaking = false
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
		"cpthazama/avp/humans/android/pain_and01_01.ogg",
		"cpthazama/avp/humans/android/pain_and01_02.ogg",
		"cpthazama/avp/humans/android/pain_and01_03.ogg",
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
function ENT:OnInit()
	self:SetBodygroup(self:FindBodygroupByName("mask"),self.AllowCloaking && 2 or 1)
	self.HasFallen = false
	self.NextCloakT = 0

	if self.AllowCloaking then
		self:SetSkin(1)
		self:SetBodygroup(self:FindBodygroupByName("armor"),1)
		self.GeneralSoundPitch1 = 90
		self.GeneralSoundPitch2 = 95
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:HandlePerceivedRelationship(v)
	if self:GetCloaked() then
		local calcMult = ((self:IsMoving() && (self:GetIdealActivity() == ACT_WALK && 0.35 or 1) or 0.15) *(self:GetSprinting() && 3 or 1))
		if v.VJ_AVP_Xenomorph or v.VJ_AVP_Predator then
			return
		end
		if v.EntityClass == AVP_ENTITYCLASS_ANDROID then
			calcMult = calcMult *1.6
		end
		if v:Visible(self) && v:GetPos():Distance(self:GetPos()) <= (300 *calcMult) then
			return D_NU
		end
		if v:GetPos():Distance(self:GetPos()) > (500 *calcMult) then
			if v:HasEnemyMemory(self) then
				v:ClearEnemyMemory(self)
			end
			if v:GetEnemy() == self then
				v:SetEnemy(nil)
			end
			return D_NU
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnThink2(curTime)
	if !self.AllowCloaking or self.HasFallen then return end
	local enemy = self:GetEnemy()
	local cont = self.VJ_IsBeingControlled
	if self:GetCloaked() then
		for _,v in ents.Iterator() do
			if (v:IsNPC() or v:IsNextBot()) && v:GetClass() != "obj_vj_bullseye" && self:CheckRelationship(v) != D_LI then
				local calcMult = ((self:IsMoving() && (self:GetIdealActivity() == ACT_WALK && 0.35 or 1) or 0.15) *(sprinting && 3 or 1))
				if v.VJ_AVP_Xenomorph or v.VJ_AVP_Predator then
					continue
				end
				if v.EntityClass == AVP_ENTITYCLASS_ANDROID then
					calcMult = calcMult *1.6
				end
				if v:Visible(self) && v:GetPos():Distance(self:GetPos()) <= (300 *calcMult) then
					continue
				end
				if v:GetPos():Distance(self:GetPos()) > (500 *calcMult) then
					if v.HasEnemyMemory && v:HasEnemyMemory(self) then
						v:ClearEnemyMemory(self)
					end
					if v.GetEnemy && v:GetEnemy() == self then
						v:SetEnemy(nil)
					end
				end
			end
		end
		if self:WaterLevel() >= 2 or !IsValid(self:GetEnemy()) && !self.Alerted && !cont then
			self:Camo(false)
			self.NextCloakT = curTime +2
		end
	else
		-- if !self:GetCloaked() && curTime > self.NextCloakT then
		-- 	self:Camo(!self:GetCloaked())
		-- 	self.NextCloakT = curTime +1
		-- end
		if IsValid(enemy) && !cont then
			if !self:GetCloaked() && self:GetState() == VJ_STATE_NONE && curTime > self.NextCloakT && !enemy.VJ_AVP_Xenomorph && math.random(1,30) == 1 then
				self:Camo(!self:GetCloaked())
				self.NextCloakT = curTime +1
			end
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Camo(set)
	self:SetCloaked(set)
	if set then
		-- self:SetMaterial("models/cpthazama/avp/cloak")
		-- self:AddFlags(FL_NOTARGET)
		self:DrawShadow(false)
		if IsValid(self:GetActiveWeapon()) then
			self:GetActiveWeapon():DrawShadow(false)
			-- self:GetActiveWeapon():SetMaterial("models/cpthazama/avp/cloak")
		end
		self:EmitSound("cpthazama/avp/predator/cloak/prd_cloak.ogg",70)
		for _,x in ents.Iterator() do
			if (x:GetClass() != self:GetClass() && x:GetClass() != "npc_grenade_frag") && x:IsNPC() && self:Visible(x) then
				x:AddEntityRelationship(self,D_NU,99)
				if x.IsVJBaseSNPC == true then
					x.MyEnemy = NULL
					x:SetEnemy(NULL)
					x:ClearEnemyMemory()
				end
				if VJ.HasValue(self.NPCTbl_Combine,x:GetClass()) or VJ.HasValue(self.NPCTbl_Resistance,x:GetClass()) then
					x:VJ_SetSchedule(SCHED_RUN_RANDOM)
					x:SetEnemy(NULL)
					x:ClearEnemyMemory()
				end
			end
		end
	else
		-- self:SetMaterial(" ")
		self:RemoveFlags(FL_NOTARGET)
		self:DrawShadow(true)
		self:EmitSound(self:WaterLevel() >= 2 && "cpthazama/avp/predator/cloak/predator_decloak_water.ogg" or "cpthazama/avp/predator/cloak/prd_uncloak.ogg",70)
		if IsValid(self:GetActiveWeapon()) then
			self:GetActiveWeapon():DrawShadow(true)
			-- self:GetActiveWeapon():SetMaterial(" ")
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local nono = {
	"crossbow",
	"pistol",
	"revolver",
}
--
function ENT:OnDamaged(dmginfo,hitgroup)
	if self:GetCloaked() && CurTime() > self.NextCloakT && math.random(1,4) == 1 then
		self:Camo(false)
		self.NextCloakT = CurTime() +1
	end
	if !self.HasFallen && self:Health() <= self:GetMaxHealth() *0.2 && math.random(1,(hitgroup == HITGROUP_LEFTLEG or hitgroup == HITGROUP_RIGHTLEG) && 1 or 12) == 1 && IsValid(self:GetActiveWeapon()) && !nono[self:GetActiveWeapon():GetHoldType()] then
		self.HasFallen = true
		self:Camo(false)
		self.AnimationTranslations[ACT_IDLE] = ACT_IDLE_HURT
		self.AnimationTranslations[ACT_RANGE_ATTACK1] = ACT_IDLE_SMG1
		self.AnimationTranslations[ACT_IDLE_ANGRY] = ACT_IDLE_STEALTH
		self:DoChangeMovementType(VJ_MOVETYPE_STATIONARY)
		self:SetMaxYawSpeed(1)
		dmginfo:SetDamageForce(vector_origin)
		self:SetLocalVelocity(vector_origin)
		self:PlayAnimation("android_thwa_LooseLeg_to_sit",true,false,false)
		if hitgroup == HITGROUP_LEFTLEG then
			self:SetBodygroup(self:FindBodygroupByName("lleg"),1)
		elseif hitgroup == HITGROUP_RIGHTLEG then
			self:SetBodygroup(self:FindBodygroupByName("rleg"),1)
		end
		self.PoseParameterLooking_Names = {pitch={"pp_sit_pitch"}, yaw={"pp_sit_yaw"}, roll={}}
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnDeath(dmginfo, hitgroup, status)
	if status == "DeathAnim" then
		if self:GetCloaked() then
			self:Camo(false)
		end
	end
	self.BaseClass.OnDeath(self, dmginfo, hitgroup, status)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnCreateDeathCorpse(dmginfo, hitgroup, ent)
	ent.VJ_AVP_IsTech = true
	ent:SetNW2Bool("AVP.IsTech",true)
	ent.OnHeadAte = function(corpse,xeno)
		corpse:SetBodygroup(corpse:FindBodygroupByName("head"),1)
		corpse:SetBodygroup(corpse:FindBodygroupByName("mask"),0)
	end
	local doSplode = true
	if !self.HasFallen && math.random(1,4) == 1 then
		doSplode = false
	end
	local class = self:GetClass()
	local wep = self.StoredWeapon
	local fac = self.VJ_NPC_Class

	if !doSplode then
		undo.ReplaceEntity(self,ent)
	end

	timer.Simple(1.25,function()
		if IsValid(ent) then
			sound.EmitHint(SOUND_DANGER, ent:GetPos(), 250, 3.75, ent)
			ParticleEffectAttach("vj_avp_android_death_charge",PATTACH_ABSORIGIN_FOLLOW,ent,0)
		end
	end)

	timer.Simple(5,function()
		if IsValid(ent) then
			if !doSplode then
				local tr = util.TraceLine({
					start = ent:GetPos(),
					endpos = ent:GetPos() -Vector(0,0,128),
					filter = ent
				})
				local npc = ents.Create(class)
				npc:SetPos(tr.HitPos or ent:GetPos())
				npc:SetAngles(ent:GetAngles())
				npc.VJ_NPC_Class = fac
				npc:Spawn()
				npc:Activate()
				SafeRemoveEntity(npc:GetActiveWeapon())
				undo.ReplaceEntity(ent,npc)
				timer.Simple(0,function()
					if IsValid(npc) then
						ParticleEffectAttach("vj_avp_android_death_charge",PATTACH_ABSORIGIN_FOLLOW,npc,0)
						npc:DoChangeWeapon(wep)
						VJ.STOPSOUND(self.CurrentSpeechSound)
						VJ.STOPSOUND(self.CurrentIdleSound)
						VJ.CreateSound(npc,"cpthazama/avp/humans/vocals/Android_01/head_missing_and01_0" .. math.random(2,4) .. ".ogg",75)
						npc:PlayAnimation("android_thwa_spark_and_sit_up",true,false,false)
						npc.HasFallen = true
						timer.Simple(0.1,function()
							if IsValid(npc) then
								npc.AnimationTranslations[ACT_IDLE] = ACT_IDLE_HURT
								npc.AnimationTranslations[ACT_RANGE_ATTACK1] = ACT_IDLE_SMG1
								npc.AnimationTranslations[ACT_IDLE_ANGRY] = ACT_IDLE_STEALTH
								npc.PoseParameterLooking_Names = {pitch={"pp_sit_pitch"}, yaw={"pp_sit_yaw"}, roll={}}
							end
						end)
						timer.Simple(1,function()
							if IsValid(npc) then
								npc:StopParticles()
							end
						end)
						npc:DoChangeMovementType(VJ_MOVETYPE_STATIONARY)
						npc:SetMaxYawSpeed(1)
					end
				end)
				SafeRemoveEntity(ent)
				return
			end
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