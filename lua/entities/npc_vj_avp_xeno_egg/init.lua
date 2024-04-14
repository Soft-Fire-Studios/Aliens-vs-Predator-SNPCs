AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2024 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/avp/xeno/egg.mdl"}
ENT.StartHealth = 45
ENT.SightDistance = 250
ENT.SightAngle = 180
ENT.MovementType = VJ_MOVETYPE_STATIONARY
ENT.CanTurnWhileStationary = false

ENT.BloodColor = "Yellow"
ENT.CustomBlood_Particle = {"vj_avp_blood_xeno"}
ENT.CustomBlood_Decal = {"VJ_AVP_BloodXenomorph"}
ENT.HasBloodPool = false
ENT.VJ_NPC_Class = {"CLASS_XENOMORPH"}

ENT.HasMeleeAttack = false
ENT.CallForHelp = false

ENT.HasDeathRagdoll = true
ENT.DeathCorpseEntityClass = "prop_vj_animatable"
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.Opened = false

	self:SetAngles(Angle(0,math.random(0,360),0))
	self:AddFlags(FL_NOTARGET)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:TranslateActivity(act)
	if act == ACT_IDLE && self.Opened then
		return ACT_IDLE_ANGRY
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Open()
	self:VJ_ACT_PLAYACTIVITY(ACT_ARM,true,false,false)
	VJ.EmitSound(self,"cpthazama/avp/xeno/egg/egg_open_0" .. math.random(1,3) .. ".ogg",75)
	timer.Simple(0.5,function()
		if IsValid(self) then
			local facehugger = ents.Create("npc_vj_avp_xeno_facehugger")
			facehugger:SetPos(self:GetPos())
			facehugger:SetAngles(self:GetAngles())
			facehugger:SetOwner(self)
			facehugger:Spawn()
			facehugger:Activate()
			facehugger:SetNoDraw(true)
			facehugger:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK)
			timer.Simple(0.15,function()
				if IsValid(facehugger) then
					facehugger:SetNoDraw(false)
				end
			end)
			facehugger:VJ_ACT_PLAYACTIVITY(ACT_ARM,true,false,false,0,{OnFinish=function(i,anim)
				if i then return end
				facehugger:SetPos(facehugger:GetBonePosition(2))
				facehugger:SetState()
			end})
		end
	end)
	self.Opened = true
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAlert(ent)
	if !self.Opened then
		self:Open()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo, hitgroup)
	local dmgInflictor = dmginfo:GetInflictor()
	local dmgAttacker = dmginfo:GetAttacker()
	local isFireDmg = self:IsOnFire() && IsValid(dmgInflictor) && IsValid(dmgAttacker) && dmgInflictor:GetClass() == "entityflame" && dmgAttacker:GetClass() == "entityflame"
	if isFireDmg then
		dmginfo:ScaleDamage(2)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_OnBleed(dmginfo,hitgroup)
	self:Acid(dmginfo:GetDamagePosition())
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnMaintainRelationships(ent, entFri, entDist)
	if entFri && ent.VJ_AVP_XenomorphCarrier && !self.Opened && entDist <= 400 && ent:GetFacehuggerCount() < 9 then
		self:Open()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnKilled()
	self:Acid(self:GetPos(),150,20)
	self:SetBodygroup(1,1)
	VJ.EmitSound(self,"cpthazama/avp/xeno/alien/blood/alien_blood_10s_0" .. math.random(1,4) .. ".ogg",75)

	local particle = ents.Create("info_particle_system")
	particle:SetKeyValue("effect_name", "vj_avp_xeno_spit_impact")
	particle:SetPos(self:GetPos())
	particle:Spawn()
	particle:Activate()
	particle:Fire("Start")
	particle:Fire("Kill", "", 0.1)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo, hitgroup, corpseEnt)
	corpseEnt:SetPos(self:GetPos() +self:GetUp() *-4)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
	if IsValid(self.Queen) then
		for _,v in ipairs(self.Queen.Eggs) do
			if IsValid(v) then
				if v == self then
					table.remove(self.Queen.Eggs,_)
				end
			end
		end
	end
end