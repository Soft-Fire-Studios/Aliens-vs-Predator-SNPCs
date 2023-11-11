AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/avp/xeno/warrior.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 225
ENT.HullType = HULL_HUMAN
ENT.FindEnemy_CanSeeThroughWalls = true
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.BloodColor = "Yellow" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.CustomBlood_Particle = {"vj_avp_blood_xeno"}
ENT.VJ_NPC_Class = {"CLASS_XENOMORPH"} -- NPCs with the same class with be allied to each other

ENT.HasMeleeAttack = false

ENT.VJC_Data = {
    CameraMode = 2,
    ThirdP_Offset = Vector(0, 0, -35),
    FirstP_Bone = "Bip01 Head",
    FirstP_Offset = Vector(15, 0, 0),
    FirstP_ShrinkBone = false
}

ENT.GeneralSoundPitch1 = 100

ENT.SoundTbl_FootStep = {
	"cpthazama/avp/xeno/fs_alien_metal_walk_01.wav",
	"cpthazama/avp/xeno/fs_alien_metal_walk_02.wav",
	"cpthazama/avp/xeno/fs_alien_metal_walk_03.wav",
	"cpthazama/avp/xeno/fs_alien_metal_walk_04.wav",
	"cpthazama/avp/xeno/fs_alien_metal_walk_05.wav",
	"cpthazama/avp/xeno/fs_alien_metal_walk_06.wav",
	"cpthazama/avp/xeno/fs_alien_metal_walk_07.wav",
	"cpthazama/avp/xeno/fs_alien_metal_walk_08.wav",
	"cpthazama/avp/xeno/fs_alien_metal_walk_09.wav",
	"cpthazama/avp/xeno/fs_alien_metal_walk_10.wav",
}
ENT.SoundTbl_Idle = {
	"cpthazama/avp/xeno/alien/alien_drool_01.mp3",
	"cpthazama/avp/xeno/alien/alien_drool_02.mp3",
}
ENT.SoundTbl_Alert = {
	"cpthazama/avp/xeno/alien/alien_distract_01.mp3",
	"cpthazama/avp/xeno/alien/alien_growl_short_01.mp3",
	"cpthazama/avp/xeno/alien/alien_growl_short_02.mp3",
	"cpthazama/avp/xeno/alien/alien_growl_short_03.mp3",
	"cpthazama/avp/xeno/alien/alien_growl_short_04.mp3",
	"cpthazama/avp/xeno/alien/alien_growl_short_05.mp3",
	"cpthazama/avp/xeno/alien/alien_sprint_burst_01.mp3",
	"cpthazama/avp/xeno/alien/alien_sprint_burst_02.mp3",
	"cpthazama/avp/xeno/alien/alien_sprint_burst_03.mp3",
}
ENT.SoundTbl_CombatIdle = {
	"cpthazama/avp/xeno/alien/alien_hiss_long_01.mp3",
	"cpthazama/avp/xeno/alien/alien_hiss_long_02.mp3",
	"cpthazama/avp/xeno/alien/alien_hiss_short_01.mp3",
	"cpthazama/avp/xeno/alien/alien_hiss_short_02.mp3",
	"cpthazama/avp/xeno/alien/alien_injured_growl_01.mp3",
	"cpthazama/avp/xeno/alien/alien_injured_growl_02.mp3",
	"cpthazama/avp/xeno/alien/alien_injured_growl_03.mp3",
	"cpthazama/avp/xeno/alien/alien_injured_growl_04.mp3",
}
ENT.SoundTbl_BeforeMeleeAttack = {
	-- "cpthazama/avp/xeno/alien/alien_jump_grunt_01.mp3",
	-- "cpthazama/avp/xeno/alien/alien_jump_grunt_02.mp3",
	-- "cpthazama/avp/xeno/alien/alien_jump_grunt_03.mp3",
	-- "cpthazama/avp/xeno/alien/alien_jump_grunt_04.mp3",
	-- "cpthazama/avp/xeno/alien/alien_jump_grunt_05.mp3",
}
ENT.SoundTbl_Pain = {
	"cpthazama/avp/xeno/alien/aln_pain_small_01.mp3",
	"cpthazama/avp/xeno/alien/aln_pain_small_02.mp3",
	"cpthazama/avp/xeno/alien/aln_pain_small_03.mp3",
	"cpthazama/avp/xeno/alien/aln_pain_small_04.mp3",
	"cpthazama/avp/xeno/alien/aln_pain_small_05.mp3",
	"cpthazama/avp/xeno/alien/aln_pain_small_06.mp3",
	"cpthazama/avp/xeno/alien/aln_pain_small_07.mp3",
	"cpthazama/avp/xeno/alien/aln_pain_small_08.mp3",
	"cpthazama/avp/xeno/alien/aln_pain_small_09.mp3",
	"cpthazama/avp/xeno/alien/aln_pain_small_10.mp3",
}
ENT.SoundTbl_Death = {
	"cpthazama/avp/xeno/alien/alien_death_scream_iconic_elephant.mp3",
	"cpthazama/avp/xeno/alien/aln_death_scream_20.mp3",
	"cpthazama/avp/xeno/alien/aln_death_scream_21.mp3",
	"cpthazama/avp/xeno/alien/aln_death_scream_22.mp3",
	"cpthazama/avp/xeno/alien/aln_death_scream_23.mp3",
	"cpthazama/avp/xeno/alien/aln_death_scream_24.mp3",
	"cpthazama/avp/xeno/alien/aln_death_scream_25.mp3",
	"cpthazama/avp/xeno/alien/aln_death_scream_26.mp3",
	"cpthazama/avp/xeno/alien/aln_death_scream_27.mp3",
}
ENT.SoundTbl_Jump = {
	"cpthazama/avp/xeno/alien/alien_jump_grunt_01.mp3",
	"cpthazama/avp/xeno/alien/alien_jump_grunt_02.mp3",
	"cpthazama/avp/xeno/alien/alien_jump_grunt_03.mp3",
	"cpthazama/avp/xeno/alien/alien_jump_grunt_04.mp3",
	"cpthazama/avp/xeno/alien/alien_jump_grunt_05.mp3",
}

ENT.AnimationBehaviors = {}

ENT.AttackSets = {
	Crawl = {
		{
			Start = "crawl_stand_attack_left",
			End = "crawl_stand_attack_left_end",
			Countered = "crawl_stand_attack_left_countered",
		},
	},
	Stand = {
		{
			Start = "light_attack_left_mid",
			Gesture = true,
			Countered = "light_attack_left_mid_blocked",
		},
	},
}

ENT.CanSpit = false
ENT.CanStand = true
ENT.CanLeap = true
ENT.FaceEnemyMovements = {ACT_RUN_RELAXED=true,ACT_RUN=true,ACT_WALK_STIMULATED=true}

ENT.SoundTbl_Alert = {
	"cpthazama/avp/xeno/alien/vocals/alien_hiss_long_01.ogg",
	"cpthazama/avp/xeno/alien/vocals/alien_hiss_long_02.ogg",
	"cpthazama/avp/xeno/alien/vocals/alien_hiss_scream_long_01.ogg",
	"cpthazama/avp/xeno/alien/vocals/alien_hiss_scream_long_02.ogg",
	"cpthazama/avp/xeno/alien/vocals/alien_hiss_short_01.ogg",
	"cpthazama/avp/xeno/alien/vocals/alien_hiss_short_02.ogg",
}
ENT.SoundTbl_CombatIdle = {
	"cpthazama/avp/xeno/alien/vocals/alien_growl_short_01.ogg",
	"cpthazama/avp/xeno/alien/vocals/alien_growl_short_02.ogg",
	"cpthazama/avp/xeno/alien/vocals/alien_growl_short_03.ogg",
	"cpthazama/avp/xeno/alien/vocals/alien_growl_short_04.ogg",
	"cpthazama/avp/xeno/alien/vocals/alien_growl_short_05.ogg",
}
ENT.SoundTbl_Jump = {
	"cpthazama/avp/xeno/alien/vocals/alien_jump_grunt_01.ogg",
	"cpthazama/avp/xeno/alien/vocals/alien_jump_grunt_02.ogg",
	"cpthazama/avp/xeno/alien/vocals/alien_jump_grunt_03.ogg",
	"cpthazama/avp/xeno/alien/vocals/alien_jump_grunt_04.ogg",
}
ENT.SoundTbl_Pain = {
	"cpthazama/avp/xeno/alien/vocals/aln_pain_small_01.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_pain_small_02.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_pain_small_03.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_pain_small_04.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_pain_small_05.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_pain_small_06.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_pain_small_07.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_pain_small_08.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_pain_small_09.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_pain_small_10.ogg",
}
ENT.SoundTbl_Death = {
	"cpthazama/avp/xeno/alien/vocals/alien_death_scream_iconic_elephant.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_death_scream_20.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_death_scream_21.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_death_scream_22.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_death_scream_23.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_death_scream_24.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_death_scream_25.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_death_scream_26.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_death_scream_27.ogg",
}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnChangeActivity(act)
	if self.AnimationBehaviors[act] then
		self.AnimationBehaviors[act](self)
	end
	if act == ACT_IDLE then
		local idleAct = self:SelectIdleActivity()
		if idleAct != act then
			self:ResetIdealActivity(idleAct)
		end
	elseif act == ACT_JUMP then
		VJ_CreateSound(self,self.SoundTbl_Jump,76)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Controller_Initialize(ply,controlEnt)
    net.Start("VJ_AVP_Xeno_Client")
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
		net.Start("VJ_AVP_Xeno_Client")
			net.WriteBool(true)
			net.WriteEntity(self)
			net.WriteEntity(ply)
		net.Send(ply)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.CurrentSet = 1 -- Crawl | 2 = Stand
	self.LastIdleActivity = ACT_IDLE
	self.LastMovementActivity = ACT_RUN
	self.ChangeSetT = CurTime() +1
	self.IsUsingFaceAnimation = false

	if self.OnInit then
		self:OnInit()
	end

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
		end
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
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
	local anim = "jump_fwd"
	local dist = self:GetPos():Distance(self.LongJumpPos)
	local height = self:GetPos().z -self.LongJumpPos.z
	self:FaceCertainPosition(self.LongJumpPos,1)
	self:VJ_ACT_PLAYACTIVITY(anim,true,false,false)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == "jump_start" then
		self.LongJumping = true
	elseif key == "jump_end" then
		self.LongJumping = false
		self:SetLocalVelocity(Vector(0,0,0))
		self:SetVelocity(self:GetForward() *150 +Vector(0,0,-100))
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
	elseif key == "step" then
		self:FootStepSoundCode()
	elseif key == "attack" then
		self:MeleeAttackCode()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomAttack(ent,visible)
	local cont = self.VJ_TheController
	local dist = self.NearestPointToEnemyDistance
	local isCrawling = self.CurrentSet == 1

	if IsValid(cont) then
		if cont:KeyDown(IN_ATTACK) && !self:IsBusy() && !self.IsAttacking then
			local anim = isCrawling && self.AttackSets.Crawl or self.AttackSets.Stand
			anim = VJ_PICK(anim)
			self.CurrentAttackAnimation = anim.Start
			self.IsAttacking = true
			if anim.Gesture then
				self:PlayGesture(anim.Start,1,function(interupted)
					if interupted then return end
					self.IsAttacking = false
				end)
				return
			end
			self:VJ_ACT_PLAYACTIVITY(anim.Start,true,false,true,0,{OnFinish=function(interupted, animation)
				if interupted then return end
				self:VJ_ACT_PLAYACTIVITY(anim.End,true,false,false,0,{OnFinish=function(interupted, animation)
					if interupted then return end
					self.IsAttacking = false
				end})
			end})
		elseif !cont:KeyDown(IN_ATTACK) && cont:KeyDown(IN_SPEED) && cont:KeyDown(IN_JUMP) && !self:IsBusy() then
			self:LongJumpCode()
		end
		return
	end

	if visible then
		if dist <= 100 && !self:IsBusy() && !self.IsAttacking then
			local enemyToSelfDir = (ent:GetPos() -self:GetPos()):GetNormalized()
			print((ent:IsNPC() && ent:GetHullType() == HULL_HUMAN or ent:IsPlayer()),ent:GetAngles():Forward():Dot(enemyToSelfDir),self:GetAngles():Forward():Dot(enemyToSelfDir))
			if (ent:IsNPC() && ent:GetHullType() == HULL_HUMAN or ent:IsPlayer()) && ent:GetAngles():Forward():Dot(enemyToSelfDir) > 0.5 then
				self:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK)
				if ent:IsNPC() then
					if ent.IsVJBaseSNPC then
						ent:StopMoving()
						ent:ClearSchedule()
						ent:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK)
					end
				elseif ent:IsPlayer() then
					hook.Add("Think", self, function(self)
						if !IsValid(ent) or IsValid(ent) && ent:Health() <= 0 then
							if IsValid(ent) then
								ent:Freeze(false)
							end
							hook.Remove("Think", self)
							return
						end
						ent:Freeze(true)
						ent:SetEyeAngles((self:GetPos() -ent:GetPos()):Angle())
					end)
				end
				self:VJ_ACT_PLAYACTIVITY("headbite_behind",true,false,true,0,{OnFinish=function(interupted, animation)
					if interupted then hook.Remove("Think", self) return end
					self:VJ_ACT_PLAYACTIVITY("headbite_behind_kill",true,false,true,0,{OnFinish=function(interupted, animation)
						hook.Remove("Think", self)
						if interupted then return end
						if IsValid(ent) then
							if ent:IsNPC() then
								ent:SetHealth(0)
								ent:TakeDamage(999999999,self,self)
							else
								ent:Freeze(false)
								ent:GodDisable()
								ent:SetHealth(0)
								ent:TakeDamage(999999999,self,self)
							end
						end
						self:SetState()
					end})
				end})
				return
			end
			local anim = isCrawling && self.AttackSets.Crawl or self.AttackSets.Stand
			anim = VJ_PICK(anim)
			self.CurrentAttackAnimation = anim.Start
			self.IsAttacking = true
			if anim.Gesture then
				self:PlayGesture(anim.Start,1,function(interupted)
					if interupted then return end
					self.IsAttacking = false
				end)
				return
			end
			self:VJ_ACT_PLAYACTIVITY(anim.Start,true,false,true,0,{OnFinish=function(interupted, animation)
				if interupted then return end
				self:VJ_ACT_PLAYACTIVITY(anim.End,true,false,false,0,{OnFinish=function(interupted, animation)
					if interupted then return end
					self.IsAttacking = false
				end})
			end})
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DoCounterAnimation()
	local curAnim = self.CurrentAttackAnimation
	for k,v in pairs(self.AttackSets) do
		for _,anim in pairs(v) do
			if anim.Start == curAnim then
				self.IsAttacking = false
				self:VJ_ACT_PLAYACTIVITY(anim.Countered,true,false,true,0,{OnFinish=function(interupted, animation)
					if interupted then return end
					self:VJ_ACT_PLAYACTIVITY(anim.End,true,false,true)
				end})
				break
			end
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:PlayGesture(anim,rate,OnFinish)
	if VJ_AnimationExists(self,anim) == false then return end
	local seed = math.random(1,999999)
	self.CurGestureAnimationSeed = seed
	if rate == true then
		if isstring(anim) then
			anim = VJ_SequenceToActivity(self,anim)
		end
		self:RestartGesture(anim)
		if OnFinish then
			timer.Simple(VJ_GetSequenceDuration(self,anim), function()
				if IsValid(self) && !self.Dead then
					OnFinish(self.CurGestureAnimationSeed != seed)
				end
			end)
		end
		return VJ_GetSequenceDuration(self,anim)
	end
	local gesture = self:AddGestureSequence(self:LookupSequence(anim))
	self:SetLayerPriority(gesture, 1)
	self:SetLayerPlaybackRate(gesture, (rate or 1) *0.5)
	if OnFinish then
		timer.Simple(VJ_GetSequenceDuration(self,anim), function()
			if IsValid(self) && !self.Dead then
				OnFinish(self.CurGestureAnimationSeed != seed)
			end
		end)
	end
	return VJ_GetSequenceDuration(self,anim)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Gibs()
	local bloodeffect = EffectData()
	bloodeffect:SetOrigin(self:GetPos() +self:OBBCenter())
	bloodeffect:SetColor(VJ_Color2Byte(Color(255,221,35)))
	bloodeffect:SetScale(300)
	util.Effect("VJ_Blood1",bloodeffect)

	self:CreateGibEntity("obj_vj_gib","UseAlien_Small")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Small")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	local curTime = CurTime()
	local ent = self:GetEnemy()
	local ply = self.VJ_TheController
	local curSet = self.CurrentSet
	local idleAct = self:SelectIdleActivity()
	local moveAct = self:SelectMovementActivity()
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

	if self.HasBreath then
		self:Breathe()
	end

	if self.LongJumping && self.LongJumpPos then
		local currentPos = self:GetPos()
		local dist = currentPos:Distance(self.LongJumpPos)
		local targetPos = self.LongJumpPos +(dist < 250 && self:OBBCenter() or self:OBBCenter() *3)
		local moveDirection = (targetPos -currentPos):GetNormalized()
		local moveSpeed = (dist < 250 && 800 or dist *4)
		local newPos = currentPos +moveDirection *moveSpeed *FrameTime()
		self:SetLocalVelocity(moveDirection *moveSpeed)
	end

	if self.IsAttacking == false then
		self.CurrentAttackAnimation = nil
	end

	self:SetEnemyCS(ent)
	self:SetPoseParameter("standing", Lerp(FrameTime() *10,self:GetPoseParameter("standing"),curSet -1))

	-- self.IsUsingFaceAnimation = self.FaceEnemyMovements[moveAct]
	if IsValid(ply) then
		if ply:KeyDown(IN_DUCK) then
			if curTime > self.ChangeSetT then
				self.CurrentSet = curSet == 1 && 2 or 1
				self.ChangeSetT = curTime +0.5
			end
		end
	else
		if IsValid(ent) then
			local dist = self.NearestPointToEnemyDistance
			if curTime > self.ChangeSetT then
				if curSet == 1 then
					if dist < 750 && math.random(1,20) == 1 then
						self.CurrentSet = 2
						self.ChangeSetT = curTime +math.Rand(15,35)
					end
				else
					if dist >= 750 && math.random(1,10) == 1 then
						self.CurrentSet = 1
						self.ChangeSetT = curTime +math.Rand(15,35)
					end
				end
			end
		else
			if curTime > self.ChangeSetT then
				self.CurrentSet = 1
				self.ChangeSetT = curTime +math.Rand(3,8)
			end
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_OnBleed(dmginfo,hitgroup)
	self:Acid(dmginfo:GetDamagePosition(),25,200,5)

	local seq = self:GetSequenceName(self:GetSequence())
	if seq == self.CurrentAttackAnimation then
		self:DoCounterAnimation()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnKilled()
	self:Acid(self:GetPos(),25,375,25)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SelectMovementActivity()
	local act = ACT_RUN
	local ply = self.VJ_TheController
	local standing = self.CurrentSet == 2
	if IsValid(ply) then
		if ply:KeyDown(IN_WALK) then
			act = standing && ACT_WALK or ACT_RUN_RELAXED
		elseif ply:KeyDown(IN_SPEED) then
			act = standing && ACT_RUN or ACT_RUN_RELAXED
		else
			act = standing && ACT_WALK_STIMULATED or ACT_RUN_RELAXED
		end
		return act
	end
	local currentSchedule = self.CurrentSchedule
	if currentSchedule != nil then
		if currentSchedule.MoveType == 0 then
			act = standing && (self.Alerted == true && ACT_WALK_STIMULATED or ACT_WALK) or ACT_RUN_RELAXED
		else
			act = standing && ACT_RUN or ACT_RUN_RELAXED
		end
	end
	return act
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SelectIdleActivity()
	local act = ACT_IDLE
	local standing = self.CurrentSet == 2
	-- if standing then
		-- act = ACT_IDLE_STIMULATED
	-- else
		act = ACT_IDLE
	-- end
	return act
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
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo, hitgroup, ent)
	ent.VJ_AVP_Xenomorph = true
	ent:SetNW2Bool("AVP.Xenomorph",true)
end