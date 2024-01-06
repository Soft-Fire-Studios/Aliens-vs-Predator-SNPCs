AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/avp/xeno/predalien.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 1500
ENT.VJ_IsHugeMonster = true
ENT.HullType = HULL_LARGE

ENT.VJC_Data = {
    CameraMode = 2,
    ThirdP_Offset = Vector(0, 0, -35),
    FirstP_Bone = "Bip01 Head",
    FirstP_Offset = Vector(20, 0, -5),
    FirstP_ShrinkBone = false
}

ENT.FootStepSoundLevel = 82

ENT.AlwaysStand = true
ENT.TranslateActivities = {
	[ACT_IDLE] = ACT_HL2MP_IDLE_SMG1,
	[ACT_WALK] = ACT_HL2MP_WALK_SMG1,
	[ACT_RUN] = ACT_HL2MP_RUN_SMG1,
	[ACT_MP_SPRINT] = ACT_HL2MP_RUN_SMG1,
	-- [ACT_TURN_LEFT] = ACT_ROLL_LEFT,
	-- [ACT_TURN_RIGHT] = ACT_ROLL_RIGHT,
}
ENT.FaceEnemyMovements = {ACT_HL2MP_WALK_SMG1,ACT_HL2MP_RUN_SMG1}

ENT.StandingBounds = Vector(16,16,74)
ENT.CrawlingBounds = Vector(16,16,74)
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnInit()
	-- self.CurrentSet = 2
	if GetConVar("vj_avp_bosstheme_a"):GetBool() then
		self.HasSoundTrack = true
		self.SoundTbl_SoundTrack = {"cpthazama/avp/music/boss/The Unstoppable.mp3"}
	end

	self.SoundTbl_Idle = {
		"cpthazama/avp/xeno/predalien/idle1.ogg",
		"cpthazama/avp/xeno/predalien/idle2.ogg",
		"cpthazama/avp/xeno/predalien/growl1.ogg",
		"cpthazama/avp/xeno/predalien/growl2.ogg",
		"cpthazama/avp/xeno/predalien/growl3.ogg",
	}
	self.SoundTbl_Alert = {
		"cpthazama/avp/xeno/predalien/hiss1.ogg",
		"cpthazama/avp/xeno/predalien/predalien_scream_p01.ogg",
	}
	self.SoundTbl_Attack = {
		"cpthazama/avp/xeno/alien hag queen/alien_hag_queen_scream_short_01.ogg",
		"cpthazama/avp/xeno/alien hag queen/alien_hag_queen_scream_short_02.ogg",
		"cpthazama/avp/xeno/alien hag queen/alien_hag_queen_scream_short_03.ogg",
	}
	self.SoundTbl_CombatIdle = {
		"cpthazama/avp/xeno/predalien/growl4.ogg",
		-- "cpthazama/avp/xeno/predalien/growl7.ogg",
		"cpthazama/avp/xeno/predalien/growl8.ogg",
		"cpthazama/avp/xeno/predalien/growl9.ogg",
	}
	self.SoundTbl_Jump = {
		"cpthazama/avp/xeno/predalien/scream1.ogg",
		"cpthazama/avp/xeno/predalien/scream2.ogg",
	}
	self.SoundTbl_Pain = {
		"cpthazama/avp/xeno/predalien/pain2.ogg",
		"cpthazama/avp/xeno/predalien/pain3.ogg",
		"cpthazama/avp/xeno/alien queen/vocal/alien_queen_scream_06.ogg",
	}
	self.SoundTbl_Death = {
		"cpthazama/avp/xeno/predalien/predalien_death_scream_01.ogg",
	}

	self.SoundTbl_FootSteps = {
		[MAT_CONCRETE] = {
			"cpthazama/avp/xeno/alien queen/alien_queen_footstep_01.ogg",
			"cpthazama/avp/xeno/alien queen/alien_queen_footstep_02.ogg",
			"cpthazama/avp/xeno/alien queen/alien_queen_footstep_03.ogg",
		}
	}
	self.FootData = {
		["lfoot"] = {Range=24,OnGround=true},
		["rfoot"] = {Range=24,OnGround=true}
	}

	self.AttackDistance = 80
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnStep(pos,name)
	util.ScreenShake(pos,5,100,0.35,500)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:TranslateActivity(act)
	if self.TranslateActivities[act] then
		return self.TranslateActivities[act]
	end
	return act
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAlert(ent)
	if math.random(1,2) == 1 && !self:IsBusy() then
		self:StopAllCommonSpeechSounds()
		self:VJ_ACT_PLAYACTIVITY("Predalien_Hybrid_lava_angry_roar",true,false,false)
		self:PlaySound("cpthazama/avp/xeno/predalien/scream3.ogg",90)
		util.ScreenShake(self:EyePos(),16,200,4,1000,true)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnCallForHelp(ally)
	if self:IsBusy() then return end
	self:StopAllCommonSpeechSounds()
	self:VJ_ACT_PLAYACTIVITY("Predalien_Hybrid_lava_angry_roar",true,false,false)
	self:PlaySound("cpthazama/avp/xeno/predalien/scream3.ogg",90)
	util.ScreenShake(self:EyePos(),16,200,4,1000,true)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SelectIdleActivity()
	return ACT_IDLE
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SelectMovementActivity()
	local act = ACT_RUN
	local ply = self.VJ_TheController
	local standing = self.CurrentSet == 2
	if IsValid(ply) then
		if ply:KeyDown(IN_WALK) then
			act = ACT_WALK
		end
		return act
	end
	local currentSchedule = self.CurrentSchedule
	if currentSchedule != nil then
		if currentSchedule.MoveType == 0 then
			act = ACT_WALK
		end
	end
	return act
end
---------------------------------------------------------------------------------------------------------------------------------------------
local sdClawFlesh = {
	"cpthazama/avp/weapons/alien/claws/alien_claw_impact_flesh_01.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_impact_flesh_02.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_impact_flesh_03.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_impact_flesh_04.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_impact_flesh_05.ogg",
}
local sdClawMiss = {
	"cpthazama/avp/weapons/alien/claws/alien_claw_swipe_01.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_swipe_02.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_swipe_03.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_swipe_04.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_swipe_05.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_swipe_06.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_swipe_07.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_swipe_08.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_swipe_09.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_swipe_10.ogg",
}
local sdMM = {
	"cpthazama/avp/weapons/alien/claws/alien_claw_impact_mn_01.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_impact_mn_02.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_impact_mn_03.ogg",
}
local sdTail = {
	"cpthazama/avp/weapons/alien/tail/alien_heavyattack_tailstab_mn_01.ogg",
	"cpthazama/avp/weapons/alien/tail/alien_heavyattack_tailstab_mn_02.ogg",
	"cpthazama/avp/weapons/alien/tail/alien_heavyattack_tailstab_mn_03.ogg",
	"cpthazama/avp/weapons/alien/tail/alien_tail_impact_flesh_01.ogg",
	"cpthazama/avp/weapons/alien/tail/alien_tail_impact_flesh_02.ogg",
	"cpthazama/avp/weapons/alien/tail/alien_tail_impact_flesh_03.ogg",
	"cpthazama/avp/weapons/alien/tail/alien_tail_impact_flesh_04.ogg",
	"cpthazama/avp/weapons/alien/tail/alien_tail_impact_flesh_05.ogg",
}
local sdTailMiss = {
	"cpthazama/avp/weapons/alien/tail/alien_tailswipe_tp_1.ogg",
	"cpthazama/avp/weapons/alien/tail/alien_tailswipe_tp_2.ogg",
	"cpthazama/avp/weapons/alien/tail/alien_tailswipe_tp_3.ogg",
	"cpthazama/avp/weapons/alien/tail/alien_tailswipe_tp_4.ogg",
	"cpthazama/avp/weapons/alien/tail/alien_tailswipe_tp_5.ogg",
	"cpthazama/avp/weapons/alien/tail/alien_tailswipe_tp_6.ogg",
}
--
function ENT:OnInput(key)
	if key == "hybrid_heavyattack" then
		self.AttackDamage = 150
		self.AttackDamageDistance = 140
		self.AttackDamageType = bit.bor(DMG_SLASH,DMG_VEHICLE,DMG_CRUSH)
		VJ.EmitSound(self,#self:RunDamageCode() > 0 && sdClawFlesh or sdClawMiss,75)
		VJ.EmitSound(self,"cpthazama/avp/xeno/praetorian/praetorian_hit_wall_01.ogg",80)
		ParticleEffect("AntlionFX_UnBurrow",self:GetPos() +self:GetForward() *45,Angle())
		util.ScreenShake(self:GetPos(),16,200,2,1500)
	elseif key == "hybrid_slampre" then
		VJ.CreateSound(self,"cpthazama/avp/xeno/alien queen/alien_queen_breathe_in_02.ogg",75,80)
	elseif key == "hybrid_slam" then
		VJ.CreateSound(self,"cpthazama/avp/xeno/praetorian/vocal/praetorian_trophy_struggle_02.ogg",90)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomAttack(ent,visible)
	if self.InFatality or self.DoingFatality then return end
	local cont = self.VJ_TheController
	local dist = self.NearestPointToEnemyDistance
	-- local dist = self.LastEnemyDistance
	local isCrawling = self.CurrentSet == 1

	if IsValid(cont) then
		if cont:KeyDown(IN_ATTACK) && !cont:KeyDown(IN_ATTACK2) && !self:IsBusy() then
			self:AttackCode(isCrawling)
		elseif cont:KeyDown(IN_ATTACK2) && !cont:KeyDown(IN_ATTACK) && !self:IsBusy() then
			self:AttackCode(isCrawling,5)
		elseif cont:KeyDown(IN_ATTACK) && cont:KeyDown(IN_ATTACK2) && cont:KeyDown(IN_JUMP) && !self:IsBusy() then
			self:AttackCode(isCrawling,4)
		elseif !cont:KeyDown(IN_ATTACK) && !cont:KeyDown(IN_ATTACK2) && cont:KeyDown(IN_JUMP) && !self:IsBusy() then
			self:LongJumpCode()
		end
		return
	end

	if visible then
		if self.CanAttack then
			if dist <= self.AttackDistance && !self:IsBusy() then
				local canUse, inFront = self:CanUseFatality(ent)
				if canUse && (inFront && math.random(1,2) == 1 or !inFront) then
					if self:DoFatality(ent,inFront) == false then
						self:AttackCode(isCrawling)
					end
				else
					self:AttackCode(isCrawling)
				end
			end
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DoLeapAttack()
	/*
		Predalien_Hybrid_leap_attack_telegraph
		Predalien_Hybrid_leap_attack_leap_to_grapple
		Predalien_Hybrid_leap_attack_miss
		Predalien_Hybrid_leap_attack_hit_wall
	*/
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:AttackCode(isCrawling,forceAttack)
	if self.InFatality or self.DoingFatality then return end
	if !self.CanAttack then return end
	if self:IsMoving() && forceAttack == nil then
		self.AttackType = 2
		self.AttackSide = self.AttackSide == "right" && "left" or "right"
		self:PlaySound(self.SoundTbl_Attack,75)
		self:VJ_ACT_PLAYACTIVITY("Predalien_Hybrid_claw_swipe_" .. self.AttackSide .. "_step",true,false,true,0,{OnFinish=function(interrupted)
			if interrupted or self.InFatality then return end -- Means we hit something
			self.AttackDamage = 40
			self.AttackDamageDistance = 140
			self.AttackDamageType = DMG_SLASH
			VJ.EmitSound(self,#self:RunDamageCode() > 0 && sdClawFlesh or sdClawMiss,75)
			self:VJ_ACT_PLAYACTIVITY("Predalien_Hybrid_claw_swipe_" .. self.AttackSide .. "_step_hit_or_miss",true,false,true)
		end})
	else
		if forceAttack == 5 or forceAttack == nil && !IsValid(self.VJ_TheController) && math.random(1,4) == 1 then
			self.AttackType = 5
			self:VJ_ACT_PLAYACTIVITY("Predalien_Hybrid_heavy_attack_pound_fists",true,false,true)
		elseif forceAttack == 4 or forceAttack == nil && !IsValid(self.VJ_TheController) && math.random(1,4) == 1 then
			self.AttackType = 5
			self:DoLeapAttack()
		else
			self.AttackType = 1
			self.AttackSide = self.AttackSide == "right" && "left" or "right"
			self:PlaySound(self.SoundTbl_Attack,75)
			self:VJ_ACT_PLAYACTIVITY("Predalien_Hybrid_claw_swipe_" .. self.AttackSide,true,false,true,0,{OnFinish=function(interrupted)
				if interrupted or self.InFatality then return end -- Means we hit something
				self.AttackDamage = 40
				self.AttackDamageDistance = 140
				self.AttackDamageType = DMG_SLASH
				VJ.EmitSound(self,#self:RunDamageCode() > 0 && sdClawFlesh or sdClawMiss,75)
				self:VJ_ACT_PLAYACTIVITY("Predalien_Hybrid_claw_swipe_" .. self.AttackSide .. "_hit_or_miss",true,false,true)
			end})
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:LongJumpCode(gotoPos,atk)
	if self.InFatality then return true end
	if self:IsBusy() then return true end
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
	if !canJump then return true end
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
		anim = "Predalien_Hybrid_jump_up"
	elseif height > 150 then
		anim = "Predalien_Hybrid_jump_drop_down"
	else
		if dist > 1500 then
			anim = "Predalien_Hybrid_jump_long"
		elseif dist > 1200 then
			anim = "Predalien_Hybrid_jump_medium"
		elseif dist > 800 then
			anim = "Predalien_Hybrid_jump_shallow"
		else
			anim = "Predalien_Hybrid_jump_short"
		end
	end
	self:FaceCertainPosition(self.LongJumpPos,1)
	self:VJ_ACT_PLAYACTIVITY(anim,true,false,false)
end
---------------------------------------------------------------------------------------------------------------------------------------------
local vec0 = Vector(0,0,0)
--
function ENT:OnThink()
	-- if !IsValid(self:GetEnemy()) then
		local goalPos = self:GetGoalPos()
		if goalPos == vec0 or goalPos != vec0 && self:GetPos():Distance(goalPos) < 45 then
			goalPos = nil
			return
		end
		local heightDif = math.abs(goalPos.z -self:GetPos().z)
		local tr = util.TraceLine({
			start = goalPos,
			endpos = goalPos +self:GetUp() *175,
			filter = self,
			mask = MASK_SOLID_BRUSHONLY
		})
		-- VJ.DEBUG_TempEnt(tr.HitPos, self:GetAngles(), Color(0,68,255), 5)
		if (heightDif > 200 or self:GetPos():Distance(goalPos) > 600) && self:VisibleVec(tr.HitPos) && math.random(1,30) == 1 then
			self:LongJumpCode(goalPos)
		end
	-- end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local math_Clamp = math.Clamp
--
function ENT:JumpVelocityCode()
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
		local moveSpeed = math_Clamp((dist < 250 && 700 or dist *3.5),700,3000)
		local newPos = currentPos +moveDirection *moveSpeed *FrameTime()
		self:SetLocalVelocity(moveDirection *moveSpeed)
	end
end