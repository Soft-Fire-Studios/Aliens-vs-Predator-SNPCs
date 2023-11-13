AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/avp/predators/youngblood.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 450
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.BloodColor = "Green" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.CustomBlood_Particle = {"vj_avp_blood_predator"}
ENT.VJ_NPC_Class = {"CLASS_PREDATOR"} -- NPCs with the same class with be allied to each other

ENT.HasMeleeAttack = false

ENT.PoseParameterLooking_InvertYaw = true
ENT.PoseParameterLooking_InvertPitch = true
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
ENT.DisableFootStepSoundTimer = true -- If set to true, it will disable the time system for the footstep sound code, allowing you to use other ways like model events

ENT.VJC_Data = {
    CameraMode = 2, -- Sets the default camera mode | 1 = Third Person, 2 = First Person
    ThirdP_Offset = Vector(0, 0, -35), -- The offset for the controller when the camera is in third person
    FirstP_Bone = "Bip01 Head", -- If left empty, the base will attempt to calculate a position for first person
    FirstP_Offset = Vector(15, 0, 2), -- The offset for the controller when the camera is in first person
}

ENT.GeneralSoundPitch1 = 100

ENT.SoundTbl_FootStep = {
	"player/footsteps/gravel1.wav",
	"player/footsteps/gravel2.wav",
	"player/footsteps/gravel3.wav",
	"player/footsteps/gravel4.wav",
}
ENT.SoundTbl_Idle = {
	"cpthazama/avp/predator/vocals/prd_clicks_01.ogg",
	"cpthazama/avp/predator/vocals/prd_clicks_02.ogg",
	"cpthazama/avp/predator/vocals/prd_clicks_03.ogg",
	"cpthazama/avp/predator/vocals/prd_clicks_04.ogg",
	"cpthazama/avp/predator/vocals/prd_clicks_05.ogg",
	"cpthazama/avp/predator/vocals/prd_clicks_06.ogg",
	"cpthazama/avp/predator/vocals/prd_clicks_07.ogg",
	"cpthazama/avp/predator/vocals/prd_clicks_08.ogg",
	"cpthazama/avp/predator/vocals/prd_clicks_09.ogg",
	"cpthazama/avp/predator/vocals/prd_clicks_10.ogg",
}
ENT.SoundTbl_Laugh = {
	"cpthazama/avp/predator/vocals/pred_laugh_taunt_ako.ogg",
	"cpthazama/avp/predator/vocals/pred_laugh_taunt_bill.ogg",
	"cpthazama/avp/predator/vocals/pred_laugh_taunt_glenn.ogg"
}
ENT.SoundTbl_Distract = {
	"cpthazama/avp/humans/vocals/Pred_Distract/PRED_DISTRACT_01.ogg",
	"cpthazama/avp/humans/vocals/Pred_Distract/PRED_DISTRACT_02.ogg",
	"cpthazama/avp/humans/vocals/Pred_Distract/PRED_DISTRACT_03.ogg",
	"cpthazama/avp/humans/vocals/Pred_Distract/PRED_DISTRACT_04.ogg",
	"cpthazama/avp/predator/distraction/pred_distraction_01.ogg",
	"cpthazama/avp/predator/distraction/pred_distraction_02.ogg",
	"cpthazama/avp/predator/distraction/pred_distraction_03.ogg",
	"cpthazama/avp/predator/distraction/pred_distraction_04.ogg",
	"cpthazama/avp/predator/distraction/pred_distraction_05.ogg"
}
ENT.SoundTbl_Jump = {
	"cpthazama/avp/predator/vocals/prd_grunt_jump_01.ogg",
	"cpthazama/avp/predator/vocals/prd_grunt_jump_02.ogg",
}
ENT.SoundTbl_Land = {
	"cpthazama/avp/predator/vocals/prd_grunt_jump_land_01.ogg",
	"cpthazama/avp/predator/vocals/prd_grunt_jump_land_02.ogg",
	"cpthazama/avp/predator/vocals/prd_grunt_jump_land_03.ogg",
	"cpthazama/avp/predator/vocals/prd_grunt_jump_land_04.ogg",
	"cpthazama/avp/predator/vocals/prd_grunt_jump_land_05.ogg",
	"cpthazama/avp/predator/vocals/prd_grunt_jump_land_06.ogg",
	"cpthazama/avp/predator/vocals/prd_grunt_jump_land_07.ogg",
	"cpthazama/avp/predator/vocals/prd_grunt_jump_land_08.ogg",
	"cpthazama/avp/predator/vocals/prd_grunt_jump_land_09.ogg",
	"cpthazama/avp/predator/vocals/prd_grunt_jump_land_10.ogg",
}
ENT.SoundTbl_Attack = {
	"cpthazama/avp/predator/vocals/prd_trophy_growl_01.ogg",
	"cpthazama/avp/predator/vocals/prd_trophy_growl_02.ogg",
}
ENT.SoundTbl_Pain = {
	"cpthazama/avp/predator/vocals/prd_hurt_scream_01.ogg",
	"cpthazama/avp/predator/vocals/prd_hurt_scream_02.ogg",
	"cpthazama/avp/predator/vocals/prd_hurt_scream_03.ogg",
	"cpthazama/avp/predator/vocals/prd_hurt_scream_04.ogg",
	"cpthazama/avp/predator/vocals/prd_hurt_scream_05.ogg",
	"cpthazama/avp/predator/vocals/prd_hurt_scream_06.ogg",
	"cpthazama/avp/predator/vocals/prd_hurt_scream_07.ogg",
	"cpthazama/avp/predator/vocals/prd_hurt_scream_08.ogg",
	"cpthazama/avp/predator/vocals/prd_hurt_scream_09.ogg",
	"cpthazama/avp/predator/vocals/prd_hurt_scream_10.ogg",
	"cpthazama/avp/predator/vocals/prd_hurt_medium_01.ogg",
	"cpthazama/avp/predator/vocals/prd_hurt_medium_02.ogg",
	"cpthazama/avp/predator/vocals/prd_hurt_medium_03.ogg",
	"cpthazama/avp/predator/vocals/prd_hurt_medium_04.ogg",
	"cpthazama/avp/predator/vocals/prd_hurt_medium_05.ogg",
	"cpthazama/avp/predator/vocals/prd_hurt_medium_06.ogg",
	"cpthazama/avp/predator/vocals/prd_hurt_medium_07.ogg",
	"cpthazama/avp/predator/vocals/prd_hurt_medium_08.ogg",
	"cpthazama/avp/predator/vocals/prd_hurt_medium_09.ogg",
	"cpthazama/avp/predator/vocals/prd_hurt_medium_10.ogg",
}
ENT.SoundTbl_Death = {
	"cpthazama/avp/predator/vocals/prd_death_scream_01.ogg",
	"cpthazama/avp/predator/vocals/prd_death_scream_02.ogg",
}

util.AddNetworkString("VJ_AVP_Predator_Client")

ENT.AttackAnimations = {
	{
		"predator_claws_attack_[SIDE]_punch_into",
		"predator_claws_attack_[SIDE]_punch_hit",
		"predator_claws_attack_[SIDE]_punch_close",
	}
}
ENT.CanAttack = true
ENT.AttackDistance = 70
ENT.AttackDamage = 35
ENT.AttackDamageDistance = 110
ENT.AttackDamageType = 24
ENT.AttackDamageType = DMG_SLASH
---------------------------------------------------------------------------------------------------------------------------------------------
local toSeq = VJ.SequenceToActivity
--
function ENT:CustomOnChangeActivity(newAct)
	if newAct == ACT_SPRINT then
		VJ.EmitSound(self,"cpthazama/avp/predator/adrenalin/adrenalin_turn_on_0" .. math.random(1,5) .. ".ogg",70)
	end
	self.LongJumping = false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Controller_Initialize(ply,controlEnt)
    net.Start("VJ_AVP_Predator_Client")
		net.WriteBool(false)
		net.WriteEntity(self)
		net.WriteEntity(ply)
    net.Send(ply)

	controlEnt.VJC_Player_DrawHUD = false

	function controlEnt:CustomOnThink()
		self.VJC_NPC_CanTurn = self.VJC_Camera_Mode == 2
		self.VJC_BullseyeTracking = self.VJC_Camera_Mode == 2
	end

	function controlEnt:CustomOnStopControlling()
		net.Start("VJ_AVP_Predator_Client")
			net.WriteBool(true)
			net.WriteEntity(self)
			net.WriteEntity(ply)
		net.Send(ply)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetVisionMode(0)
	self:SetBodygroup(self:FindBodygroupByName("mask"),1)
	self.NextFindStalkPos = 0
	self.NextCloakT = CurTime() +1.5
	self.SprintT = 0
	self.NextSprintT = 0

	hook.Add("PlayerButtonDown", self, function(self, ply, button)
		if ply.VJTag_IsControllingNPC == true && IsValid(ply.VJ_TheControllerEntity) then
			local cent = ply.VJ_TheControllerEntity
            if cent.VJCE_NPC == self then
                cent.VJCE_NPC:OnKeyPressed(ply,button)
            end
        end
    end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnKeyPressed(ply,key)
    if key == KEY_E then
		local tr = util.TraceLine({
			start = self:EyePos(),
			endpos = self:EyePos() +ply:GetAimVector() *125,
			filter = {self,ply}
		})
		local ent = tr.Entity
		if tr.Hit && IsValid(ent) then
			ent:Fire("Use",nil,0,ply,self)
		else
			self.DistractT = self.DistractT or 0
			if CurTime() < self.DistractT then return end
			local tr = util.TraceHull({
				start = self:EyePos(),
				endpos = self:EyePos() +ply:GetAimVector() *6000,
				filter = {self,ply,self.VJ_TheControllerBullseye},
				mins = Vector(-10,-10,-10),
				maxs = Vector(10,10,10)
			})
			if tr.Hit && IsValid(tr.Entity) then
				local ent = tr.Entity
				self:DistractionCode(ent)
			end
		end
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomAttack(ent,vis)
	local cont = self.VJ_TheController
	local dist = self.NearestPointToEnemyDistance
	if IsValid(cont) then
		if cont:KeyDown(IN_ATTACK) && !self:IsBusy() then
			if cont:KeyDown(IN_SPEED) then
				self:LongJumpCode(nil,true)
			else
				self:AttackCode()
			end
		elseif !cont:KeyDown(IN_ATTACK) && cont:KeyDown(IN_SPEED) && cont:KeyDown(IN_JUMP) && !self:IsBusy() then
			self:LongJumpCode()
		elseif !cont:KeyDown(IN_ATTACK) && !cont:KeyDown(IN_ATTACK2) && !cont:KeyDown(IN_JUMP) && !cont:KeyDown(IN_SPEED) && cont:KeyDown(IN_DUCK) && !self:IsBusy() then
			self:SpecialAttackCode(self.CurrentEquipment)
		end
	else
		if dist <= self.AttackDistance && !self:IsBusy() && vis then
			self:AttackCode()
		elseif vis && self.DisableChasingEnemy && self:GetCloaked() && math.random(1,100) == 1 then
			self:DistractionCode(ent)
		elseif vis && dist > 200 && dist <= 2500 && !self:IsBusy() && math.random(1,self.DisableChasingEnemy && 100 or 45) == 1 then
			self:SpecialAttackCode(1)
		end
		local pos = ent:GetPos()
		local heightDif = math.abs(pos.z -self:GetPos().z)
		if !self:IsBusy() && !self.DisableChasingEnemy && vis then
			if dist < 250 && dist > 150 && math.random(1,12) == 1 then
				self:LongJumpCode(pos,true)
			elseif (dist > 600 or heightDif > 350) && dist <= 1500 then
				local vecRand = VectorRand() *100
				vecRand.z = 0
				self:LongJumpCode(pos +vecRand)
				-- self:LongJumpCode(pos)
			end
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SpecialAttackCode(atk)
	local atk = atk or 1
	if atk == 1 then
		self:SetBeam(true)
		self.PoseParameterLooking_Names = {pitch={"plasma_pitch"}, yaw={"plasma_yaw"}, roll={}}
		ParticleEffectAttach("vj_avp_predator_plasma_charge",PATTACH_POINT_FOLLOW,self,1)
		VJ.EmitSound(self,"cpthazama/avp/weapons/predator/plasma_caster/plasma_caster_charge_05.ogg",80)
		self:VJ_ACT_PLAYACTIVITY("vjges_predator_plasma_caster_extend",true,false,true,0,{AlwaysUseGesture=true,OnFinish=function(interrupted)
			if interrupted then self:SetBeam(false) self.PoseParameterLooking_Names = {pitch={}, yaw={}, roll={}} return end

			local ent = self:GetLockOn()
			if IsValid(ent) then
				local att = self:GetAttachment(self:LookupAttachment("plasma"))
				local targetPos = ent:GetPos() +ent:OBBCenter()
				local targetAng = (targetPos -att.Pos):Angle()
				local ang = self:GetAngles()
				targetAng.y = math.Clamp(targetAng.y, ang.y - 70, ang.y + 70)
				local proj = ents.Create("obj_vj_avp_projectile")
				proj:SetPos(att.Pos)
				proj:SetAngles(targetAng)
				proj:SetOwner(self)
				proj:SetAttackType(2,150,DMG_BLAST,300,45,true)
				proj:SetNoDraw(true)
				proj:Spawn()
				-- proj.SoundTbl_Idle = {"weapons/rpg/rocket1.wav"}
				proj.DecalTbl_DeathDecals = {"Scorch"}
				proj.OnDeath = function(projEnt,data, defAng, HitPos)
					ParticleEffect("vj_avp_predator_plasma_impact",HitPos,defAng)
					sound.Play("cpthazama/avp/weapons/predator/plasma_caster/plasma_bolt_explosion_0" .. math.random(1,5) .. ".ogg",HitPos,90)
				end
				-- proj:AddSound("cpthazama/resistance2/chimera/titan/cha_titan_projectilefireloop_jcm.wav",80)
				ParticleEffectAttach("vj_avp_predator_plasma_proj",PATTACH_POINT_FOLLOW,proj,0)

				local phys = proj:GetPhysicsObject()
				if IsValid(phys) then
					phys:SetVelocity(proj:GetForward() *2000)
				end

				VJ.EmitSound(self,"cpthazama/avp/weapons/predator/plasma_caster/plasma_caster_shot_0" .. math.random(1,3) .. ".ogg",80)
			end
			self:SetPoseParameter("plasma_pitch",0)
			self:SetPoseParameter("plasma_yaw",0)
			self.PoseParameterLooking_Names = {pitch={}, yaw={}, roll={}}
			self:VJ_ACT_PLAYACTIVITY("vjges_predator_plasma_caster_retract",true,false,false,0,{AlwaysUseGesture=true,OnFinish=function(interrupted)
				self:SetBeam(false)
			end})
			self.NextChaseTime = 0
		end})
		self.NextChaseTime = 0
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local string_Replace = string.Replace
--
function ENT:AttackCode()
	if !self.CanAttack then return end
	self.AttackSide = self.AttackSide == "right" && "left" or "right"
	local anim = VJ.PICK(self.AttackAnimations)
	if anim then
		anim[1] = string_Replace(anim[1],"[SIDE]",self.AttackSide)
		anim[2] = string_Replace(anim[2],"[SIDE]",self.AttackSide)
		anim[3] = string_Replace(anim[3],"[SIDE]",self.AttackSide)
		self:PlaySound(self.SoundTbl_Attack,78)
		self:VJ_ACT_PLAYACTIVITY(anim[1],true,false,false,0,{AlwaysUseGesture=true,OnFinish=function(interrupted)
			if interrupted then return end
			local hitEnts = self:RunDamageCode()
			if #hitEnts > 0 then
				self:VJ_ACT_PLAYACTIVITY(anim[2],true,false,false,0,{AlwaysUseGesture=true})
				self.NextChaseTime = 0
				self:OnHit(hitEnts)
			else
				self:VJ_ACT_PLAYACTIVITY(anim[3],true,false,false,0,{AlwaysUseGesture=true})
				self.NextChaseTime = 0
			end
		end})
		self.NextChaseTime = 0
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RunDamageCode(mult)
	local mult = mult or 1
	local hitEnts = VJ.AVP_ApplyRadiusDamage(self,self,self:GetPos() +self:OBBCenter(),self.AttackDamageDistance or 120,(self.AttackDamage or 10) *mult,self.AttackDamageType or DMG_SLASH,true,false,{UseConeDegree=self.MeleeAttackDamageAngleRadius},
	function(ent)
		return ent:IsNPC() or ent:IsPlayer() or ent:IsNextBot() or VJ.IsProp(ent)
	end)
	return hitEnts
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnHit(hitEnts)
	if self:GetCloaked() then
		self:Camo(false)
		self.NextCloakT = CurTime() +2
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
/*
	predator_claws_jump_drop_down -- Down
	predator_claws_jump_gain_height -- Up
	predator_claws_jump_long -- Far
	predator_claws_jump_medium -- Medium distance
	predator_claws_jump_shallow -- Somewhat close
	predator_claws_jump_short -- Up close
*/
--
function ENT:LongJumpCode(gotoPos,atk)
	local ply = self.VJ_TheController
	local bullseye = self.VJ_TheControllerBullseye
	local aimVec = IsValid(ply) && ply:GetAimVector()
	local tr1
	local canJump = true
	if gotoPos then
		tr1 = util.TraceLine({
			start = self:EyePos(),
			endpos = gotoPos +Vector(0,0,self:OBBMaxs().z),
			filter = {self,ply,bullseye}
		})
		canJump = self:VisibleVec(gotoPos)
	else
		tr1 = util.TraceLine({
			start = self:EyePos(),
			endpos = self:EyePos() +(IsValid(ply) && aimVec *(atk && 800 or 2000) or self:GetForward() *800),
			filter = {self,ply,bullseye}
		})
	end
	if !canJump then return end
	local firstHit = tr1.HitPos
	-- VJ.DEBUG_TempEnt(firstHit, self:GetAngles(), Color(255,0,0), 5)
	local upCheck1 = util.TraceLine({
		start = firstHit,
		endpos = firstHit +self:GetUp() *600,
		filter = {self,ply,bullseye}
	})
	local trSt
	if upCheck1 then
		local pos = upCheck1.HitPos +(upCheck1.HitPos -self:GetPos()):GetNormalized() *64
		-- VJ.DEBUG_TempEnt(pos, self:GetAngles(), Color(255,242,0), 5)
		trSt = util.TraceLine({
			start = pos,
			endpos = pos +self:GetUp() *-2000,
			filter = {self,ply,bullseye}
		})
		-- VJ.DEBUG_TempEnt(trSt.HitPos, self:GetAngles(), Color(255,0,212), 5)
	else
		trSt = util.TraceLine({
			start = firstHit,
			endpos = firstHit +self:GetUp() *-2000,
			filter = {self,ply,bullseye}
		})
		-- VJ.DEBUG_TempEnt(trSt.HitPos, self:GetAngles(), Color(17,255,0), 5)
	end
	local startPos = trSt.HitPos +trSt.HitNormal *4
	-- VJ.DEBUG_TempEnt(startPos, self:GetAngles(), Color(13,0,255), 5)
	self.LongJumpPos = trSt.HitPos
	self.LongJumpAttacking = atk
	local anim
	local dist = self:GetPos():Distance(self.LongJumpPos)
	local height = self:GetPos().z -self.LongJumpPos.z
	if height < -150 then
		anim = "predator_claws_jump_gain_height"
	elseif height > 150 then
		anim = "predator_claws_jump_drop_down"
	else
		if dist > 1500 then
			anim = atk && {"predator_claws_attack_left_lower_slash_long"} or "predator_claws_jump_long"
		elseif dist > 1200 then
			anim = atk && {"predator_claws_attack_left_lower_slash_medium"} or "predator_claws_jump_medium"
		elseif dist > 800 then
			anim = atk && {"predator_claws_attack_left_lower_slash_medium"} or "predator_claws_jump_shallow"
		else
			anim = atk && {"predator_claws_attack_left_lower_slash_medium"} or "predator_claws_jump_short"
		end
	end
	self:FaceCertainPosition(self.LongJumpPos,1)
	self:VJ_ACT_PLAYACTIVITY(anim,true,false,false)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DistractionCode(ent)
	self:StopAllCommonSpeechSounds()
	if math.random(1,4) == 1 then
		VJ.CreateSound(self,self.SoundTbl_Laugh,90)
		self.DistractT = CurTime() +5
	else
		local soundPos = ent:GetPos() +VectorRand() *600
		local soundF = VJ_PICK(self.SoundTbl_Distract)
		self.DistractT = CurTime() +SoundDuration(soundF) +5
		sound.Play(soundF,soundPos,72)
		VJ.EmitSound(self,soundF,65)
		if ent:IsNPC() then
			if ent.IsVJBaseSNPC && !ent:IsBusy() && !ent.Alerted then
				ent:SetLastPosition(soundPos)
				ent:VJ_TASK_GOTO_LASTPOS("TASK_WALK_PATH",function(x) x.CanShootWhenMoving = true end)
				if ent.OnHearDistraction then
					ent:OnHearDistraction(self,soundPos)
				else
					ent:CustomOnInvestigate(v)
					ent:PlaySoundSystem(#ent.SoundTbl_Investigate > 0 && "InvestigateSound" or "Alert")
				end
			elseif !ent.IsVJBaseSNPC then
				ent:SetLastPosition(soundPos)
				ent:SetSchedule(SCHED_FORCED_GO)
			end
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomBeforeApplyRelationship(v)
	local sprinting = self:GetSprinting()
	local calcMult = ((self:IsMoving() && 1 or 0.15) *(sprinting && 3 or 1))
	if v.VJ_AVP_Xenomorph or (v.VJ_AVP_Predator && v:GetVisionMode() == 1) or v:Visible(self) && v:GetPos():Distance(self:GetPos()) <= (400 *calcMult) then
		self:AddEntityRelationship(v, D_NU, 10)
		return false
	end
	if v:GetPos():Distance(self:GetPos()) > (600 *calcMult) then
		if v:HasEnemyMemory(self) then
			v:ClearEnemyMemory(self)
			v:MarkEnemyAsEluded(self)
			v:UpdateEnemyMemory(self,self:GetPos() +VectorRand() *500)
		end
		if v:GetEnemy() == self then
			v:SetEnemy(nil)
		end
		self:AddEntityRelationship(v, D_NU, 10)
		return false
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == "jump_start" then
		self:SetJumpPosition(self.LongJumpPos)
		self.LongJumping = true
		VJ.CreateSound(self,self.SoundTbl_Jump,75)
		VJ.EmitSound(self,"cpthazama/avp/predator/jump/prd_jump_force_3rdp_0" .. math.random(1,5) .. ".ogg",70)
	elseif key == "jump_end" then
		self.LongJumping = false
		self:SetJumpPosition(Vector(0,0,0))
		self:SetLocalVelocity(Vector(0,0,0))
		self:SetVelocity(self:GetForward() *150 +Vector(0,0,-100))
		VJ.CreateSound(self,self.SoundTbl_Land,75)
		VJ.EmitSound(self,VJ_PICK({"cpthazama/avp/predator/jump/pred_heavy_land_01.ogg","cpthazama/avp/predator/jump/pred_heavy_land_02.ogg","cpthazama/avp/predator/jump/pred_heavy_land_03.ogg"}),75)
		local tr = util.TraceLine({
			start = self:GetPos(),
			endpos = self:GetPos() +self:GetUp() *-100,
			filter = {self},
			mask = MASK_SOLID_BRUSHONLY
		})
		if tr.Hit then
			local fx = EffectData()
			fx:SetOrigin(tr.HitPos)
			fx:SetScale(2)
			fx:SetMagnitude(2)
			fx:SetNormal(self:GetUp())
			util.Effect("ElectricSpark",fx)
			for i = 1,16 do
				util.Effect("GlassImpact",fx)
			end
		end
	elseif key == "attack" then
		self:RunDamageCode()
	elseif key == "attack_heavy" then
		self:RunDamageCode(1.75)
	elseif key == "attack_jump" then
		self:RunDamageCode(1.25)
	elseif key == "attack_jump_heavy" then
		self:RunDamageCode(2)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SelectMovementActivity(dist)
	local act = ACT_WALK
	local ply = self.VJ_TheController
	if IsValid(ply) then
		if ply:KeyDown(IN_WALK) then
			act = ACT_WALK
		elseif ply:KeyDown(IN_SPEED) && self.NextSprintT < CurTime() then
			act = ACT_SPRINT
		else
			act = ACT_RUN
		end
		return act
	end
	local currentSchedule = self.CurrentSchedule
	if currentSchedule != nil then
		if currentSchedule.MoveType == 0 then
			act = ACT_WALK
		else
			if dist && dist > self.AttackDistance *3 && self.NextSprintT < CurTime() then
				act = ACT_SPRINT
			else
				act = ACT_RUN
			end
		end
	end
	return act
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SelectIdleActivity(dist)
	local act = ACT_IDLE
	if self.Alerted then
		act = toSeq(self,"predator_claws_ai_idle")
	end
	return act
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	local curTime = CurTime()
	local dist = self.NearestPointToEnemyDistance
	local idleAct = self:SelectIdleActivity(dist)
	local moveAct = self:SelectMovementActivity(dist)
	local ply = self.VJ_TheController
	if self.LastIdleActivity != idleAct then
		self.LastIdleActivity = idleAct
		self:SetIdleAnimation({idleAct})
		self:SetArrivalActivity(idleAct)
	end
	if self.LastMovementActivity != moveAct then
		self.LastMovementActivity = moveAct
		self.AnimTbl_Walk = {moveAct}
		self.AnimTbl_Run = {moveAct}
	end

	self:SetSprinting(self:IsMoving() && self:GetActivity() == ACT_SPRINT)
	if IsValid(ply) && self:GetBeam() == true then
		local closeDist = 999999
		local closeEnt
		for _,v in pairs(ents.FindInSphere(self.VJ_TheControllerBullseye:GetPos(),300)) do
			if (v:IsNPC() or v:IsNextBot()) && v:GetClass() != "obj_vj_bullseye" && self:CheckRelationship(v) != D_LI && self:GetPos():Distance(v:GetPos()) < closeDist then
				closeEnt = v
			end
		end
		if IsValid(closeEnt) then
			self:SetLockOn(closeEnt)
		else
			self:SetLockOn(self:GetEnemy())
		end
	else
		self:SetLockOn(self:GetEnemy())
	end

	local sprinting = self:GetSprinting()
	self.CanAttack = !sprinting
	if sprinting then
		self.SprintT = self.SprintT +0.1
		if self.SprintT >= 4 then
			self.NextSprintT = curTime +3
		end
	else
		if self.SprintT > 0 then
			self.SprintT = self.SprintT -0.2
		end
	end

	if self.LongJumping && self.LongJumpPos then
		local currentPos = self:GetPos()
		if self.LongJumpAttacking then
			local targetPos = self.LongJumpPos +self:GetUp() *20
			local moveDirection = (targetPos -currentPos):GetNormalized()
			local moveSpeed = 600
			local newPos = currentPos +moveDirection *moveSpeed *FrameTime()
			self:SetLocalVelocity(moveDirection *moveSpeed)
		else
			local dist = currentPos:Distance(self.LongJumpPos)
			local targetPos = self.LongJumpPos +(dist < 250 && self:OBBCenter() or self:OBBCenter() *3)
			local moveDirection = (targetPos -currentPos):GetNormalized()
			local moveSpeed = (dist < 250 && 430 or dist *2)
			local newPos = currentPos +moveDirection *moveSpeed *FrameTime()
			self:SetLocalVelocity(moveDirection *moveSpeed)
		end
	end

	if self:GetCloaked() then
		if self:WaterLevel() >= 2 then
			self:Camo(false)
			self.NextCloakT = curTime +2
		end
		for _,v in pairs(select(2,ents.Iterator())) do
			if (v:IsNPC() or v:IsNextBot()) && v:GetClass() != "obj_vj_bullseye" && self:CheckRelationship(v) != D_LI then
				local calcMult = ((self:IsMoving() && 1 or 0.15) *(sprinting && 3 or 1))
				if v.VJ_AVP_Xenomorph or (v.VJ_AVP_Predator && v:GetVisionMode() == 1) or v:Visible(self) && v:GetPos():Distance(self:GetPos()) <= (400 *calcMult) then
					continue
				end
				if v:GetPos():Distance(self:GetPos()) > (600 *calcMult) then
					if v:IsNPC() then
						v:ClearEnemyMemory(self)
						v:MarkEnemyAsEluded(self)
						v:UpdateEnemyMemory(self,self:GetPos() +VectorRand() *500)
					end
					if v.GetEnemy && v:GetEnemy() == self then
						v:SetEnemy(nil)
					end
				end
			end
		end
	end

	if IsValid(ply) then
		if ply:KeyDown(IN_RELOAD) && curTime > self.NextCloakT then
			self:Camo(!self:GetCloaked())
			self.NextCloakT = curTime +1
		end
	else
		local enemy = self:GetEnemy()
		if IsValid(enemy) then
			if !self:GetCloaked() && curTime > self.NextCloakT && dist > self.AttackDistance *3 then
				self:Camo(!self:GetCloaked())
				self.NextCloakT = curTime +1
			end
			if enemy.VJ_AVP_Xenomorph then
				self:SetVisionMode(2)
				self.DisableChasingEnemy = false
			else
				if enemy.VJ_AVP_IsTech then
					self:SetVisionMode(3)
				else
					self:SetVisionMode(1)
				end
				if (enemy:IsPlayer() or enemy:IsNPC() && enemy:Disposition(self) != D_HT) && dist > 1000 && !self:IsBusy() then
					self.DisableChasingEnemy = true
					if curTime > self.NextFindStalkPos then
						local vis = self:Visible(enemy)
						local vsched = vj_ai_schedule.New("vj_goto_lastpos")
						if vis then
							vsched:EngTask("TASK_GET_PATH_TO_RANDOM_NODE", 1000)
						else
							vsched:EngTask("TASK_GET_PATH_TO_ENEMY_LOS", 0)
						end
						vsched:EngTask("TASK_WAIT_FOR_MOVEMENT", 0)
						vsched.IsMovingTask = true
						if vis then
							self:SetMovementActivity(VJ.PICK(self.AnimTbl_Walk))
							vsched.MoveType = 0
						else
							self:SetMovementActivity(VJ.PICK(self.AnimTbl_Run))
							vsched.MoveType = 1
						end
						vsched.ConstantlyFaceEnemyVisible = true
						self:StartSchedule(vsched)
						self.NextFindStalkPos = curTime +math.Rand(5,20)
					end
					local goalPos = self:GetGoalPos()
					local heightDif = math.abs(goalPos.z -self:GetPos().z)
					if (heightDif > 200 or self:GetPos():Distance(goalPos) > 700) && self:VisibleVec(goalPos +self:GetUp() *16) && self:GetCloaked() then
						self:LongJumpCode(goalPos)
					end
				else
					self.DisableChasingEnemy = false
				end
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
			self:GetActiveWeapon():SetMaterial("models/cpthazama/avp/cloak")
		end
		self:EmitSound("cpthazama/avp/predator/cloak/prd_cloak.ogg",70)
		for _, x in ipairs(ents.GetAll()) do
			if (x:GetClass() != self:GetClass() && x:GetClass() != "npc_grenade_frag") && x:IsNPC() && self:Visible(x) then
				x:AddEntityRelationship(self,D_NU,99)
				if x.IsVJBaseSNPC == true then
					x.MyEnemy = NULL
					x:SetEnemy(NULL)
					x:ClearEnemyMemory()
				end
				if VJ_HasValue(self.NPCTbl_Combine,x:GetClass()) or VJ_HasValue(self.NPCTbl_Resistance,x:GetClass()) then
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
			self:GetActiveWeapon():SetMaterial(" ")
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_OnBleed(dmginfo,hitgroup)
	if self.DisableChasingEnemy then
		self:StopMoving()
		self.DisableChasingEnemy = false
		self.NextFindStalkPos = CurTime() +math.Rand(15,20)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnKilled()
	if self:GetState() == VJ_STATE_NONE then
		for i = 1,self:GetBoneCount() -1 do
			if math.random(1,4) <= 3 then continue end
			local bone = self:GetBonePosition(i)
			if bone then
				local particle = ents.Create("info_particle_system")
				particle:SetKeyValue("effect_name", VJ.PICK(self.CustomBlood_Particle))
				particle:SetPos(bone +VectorRand() *15)
				particle:Spawn()
				particle:Activate()
				particle:Fire("Start")
				particle:Fire("Kill", "", 0.1)
			end
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnChangeActivity(newAct)
	//print(newAct)
	local funcCustom = self.CustomOnChangeActivity; if funcCustom then funcCustom(self, newAct) end
	if newAct == ACT_TURN_LEFT or newAct == ACT_TURN_RIGHT then
		self.NextIdleStandTime = CurTime() + VJ.AnimDuration(self, self:GetSequenceName(self:GetSequence()))
		//self.NextIdleStandTime = CurTime() + 1.2
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:PlaySound(sndTbl,level,pitch,setCurSnd)
	if sndTbl == nil or istable(sndTbl) && #sndTbl <= 0 then return 0 end
	if setCurSnd then
		self:StopAllCommonSpeechSounds()
	end
	local sndName = VJ_PICK(sndTbl)
	local snd = VJ_CreateSound(self,sndName,level or 75,pitch or math.random(self.GeneralSoundPitch1,self.GeneralSoundPitch2))
	if setCurSnd then
		self.CurrentVoiceLine = snd
	end
	self.DeleteSounds = self.DeleteSounds or {}
	table.insert(self.DeleteSounds,snd)
	return SoundDuration(sndName)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
	VJ_STOPSOUND(self.CurrentVoiceLine)
	if self.DeleteSounds then
		for _,v in pairs(self.DeleteSounds) do
			VJ_STOPSOUND(v)
		end
	end
end