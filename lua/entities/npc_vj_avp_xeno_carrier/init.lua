AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/avp/xeno/carrier.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 500
ENT.VJ_IsHugeMonster = true
ENT.HullType = HULL_LARGE

ENT.VJC_Data = {
    CameraMode = 2,
    ThirdP_Offset = Vector(0, 0, -35),
    FirstP_Bone = "Bip01 Head",
    FirstP_Offset = Vector(20, 0, 0),
    FirstP_ShrinkBone = false
}

ENT.HasBreath = true
ENT.FootStepSoundLevel = 82
ENT.FootStepPitch1 = 75
ENT.FootStepPitch2 = 85

ENT.AttackDamageMultiplier = 1.2
ENT.CanSpit = false
ENT.AlwaysStand = true
ENT.AnimTranslations = {
	[ACT_IDLE] = ACT_HL2MP_IDLE_SMG1,
	-- [ACT_WALK] = ACT_HL2MP_WALK_SMG1,
	-- [ACT_RUN] = ACT_HL2MP_WALK_CROUCH_SMG1,
	[ACT_MP_SPRINT] = ACT_VM_SPRINT_IDLE,
	[ACT_TURN_LEFT] = ACT_ROLL_LEFT,
	[ACT_TURN_RIGHT] = ACT_ROLL_RIGHT,
}
ENT.FaceEnemyMovements = {ACT_HL2MP_WALK_SMG1,ACT_HL2MP_WALK_CROUCH_SMG1,ACT_HL2MP_RUN_SMG1,ACT_VM_SPRINT_IDLE}

ENT.StandingBounds = Vector(16,16,100)
ENT.CrawlingBounds = Vector(16,16,100)
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnInit()
	self.FootData = {
		["lfoot"] = {Range=15.5,OnGround=true},
		["rfoot"] = {Range=15,OnGround=true},
		["lhand"] = {Range=8.5,OnGround=true},
		["rhand"] = {Range=8.5,OnGround=true}
	}
	self.GeneralSoundPitch1 = 115
	self.GeneralSoundPitch2 = 125

	self.Facehuggers = {}
	self.NextFacehuggerAttackT = 0

	self.HitGroups = {
		[HITGROUP_HEAD] = {
			HP = 400,
			Dead = false,
			OnDecap = function(self,dmginfo,hitgroup)
				self:SetBodygroup(self:FindBodygroupByName("head"),1)
				self:SetBodygroup(self:FindBodygroupByName("mouth"),1)
				self:SetHealth(0)
				self:TakeDamage(100,dmginfo:GetAttacker(),dmginfo:GetInflictor())
			end,
		},
		[HITGROUP_LEFTARM] = {
			HP = 250,
			Dead = false,
			OnDecap = function(self,dmginfo,hitgroup)
				self:SetBodygroup(self:FindBodygroupByName("larm"),1)
				self.Gibbed = self.Gibbed or {}
				self.Gibbed.LeftArm = true
				if self.Gibbed.RightArm then
					self:SetHealth(0)
					self:TakeDamage(100,dmginfo:GetAttacker(),dmginfo:GetInflictor())
					self:StopAttacks(true)
					self.CurrentAttackAnimationTime = 0	
					self:StopMoving()
					self:CapabilitiesRemove(CAP_MOVE_JUMP)
				end
			end,
		},
		[HITGROUP_RIGHTARM] = {
			HP = 250,
			Dead = false,
			OnDecap = function(self,dmginfo,hitgroup)
				self:SetBodygroup(self:FindBodygroupByName("rarm"),1)
				self.Gibbed = self.Gibbed or {}
				self.Gibbed.RightArm = true
				if self.Gibbed.LeftArm then
					self:SetHealth(0)
					self:TakeDamage(100,dmginfo:GetAttacker(),dmginfo:GetInflictor())
					self:StopAttacks(true)
					self.CurrentAttackAnimationTime = 0	
					self:StopMoving()
					self:CapabilitiesRemove(CAP_MOVE_JUMP)
				end
			end,
		},
		[HITGROUP_LEFTLEG] = {
			HP = 250,
			Dead = false,
			OnDecap = function(self,dmginfo,hitgroup)
				self:SetBodygroup(self:FindBodygroupByName("lleg"),1)
				self.Gibbed = self.Gibbed or {}
				self.Gibbed.LeftLeg = true
				self:StopAttacks(true)
				self.CurrentAttackAnimationTime = 0	
				self:StopMoving()
				self:CapabilitiesRemove(CAP_MOVE_JUMP)
			end,
		},
		[HITGROUP_RIGHTLEG] = {
			HP = 250,
			Dead = false,
			OnDecap = function(self,dmginfo,hitgroup)
				self:SetBodygroup(self:FindBodygroupByName("rleg"),1)
				self.Gibbed = self.Gibbed or {}
				self.Gibbed.RightLeg = true
				self:StopAttacks(true)
				self.CurrentAttackAnimationTime = 0	
				self:StopMoving()
				self:CapabilitiesRemove(CAP_MOVE_JUMP)
			end,
		},
		[111] = {
			HP = 250,
			Dead = false,
			OnDecap = function(self,dmginfo,hitgroup)
				self:SetBodygroup(self:FindBodygroupByName("tail_end"),1)
				self.Gibbed = self.Gibbed or {}
				self.Gibbed.Tail = true
			end,
		},
		[110] = {
			HP = 250,
			Dead = false,
			OnDecap = function(self,dmginfo,hitgroup)
				self:SetBodygroup(self:FindBodygroupByName("tail"),1)
				self:SetBodygroup(self:FindBodygroupByName("tail_end"),2)
				self.Gibbed = self.Gibbed or {}
				self.Gibbed.Tail = true
			end,
		},
	}
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnStep(pos,name)
	util.ScreenShake(pos,5,100,0.35,500)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Breathe()
	if CurTime() > (self.NextBreathT or 0) then
		local snd = "cpthazama/avp/xeno/alien queen/alien_queen_breathe_in_0" .. math.random(1,3) .. ".ogg"
		local sndB = "cpthazama/avp/xeno/alien queen/alien_queen_breathe_out_0" .. math.random(1,3) .. ".ogg"
		VJ_CreateSound(self,snd,65,125)
		timer.Simple(1,function()
			if IsValid(self) then
				VJ_CreateSound(self,sndB,65,125)
			end
		end)
		self.NextBreathT = CurTime() +2.3
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SelectIdleActivity(act)
	local gib = self.Gibbed
	if gib && (gib.LeftLeg or gib.RightLeg or gib.LeftArm or gib.RightArm) then
		return (gib.LeftArm && ACT_WALK_CROUCH or gib.RightArm && ACT_WALK_CROUCH_AIM) or ACT_RUN_CROUCH
	end
	return ACT_IDLE
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnCustomAttack(cont,ent,visible,dist)
	if IsValid(ent) && visible && dist <= 500 then
		local count = self:GetFacehuggerCount()
		if count >= 0 && CurTime() > self.NextFacehuggerAttackT && ((ent:IsNPC() or (ent:IsNextBot() && ent.IsLambdaPlayer) or ent:IsPlayer()) && !ent.VJ_AVP_IsFacehugged && !ent.VJ_AVP_IsTech && (ent:IsNPC() && (ent:GetHullType() == HULL_HUMAN or ent:GetHullType() == HULL_WIDE_HUMAN) or !ent:IsNPC())) then
			self.NextFacehuggerAttackT = CurTime() +math.Rand(3,6)
			if self.Facehuggers[count] then
				self.Facehuggers[count]:AttachToCarrier(self,true,ent)
			end
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:WhenKilled(dmginfo, hitgroup)
	for _,v in pairs(self.Facehuggers) do
		if IsValid(v) then
			v:AttachToCarrier(self,true)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GetFacehuggerCount()
	local count = 0
	for _,v in pairs(self.Facehuggers) do
		if IsValid(v) then
			count = count +1
		end
	end
	return count
end