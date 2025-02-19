AddCSLuaFile("shared.lua")
include("shared.lua")
include("vj_base/extensions/avp_fatality_module.lua")
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/avp/predators/youngblood.mdl"}
ENT.StartHealth = 450
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.BloodColor = VJ.BLOOD_COLOR_GREEN
ENT.BloodParticle = {"vj_avp_blood_predator"}
ENT.BloodDecal = {"VJ_AVP_BloodPredator"}
ENT.BloodPool = {"vj_avp_bloodpool_predator"}
ENT.VJ_NPC_Class = {"CLASS_PREDATOR","CLASS_YAUTJA"}

-- Example scenario:
--      [A]       <- Apex
--     /   \
--    /     [S]   <- Start
--  [E]           <- End
ENT.JumpParams = {
	MaxRise = 800,
	MaxDrop = 1400,
	MaxDistance = 750,
}

ENT.FootData = {
    ["lfoot"] = {Range = 9.53, OnGround = true, AttID = nil},
    ["rfoot"] = {Range = 9.53, OnGround = true, AttID = nil},
}
ENT.FootstepSoundLevel = 62

ENT.HasMeleeAttack = false

ENT.PoseParameterLooking_InvertYaw = true
ENT.PoseParameterLooking_InvertPitch = true
ENT.HasExtraMeleeAttackSounds = true
ENT.DisableFootStepSoundTimer = true

ENT.ControllerParams = {
    CameraMode = 2,
    ThirdP_Offset = Vector(0, 0, -35),
    FirstP_Bone = "Bip01 Head",
    FirstP_Offset = Vector(0, 0, 0),
    -- FirstP_Offset = Vector(10, 0, 3),
    FirstP_CameraBoneAng = 1,
    VJC_FP_CameraBoneAng_Offset = 0
}

ENT.HasDeathAnimation = true
ENT.AnimTbl_Death = {"predator_claws_death_Back_Left","predator_claws_death_Back_Right","predator_claws_death_Front_Left","predator_claws_death_Front_Right"}

ENT.MainSoundPitch = 100

ENT.AnimTbl_Fatalities = {
	Alien = {
		Trophy = {
			Grab = "predator_claws_trophy_standing_alien_grab",
			Lift = "predator_claws_trophy_standing_alien_lift",
			Counter = "predator_claws_trophy_alien_countered",
			Kill = {
				"predator_claws_trophy_alien_impale",
				"predator_claws_trophy_alien_kill",
				"predator_claws_trophy_alien_kill_headplant",
				"predator_claws_trophy_alien_kill_kneeplant",
				"predator_claws_trophy_alien_kill_slow"
			}
		},
		Stealth = {
			Kill = {"predator_claws_stealthkill_alien_kill","predator_claws_stealthkill_alien_standing_kill"},
			OnlyKill = true
		}
	},
	Human = {
		Trophy = {
			Grab = "predator_wristblade_marine_trophy_kill_grab",
			Lift = "predator_wristblade_marine_trophy_kill_lift",
			Counter = "predator_wristblade_marine_trophy_kill_countered",
			Kill = {
				"predator_wristblade_marine_trophy_kill",
				"predator_wristblade_marine_trophy_kill_eyestab",
				"predator_wristblade_marine_trophy_kill_stomachrip",
				"predator_wristblade_marine_trophy_kill_short"
			}
		},
		Stealth = {
			Grab = "predator_claws_stealthkill_human_grab",
			Lift = "predator_claws_stealthkill_human_start",
			Counter = "predator_claws_stealthkill_human_countered",
			Kill = {
				"predator_claws_stealthkill_human_kill",
				"predator_claws_stealthkill_human_kill_quick",
				"predator_claws_stealthkill_human_kill_slow",
				"predator_claws_stealthkill_human_kill_stab_chest",
				"predator_claws_stealthkill_human_headrip_kill"
			}
		}
	},
	Predator = {
		Trophy = {
			Grab = "predator_claws_trophy_pred_grab",
			Lift = "predator_claws_trophy_pred_lift",
			Counter = "predator_claws_trophy_pred_countered",
			Kill = {
				"predator_claws_trophy_pred_kill",
				"predator_claws_trophy_pred_headstab_kill",
			}
		},
	}
}

ENT.AnimTbl_FatalitiesResponse = {
	["predator_claws_trophy_pred_grab"] = "predator_claws_guard_block_broken",
	["predator_claws_trophy_pred_lift"] = "predator_claws_trophy_pred_victim_lift",
	["predator_claws_trophy_pred_countered"] = "predator_claws_trophy_pred_victim_counter",
	["predator_claws_trophy_pred_kill"] = "predator_claws_trophy_pred_victim_die",
	["predator_claws_trophy_pred_headstab_kill"] = "predator_claws_trophy_pred_headstab_death",
	["headbite_pred"] = "predator_claws_alien_headbite",
	["headbite_pred_countered"] = "predator_claws_alien_headbite_counter",
	["headbite_pred_kill"] = "predator_claws_alien_headbite_death",
	["stealth_kill_pred"] = "predator_claws_alien_stealth_kill",
	["stealth_kill_pred_countered"] = "predator_claws_counter_alien_stealth_kill",
	["stealth_kill_pred_finished"] = "predator_claws_alien_stealth_kill_death",
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
	"cpthazama/avp/predator/pred_win.WAV",
}
ENT.SoundTbl_Stimpack = {
	"cpthazama/avp/predator/vocals/prd_health_pain_scream_01.ogg",
	"cpthazama/avp/predator/vocals/prd_health_pain_scream_02.ogg",
	"cpthazama/avp/predator/vocals/prd_health_pain_scream_03.ogg",
}
ENT.SoundTbl_Pain = {
	"cpthazama/avp/predator/vocals/prd_pain_scream_01.ogg",
	"cpthazama/avp/predator/vocals/prd_pain_scream_02.ogg",
	"cpthazama/avp/predator/vocals/prd_pain_scream_03.ogg",
	"cpthazama/avp/predator/vocals/prd_pain_scream_04.ogg",
	"cpthazama/avp/predator/vocals/prd_pain_scream_05.ogg",
	"cpthazama/avp/predator/vocals/prd_pain_scream_06.ogg",
	"cpthazama/avp/predator/vocals/prd_pain_scream_07.ogg",
	"cpthazama/avp/predator/vocals/prd_pain_scream_08.ogg",
	"cpthazama/avp/predator/vocals/prd_pain_scream_09.ogg",
	"cpthazama/avp/predator/vocals/prd_pain_scream_10.ogg",
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
	"cpthazama/avp/predator/Pred_bodygib.WAV",
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
		"predator_claws_attack_[SIDE]_punch_miss",
	},
	{
		"predator_claws_attack_[SIDE]_upper_slash_into",
		"predator_claws_attack_[SIDE]_upper_slash_hit",
		"predator_claws_attack_[SIDE]_upper_slash_miss",
	},
	{
		"predator_claws_attack_[SIDE]_lower_slash_into",
		"predator_claws_attack_[SIDE]_lower_slash_hit",
		"predator_claws_attack_[SIDE]_lower_slash_miss",
	},
}
ENT.CanAttack = true
ENT.AttackDistance = 70
ENT.AttackDamage = 35
ENT.AttackDamageDistance = 110
ENT.AttackDamageType = 24
ENT.AttackDamageType = DMG_SLASH
---------------------------------------------------------------------------------------------------------------------------------------------
util.AddNetworkString("VJ.AVP.PredatorLandingPos")
--
net.Receive("VJ.AVP.PredatorLandingPos",function(len,pl)
	local ent = net.ReadEntity()
	local pos = net.ReadVector()
	if IsValid(ent) && !ent:IsBusy() then
		ent.PredatorLandingPos = pos
	end
end)
---------------------------------------------------------------------------------------------------------------------------------------------
local toSeq = VJ.SequenceToActivity
--
function ENT:TranslateActivity(act)
	if act == ACT_IDLE then
		if self.TransIdle then
			return self.TransIdle
		end
		if self:GetEquipment() == 5 then
			return self.AttackIdleTime > CurTime() && ACT_IDLE_ANGRY_SMG1 or ACT_IDLE_SMG1
		end
		if self.AttackIdleTime > CurTime() then
			return self.AttackIdle
		elseif self.Alerted then
			return self.AlertedIdle
		end
	end
	if act == ACT_WALK or act == ACT_RUN then
		if self.IsBlocking then
			return ACT_WALK
		end
		return self:SelectMovementActivity(act)
	end
	return act
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SelectMovementActivity(act)
	local ply = self.VJ_TheController
	local speargun = self:GetEquipment() == 5
	if IsValid(ply) then
		if ply:KeyDown(IN_WALK) then
			return speargun && ACT_HL2MP_WALK_SMG1 or ACT_WALK
		elseif ply:KeyDown(IN_SPEED) && self.NextSprintT < CurTime() then
			return speargun && ACT_HL2MP_SWIM_SMG1 or ACT_SPRINT
		else
			return speargun && ACT_HL2MP_RUN_SMG1 or ACT_RUN
		end
	else
		if self.Cur_Walk && act == ACT_WALK then
			return speargun && ACT_HL2MP_WALK_SMG1 or ACT_WALK
		elseif self.Cur_Run && act == ACT_RUN then
			return speargun && ACT_HL2MP_RUN_SMG1 or ACT_RUN
		end
		local dist = self.EnemyData.DistanceNearest
		if act == ACT_RUN && dist && dist > self.AttackDistance *3 && self.NextSprintT < CurTime() then
			return speargun && ACT_HL2MP_SWIM_SMG1 or ACT_SPRINT
		end
	end
	return act
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CalculateTrajectory(start, goal, pitch)
	local g = physenv.GetGravity():Length()
	local vec = Vector(goal.x - start.x, goal.y - start.y, 0)
	local x = vec:Length()
	local y = goal.z - start.z
	if pitch > 90 then pitch = 90 end
	if pitch < -90 then pitch = -90 end
	pitch = math.rad(pitch)
	if y < math.tan(pitch)*x then
		magnitude = math.sqrt((-g*x^2)/(2*math.pow(math.cos(pitch), 2)*(y - x*math.tan(pitch))))
		vec.z = math.tan(pitch)*x
		return vec:GetNormalized()*magnitude
	end
	return self:CalculateProjectile("Curve",start,goal,1200)
end
---------------------------------------------------------------------------------------------------------------------------------------------
local math_deg = math.deg
local math_atan2 = math.atan2
local string_find = string.find
local string_Replace = string.Replace
--
function ENT:CustomOnChangeActivity(newAct)
	-- if newAct == ACT_SPRINT then
	-- 	VJ.EmitSound(self,"cpthazama/avp/predator/adrenalin/adrenalin_turn_on_0" .. math.random(1,5) .. ".ogg",70)
	-- end
	local vm = self:GetViewModel()
	if vm then
		vm:OnChangeActivity(self,act)
	end
	self.LongJumping = false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:PlayAnimation(animation, stopActivities, stopActivitiesTime, faceEnemy, animDelay, extraOptions, customFunc)
	animation = VJ.PICK(animation)
	if stopActivitiesTime == false && (string_find(animation,"vjges_") or extraOptions && extraOptions.AlwaysUseGesture) then
		stopActivitiesTime = self:DecideAnimationLength(animation, false) *0.5
	end
	local anim,animDur = self:PlayAnim(animation,stopActivities,stopActivitiesTime,faceEnemy,animDelay,extraOptions,customFunc)
	local vm = self:GetViewModel()
	if vm then
		if extraOptions && extraOptions.VMAnim then
			timer.Simple(0,function()
				if IsValid(vm) then
					vm:PlayWeaponAnimation(extraOptions.VMAnim)
				end
			end)
		else
			vm:OnChangeActivity(self,anim)
		end
	end
	if extraOptions && extraOptions.AlwaysUseGesture && !extraOptions.DisableChaseFix then
		self.NextChaseTime = 0
	end
	self.LastActivity = anim
	self.LastSequence = self:GetSequenceName(self:LookupSequence(animation))
	return anim,animDur
end
---------------------------------------------------------------------------------------------------------------------------------------------
local varGes = "vjges_"
local varSeq = "vjseq_"
local string_sub = string.sub
local table_concat = table.concat
--
function ENT:PlayAnim(animation, lockAnim, lockAnimTime, faceEnemy, animDelay, extraOptions, customFunc)
	animation = VJ.PICK(animation)
	if !animation then return ACT_INVALID, 0, ANIM_TYPE_NONE end
	
	lockAnim = lockAnim or false
	if lockAnimTime == nil then -- If user didn't put anything, then default it to 0
		lockAnimTime = 0 -- Set this value to false to let the base calculate the time
	end
	faceEnemy = faceEnemy or false -- Should it face the enemy while playing this animation?
	animDelay = tonumber(animDelay) or 0 -- How much time until it starts playing the animation (seconds)
	extraOptions = extraOptions or {}
	local isGesture = false
	local isSequence = false
	local isString = isstring(animation)
	
	-- Handle "vjges_" and "vjseq_"
	if isString then
		local finalString; -- Only define a table if we need to!
		local posCur = 1
		for i = 1, #animation do
			local posStartGes, posEndGes = string_find(animation, varGes, posCur) -- Check for "vjges_"
			local posStartSeq, posEndSeq = string_find(animation, varSeq, posCur) -- Check for "vjges_"
			if !posStartGes && !posStartSeq then -- No ges or seq was found, end the loop!
				if finalString then
					finalString[#finalString + 1] = string_sub(animation, posCur)
				end
				break
			end
			if !finalString then finalString = {} end -- Found a match, create table if needed
			if posStartGes then
				isGesture = true
				finalString[i] = string_sub(animation, posCur, posStartGes - 1)
				posCur = posEndGes + 1
			end
			if posStartSeq then
				isSequence = true
				finalString[i] = string_sub(animation, posCur, posStartSeq - 1)
				posCur = posEndSeq + 1
			end
		end
		if finalString then
			animation = table_concat(finalString)
		end
		-- If animation is -1 then it's probably an activity, so turn it into an activity
		-- EX: "vjges_"..ACT_MELEE_ATTACK1
		if isGesture && !isSequence && self:LookupSequence(animation) == -1 then
			animation = tonumber(animation)
			isString = false
		end
	end
	
	if extraOptions.AlwaysUseGesture == true then isGesture = true end -- Must play as a gesture
	if extraOptions.AlwaysUseSequence == true then -- Must play as a sequence
		//isGesture = false -- Leave this alone to allow gesture-sequences to play even when "AlwaysUseSequence" is true!
		isSequence = true
		if isnumber(animation) then -- If it's an activity, then convert it to a string
			animation = self:GetSequenceName(self:SelectWeightedSequence(animation))
		end
	elseif isString && !isSequence then -- Only for regular & gesture strings
		-- If it can be played as an activity, then convert it!
		local result = self:GetSequenceActivity(self:LookupSequence(animation))
		if result == nil or result == -1 then -- Leave it as string
			isSequence = true
		else -- Set it as an activity
			animation = result
			isString = false
		end
	end
	
	-- If the given animation doesn't exist, then check to see if it does in the weapon translation list
	if VJ.AnimExists(self, animation) == false then
		if !isString then -- If it's an activity then check for possible translation
			-- If it returns the same activity as "animation", then there isn't even a translation for it so don't play any animation =(
			if self:TranslateActivity(animation) == animation then
				return ACT_INVALID, 0, ANIM_TYPE_NONE
			end
		else -- No animation =(
			return ACT_INVALID, 0, ANIM_TYPE_NONE
		end
	end
	
	local animType = ((isGesture and ANIM_TYPE_GESTURE) or isSequence and ANIM_TYPE_SEQUENCE) or ANIM_TYPE_ACTIVITY -- Find the animation type
	local seed = CurTime() -- Seed the current animation, used for animation delaying & on complete check
	self.LastAnimType = animType
	self.LastAnimSeed = seed
	
	local function PlayAct()
		local originalPlaybackRate = self.AnimPlaybackRate
		local customPlaybackRate = extraOptions.PlayBackRate
		local playbackRate = customPlaybackRate or originalPlaybackRate
		self:SetPlaybackRate(playbackRate) -- Call this to change "self.AnimPlaybackRate" so "DecideAnimationLength" can be calculated correctly
		local animTime = self:DecideAnimationLength(animation, false)
		self.AnimPlaybackRate = originalPlaybackRate -- Change it back to the true rate
		local doRealAnimTime = true -- Only for activities, recalculate the animTime after the schedule starts to get the real sequence time, if `lockAnimTime` is NOT set!
		
		if lockAnim then
			if isbool(lockAnimTime) then -- false = Let the base calculate the time
				lockAnimTime = animTime
			else -- Manually calculated
				doRealAnimTime = false
				if !extraOptions.PlayBackRateCalculated then -- Make sure not to calculate the playback rate when it already has!
					lockAnimTime = lockAnimTime / playbackRate
				end
				animTime = lockAnimTime
			end
			
			local curTime = CurTime()
			self.NextChaseTime = curTime + lockAnimTime
			self.NextIdleTime = curTime + lockAnimTime
			self.AnimLockTime = curTime + lockAnimTime
			
			if lockAnim != "LetAttacks" then
				self:StopAttacks(true)
				self.PauseAttacks = true
				timer.Create("attack_pause_reset"..self:EntIndex(), lockAnimTime, 1, function() self.PauseAttacks = false end)
			end
		end
		self.LastAnimSeed = seed -- We need to set it again because self:StopAttacks() above will reset it when it calls to chase enemy!
		
		if isGesture then
			-- If it's an activity gesture AND it's already playing it, then remove it! Fixes same activity gestures bugging out when played right after each other!
			if !isSequence && self:IsPlayingGesture(animation) then
				self:RemoveGesture(animation)
				//self:RemoveAllGestures() -- Disallows the ability to layer multiple gestures!
			end
			local gesture = isSequence and self:AddGestureSequence(self:LookupSequence(animation)) or self:AddGesture(animation)
			//print(gesture)
			if gesture != -1 then
				self:SetLayerPriority(gesture, 1) // 2
				//self:SetLayerWeight(gesture, 1)
				self:SetLayerPlaybackRate(gesture, extraOptions.GesturePlayBackRate or playbackRate * 0.5)
			end
		else -- Sequences & Activities
			local schedule = vj_ai_schedule.New("PlayAnim_"..animation)
			
			-- For humans NPCs, internally the base will set these variables back to true after this function if it's called by weapon attack animations!
			self.WeaponAttackState = VJ.WEP_ATTACK_STATE_NONE
			
			//self:StartEngineTask(ai.GetTaskID("TASK_RESET_ACTIVITY"), 0) //schedule:EngTask("TASK_RESET_ACTIVITY", 0)
			//if self.Dead then schedule:EngTask("TASK_STOP_MOVING", 0) end
			//self:FrameAdvance(0)
			self:TaskComplete()
			self:StopMoving()
			self:ClearSchedule()
			self:ClearGoal()
			
			if isSequence then
				doRealAnimTime = false -- Sequences already have the correct time
				local seqID = self:LookupSequence(animation)
				--
				-- START: Experimental transition system for sequences
				local transitionAnim = self:FindTransitionSequence(self:GetSequence(), seqID) -- Find the transition sequence
				local transitionAnimTime = 0
				if transitionAnim != -1 && seqID != transitionAnim then -- If it exists AND it's not the same as the animation
					transitionAnimTime = self:SequenceDuration(transitionAnim) / playbackRate
					schedule:AddTask("TASK_VJ_PLAY_SEQUENCE", {
						animation = transitionAnim,
						playbackRate = customPlaybackRate or false,
						duration = transitionAnimTime
					})
				end
				-- END: Experimental transition system for sequences
				--
				schedule:AddTask("TASK_VJ_PLAY_SEQUENCE", {
					animation = animation,
					playbackRate = customPlaybackRate or false,
					duration = animTime
				})
				//self:PlaySequence(animation, playbackRate, extraOptions.SequenceDuration != false, dur)
				animTime = animTime + transitionAnimTime -- Adjust the animation time in case we have a transition animation!
			else -- Only if activity
				//self:SetActivity(ACT_RESET)
				schedule:AddTask("TASK_VJ_PLAY_ACTIVITY", {
					animation = animation,
					playbackRate = customPlaybackRate or false,
					duration = doRealAnimTime or animTime
				})
				-- Old engine task animation system
				/*if self.MovementType == VJ_MOVETYPE_AERIAL or self.MovementType == VJ_MOVETYPE_AQUATIC then
					self:ResetIdealActivity(animation)
					//schedule:EngTask("TASK_SET_ACTIVITY", animation) -- To avoid AutoMovement stopping the velocity
				//elseif faceEnemy == true then
					//schedule:EngTask("TASK_PLAY_SEQUENCE_FACE_ENEMY", animation)
				else
					-- Engine's default animation task
					-- REQUIRED FOR TASK_PLAY_SEQUENCE: It fixes animations NOT applying walk frames if the previous animation was the same!
					if self:GetActivity() == animation then
						self:ResetSequenceInfo()
						self:SetSaveValue("sequence", 0)
					end
					schedule:EngTask("TASK_PLAY_SEQUENCE", animation)
				end*/
			end
			schedule.IsPlayActivity = true
			schedule.CanBeInterrupted = !lockAnim
			if (customFunc) then customFunc(schedule, animation) end
			self:StartSchedule(schedule)
			if doRealAnimTime then
				-- Get the calculated duration (Only done in Activity type)
				animTime = self.CurrentTask.TaskData.duration
			end
			if faceEnemy then
				self:SetTurnTarget("Enemy", animTime, false, faceEnemy == "Visible")
			end
		end
		
		-- If it has a OnFinish function, then set the timer to run it when it finishes!
		if (extraOptions.OnFinish) then
			timer.Simple(animTime, function()
				if IsValid(self) && !self.Dead then
					extraOptions.OnFinish(self.LastAnimSeed != seed, animation)
				end
			end)
		end
		return animTime
	end
	
	-- For delay system
	if animDelay > 0 then
		timer.Simple(animDelay, function()
			if IsValid(self) && self.LastAnimSeed == seed then
				PlayAct()
			end
		end)
		return animation, animDelay + self:DecideAnimationLength(animation, false), animType -- Approximation, this may be inaccurate!
	else
		return animation, PlayAct(), animType
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local vecZ20 = Vector(0, 0, 20)
--
function ENT:Controller_Initialize(ply,controlEnt)
    net.Start("VJ_AVP_Predator_Client")
		net.WriteBool(false)
		net.WriteEntity(self)
		net.WriteEntity(ply)
    net.Send(ply)

	local npc = self
	controlEnt.VJC_Player_DrawHUD = false
	controlEnt.VJC_NPC_CanTurn = false
	self.JumpParams.Enabled = false

	function controlEnt:OnThink()
		self.VJCE_NPC:SetMoveVelocity(self.VJCE_NPC:GetMoveVelocity() *2)
		self.VJCE_NPC:SetArrivalSpeed(9999)
		self.VJC_NPC_CanTurn = self.VJC_Camera_Mode == 2
		self.VJC_BullseyeTracking = (self.VJCE_NPC:IsMoving() && !self.VJCE_NPC:GetSprinting()) or self.VJC_Camera_Mode == 2
		if self.VJC_Camera_Mode == 2 then
			self.VJCE_NPC.AttackIdleTime = CurTime() +1.5
		end
	end

	function controlEnt:OnStopControlling()
		net.Start("VJ_AVP_Predator_Client")
			net.WriteBool(true)
			net.WriteEntity(npc)
			net.WriteEntity(ply)
		net.Send(ply)
		if IsValid(npc) then
			npc.JumpParams.Enabled = true
		end
	end

	function controlEnt:Think()
		local ply = self.VJCE_Player
		local npc = self.VJCE_NPC
		local camera = self.VJCE_Camera
		if (!camera:IsValid()) then self:StopControlling() return end
		if !IsValid(ply) /*or ply:KeyDown(IN_USE)*/ or ply:Health() <= 0 or (!ply.VJ_IsControllingNPC) or !IsValid(npc) or (npc:Health() <= 0) then self:StopControlling() return end
		if ply.VJ_IsControllingNPC != true then return end
		local curTime = CurTime()
		if ply.VJ_IsControllingNPC && IsValid(npc) then
			local npcWeapon = npc:GetActiveWeapon()
			self.VJC_NPC_LastPos = npc:GetPos()
			ply:SetPos(self.VJC_NPC_LastPos + vecZ20) -- Set the player's location
			self:SendDataToClient()
			
			-- HUD
			if self.VJC_Player_DrawHUD then
				net.Start("vj_controller_hud")
					net.WriteBool(ply:GetInfoNum("vj_npc_cont_hud", 1) == 1)
					net.WriteFloat(npc:GetMaxHealth())
					net.WriteFloat(npc:Health())
					net.WriteString(npc:GetName())
					net.WriteInt(npc.HasMeleeAttack == true && (((npc.IsAbleToMeleeAttack != true or npc.AttackType == VJ.ATTACK_TYPE_MELEE) and 2) or 1) or 0, 3)
					net.WriteInt(npc.HasRangeAttack == true && (((npc.IsAbleToRangeAttack != true or npc.AttackType == VJ.ATTACK_TYPE_RANGE) and 2) or 1) or 0, 3)
					net.WriteInt(npc.HasLeapAttack == true && (((npc.IsAbleToLeapAttack != true or npc.AttackType == VJ.ATTACK_TYPE_LEAP) and 2) or 1) or 0, 3)
					net.WriteBool(IsValid(npcWeapon))
					net.WriteInt(IsValid(npcWeapon) && npcWeapon:Clip1() or 0, 32)
					net.WriteInt(npc.HasGrenadeAttack == true && ((curTime <= npc.NextThrowGrenadeT and 2) or 1) or 0, 3)
				net.Send(ply)
			end
			
			local wepList = ply:GetWeapons()
			if #wepList > 0 then
				for _, v in ipairs(wepList) do
					if !v.VJBase_IsControllerWeapon then
						ply:StripWeapon(v:GetClass())
					end
				end
			end
	
			local bullseyePos = self.VJCE_Bullseye:GetPos()
			if ply:GetInfoNum("vj_npc_cont_debug", 0) == 1 then
				VJ.DEBUG_TempEnt(ply:GetPos(), self:GetAngles(), Color(0,109,160)) -- Player's position
				VJ.DEBUG_TempEnt(camera:GetPos(), self:GetAngles(), Color(255,200,260)) -- Camera's position
				VJ.DEBUG_TempEnt(bullseyePos, self:GetAngles(), Color(255,0,0)) -- Bullseye's position
			end
			
			self:OnThink()
	
			local canTurn = true
			if npc.Flinching == true or (((npc.CurrentSchedule && !npc.CurrentSchedule.IsPlayActivity) or npc.CurrentSchedule == nil) && npc:GetNavType() == NAV_JUMP) then return end
	
			-- Weapon attack
			if npc.IsVJBaseSNPC_Human == true then
				if IsValid(npcWeapon) && !npc:IsMoving() && npcWeapon.IsVJBaseWeapon == true && ply:KeyDown(IN_ATTACK2) && npc.AttackType == VJ.ATTACK_TYPE_NONE && npc.PauseAttacks == false && npc:GetWeaponState() == VJ.WEP_STATE_READY then
					//npc:SetAngles(Angle(0,math.ApproachAngle(npc:GetAngles().y,ply:GetAimVector():Angle().y,100),0))
					npc:SetTurnTarget(bullseyePos, 0.2)
					canTurn = false
					if VJ.IsCurrentAnim(npc, npc:TranslateActivity(npc.WeaponAttackAnim)) == false && VJ.IsCurrentAnim(npc, npc.AnimTbl_WeaponAttack) == false then
						npc:OnWeaponAttack()
						npc.WeaponAttackAnim = VJ.PICK(npc.AnimTbl_WeaponAttack)
						npc:PlayAnim(npc.WeaponAttackAnim, false, 2, false)
						npc.WeaponAttackState = VJ.WEP_ATTACK_STATE_FIRE_STAND
					end
				end
				if !ply:KeyDown(IN_ATTACK2) then
					npc.WeaponAttackState = VJ.WEP_ATTACK_STATE_NONE
				end
			end
			
			if npc.AttackAnimTime < CurTime() && curTime > npc.NextChaseTime && npc.IsVJBaseSNPC_Tank != true then
				-- Turning
				if !npc:IsMoving() && canTurn && npc.MovementType != VJ_MOVETYPE_PHYSICS && ((npc.IsVJBaseSNPC_Human && npc:GetWeaponState() != VJ.WEP_STATE_RELOADING) or (!npc.IsVJBaseSNPC_Human)) then
					npc:SCHEDULE_IDLE_STAND()
					if self.VJC_NPC_CanTurn == true then
						local turnData = npc.TurnData
						if turnData.Target != self.VJCE_Bullseye then
							npc:SetTurnTarget(self.VJCE_Bullseye, 1)
						elseif npc:GetActivity() == ACT_IDLE && npc:GetIdealActivity() == ACT_IDLE then -- Check both current act AND ideal act because certain activities only change the current act (Ex: UpdateTurnActivity function)
							npc:UpdateTurnActivity()
							if npc:GetIdealActivity() != ACT_IDLE then -- If ideal act is no longer idle, then we have selected a turn activity!
								npc.NextIdleTime = CurTime() + npc:DecideAnimationLength(npc:GetIdealActivity())
							end
						end
					end
					//self.TestLerp = npc:GetAngles().y
					//npc:SetAngles(Angle(0,Lerp(100*FrameTime(),self.TestLerp,ply:GetAimVector():Angle().y),0))
				end
				
				-- Movement
				npc:Controller_Movement(self, ply, bullseyePos)
				
				//if (ply:KeyDown(IN_USE)) then
					//npc:StopMoving()
					//self:StopControlling()
				//end
			end
		end
		self:NextThink(curTime)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:TranslateNavGoal(ent,goal)
	if ent.EntityClass == AVP_ENTITYCLASS_SENTRYGUN then
		local RC = ent.RC
		if IsValid(RC) then
			if self:GetPos():Distance(RC:GetPos()) <= 80 && !self:IsBusy() then
				self:DestroyConsole(RC)
				return
			end
			return RC:GetPos() +RC:GetForward() *50
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DoCountdownAttack()
	self:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK)

	local function Do(t,func)
		timer.Simple(t,function()
			if IsValid(self) then
				func()
			end
		end)
	end

	if self:GetCloaked() then
		self:Camo(false)
		self.NextCloakT = CurTime() +50
	end
	self:PlayAnimation("predator_destruct_start",true,false,false)
	self:SetBodygroup(self:FindBodygroupByName("mask"),0)
	self.TransIdle = ACT_HL2MP_IDLE
	Do(0,function()
		self:PlayAnimation("vjges_predator_" .. (self:GetEquipment() == 5 && "speargun" or "claws") .. "_console_use",false,false,false,0,{AlwaysUseGesture=true,DisableChaseFix=true})
		VJ.EmitSound(self,"cpthazama/avp/predator/console/prd_console_open_01.ogg",70)
		self.SuicideStartFX = VJ.CreateSound(self,"cpthazama/avp/predator/Suicide_Start0" .. math.random(1,2) .. ".ogg",80)
		if self:GetCloaked() then
			self:Camo(false)
			self.NextCloakT = CurTime() +50
		end
	end)
	Do(1.25,function() VJ.EmitSound(self,"cpthazama/avp/predator/console/prd_console_button_press_01.ogg",70) end)
	Do(1.65,function() VJ.EmitSound(self,"cpthazama/avp/predator/console/prd_console_button_press_01.ogg",70) end)
	Do(1.8,function() VJ.EmitSound(self,"cpthazama/avp/predator/console/prd_console_button_press_01.ogg",70) end)
	Do(2.1,function() VJ.EmitSound(self,"cpthazama/avp/predator/console/prd_console_button_press_01.ogg",70) end)
	Do(2.6,function() VJ.EmitSound(self,"cpthazama/avp/predator/console/prd_console_close_01.ogg",70) end)
	Do(3,function()
		if self:GetCloaked() then
			self:Camo(false)
			self.NextCloakT = CurTime() +50
		end
		self.CountdownTimer = CurTime() +30
		ParticleEffectAttach("vj_avp_predator_plasma_charging",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("panel"))
		self.NuclearLoopFX = CreateSound(self,"cpthazama/avp/predator/Suicide_LoopFX.wav")
		self.NuclearLoopFX:SetSoundLevel(60)
		self.NuclearLoopFX:Play()
		sound.EmitHint(SOUND_DANGER, self:GetPos(), 600, 30, self)
	end)
	Do(13,function()
		VJ.STOPSOUND(self.SuicideStartFX)
		self.SuicideFX = VJ.CreateSound(self,"cpthazama/avp/predator/Suicide.ogg",90)
	end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
local bounds = Vector(14,14,75)
local defArmor = Vector(1,1,1)
--
function ENT:Init()
	self:SetVisionMode(0)
	self:SetEquipment(1)
	self:SetStimCount(5)
	self:SetEnergy(200)
	self:SetArmorColor(self.ArmorColor or defArmor)
	self:SetBodygroup(self:FindBodygroupByName("mask"),1)
	self.LastSVVisionMode = 0
	self.NextFindStalkPos = 0
	self.StalkEnemyTime = 0
	self.LastEnemyAllyCount = 0
	self.NextCloakT = CurTime() +1.5
	self.SprintT = 0
	self.NextSprintT = 0
	self.NextHealT = 0
	self.AttackIdleTime = 0
	self.LookForHidingSpotAttempts = 0
	self.NextLookForHidingSpotT = 0
	self.NextRegenEnergyT = 0
	self.AI_IsBlocking = false
	self.IsBlocking = false
	self.BlockAnimTime = 0
	self.AI_BlockTime = 0
	self.SpecialBlockAnimTime = 0
	self.PlasmaHoldTime = 0
	self.PlasmaMaxChargeT = 0
	self.PlasmaFireDelayT = 0
	self.NextSpearGunFireT = 0
	self.ActivatedSelfDestruct = false
	self.TotalBasicAttacks = 0
	self.NextKnockdownT = 0
	
	self:SetBodygroup(self:FindBodygroupByName("equip_mine"),1)
	self:SetBodygroup(self:FindBodygroupByName("equip_disc"),1)
	self:SetBodygroup(self:FindBodygroupByName("equip_spear"),1)
	self:SetBodygroup(self:FindBodygroupByName("equip_speargun"),1)

	self:SetCollisionBounds(bounds,Vector(-bounds.x,-bounds.y,0))
	self:SetSurroundingBounds(Vector(-bounds.x *1.8,-bounds.y *1.8,-bounds.z *1.8),Vector(bounds.x *1.8,bounds.y *1.8,bounds.z *1.8))
	self.AlertedIdle = toSeq(self,"predator_claws_ai_idle")
	self.AttackIdle = toSeq(self,"predator_claws_idle_aim")

	if self.OnInit then
		self:OnInit()
	end

    for attName, var in pairs(self.FootData) do
        var.AttID = self:LookupAttachment(attName)
    end

	timer.Simple(0,function()
		if IsValid(self) && (self.SpawnedUsingMutator or GetConVar("vj_avp_predmobile"):GetBool()) then
			-- local ply = self:GetCreator()
			-- if game.SinglePlayer() then
			-- 	ply = Entity(1)
			-- end
			-- if !self.SpawnedUsingMutator && IsValid(ply) && IsValid(ply:GetActiveWeapon()) && ply:GetActiveWeapon():GetClass() == "weapon_vj_controller" then
			-- 	local SpawnControllerObject = ents.Create("obj_vj_controller")
			-- 	SpawnControllerObject.VJCE_Player = ply
			-- 	SpawnControllerObject:SetControlledNPC(self)
			-- 	SpawnControllerObject:Spawn()
			-- 	SpawnControllerObject:StartControlling()
			-- end
			local tr = util.TraceHull({
				start = self:GetPos(),
				endpos = self:GetPos() +self:GetUp() *32000,
				filter = {self},
				mins = self:OBBMins(),
				maxs = self:OBBMaxs()
			})
			if tr.HitSky then
				self:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK)
				self:AddFlags(FL_NOTARGET)
				self.EnemyDetection = false
				local predmobile = ents.Create("sent_vj_avp_predmobile")
				predmobile:SetPos(self:GetPos())
				predmobile:SetAngles(self:GetAngles())
				predmobile:Spawn()
				predmobile:SetOwner(self)
				predmobile:ResetSequence("predator_intro")
				self.PredShip = predmobile
				self:DeleteOnRemove(predmobile)
				self:PlayAnimation("predator_intro",true,false,false,0,{OnFinish=function()
					self.EnemyDetection = true
					self:SetState()
					self:RemoveFlags(FL_NOTARGET)
					SafeRemoveEntity(predmobile)
				end})
			end
		end
	end)

	hook.Add("PlayerButtonDown", self, function(self, ply, button)
		if ply.VJ_IsControllingNPC == true && IsValid(ply.VJ_TheControllerEntity) then
			local cent = ply.VJ_TheControllerEntity
            if cent.VJCE_NPC == self then
                cent.VJCE_NPC:OnKeyPressed(ply,button)
            end
        end
    end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
local orgIsBusy = ENT.IsBusy
--
function ENT:IsBusy()
	return orgIsBusy(self) or self.ActivatedSelfDestruct
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:ChangeEquipment(equip)
	local ply = self.VJ_TheController
	if equip == 1 then
		self:SetEquipment(1)
		self:SetPoseParameter("speargun_pitch",0)
		self:SetPoseParameter("speargun_yaw",0)
		self:SetBodygroup(self:FindBodygroupByName("equip_speargun"),1)
		SafeRemoveEntity(self.SpearGun)
		if !self:IsBusy() then
			self:PlayAnimation("vjges_predator_" .. (self:GetEquipment() == 5 && "speargun" or "claws") .. "_console_use",false,false,false,0,{AlwaysUseGesture=true})
			self.NextChaseTime = 0
		end
		self:SetEquipmentShowTime(CurTime() +1.5)
		VJ_AVP_CSound(ply,"cpthazama/avp/shared/console_button_beep_01.ogg")
		self.PoseParameterLooking_Names = {pitch={"aim_pitch"}, yaw={"aim_yaw"}, roll={}}
	elseif equip == 2 then
		self:SetEquipment(2)
		self:SetPoseParameter("speargun_pitch",0)
		self:SetPoseParameter("speargun_yaw",0)
		self:SetBodygroup(self:FindBodygroupByName("equip_speargun"),1)
		SafeRemoveEntity(self.SpearGun)
		if !self:IsBusy() then
			self:PlayAnimation("vjges_predator_" .. (self:GetEquipment() == 5 && "speargun" or "claws") .. "_console_use",false,false,false,0,{AlwaysUseGesture=true})
			self.NextChaseTime = 0
		end
		self:SetEquipmentShowTime(CurTime() +1.5)
		VJ_AVP_CSound(ply,"cpthazama/avp/shared/console_button_beep_01.ogg")
		self.PoseParameterLooking_Names = {pitch={"aim_pitch"}, yaw={"aim_yaw"}, roll={}}
	elseif equip == 3 then
		self:SetEquipment(3)
		self:SetPoseParameter("speargun_pitch",0)
		self:SetPoseParameter("speargun_yaw",0)
		self:SetBodygroup(self:FindBodygroupByName("equip_speargun"),1)
		SafeRemoveEntity(self.SpearGun)
		if !self:IsBusy() then
			self:PlayAnimation("vjges_predator_" .. (self:GetEquipment() == 5 && "speargun" or "claws") .. "_console_use",false,false,false,0,{AlwaysUseGesture=true})
			self.NextChaseTime = 0
		end
		self:SetEquipmentShowTime(CurTime() +1.5)
		VJ_AVP_CSound(ply,"cpthazama/avp/shared/console_button_beep_01.ogg")
		self.PoseParameterLooking_Names = {pitch={"aim_pitch"}, yaw={"aim_yaw"}, roll={}}
	elseif equip == 4 then
		self:SetEquipment(4)
		self:SetPoseParameter("speargun_pitch",0)
		self:SetPoseParameter("speargun_yaw",0)
		self:SetBodygroup(self:FindBodygroupByName("equip_speargun"),1)
		SafeRemoveEntity(self.SpearGun)
		if !self:IsBusy() then
			self:PlayAnimation("vjges_predator_" .. (self:GetEquipment() == 5 && "speargun" or "claws") .. "_console_use",false,false,false,0,{AlwaysUseGesture=true})
			self.NextChaseTime = 0
		end
		self:SetEquipmentShowTime(CurTime() +1.5)
		VJ_AVP_CSound(ply,"cpthazama/avp/shared/console_button_beep_01.ogg")
		self.PoseParameterLooking_Names = {pitch={"aim_pitch"}, yaw={"aim_yaw"}, roll={}}
	elseif equip == 5 then
		self:SetEquipment(5)
		self:SetBodygroup(self:FindBodygroupByName("equip_speargun"),0)
		local att = self:GetAttachment(self:LookupAttachment("Speargun"))
		local speargun = ents.Create("prop_vj_animatable")
		speargun:SetModel("models/cpthazama/avp/predators/equipment/speargun.mdl")
		speargun:SetPos(att.Pos)
		speargun:SetAngles(att.Ang)
		speargun:SetOwner(self)
		speargun:Spawn()
		speargun:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
		speargun:SetSolid(SOLID_NONE)
		speargun:SetParent(self)
		speargun:AddEffects(bit.bor(EF_BONEMERGE,EF_PARENT_ANIMATES))
		self:DeleteOnRemove(speargun)
		self.SpearGun = speargun
		if !self:IsBusy() then
			local _,dir = self:PlayAnimation("vjges_predator_" .. (self:GetEquipment() == 5 && "speargun" or "claws") .. "_console_use",false,false,false,0,{AlwaysUseGesture=true,VMAnim = "predator_hud_speargun_extend"})
			self.NextChaseTime = 0
			self.NextSpearGunFireT = CurTime() +dir +0.2
		end
		self:SetEquipmentShowTime(CurTime() +1.5)
		VJ_AVP_CSound(ply,"cpthazama/avp/shared/console_button_beep_01.ogg")
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SapBattery(ent)
	local _,animDur = self:PlayAnimation("Predator_Battery_Interaction",true,false,false,0,{OnFinish=function()
		self.BatteryEnt = nil
	end})
	if self:GetCloaked() then
		self:Camo(false)
		self.NextCloakT = CurTime() +animDur
	end
	self:SetTurnTarget(ent,1,true)
	self.BatteryEnt = ent
	self:SetPos(ent:GetPos() +ent:GetForward() *50 +ent:GetUp() *6)
	self:SetAngles(Angle(0,(ent:GetPos() -self:GetPos()):Angle().y,0))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DestroyConsole(ent)
	local _,animDur = self:PlayAnimation("Predator_Disable_Interaction",true,false,false,0,{OnFinish=function()
		self.ConsoleEnt = nil
	end})
	if self:GetCloaked() then
		self:Camo(false)
		self.NextCloakT = CurTime() +animDur
	end
	self:SetTurnTarget(ent,1,true)
	self.ConsoleEnt = ent
	self:SetPos(ent:GetPos() +ent:GetForward() *50 +ent:GetUp() *6)
	self:SetAngles(Angle(0,(ent:GetPos() -self:GetPos()):Angle().y,0))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnKeyPressed(ply,key)
	-- print("----------------------------------")
	-- print(key)
	-- for k, v in pairs(_G) do
	-- 	if isnumber(v) && v == key && string.StartWith(k,"KEY_") then
	-- 		Entity(1):ChatPrint(k)
	-- 		break
	-- 	end
	-- end
    if key == KEY_E then
		local tr = util.TraceLine({
			start = self:EyePos(),
			endpos = self:EyePos() +ply:GetAimVector() *125,
			filter = {self,ply}
		})
		local ent = tr.Entity
		if tr.Hit && IsValid(ent) then
			if !ent:IsNPC() && !ent:IsPlayer() then
				if ent:GetClass() == "sent_vj_avp_battery" && ent.BatteryLife > 0 && self:GetEnergy() < 200 && !self:IsBusy() then
					self:SapBattery(ent)
					return
				elseif ent:GetClass() == "sent_vj_avp_controller" && !self:IsBusy() then
					self:DestroyConsole(ent)
					return
				end
				ent:Fire("Use",nil,0,ply,self)
				return
			end
			if ent:IsNPC() && self.EnemyData.DistanceNearest <= self.AttackDistance && self.CanAttack && !self:IsBusy() then
				local canUse, inFront = self:CanUseFatality(ent)
				if canUse then
					self:DoFatality(ent,inFront)
					return
				end
			end
		end
		self.DistractT = self.DistractT or 0
		if CurTime() < self.DistractT or self:IsBusy() then return end
		local tr = util.TraceHull({
			start = self:EyePos(),
			endpos = self:EyePos() +ply:GetAimVector() *6000,
			filter = {self,ply,self.VJ_TheControllerBullseye,ply:GetViewModel(),ply:GetActiveWeapon()},
			mins = Vector(-10,-10,-10),
			maxs = Vector(10,10,10)
		})
		if tr.Hit && IsValid(tr.Entity) then
			local ent = tr.Entity
			if (ent:IsNPC() or ent:IsPlayer()) && self:CheckRelationship(ent) == D_HT then
				self:DistractionCode(ent)
			end
		end
    elseif key == KEY_G then
		if self:Health() < self:GetMaxHealth() && self:GetStimCount() > 0 && CurTime() > self.NextHealT then
			self:UseStimpack()
			self.NextHealT = CurTime() +3
		end
	elseif key == KEY_SPACE && !self:IsBusy() then
		local ply = self.VJ_TheController
		if IsValid(ply) && ply:KeyDown(IN_SPEED) or self:GetNavType() != NAV_GROUND then return end

		local moving = self:IsMoving()
		local ang = ply:EyeAngles()
		ang:RotateAroundAxis(ang:Up(), moveAng.y)
		self:SetGroundEntity(NULL)
		self:StopCurrentSchedule()
		local jumpPos
		if moving then
			jumpPos = self:GetPos() +ang:Forward() *1 +ang:Up() *1
		else
			jumpPos = self:GetPos() +ang:Up() *1
		end
		local trajectory = VJ.CalculateTrajectory(self,nil,"CurveOld",self:GetPos(),jumpPos,moving && 500 or 400)
		self:ForceMoveJump(trajectory)
    elseif key == KEY_1 then
		self:ChangeEquipment(1)
	elseif key == KEY_2 then
		self:ChangeEquipment(2)
	elseif key == KEY_3 then
		self:ChangeEquipment(3)
	elseif key == KEY_4 then
		self:ChangeEquipment(4)
	elseif key == KEY_5 then
		self:ChangeEquipment(5)
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GetMovementDirection()
	local ply = self.VJ_TheController
	if !IsValid(ply) then return end

	local key_forward = ply:KeyDown(IN_FORWARD)
	local key_back = ply:KeyDown(IN_BACK)
	local key_left = ply:KeyDown(IN_MOVELEFT)
	local key_right = ply:KeyDown(IN_MOVERIGHT)

	local rot = Angle()
	if key_forward then
		if key_left then
			rot = Angle(0,45,0)
		elseif key_right then
			rot = Angle(0,-45,0)
		end
	elseif key_back then
		if key_left then
			rot = Angle(0,135,0)
		elseif key_right then
			rot = Angle(0,-135,0)
		else
			rot = Angle(0,180,0)
		end
	elseif key_left then
		rot = Angle(0,90,0)
	elseif key_right then
		rot = Angle(0,-90,0)
	end

	return rot:Forward(), rot
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GetFatalityOffset(ent)
	local offset = (self:OBBMaxs().y +ent:OBBMaxs().y) *2
	if ent.VJ_AVP_Xenomorph then
		offset = (self:OBBMaxs().y +ent:OBBMaxs().y) *1
	elseif ent.VJ_AVP_Predator then
		offset = 1
	elseif ent.VJ_AVP_Marine then
		offset = 0
	end
	return offset
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnFatality(ent,inFront,willCounter,fType)
	if !willCounter then
		self:SetBodygroup(self:FindBodygroupByName("mask"),0)
	end
	if self:GetCloaked() then
		self:Camo(false)
		self.NextCloakT = CurTime() +50
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:FireSpearGun()
	if self.InFatality or self.DoingFatality then return end
	if !self.CanAttack or CurTime() < self.NextSpearGunFireT or self:GetSprinting() or self:GetEnergy() < 10 then return end
	self.AttackIdleTime = CurTime() +VJ.AnimDuration(self,"predator_speargun_fire") +5
	self:PlayAnimation("vjges_predator_speargun_fire",true,false,true,0,{AlwaysUseGesture=true})
	self.NextSpearGunFireT = CurTime() +1
	self.NextChaseTime = 0

	local speargun = self.SpearGun
	if !IsValid(speargun) then return end

	local att = speargun:GetAttachment(1)
	local bSpread = 30
	local targetPos = IsValid(self:GetEnemy()) && (self:GetEnemy():GetPos() +self:GetEnemy():OBBCenter()) or self:EyePos() +self:GetForward() *4000

	sound.Play("cpthazama/avp/predator/Speargun_Fire0" .. math.random(1,4) .. ".ogg",att.Pos,85)

	local bullet = {}
	bullet.Num = 1
	bullet.Src = att.Pos
	bullet.Dir = (targetPos -att.Pos):GetNormalized() *4000
	bullet.Spread = Vector(math.random(-bSpread,bSpread),math.random(-bSpread,bSpread),math.random(-bSpread,bSpread))
	bullet.Tracer = 1
	bullet.TracerName = "VJ_AVP_Speargun"
	bullet.Force = 25
	bullet.Damage = 65
	bullet.AmmoType = "AR2"
	bullet.Callback = function(attacker,tr,dmginfo)
		util.ScreenShake(tr.HitPos,16,100,0.2,50)
		dmginfo:SetDamageType(bit.bor(DMG_BULLET,DMG_SNIPER,DMG_SHOCK))
	end
	self:FireBullets(bullet)
	
	local FireLight1 = ents.Create("light_dynamic")
	FireLight1:SetKeyValue("brightness","4")
	FireLight1:SetKeyValue("distance","125")
	FireLight1:SetPos(att.Pos)
	FireLight1:SetLocalAngles(self:GetAngles())
	FireLight1:Fire("Color","255 0 0")
	FireLight1:SetParent(self)
	FireLight1:Spawn()
	FireLight1:Activate()
	FireLight1:Fire("TurnOn","",0)
	FireLight1:Fire("Kill","",0.07)
	self:DeleteOnRemove(FireLight1)

	self:SetEnergy(math.Clamp(self:GetEnergy() -10,0,200))
	self:SetCloakDisruptTime(CurTime() +1.5)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomAttack(ent,vis)
	if self.InFatality or self.DoingFatality then return end
	local equipment = self:GetEquipment()
	local cont = self.VJ_TheController
	local dist = self.EnemyData.DistanceNearest
	local doingBlock = IsValid(cont) && (cont:KeyDown(IN_ATTACK) && cont:KeyDown(IN_ATTACK2)) or !IsValid(cont) && self.AI_IsBlocking
	if CurTime() < self.SpecialBlockAnimTime or equipment == 5 or self:IsBusy() then
		doingBlock = false
	end
	if !doingBlock && self.IsBlocking then
		self.IsBlocking = false
	elseif doingBlock && !self.IsBlocking then
		self.IsBlocking = true
	end
	if IsValid(cont) then
		if VJ_AVP_PREDINFO_ENABLED then
			local target = ent
			local tr = util.TraceHull({
				start = self:EyePos(),
				endpos = self:EyePos() +cont:GetAimVector() *2048,
				filter = {self,cont},
				mins = Vector(-5,-5,-5),
				maxs = Vector(5,5,5),
				mask = MASK_SHOT
			})
			target = tr.Entity
			VJ_AVP_PredatorHUD_Transmit(target,cont)
			self:SetLookEntity(target)
		end
		self.LookForHidingSpot = false
		if doingBlock then return end
		if equipment == 5 then
			if cont:KeyDown(IN_ATTACK) && !self:IsBusy() then
				self:FireSpearGun()
			elseif !cont:KeyDown(IN_ATTACK) && cont:KeyDown(IN_SPEED) && cont:KeyDown(IN_JUMP) && !self:IsBusy() then
				self:LongJumpCode()
			end
			return
		end
		if cont:KeyDown(IN_ATTACK) && !cont:KeyDown(IN_ATTACK2) && !self:IsBusy() then
			if cont:KeyDown(IN_SPEED) then
				self:LongJumpCode(nil,true)
			else
				self:AttackCode()
			end
		elseif !cont:KeyDown(IN_ATTACK) && cont:KeyDown(IN_ATTACK2) && !self:IsBusy() then
			self:HeavyAttackCode()
		elseif !doingBlock && cont:KeyDown(IN_SPEED) && cont:KeyDown(IN_JUMP) && !self:IsBusy() then
			self:LongJumpCode()
		elseif !doingBlock && !cont:KeyDown(IN_JUMP) && !cont:KeyDown(IN_SPEED) && cont:KeyDown(IN_DUCK) && !self:IsBusy() then
			self:SpecialAttackCode(self:GetEquipment())
		end
	else
		if self.LookForHidingSpot then return end
		if equipment == 5 then
			if dist <= 2500 && !self:IsBusy() && vis then
				if dist <= 300 then
					self:ChangeEquipment(1)
					return
				end
				-- if !self.DisableChasingEnemy then
				-- 	self.DisableChasingEnemy = true
				-- end
				-- self:StopMoving()
				self:FireSpearGun()
			elseif !doingBlock && vis && self.DisableChasingEnemy && self:GetCloaked() && math.random(1,100) == 1 then
				self:DistractionCode(ent)
			elseif !doingBlock && vis && dist > 200 && dist <= 2500 && !self:IsBusy() && math.random(1,self.DisableChasingEnemy && 100 or 45) == 1 then
				self:ChangeEquipment(1)
				self:SpecialAttackCode(1)
			elseif !doingBlock && vis && dist > 200 && dist <= 1250 && !self:IsBusy() && math.random(1,self.DisableChasingEnemy && 600 or 40) == 1 then
				self:ChangeEquipment(3)
				self:SpecialAttackCode(3)
			elseif !doingBlock && vis && dist > 200 && dist <= 1500 && !self:IsBusy() && math.random(1,self.DisableChasingEnemy && 80 or 35) == 1 then
				self:ChangeEquipment(4)
				self:SpecialAttackCode(4)
			end
		else
			if self.AI_IsBlocking && CurTime() > self.AI_BlockTime then
				self.AI_IsBlocking = false
				self.IsBlocking = false
				return
			end
			if ent.EntityClass == AVP_ENTITYCLASS_SENTRYGUN then
				-- local RC = ent.RC
				-- local RCDist = self:GetPos():Distance(RC:GetPos())
				-- if IsValid(RC) then
				-- 	self.NextRCMoveT = self.NextRCMoveT or 0
				-- 	self:SetLastPosition(RC:GetPos() +RC:GetForward() *50)
				-- 	if CurTime() > self.NextRCMoveT then
				-- 		self:SCHEDULE_GOTO_POSITION("TASK_RUN_PATH",function(x)
				-- 			x.CanShootWhenMoving = true
				-- 			x.ConstantlyFaceEnemyVisible = true
				-- 		end)
				-- 		self.NextRCMoveT = CurTime() +6
				-- 	end
				-- 	if RCDist <= 80 && RCDist < ent:GetPos():Distance(self:GetPos()) && !self:IsBusy() then
				-- 		self:DestroyConsole(RC)
				-- 	end
				-- end
				return
			end
			if dist <= self.AttackDistance && !self:IsBusy() && !doingBlock && vis then
				local canUse, inFront = self:CanUseFatality(ent)
				if canUse && (inFront && math.random(1,2) == 1 or !inFront) then
					if self:DoFatality(ent,inFront) == false then
						self:AttackCode()
					end
				else
					if !self.AI_IsBlocking && (!ent.IsVJBaseSNPC && (string_find(ent:GetSequenceName(ent:GetSequence()),"attack") or math.random(1,3) == 1) or ent.IsVJBaseSNPC && ent.AttackType == VJ.ATTACK_TYPE_MELEE && ent.AttackState == VJ.ATTACK_STATE_STARTED) && math.random(1,2) == 1 then
						self.AI_IsBlocking = true
						self.AI_BlockTime = CurTime() +math.Rand(2,4)
						return
					else
						if math.random(1,6) == 1 && self.TotalBasicAttacks > 2 then
							self:HeavyAttackCode()
						else
							self:AttackCode()
						end
					end
				end
			elseif !doingBlock && vis && self.DisableChasingEnemy && self:GetCloaked() && math.random(1,100) == 1 then
				self:DistractionCode(ent)
			elseif !doingBlock && vis && dist > 200 && dist <= 2500 && !self:IsBusy() && math.random(1,self.DisableChasingEnemy && 100 or 45) == 1 then
				self:ChangeEquipment(1)
				self:SpecialAttackCode(1)
			elseif !doingBlock && vis && dist > 200 && dist <= 1250 && !self:IsBusy() && math.random(1,self.DisableChasingEnemy && 600 or 40) == 1 then
				self:ChangeEquipment(3)
				self:SpecialAttackCode(3)
			elseif !doingBlock && vis && dist > 200 && dist <= 1500 && !self:IsBusy() && math.random(1,self.DisableChasingEnemy && 80 or 35) == 1 then
				self:ChangeEquipment(4)
				self:SpecialAttackCode(4)
			-- elseif self.DisableChasingEnemy && !doingBlock && vis && dist > 1000 && dist <= 4000 && !self:IsBusy() && math.random(1,600) == 1 then
				-- self:ChangeEquipment(5)
				-- self:SpecialAttackCode(5)
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
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:HeavyAttackCode()
	if self.InFatality or self.DoingFatality then return end
	if self:IsBusy() then return end
	self:PlaySound(self.SoundTbl_Attack,78)
	self.TotalBasicAttacks = 0
	self:PlayAnimation("predator_claws_attack_heavy_buildup",true,false,true,0,{OnFinish=function(i)
		if i then return end
		self:PlayAnimation("predator_claws_attack_heavy_hit_close",true,false,false)
	end})
end
---------------------------------------------------------------------------------------------------------------------------------------------
local math_ceiling = math.ceil
--
function ENT:FirePlasmaCaster()
	if self.PlasmaHoldTime <= 1 then
		self.PlasmaHoldTime = 1
	end
	local amount = math_ceiling(self.PlasmaHoldTime *10)
	self:StopParticles()
	self.PlasmaMaxChargeT = 0
	self.LastSpecialAttackID = 0
	if self:GetEnergy() >= amount then
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
			proj:SetAttackType(2,amount *3,DMG_BLAST,300,45,true)
			proj:SetNoDraw(true)
			proj:Spawn()
			-- proj.SoundTbl_Idle = {"weapons/rpg/rocket1.wav"}
			proj.CollisionDecal = {"Scorch"}
			proj.OnDeath = function(projEnt,data, defAng, HitPos)
				ParticleEffect(amount <= 20 && "vj_avp_predator_plasma_impact_light" or "vj_avp_predator_plasma_impact",HitPos,defAng)
				sound.Play("cpthazama/avp/weapons/predator/plasma_caster/plasma_bolt_explosion_0" .. math.random(1,5) .. ".ogg",HitPos,90)
			end
			proj:AddSound("cpthazama/avp/predator/adrenalin/adrenalin_loop.wav",65)
			ParticleEffectAttach("vj_avp_predator_plasma_proj",PATTACH_POINT_FOLLOW,proj,0)

			local phys = proj:GetPhysicsObject()
			if IsValid(phys) then
				local maxSpeedPercentage = 1 -(self.PlasmaHoldTime /4)
				phys:SetVelocity(proj:GetForward() *(2000 +(2000 *maxSpeedPercentage)))
			end

			if amount <= 20 then
				VJ.EmitSound(self,"cpthazama/avp/weapons/predator/plasma_caster/plasma_x_impact.ogg",80,100)
				VJ.EmitSound(self,"cpthazama/avp/weapons/predator/plasma_caster/plasma_x_fire" .. math.random(1,3) .. ".ogg",110 -(amount /2))
			else
				VJ.EmitSound(self,"cpthazama/avp/weapons/predator/plasma_caster/plasma_caster_shot_0" .. math.random(1,3) .. ".ogg",85,110 -(amount /4))
			end
		end
		self:SetEnergy(self:GetEnergy() -amount)
		self.NextRegenEnergyT = CurTime() +5
		ParticleEffect("vj_avp_predator_plasma_fire",self:GetAttachment(self:LookupAttachment("plasma")).Pos,self:GetAngles())
	else
		VJ.EmitSound(self,"cpthazama/avp/weapons/predator/plasma_caster/plasma_caster_no_energy_01.ogg",70)
	end
	-- self:SetPoseParameter("plasma_pitch",0)
	-- self:SetPoseParameter("plasma_yaw",0)
	-- self.PoseParameterLooking_Names = {pitch={"aim_pitch"}, yaw={"aim_yaw"}, roll={}}
	-- self:PlayAnimation("vjges_predator_plasma_caster_retract",true,false,false,0,{AlwaysUseGesture=true,OnFinish=function(interrupted)
		-- self:SetBeam(false)
	-- end})
	self.PlasmaHoldTime = 0
	self.PlasmaFireDelayT = CurTime() +0.51
	timer.Simple(0.5,function()
		if IsValid(self) && self.LastSpecialAttackID == 0 then
			self:SetBeam(false)
		end
	end)
	self.NextChaseTime = 0
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SpecialAttackCode(atk)
	if self.InFatality or self.DoingFatality or IsValid(self:GetDisc()) then return end
	local atk = atk or 1
	self.LastSpecialAttackID = atk
	if atk == 1 && CurTime() > self.PlasmaFireDelayT && !self:GetBeam() then
		self:SetBeam(true)
		-- self.PoseParameterLooking_Names = {pitch={"aim_pitch","plasma_pitch"}, yaw={"aim_yaw","plasma_yaw"}, roll={}}
		-- ParticleEffectAttach("vj_avp_predator_plasma_charge",PATTACH_POINT_FOLLOW,self,1)
		ParticleEffectAttach("vj_avp_predator_plasma_charging",PATTACH_POINT_FOLLOW,self,1)
		VJ.EmitSound(self,"cpthazama/avp/weapons/predator/plasma_caster/plasma_caster_charge_05.ogg",80)
		-- local _,dur = self:PlayAnimation("vjges_predator_plasma_caster_extend",true,false,true,0,{AlwaysUseGesture=true,OnFinish=function(interrupted)
		-- 	if interrupted then self:SetBeam(false) self.PoseParameterLooking_Names = {pitch={"aim_pitch"}, yaw={"aim_yaw"}, roll={}} return end
		-- 	if !IsValid(self.VJ_TheController) then
		-- 		self:FirePlasmaCaster()
		-- 	end
		-- end})
		self.PlasmaFireDelayT = CurTime() +0.1
		if !IsValid(self.VJ_TheController) then
			timer.Simple(1,function()
				if IsValid(self) && !IsValid(self.VJ_TheController) then
					self:FirePlasmaCaster()
				end
			end)
			self.PlasmaHoldTime = math.Rand(1,4)
		end
		-- self.PlasmaMaxChargeT = CurTime() +dur
		self.NextChaseTime = 0
	elseif atk == 2 then
		local att = self:GetAttachment(self:LookupAttachment("Pred_Mine"))
		local mine = ents.Create("prop_vj_animatable")
		mine:SetModel("models/cpthazama/avp/predators/equipment/mine.mdl")
		mine:SetPos(att.Pos)
		mine:SetAngles(att.Ang)
		mine:SetOwner(self)
		mine:Spawn()
		mine:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
		mine:SetSolid(SOLID_NONE)
		mine:SetParent(self)
		mine:AddEffects(bit.bor(EF_BONEMERGE,EF_PARENT_ANIMATES))
		self:DeleteOnRemove(mine)
		self.Mine = mine
		-- local _,dur = self:PlayAnimation("vjges_predator_mine_throw",true,false,true,0,{AlwaysUseGesture=true,OnFinish=function(interrupted)
		-- 	SafeRemoveEntity(self.Mine)
		-- end})
		local mineDur = VJ.AnimDuration(self,"predator_mine_fire_into") +VJ.AnimDuration(self,"predator_mine_fire_loop") +VJ.AnimDuration(self,"predator_mine_fire_out")
		self:PlayAnimation("predator_mine_fire_into",true,false,true,0,{AlwaysUseGesture=true,OnFinish=function(interrupted,anim)
			if self.LastActivity != anim then return end
			self:PlayAnimation("predator_mine_fire_loop",true,false,true,0,{AlwaysUseGesture=true,OnFinish=function(interrupted,anim)
				if self.LastActivity != anim then return end
				self:PlayAnimation("predator_mine_fire_out",true,false,true,0,{AlwaysUseGesture=true})
			end})
		end})
		SafeRemoveEntityDelayed(self.Mine,mineDur)
		self.NextChaseTime = 0
		self:SetBodygroup(self:FindBodygroupByName("equip_mine"),0)
	elseif atk == 3 then
		self:SetBeam(true)
		self:PlayAnimation("vjges_predator_battledisc_extend",true,false,true,0,{AlwaysUseGesture=true,OnFinish=function(interrupted,anim)
			if self.LastActivity != anim then self:SetBeam(false) SafeRemoveEntity(self.Disc) return end
			local _,dur = self:PlayAnimation("vjges_predator_battledisc_throw",true,false,true,0,{AlwaysUseGesture=true,OnFinish=function(interrupted)
				SafeRemoveEntity(self.Disc)
			end})
			SafeRemoveEntityDelayed(self.Disc,dur)
			self.NextChaseTime = 0
		end})
		self.NextChaseTime = 0
	elseif atk == 4 then
		if IsValid(self:GetSpear()) then return end -- If we've already thrown the spear, go get it back or you can't use this attack!
		local att = self:GetAttachment(self:LookupAttachment("spear"))
		local spear = ents.Create("prop_vj_animatable")
		spear:SetModel("models/cpthazama/avp/predators/equipment/spear.mdl")
		spear:SetPos(att.Pos)
		spear:SetAngles(att.Ang)
		spear:SetOwner(self)
		spear:Spawn()
		spear:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
		spear:SetSolid(SOLID_NONE)
		spear:SetParent(self)
		spear:AddEffects(bit.bor(EF_BONEMERGE,EF_PARENT_ANIMATES))
		self:DeleteOnRemove(spear)
		self.SpearProp = spear
		VJ.EmitSound(self.SpearProp,"cpthazama/avp/weapons/predator/spear/prd_spear_draw.ogg",72)
		self:PlayAnimation("vjges_predator_spear_extend",true,false,true,0,{AlwaysUseGesture=true,OnFinish=function(interrupted,anim)
			if self.LastActivity != anim then SafeRemoveEntity(spear) return end
			local _,dur = self:PlayAnimation("vjges_predator_spear_2nd_throw",true,false,true,0,{AlwaysUseGesture=true,OnFinish=function(interrupted)
				SafeRemoveEntity(spear)
			end})
			SafeRemoveEntityDelayed(spear,dur)
			self.NextChaseTime = 0
		end})
		self:SetBodygroup(self:FindBodygroupByName("equip_spear"),0)
		self.NextChaseTime = 0
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GetViewModel()
	local ply = self.VJ_TheController
	if IsValid(ply) && IsValid(ply.VJ_AVP_ViewModel) then
		return ply.VJ_AVP_ViewModel
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:UseStimpack()
	if self.InFatality or self.DoingFatality then return end
	if self:IsBusy() then return end
	self:PlayAnimation("vjges_predator_" .. (self:GetEquipment() == 5 && "speargun" or "claws") .. "_healthstab",true,false,false)
	self.NextChaseTime = 0
end
---------------------------------------------------------------------------------------------------------------------------------------------
local sdClawFlesh = {
	"cpthazama/avp/weapons/predator/wrist_blades/prd_wrist_impact_flesh_mn_01.ogg",
	"cpthazama/avp/weapons/predator/wrist_blades/prd_wrist_impact_flesh_mn_02.ogg",
	"cpthazama/avp/weapons/predator/wrist_blades/prd_wrist_impact_flesh_mn_03.ogg",
	"cpthazama/avp/weapons/predator/wrist_blades/prd_wrist_blades_hit_alien_01.ogg",
	"cpthazama/avp/weapons/predator/wrist_blades/prd_wrist_blades_hit_alien_02.ogg",
	"cpthazama/avp/weapons/predator/wrist_blades/prd_wrist_blades_hit_alien_03.ogg",
	"cpthazama/avp/weapons/predator/wrist_blades/prd_wrist_blades_hit_alien_04.ogg",
	"cpthazama/avp/weapons/predator/wrist_blades/prd_wrist_blades_hit_alien_05.ogg",
}
local sdClawMiss = {
	"cpthazama/avp/weapons/predator/wrist_blades/prd_wrist_blades_swipe_01.ogg",
	"cpthazama/avp/weapons/predator/wrist_blades/prd_wrist_blades_swipe_02.ogg",
	"cpthazama/avp/weapons/predator/wrist_blades/prd_wrist_blades_swipe_03.ogg",
	"cpthazama/avp/weapons/predator/wrist_blades/prd_wrist_blades_swipe_04.ogg",
	"cpthazama/avp/weapons/predator/wrist_blades/prd_wrist_blades_swipe_05.ogg",
}
--
function ENT:AttackCode()
	if self.InFatality or self.DoingFatality or !self.CanAttack or CurTime() < (self.BlockAttackT or 0) then return end
	self.AttackSide = self.AttackSide == "right" && "left" or "right"
	local side = self.AttackSide
	local anim = VJ.PICK(self.AttackAnimations)
	if anim then
		local start,hit,miss = anim[1],anim[2],anim[3]
		start = string_Replace(start,"[SIDE]",side)
		hit = string_Replace(hit,"[SIDE]",side)
		miss = string_Replace(miss,"[SIDE]",side)
		if side == "left" && string_find(miss,"upper_slash") then // Why the Predator doesn't have a left upper slash miss animation is beyond me...
			miss = hit
		end
		self.TotalBasicAttacks = self.TotalBasicAttacks +1
		local attackTime = CurTime() +VJ.AnimDuration(self,start)
		self.AttackDamageType = DMG_SLASH
		self.AttackIdleTime = CurTime() +attackTime +VJ.AnimDuration(self,hit) +VJ.AnimDuration(self,miss) +1
		self:PlayAnimation(start,true,false,true,0,{AlwaysUseGesture=true,GesturePlayBackRate=1,OnFinish=function(interrupted)
			if self.LastSequence != start then return end
			local hitEnts = self:RunDamageCode()
			if #hitEnts > 0 then
				self:PlayAnimation(hit,true,false,true,0,{AlwaysUseGesture=true,GesturePlayBackRate=1})
				self.NextChaseTime = 0
				VJ.EmitSound(self,sdClawFlesh,75)
			else
				self:PlayAnimation(miss,true,0.15,false,0,{AlwaysUseGesture=true,GesturePlayBackRate=1})
				self.NextChaseTime = 0
				VJ.EmitSound(self,sdClawMiss,75)
			end
		end})
		self.NextChaseTime = 0
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RunDamageCode(mult)
	mult = mult or 1
	mult = mult *(self.AttackDamageMultiplier or 1)
	local hitEnts = VJ.AVP_ApplyRadiusDamage(self,self,self:GetPos() +self:OBBCenter(),self.AttackDamageDistance or 120,(self.AttackDamage or 10) *mult,self.AttackDamageType or DMG_SLASH,true,false,{UseConeDegree=self.MeleeAttackDamageAngleRadius},
	function(ent)
		return ent:IsNPC() or ent:IsPlayer() or ent:IsNextBot() or VJ.IsProp(ent) or ent:GetClass() == "prop_ragdoll"
	end)

	if #hitEnts > 0 then
		self:OnHit(hitEnts)
	end
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

local math_clamp = math.Clamp
--
function ENT:LongJumpCode(gotoPos,atk)
	if self.InFatality or self:IsBusy() or !self:OnGround() then return true end
	local ply = self.VJ_TheController
	local bullseye = self.VJ_TheControllerBullseye
	local aimVec = IsValid(ply) && ply:GetAimVector()
	local tr1
	local canJump = true
	if IsValid(ply) && ply:KeyDown(IN_ATTACK) then
		atk = true
	end
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
	if !atk && self.PredatorLandingPos then
		self.LongJumpPos = self.PredatorLandingPos
		-- print("Landing pos")
	else
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
		self.LongJumpPos = (trSt.HitPos or self.PredatorLandingPos) or firstHit
		-- print("Long Jump pos",self.LongJumpPos)
	end
	-- local startPos = trSt.HitPos +trSt.HitNormal *4
	-- VJ.DEBUG_TempEnt(startPos, self:GetAngles(), Color(13,0,255), 5)
	self.LongJumpAttacking = atk
	local anim
	local dist = self:GetPos():Distance(self.LongJumpPos)
	local height = self:GetPos().z -self.LongJumpPos.z
	local atkAnim = "predator_claws_attack_left_lower_slash_medium"
	if atk then
		local targetPos = IsValid(self:GetEnemy()) && (self:GetEnemy():GetPos() +self:GetEnemy():OBBCenter()) or self.LongJumpPos
		local dir = (targetPos -self:GetPos()):GetNormalized()
		local targetDist = self:EyePos():Distance(targetPos)
		-- if targetDist < 300 then
			-- targetPos.z = self:GetPos().z
			-- dir = (targetPos -self:GetPos()):GetNormalized()
		-- end
		local atkTr = util.TraceHull({
			start = self:EyePos(),
			endpos = self:GetPos() +dir *math_clamp(targetDist,300,2000),
			filter = {self,ply},
			mins = self:OBBMins() /2,
			maxs = self:OBBMaxs() /2
		})
		-- if atkTr.Hit && IsValid(atkTr.Entity) && self:CheckRelationship(atkTr.Entity) == D_HT then
		-- 	self.LongJumpPos = atkTr.HitPos +atkTr.HitNormal *4
		-- end
		self.LongJumpPos = atkTr.HitPos +atkTr.HitNormal *4
		self.AttackSide = self.AttackSide == "right" && "left" or "right"
		local side = self.AttackSide
		local atkType = VJ.PICK({"lower_slash","punch","upper_slash"})
		local atkDistType = dist > 1200 && "long" or "medium"
		local testAnim = "predator_claws_attack_" .. side .. "_" .. atkType .. "_" .. atkDistType
		if VJ.AnimExists(self,testAnim) then
			atkAnim = testAnim
		end
	end
	-- print("Set ",self.LongJumpAttacking)
	local animSetType = (self:GetEquipment() == 5 && "speargun" or "claws")
	if !atk && height < -150 then
		anim = "predator_" .. animSetType .. "_jump_gain_height"
	elseif !atk && height > 150 then
		anim = "predator_" .. animSetType .. "_jump_drop_down"
	else
		if dist > 1500 then
			anim = atk && atkAnim or "predator_" .. animSetType .. "_jump_long"
		elseif dist > 1200 then
			anim = atk && atkAnim or "predator_" .. animSetType .. "_jump_medium"
		elseif dist > 800 then
			anim = atk && atkAnim or "predator_" .. animSetType .. "_jump_shallow"
		else
			anim = atk && atkAnim or "predator_" .. animSetType .. "_jump_short"
		end
	end
	self:SetTurnTarget(self.LongJumpPos, 1)
	self:PlayAnimation(anim,true,false,false)
	self.PredatorLandingPos = nil
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:FindNodesNearPoint(checkPos,total,dist,minDist)
	local nodegraph = table.Copy(VJ_Nodegraph.Data.Nodes)
	local closestNode = NULL
	local closestDist = 999999
	for _,v in pairs(nodegraph) do
		local dist = v.pos:Distance(checkPos)
		if dist < closestDist then
			closestNode = v
			closestDist = dist
		end
	end
	local savedPoints = {}
	for _,v in pairs(nodegraph) do
		if v.pos:Distance(closestNode.pos) <= (dist or 1024) && v.pos:Distance(closestNode.pos) >= (minDist or 0) then
			table.insert(savedPoints,v.pos)
		end
	end
	return #savedPoints > 0 && savedPoints or false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DistractionCode(ent)
	VJ.STOPSOUND(self.CurrentSpeechSound)
	VJ.STOPSOUND(self.CurrentIdleSound)
	if math.random(1,4) == 1 then
		VJ.CreateSound(self,self.SoundTbl_Laugh,90)
		self.DistractT = CurTime() +5
	else
		if ent.VJ_AVP_Xenomorph then return end
		local soundPos = ent:GetPos() +VectorRand() *600
		local findPos = self:FindNodesNearPoint(soundPos,12,768,256)
		if findPos then
			soundPos = VJ.PICK(findPos)
		end
		local soundF = VJ.PICK(self.SoundTbl_Distract)
		self.DistractT = CurTime() +10
		sound.Play(soundF,soundPos,72)
		VJ.EmitSound(self,soundF,65)
		if ent:IsNPC() then
			if ent.IsVJBaseSNPC && !ent:IsBusy() && !ent.Alerted then
				ent:SetLastPosition(soundPos)
				ent:SCHEDULE_GOTO_POSITION("TASK_WALK_PATH",function(x)
					x.CanShootWhenMoving = true
					if ent.OnDistracted then
						x.RunCode_OnFinish = function()
							timer.Simple(0.01, function()
								if IsValid(ent) && !ent:IsBusy() then
									ent:OnDistracted(2)
								end
							end)
						end
					end
				end)

				if ent.OnDistracted then
					ent:OnDistracted(1)
				else
					ent:OnInvestigate(v)
					ent:PlaySoundSystem(#ent.SoundTbl_Investigate > 0 && "Investigate" or "Alert")
				end
			elseif !ent.IsVJBaseSNPC then
				ent:SetLastPosition(soundPos)
				ent:SetSchedule(SCHED_FORCED_GO)
			end
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnFacehugged(facehugger,facehuggerProp,corpse)
	self:SetBodygroup(self:FindBodygroupByName("mask"),0)
	corpse:SetBodygroup(corpse:FindBodygroupByName("mask"),0)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:HandlePerceivedRelationship(v)
	if self:GetCloaked() then
		if self:GetBeam() or v.VJ_AVP_Xenomorph or v.VJ_AVP_Predator then
			return
		end
		local calcMult = ((self:IsMoving() && (self:GetIdealActivity() == ACT_WALK && 0.35 or 1) or 0.15) *(self:GetSprinting() && 3 or 1))
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
function ENT:OnMaintainRelationships(ent, entFri, dist)
	if !entFri && ent == self:GetEnemy() && !ent.VJ_AVP_Predator && !ent.VJ_AVP_Xenomorph then
		local count = 0
		for _, v in ipairs(ents.FindInSphere(ent:GetPos(), 800)) do
			if (ent:IsNPC() && (ent.IsVJBaseSNPC && ent:CheckRelationship(v) == D_LI or !ent.IsVJBaseSNPC && ent:Disposition(v) == D_LI) or ent:IsPlayer() && (v:IsPlayer() or v:IsNPC() && v:Disposition(ent) == D_LI)) && v:Visible(ent) then
				count = count + 1
				if count > 3 then break end
			end
		end
		self.LastEnemyAllyCount = count
		if count >= 3 then
			self.StalkEnemyTime = CurTime() + math.Rand(6,15)
			-- Entity(1):ChatPrint("My enemy has too many friends, stalking!")
		else
			if math.random(1,(self:GetCloaked() or dist > 600) && 1 or 3) == 1 then
				self.StalkEnemyTime = CurTime() + math.Rand(6,15)
				if dist > 600 && !self:IsBusy() && !self:GetCloaked() then
					self:Camo(true)
				end
				-- Entity(1):ChatPrint("Choosing to play it safe by stalking!")
			end
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnInput(key,activator,caller,data)
	-- print(key)
	if key == "jump_start" then
		self:SetJumpPosition(self.LongJumpPos)
		self.LongJumping = true
		VJ.CreateSound(self,self.SoundTbl_Jump,75)
		VJ.EmitSound(self,"cpthazama/avp/predator/jump/prd_jump_force_3rdp_0" .. math.random(1,5) .. ".ogg",70)
		if IsValid(self.VJ_TheController) then
			VJ_AVP_CSound(self.VJ_TheController,"cpthazama/avp/predator/adrenalin/adrenalin_turn_on_0" .. math.random(1,5) .. ".ogg")
		end
	elseif key == "jump_end" then
		self.LongJumping = false
		self:SetJumpPosition(Vector(0,0,0))
		self:SetLocalVelocity(Vector(0,0,0))
		self:SetVelocity(self:GetForward() *150 +Vector(0,0,-100))
		VJ.CreateSound(self,self.SoundTbl_Land,75)
		VJ.EmitSound(self,VJ.PICK({"cpthazama/avp/predator/jump/pred_heavy_land_01.ogg","cpthazama/avp/predator/jump/pred_heavy_land_02.ogg","cpthazama/avp/predator/jump/pred_heavy_land_03.ogg"}),75)
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
			for _ = 1,16 do
				util.Effect("GlassImpact",fx)
			end
		end
	elseif key == "attack" then
		self.AttackDamageType = DMG_SLASH
		VJ.EmitSound(self,#self:RunDamageCode() > 0 && sdClawFlesh or sdClawMiss,75)
	elseif key == "attack_heavy" then
		self.AttackDamageType = bit.bor(DMG_SLASH,DMG_VEHICLE,DMG_SNIPER)
		VJ.EmitSound(self,#self:RunDamageCode(1.75) > 0 && sdClawFlesh or sdClawMiss,75)
	elseif key == "attack_jump" then
		self.AttackDamageType = DMG_SLASH
		VJ.EmitSound(self,#self:RunDamageCode(1.25) > 0 && sdClawFlesh or sdClawMiss,75)
	elseif key == "attack_jump_heavy" then
		self.AttackDamageType = bit.bor(DMG_SLASH,DMG_VEHICLE,DMG_SNIPER)
		VJ.EmitSound(self,#self:RunDamageCode(2) > 0 && sdClawFlesh or sdClawMiss,75)
	elseif key == "stimpack_grab" then
		local stim = ents.Create("prop_vj_animatable")
		stim:SetModel("models/cpthazama/avp/predators/equipment/stim.mdl")
		stim:SetPos(self:GetPos())
		stim:SetAngles(self:GetAngles())
		stim:SetOwner(self)
		stim:Spawn()
		stim:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
		stim:SetSolid(SOLID_NONE)
		stim:SetParent(self)
		stim:AddEffects(bit.bor(EF_BONEMERGE,EF_PARENT_ANIMATES))
		self:DeleteOnRemove(stim)
		self.Stimpack = stim
	elseif key == "stimpack_unscrew" then
		VJ.EmitSound(self,"cpthazama/avp/predator/health/prd_health_twist_01.ogg",70)
	elseif key == "stimpack_unscrewed" then
		VJ.EmitSound(self,"cpthazama/avp/predator/health/prd_health_twist_air_02.ogg",70)
	elseif key == "stimpack_use" then
		self:SetHealth(self:GetMaxHealth())
		self:SetStimCount(self:GetStimCount() -1)
		VJ.EmitSound(self,"cpthazama/avp/predator/health/prd_health_jab_01.ogg",75)
	elseif key == "stimpack_scream" then
		self:PlaySound(self.SoundTbl_Stimpack,100)
	elseif key == "stimpack_drop" then
		SafeRemoveEntity(self.Stimpack)
	elseif key == "mine_charge" then
		VJ.EmitSound(self.Mine or self,"cpthazama/avp/weapons/predator/plasma_caster/plasma_caster_charge_05.ogg",70)
		ParticleEffectAttach("vj_avp_predator_plasma_charge",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("Pred_Mine"))
	elseif key == "mine_beep" then
		VJ.EmitSound(self,"cpthazama/avp/shared/console_button_beep_01.ogg",75)
	elseif key == "mine_done" then
		self:StopParticles()
	elseif key == "mine_throw" then
		SafeRemoveEntity(self.Mine)
		self:SetBodygroup(self:FindBodygroupByName("equip_mine"),1)

		if self:GetEnergy() >= 50 then
			local att = self:GetAttachment(self:LookupAttachment("Pred_Mine"))
			local targetPos = IsValid(self.VJ_TheController) && self:GetEnemy():GetPos() or self:GetPos() +self:GetForward() *225
			local targetAng = (targetPos -att.Pos):Angle()
			local proj = ents.Create("obj_vj_avp_projectile")
			proj.Model = "models/cpthazama/avp/predators/equipment/mine.mdl"
			proj:SetPos(att.Pos)
			proj:SetAngles(targetAng)
			proj:SetOwner(self)
			proj:SetAttackType(2,150,DMG_BLAST,500,45,true)
			proj:SetNoDraw(false)
			proj:Spawn()
			proj:SetTagOwner(self)
			self:DeleteOnRemove(proj)
			proj.CollisionBehavior = VJ.PROJ_COLLISION_PERSIST
			proj.Predator = self
			proj:SetNW2Bool("AVP.IsTech",true)
			proj.VJ_AVP_IsTech = true
			proj:DrawShadow(true)
			proj.Trail = util.SpriteTrail(proj,0,Color(255,55,55),true,40,1,0.15,1 /(10 +1) *0.5,"VJ_Base/sprites/trail.vmt")
			-- proj.SoundTbl_Idle = {"weapons/rpg/rocket1.wav"}
			proj.CollisionDecal = {"Scorch"}
			proj.OnThink = function(projEnt)
				if !IsValid(projEnt.Predator) && !projEnt.Dead then
					projEnt:Remove()
					return
				end
				if !projEnt.IsArmed then return end
				for _,v in pairs(ents.FindInSphere(projEnt:GetPos(),250)) do
					if projEnt:Visible(v) && projEnt.Predator:CheckRelationship(v) == D_HT && v:GetClass() != "obj_vj_bullseye" then
						projEnt.IsArmed = false
						projEnt.DeathSnd = CreateSound(projEnt,"cpthazama/avp/weapons/predator/mine/prd_mine_triggered_01.ogg")
						projEnt.DeathSnd:SetSoundLevel(85)
						projEnt.DeathSnd:Play()
						local hitNr = (v:GetPos() -projEnt:GetPos()):GetNormalized()
						timer.Simple(1.5,function()
							if IsValid(projEnt) then
								projEnt.DeathSnd:Stop()
								local data = {}
								data.HitEntity = v
								data.HitPos = projEnt:GetPos()
								data.HitNormal = hitNr
								local phys = projEnt:GetPhysicsObject()
								projEnt.Dead = true
								projEnt:DealDamage(data, phys)
								if projEnt.ShakeWorldOnDeath == true then util.ScreenShake(projEnt:GetPos() +projEnt:GetUp() *10, projEnt.ShakeWorldOnDeathAmplitude or 16, projEnt.ShakeWorldOnDeathFrequency or 200, projEnt.ShakeWorldOnDeathDuration or 1, projEnt.ShakeWorldOnDeathRadius or 3000) end -- !!!!!!!!!!!!!! DO NOT USE THIS VARIABLE !!!!!!!!!!!!!! [Backwards Compatibility!]
								projEnt:Destroy(data, phys)
							end
						end)
						break
					end
				end
			end
			proj.OnCollision = function(projEnt,data,phys)
				if projEnt.HasLanded or data.HitEntity:IsNPC() then return end

				phys:EnableMotion(false)
				phys:EnableGravity(false)
				projEnt.HasLanded = true
				SafeRemoveEntity(projEnt.Trail)
				VJ.EmitSound(projEnt,"cpthazama/avp/weapons/predator/mine/prd_mine_arm_01.ogg",80)
				timer.Simple(3,function()
					if IsValid(projEnt) then
						projEnt.IsArmed = true
						local glow1 = ents.Create("env_sprite")
						glow1:SetKeyValue("model","sprites/light_glow02_add.vmt")
						glow1:SetKeyValue("scale","0.1")
						glow1:SetKeyValue("rendermode","9")
						glow1:SetKeyValue("rendercolor","255 55 55")
						glow1:SetKeyValue("spawnflags","0.1")
						glow1:SetParent(proj)
						glow1:SetOwner(proj)
						glow1:Fire("SetParentAttachment","1",0)
						glow1:AddEffects(EF_PARENT_ANIMATES)
						glow1:Spawn()
						proj:DeleteOnRemove(glow1)
					end
				end)
				local hitNr = data.HitPos +data.HitNormal *-1.1
				local hitAng = data.HitNormal:Angle()
				hitAng:RotateAroundAxis(hitAng:Right(),90)
				projEnt:SetPos(hitNr)
				projEnt:SetAngles(hitAng)
			end
			proj.OnDeath = function(projEnt,data, defAng, HitPos)
				ParticleEffect("vj_avp_predator_plasma_impact",HitPos,defAng)
				sound.Play("cpthazama/avp/weapons/predator/mine/prd_mine_explosion_01.ogg",HitPos,90)
			end
			-- proj:AddSound("cpthazama/resistance2/chimera/titan/cha_titan_projectilefireloop_jcm.wav",80)
			-- ParticleEffectAttach("vj_avp_predator_plasma_proj",PATTACH_POINT_FOLLOW,proj,0)

			local phys = proj:GetPhysicsObject()
			local targetPos = IsValid(self.VJ_TheController) && (self:GetEnemy():GetPos() +self:GetUp() *-35) or self:EyePos() +self:GetForward() *600
			local targetAng = (targetPos -proj:GetPos()):Angle()
			targetPos = self:GetPos() +targetAng:Forward() *600
			if IsValid(phys) then
				phys:EnableGravity(true)
				-- phys:SetVelocity(proj:GetForward() *500)
				phys:SetVelocity(VJ.CalculateTrajectory(self,nil,"CurveAntlion",proj:GetPos(),targetPos,600))
			end
			self:SetEnergy(self:GetEnergy() -50)
			self.NextRegenEnergyT = CurTime() +5
		end
	elseif key == "disc_show" then
		local att = self:GetAttachment(self:LookupAttachment("battledisc"))
		local disc = ents.Create("prop_vj_animatable")
		disc:SetModel("models/cpthazama/avp/predators/equipment/battledisc.mdl")
		disc:SetPos(att.Pos)
		disc:SetAngles(att.Ang)
		disc:SetOwner(self)
		disc:Spawn()
		disc:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
		disc:SetSolid(SOLID_NONE)
		disc:SetParent(self)
		disc:AddEffects(bit.bor(EF_BONEMERGE,EF_PARENT_ANIMATES))
		self:DeleteOnRemove(disc)
		self.Disc = disc
	
		self:SetBodygroup(self:FindBodygroupByName("equip_disc"),0)
	//elseif key == "disc_extend" then
		
	elseif key == "disc_throw" then
		SafeRemoveEntity(self.Disc)
		local att = self:GetAttachment(self:LookupAttachment("battledisc"))
		local targetPos = IsValid(self.VJ_TheController) && self:GetEnemy():GetPos() or self:EyePos() +self:GetForward() *500
		local targetAng = (targetPos -att.Pos):Angle()
		local proj = ents.Create("obj_vj_avp_pred_disc")
		proj:SetPos(att.Pos)
		proj:SetAngles(targetAng)
		proj:SetOwner(self)
		proj:SetAttackType(1,45,bit.bor(DMG_SLASH,DMG_VEHICLE))
		proj:SetNoDraw(false)
		proj:Spawn()
		self:DeleteOnRemove(proj)
		proj.Predator = self

		self.HasBattleDisc = true
		self:SetDisc(proj)
	elseif key == "disc_hide" then
		SafeRemoveEntity(self.Disc)
		self:SetBodygroup(self:FindBodygroupByName("equip_disc"),1)
	elseif key == "spear_throw" then
		SafeRemoveEntity(self.SpearProp)
		local att = self:GetAttachment(self:LookupAttachment("spear"))
		local targetPos = IsValid(self.VJ_TheController) && self:GetEnemy():EyePos() or self:EyePos() +self:GetForward() *2000
		local targetAng = (targetPos -att.Pos):Angle()
		-- targetPos = self:GetPos() +targetAng:Forward() *2000
		local proj = ents.Create("obj_vj_avp_pred_spear")
		proj:SetPos(att.Pos)
		proj:SetAngles(targetAng)
		proj:SetOwner(self)
		proj:SetAttackType(1,150,bit.bor(DMG_SLASH,DMG_DIRECT,DMG_VEHICLE))
		proj:SetNoDraw(false)
		proj:Spawn()
		self:DeleteOnRemove(proj)
		VJ.EmitSound(proj,"cpthazama/avp/weapons/predator/crossbow/crossbowfire_0" .. math.random(1,5) .. ".ogg",75)
		proj.Predator = self
		self:SetSpear(proj)

		local phys = proj:GetPhysicsObject()
		if IsValid(phys) then
			-- phys:SetVelocity(proj:GetForward() *2500)
			-- phys:SetVelocity(self:CalculateTrajectory(proj:GetPos(),targetPos,2))
			phys:SetVelocity(VJ.CalculateTrajectory(self,nil,"CurveAntlion",proj:GetPos(),targetPos,2500))
		end
	elseif key == "spear_retract" then
		if IsValid(self.SpearProp) then
			VJ.EmitSound(self.SpearProp,"cpthazama/avp/weapons/predator/spear/prd_spear_draw.ogg",72)
		end
	elseif key == "spear_hide" then
		SafeRemoveEntity(self.SpearProp)
		self:SetBodygroup(self:FindBodygroupByName("equip_spear"),1)
	elseif key == "cin_predintro_ship_uncloak" then
		local ship = self.PredShip
		if !IsValid(ship) then return end

		ship:SetCloaked(true)
	elseif key == "cin_predintro_ship_engineland" then
		local ship = self.PredShip
		if !IsValid(ship) then return end

		ship:SetCloaked(false)
		ship:EmitSound("cpthazama/avp/predator/cloak/prd_cloak.ogg",70)
		VJ.CreateSound(ship,"cpthazama/avp/predator/predmobile/land.ogg",150)
	elseif key == "cin_predintro_ship_land1" then
		local ship = self.PredShip
		if !IsValid(ship) then return end

	elseif key == "cin_predintro_ship_land2" then
		local ship = self.PredShip
		if !IsValid(ship) then return end

	elseif key == "cin_predintro_ship_gunretract" then
		local ship = self.PredShip
		if !IsValid(ship) then return end

		VJ.CreateSound(ship,"cpthazama/avp/predator/predmobile/gunretract.ogg",95)
	elseif key == "cin_predintro_ship_open" then
		local ship = self.PredShip
		if !IsValid(ship) then return end

		VJ.CreateSound(ship,"cpthazama/avp/predator/predmobile/open.ogg",95)
	elseif key == "cin_predintro_ship_beep" then
		local ship = self.PredShip
		if !IsValid(ship) then return end

		VJ.CreateSound(ship,"cpthazama/avp/shared/console_button_beep_01.ogg",75)
	elseif key == "cin_predintro_ship_enginestop" then
		local ship = self.PredShip
		if !IsValid(ship) then return end

		VJ.CreateSound(ship,"cpthazama/avp/predator/adrenalin/adrenalin_turn_off_04.ogg",90)
	elseif key == "cin_predintro_ship_close" then
		local ship = self.PredShip
		if !IsValid(ship) then return end

		VJ.CreateSound(ship,"cpthazama/avp/predator/predmobile/open.ogg",95)
	elseif key == "cin_predintro_ship_cloak" then
		local ship = self.PredShip
		if !IsValid(ship) then return end

		ship:SetCloaked(true)
		ship:EmitSound("cpthazama/avp/predator/cloak/prd_cloak.ogg",70)
	//elseif key == "cin_predintro_pred_grab" then
		
	elseif key == "cin_predintro_pred_land" then
		VJ.CreateSound(self,self.SoundTbl_Land,75)
		VJ.EmitSound(self,VJ.PICK({"cpthazama/avp/predator/jump/pred_heavy_land_01.ogg","cpthazama/avp/predator/jump/pred_heavy_land_02.ogg","cpthazama/avp/predator/jump/pred_heavy_land_03.ogg"}),75)
		local tr = util.TraceLine({
			start = self:GetBonePosition(1),
			endpos = self:GetBonePosition(1) +self:GetUp() *-100,
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
			for _ = 1,16 do
				util.Effect("GlassImpact",fx)
			end
		end
	elseif key == "cin_predintro_pred_roar" then
		self:PlaySound(self.SoundTbl_Attack,80)
	elseif key == "cin_predintro_pred_claws" then
		VJ.EmitSound(self,"cpthazama/avp/weapons/predator/wrist_blades/prd_wrist_blades_draw_01.ogg",72)
	//elseif key == "cin_predintro_pred_placement" then
		-- self:SetPos(self:GetBonePosition(1))
		-- self:SetAngles(self:GetAngles() +Angle(0,-90,0))
	elseif key == "console_open" then
		VJ.EmitSound(self,"cpthazama/avp/predator/console/prd_console_open_01.ogg",70)
	elseif key == "console_beep" then
		VJ.EmitSound(self,"cpthazama/avp/predator/console/prd_console_button_press_01.ogg",70)
	elseif key == "console_charge" then
		local ent = self.BatteryEnt
		if !IsValid(ent) then return end
		VJ.CreateSound(self,"cpthazama/avp/shared/electricity_predator_power_drain_01.ogg",75)
		self:SetEnergy(math.Clamp(self:GetEnergy() +ent.BatteryLife,0,200))
		ent:DrainBattery()
	elseif key == "console_slidebeep" then
		VJ.EmitSound(self,"cpthazama/avp/predator/focus/predator_targetinfo_off_01.ogg",70)
	elseif key == "console_close" then
		VJ.EmitSound(self,"cpthazama/avp/predator/console/prd_console_close_01.ogg",70)
	elseif key == "vo_roar" then
		self:PlaySound(self.SoundTbl_Attack,78)
	elseif key == "disable_obj" then
		local ent = self.ConsoleEnt
		if !IsValid(ent) then return end
		ent:DestroyObject()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnCatchDisc(ent)
	if !IsValid(self) then ent:Remove() return end
	local findAtt = self:LookupAttachment("battledisc")
	if findAtt <= 0 then ent:Remove() return end
	local att = self:GetAttachment(findAtt)
	local disc = ents.Create("prop_vj_animatable")
	disc:SetModel("models/cpthazama/avp/predators/equipment/battledisc.mdl")
	disc:SetPos(att.Pos)
	disc:SetAngles(att.Ang)
	disc:SetOwner(self)
	disc:Spawn()
	disc:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
	disc:SetSolid(SOLID_NONE)
	disc:SetParent(self)
	disc:AddEffects(bit.bor(EF_BONEMERGE,EF_PARENT_ANIMATES))
	self:DeleteOnRemove(disc)
	self.Disc = disc
	SafeRemoveEntityDelayed(disc,1)
	self:PlayAnimation("vjges_predator_battledisc_catch",true,false,true,0,{AlwaysUseGesture=true})
	self.NextChaseTime = 0
	self:SetDisc(nil)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnGrabSpear(ent)
	ent.IsBeingGrabbed = true
	local att = self:GetAttachment(self:LookupAttachment("spear"))
	local spear = ents.Create("prop_vj_animatable")
	spear:SetModel("models/cpthazama/avp/predators/equipment/spear.mdl")
	spear:SetPos(att.Pos)
	spear:SetAngles(att.Ang)
	spear:SetOwner(self)
	spear:Spawn()
	spear:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
	spear:SetSolid(SOLID_NONE)
	spear:SetParent(self)
	spear:AddEffects(bit.bor(EF_BONEMERGE,EF_PARENT_ANIMATES))
	self:DeleteOnRemove(spear)
	self.SpearProp = spear
	SafeRemoveEntityDelayed(spear,1)
	self:PlayAnimation("vjges_predator_spear_retract",true,false,true,0,{AlwaysUseGesture=true})
	self.NextChaseTime = 0
	self:SetSpear(nil)
	self:PlaySound({"^cpthazama/avp/predator/vocals/pred_laugh_taunt_bill.ogg","^cpthazama/avp/predator/vocals/pred_laugh_taunt_glenn.ogg"},80)

	-- if IsValid(self.VJ_TheController) then
	-- 	self.VJ_TheController:ChatPrint("[Dev] Grabbed Combi-Stick!")
	-- end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnFoundHidingSpot()
	if self:Health() < self:GetMaxHealth() && self:GetStimCount() > 0 && CurTime() > self.NextHealT then
		self:UseStimpack()
		self.NextHealT = CurTime() +math.Rand(7,14)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnFailedHidingSpot()
	if self:Health() < self:GetMaxHealth() && self:GetStimCount() > 0 && CurTime() > self.NextHealT then
		self:UseStimpack()
		self.NextHealT = CurTime() +math.Rand(7,14)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local model = "models/cpthazama/avp/predators/hud.mdl"
--
function ENT:SetViewModelWeapon(wep,ply)
	local vm = ply:GetViewModel()
	if IsValid(vm) then
		local isScripted = wep:IsScripted()

		if (self:GetVM() != wep or vm:GetModel() != model) then
			vm:SetModel(model)
			vm:SetNoDraw(false)

			if isScripted then
				timer.Simple(0, function()
					if wep:IsValid() then
						wep:Deploy()
					end
				end)
			end

			self:SetVM(wep)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local VJ_IsProp = VJ.IsProp
--
function ENT:OnCreateDeathCorpse(dmginfo, hitgroup, ent)
	ent:SetNW2Vector("AVP.ArmorTint",self:GetArmorColor())
	ent.OnHeadAte = function(corpse,xeno)
		corpse:SetBodygroup(corpse:FindBodygroupByName("mask"),0)
		corpse:SetBodygroup(corpse:FindBodygroupByName("face"),1)
	end
	if self.CountdownTimer then
		local class = self.VJ_NPC_Class
		ent.CountdownTimer = self.CountdownTimer

		ParticleEffectAttach("vj_avp_predator_plasma_charging",PATTACH_POINT_FOLLOW,ent,ent:LookupAttachment("panel"))
		sound.EmitHint(SOUND_DANGER, ent:GetPos(), 600, ent.CountdownTimer -CurTime(), ent)
		ent.NuclearLoopFX = CreateSound(ent,"cpthazama/avp/predator/Suicide_LoopFX.wav")
		ent.NuclearLoopFX:SetSoundLevel(70)
		ent.NuclearLoopFX:Play()

		hook.Add("Think",ent,function(ent)
			if ent.CountdownTimer == nil then return end
			local remainTime = ent.CountdownTimer -CurTime()
			local per = (remainTime /30)

			ent.NextCountdownTickT = ent.NextCountdownTickT or CurTime() +1
			ent.NextCountdownLaughT = ent.NextCountdownLaughT or CurTime() +math.random(1,3)
	
			if CurTime() > ent.NextCountdownTickT then
				ent.NextCountdownTickT = CurTime() +1
				local pitch = 110 +(20 *(1 -per))
				sound.Play("cpthazama/avp/predator/Bomb_Tick.ogg",ent:GetPos(),60,pitch)
			end
	
			if remainTime <= 0 then
				ent.CountdownTimer = nil
				ent:StopParticles()
				util.ScreenShake(ent:GetPos(),16,150,10,10000,true)
				sound.Play("AVP.Predator.NuclearExplosion",ent:GetPos())
				for _,v in pairs(player.GetAll()) do
					v:ScreenFade(SCREENFADE.IN,Color(170,228,255),1.25,1)
				end
				timer.Simple(0.8,function()
					if IsValid(ent) then
						local fakeNPC = ents.Create("npc_vj_avp_pred")
						fakeNPC:SetPos(ent:GetPos())
						fakeNPC:SetAngles(ent:GetAngles())
						fakeNPC.VJ_NPC_Class = class
						fakeNPC:Spawn()
						fakeNPC:Activate()
						ParticleEffect("vj_avp_predator_honor",ent:GetPos(),ent:GetAngles())
						sound.Play("AVP.Predator.NuclearExplosionFX",ent:GetPos())
						VJ.ApplyRadiusDamage(fakeNPC,fakeNPC,ent:GetPos(),3000,10000,DMG_BLAST,false,true,{DisableVisibilityCheck=true,Force=2000},function(v) if (v:IsNPC() or (v:IsPlayer() && !VJ_CVAR_IGNOREPLAYERS) or v:IsNextBot() or VJ_IsProp(v)) then v:Ignite(16) end end)
						SafeRemoveEntity(fakeNPC)
						VJ.STOPSOUND(ent.NuclearLoopFX)
						hook.Remove("Think",ent)
					end
				end)
			end
		end)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:FindNodePos(pos,min,max,upVis,upVisEnt)
	local nodegraph = table.Copy(VJ_Nodegraph.Data.Nodes)
	local closestNodes = {}
	for _,v in ipairs(nodegraph) do
		local dist = v.pos:Distance(self:GetPos())
		if dist <= (max or self.SightDistance) && dist >= (min or 0) then
			if (upVis && upVisEnt) && !upVisEnt:VisibleVec(v.pos +Vector(0,0,upVis)) then continue end
			table.insert(closestNodes,v.pos)
		end
	end
	return VJ.PICK(closestNodes)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnThinkActive()
	if self.Dead then return end
	if self.CountdownTimer then
		local remainTime = self.CountdownTimer -CurTime()
		local per = (remainTime /30)

		self.NextCountdownTickT = self.NextCountdownTickT or CurTime() +1
		self.NextCountdownLaughT = self.NextCountdownLaughT or CurTime() +math.random(1,3)

		if CurTime() > self.NextCountdownTickT then
			self.NextCountdownTickT = CurTime() +1
			local pitch = 110 +(20 *(1 -per))
			sound.Play("cpthazama/avp/predator/Bomb_Tick.ogg",self:GetPos(),60,pitch)
		end

		-- if CurTime() > self.NextCountdownLaughT then
		-- 	self.NextCountdownLaughT = CurTime() +math.random(4,5)
		-- 	VJ.CreateSound(self,"cpthazama/avp/predator/vocals/pred_laugh_taunt_bill.ogg",75,math.random(75,108))
		-- end

		if remainTime <= 0 then
			self.CountdownTimer = nil
			util.ScreenShake(self:GetPos(),16,150,10,10000,true)
			sound.Play("AVP.Predator.NuclearExplosion",self:GetPos())
			for _,v in pairs(player.GetAll()) do
				v:ScreenFade(SCREENFADE.IN,Color(170,228,255),1.25,1)
			end
			timer.Simple(0.8,function()
				if IsValid(self) then
					ParticleEffect("vj_avp_predator_honor",self:GetPos(),self:GetAngles())
					sound.Play("AVP.Predator.NuclearExplosionFX",self:GetPos())
					VJ.ApplyRadiusDamage(self,self,self:GetPos(),3000,10000,DMG_BLAST,false,true,{DisableVisibilityCheck=true,Force=2000},function(v) if (v:IsNPC() or (v:IsPlayer() && !VJ_CVAR_IGNOREPLAYERS) or v:IsNextBot() or VJ_IsProp(v)) then v:Ignite(16) end end)
					self:SetHealth(0)
					self.GodMode = false
					self:TakeDamage(2000,self,self)
				end
			end)
		end
		return
	end

	self.HasPoseParameterLooking = !self.InFatality
	if self.InFatality then
		local names = self.PoseParameterLooking_Names
		for x = 1, #names.pitch do
			self:SetPoseParameter(names.pitch[x],0)
		end
		for x = 1, #names.yaw do
			self:SetPoseParameter(names.yaw[x],0)
		end
		for x = 1, #names.roll do
			self:SetPoseParameter(names.roll[x],0)
		end
		if IsValid(self.FatalityKiller) && self.FatalityKiller:Health() <= 0 or !IsValid(self.FatalityKiller) then
			self:ResetFatality()
			self:SetHealth(0)
			self:TakeDamage(AVP.fFatalDamageAmount,self,self)
			-- self:SetCycle(self.FatalityKiller:GetCycle())
		end
		return
	end
	self:SetArrivalSpeed(9999)
	local curTime = CurTime()
	local dist = self.EnemyData.DistanceNearest
	-- local moveAct = self:SelectMovementActivity(dist)
	local ply = self.VJ_TheController
	local transAct = self:GetSequenceActivity(self:GetIdealSequence())
	local sprinting = (transAct == ACT_SPRINT or transAct == ACT_MP_SPRINT or transAct == ACT_HL2MP_SWIM_SMG1) or self.AI_IsSprinting

	-- if self.LastSVVisionMode != self:GetVisionMode() then
		-- self.LastSVVisionMode = self:GetVisionMode()
		-- for i = 1,2 do
		-- 	local att = self:GetAttachment(self:LookupAttachment("eyes"))
		-- 	local pos,ang = att.Pos,att.Ang
		-- 	ParticleEffect("vj_avp_predator_eyes_glow",pos +ang:Forward() *8.5 +ang:Right() *(i == 1 && 2 or -2),ang,self)
		-- end
	-- end

	if self.IsBlocking then
		-- if !self:IsPlayingGesture(self:GetSequenceActivity(self:LookupSequence("predator_claws_guard_loop"))) then
		if CurTime() > (self.BlockAnimTime or 0) then
			self:PlayAnimation("predator_claws_guard_loop",false,false,false,0,{AlwaysUseGesture=true})
			self.NextChaseTime = 0
		end
	elseif !self.IsBlocking then
		local anim = self:GetSequenceActivity(self:LookupSequence("predator_claws_guard_loop"))
		if self:IsPlayingGesture(anim) then
			self:RemoveGesture(anim)
		end

		if self:GetEquipment() == 1 then
			if self.PlasmaCasterLayer then
				local gesture = self:AddGestureSequence(self:LookupSequence("predator_plasma_layer"))
				self:SetLayerPriority(gesture,1)
				self:SetLayerPlaybackRate(gesture,0.5)
			end
			if !self.SetupPlasmaCaster then
				self.PoseParameterLooking_Names = {pitch={"aim_pitch","plasma_pitch"}, yaw={"aim_yaw","plasma_yaw"}, roll={}}
				self.SetupPlasmaCaster = true
				self:PlayAnimation("vjges_predator_plasma_caster_extend",true,false,true,0,{AlwaysUseGesture=true,OnFinish = function()
					self.PlasmaCasterLayer = true
					-- self:PlayAnimation("vjges_predator_plasma_layer",true,false,true,0,{AlwaysUseGesture=true})
					-- self.NextChaseTime = 0
				end})
				self.NextChaseTime = 0
			end
		else
			if self.SetupPlasmaCaster then
				self:SetPoseParameter("plasma_pitch",0)
				self:SetPoseParameter("plasma_yaw",0)
				if self:GetEquipment() == 5 then
					self.PoseParameterLooking_Names = {pitch={"aim_pitch","speargun_pitch"}, yaw={"aim_yaw","speargun_yaw"}, roll={}}
				else
					self.PoseParameterLooking_Names = {pitch={"aim_pitch"}, yaw={"aim_yaw"}, roll={}}
				end
				self.SetupPlasmaCaster = false
				self.PlasmaCasterLayer = false
				self:PlayAnimation("vjges_predator_plasma_caster_retract",true,false,true,0,{AlwaysUseGesture=true})
				self.NextChaseTime = 0
			end
		end
	end

	if !self.WasSprinting && sprinting then
		if IsValid(ply) then
			VJ_AVP_CSound(ply,"cpthazama/avp/predator/adrenalin/adrenalin_turn_on_0" .. math.random(1,5) .. ".ogg")
		end
		-- VJ.EmitSound(self,"cpthazama/avp/predator/adrenalin/adrenalin_turn_on_0" .. math.random(1,5) .. ".ogg",70)
		self.WasSprinting = true
	elseif self.WasSprinting && !sprinting then
		self.WasSprinting = false
	end

	-- if self.LastMovementActivity != moveAct then
	-- 	self.LastMovementActivity = moveAct
	-- 	self.AnimTbl_Walk = {moveAct}
	-- 	self.AnimTbl_Run = {moveAct}
	-- end

	-- if self.Flinching && self:OnGround() then
	-- 	self:SetVelocity(self:GetMoveVelocity())
	-- end
	self:SetHP(self:Health())
	if curTime > self.NextRegenEnergyT then
		self:SetEnergy(math.Clamp(self:GetEnergy() +10,0,200))
		self.NextRegenEnergyT = curTime +5
	end
	if IsValid(self:GetDisc()) then
		self:SetBeam(true)
	else
		if self.HasBattleDisc then
			self.HasBattleDisc = false
			self:SetBeam(false)
		end
	end

	if self.OnThink2 then
		self:OnThink2()
	end

	self:SetSprinting(sprinting)
	if IsValid(ply) then
		if self:GetBeam() == true then
			local closeDist = 999999
			local closeEnt
			for _,v in pairs(ents.FindInSphere(self.VJ_TheControllerBullseye:GetPos(),400)) do
				if (v:IsNPC() or v:IsNextBot()) && v:GetClass() != "obj_vj_bullseye" && self:CheckRelationship(v) != D_LI && self:GetPos():Distance(v:GetPos()) < closeDist then
					closeEnt = v
				end
			end
			if IsValid(closeEnt) then
				self:SetLockOn(closeEnt)
			else
				-- self:SetLockOn(nil)
				self:SetLockOn(self:GetEnemy())
			end
		end
	else
		self:SetLockOn(self:GetEnemy())
	end

	local sprinting = self:GetSprinting()
	self.CanAttack = !sprinting
	if sprinting then
		self.SprintT = self.SprintT +0.1
		if self.SprintT >= 6 then
			self.NextSprintT = curTime +1.5
		end
	else
		if self.SprintT > 0 then
			self.SprintT = self.SprintT -0.4
		end
	end

	if self.LongJumping && self.LongJumpPos then
		local currentPos = self:GetPos()
		if self.LongJumpAttacking then
			local targetPos = self.LongJumpPos +self:GetUp() *45
			local moveDirection = (targetPos -currentPos):GetNormalized()
			local moveSpeed = 1000
			self:SetLocalVelocity(moveDirection *moveSpeed)
			if currentPos:Distance(self.LongJumpPos) < 75 then
				self.LongJumpAttacking = false
				self:SetLocalVelocity(Vector(0,0,0))
			end
		else
			local dist = currentPos:Distance(self.LongJumpPos)
			local targetPos = self.LongJumpPos +(dist < 250 && self:OBBCenter() or self:OBBCenter() *3)
			local moveDirection = (targetPos -currentPos):GetNormalized()
			local moveSpeed = (dist < 250 && 430 or dist *2)
			self:SetLocalVelocity(moveDirection *moveSpeed)
		end
	end

	if self:GetCloaked() then
		if self:WaterLevel() >= 2 then
			self:Camo(false)
			self.NextCloakT = curTime +2
		end
		if !self:GetBeam() then
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
							-- v:MarkEnemyAsEluded(self)
							-- v:UpdateEnemyMemory(self,self:GetPos() +VectorRand() *500)
						end
						if v.GetEnemy && v:GetEnemy() == self then
							v:SetEnemy(nil)
						end
					end
				end
			end
		end
	end

	if IsValid(ply) then
		if ply:KeyDown(IN_DUCK) && self:GetBeam() && self.LastSpecialAttackID == 1 && curTime > self.PlasmaFireDelayT then
			self.PlasmaHoldTime = self.PlasmaHoldTime +0.25
			if self.PlasmaHoldTime >= 4 then
				self:FirePlasmaCaster()
			end
		elseif !ply:KeyDown(IN_DUCK) && self.LastSpecialAttackID == 1 && curTime > self.PlasmaFireDelayT then
			self:FirePlasmaCaster()
		elseif !self:GetBeam() then
			self.PlasmaHoldTime = 0
		end
		if !IsValid(ply.VJ_AVP_ViewModel) then
			ply.VJ_AVP_ViewModel = ply:Give("weapon_vj_avp_viewmodel")
			self.VJ_TheControllerEntity:DeleteOnRemove(ply.VJ_AVP_ViewModel)
		else
			local wep = ply.VJ_AVP_ViewModel
			ply.VJ_AVP_ViewModelNPC = self
			self:SetViewModelWeapon(wep,ply)
			wep:Think(self)
		end
		if ply:KeyDown(IN_RELOAD) && curTime > self.NextCloakT then
			self:Camo(!self:GetCloaked())
			if !self:IsBusy() then
				self:PlayAnimation("vjges_predator_" .. (self:GetEquipment() == 5 && "speargun" or "claws") .. "_console_use",false,false,false,0,{AlwaysUseGesture=true})
				self.NextChaseTime = 0
			end
			self.NextCloakT = curTime +1
		end
	else
		local enemy = self:GetEnemy()
		local goalPos = self:GetGoalPos()
		if goalPos == Vector() or goalPos != Vector() && self:GetPos():Distance(goalPos) < 45 then
			goalPos = nil
		end
		if self.LookForHidingSpot then
			self.DisableChasingEnemy = true
			if self.LookForHidingSpotAttempts >= 2 then
				self.LookForHidingSpot = false
				self.LookForHidingSpotAttempts = 0
				self.DisableChasingEnemy = false
				self.Cur_Walk = nil
				self.Cur_Run = nil
				self:OnFailedHidingSpot(goalPos)
				return
			end
			if goalPos && self:GetPos():Distance(goalPos) < 60 && (IsValid(enemy) && !self:Visible(enemy) or !IsValid(enemy)) then
				self.LookForHidingSpot = false
				self.LookForHidingSpotAttempts = 0
				self.DisableChasingEnemy = false
				self.Cur_Walk = nil
				self.Cur_Run = nil
				self:OnFoundHidingSpot(goalPos)
			else
				if curTime > self.NextLookForHidingSpotT && !self:IsBusy() then
					local nodegraph = table.Copy(VJ_Nodegraph.Data.Nodes)
					local closestNodes = {}
					for _,v in ipairs(nodegraph) do
						local dist = v.pos:Distance(self:GetPos())
						if dist < 1000 && dist > 400 && !self:VisibleVec(v.pos) && (IsValid(enemy) && !enemy:VisibleVec(v.pos) or !IsValid(enemy)) then
							table.insert(closestNodes,v.pos)
						end
					end
					local pos = VJ.PICK(closestNodes)
					if pos then
						self:SetLastPosition(pos)
						self:SCHEDULE_GOTO_POSITION("TASK_RUN_PATH")
						-- VJ.DEBUG_TempEnt(pos, self:GetAngles(), Color(255,0,0), 5)
						self.NextLookForHidingSpotT = curTime +(self:GetPathTimeToGoal() or 10)
					end
					self.LookForHidingSpotAttempts = self.LookForHidingSpotAttempts +1
					self.NextLookForHidingSpotT = curTime +5
				end
			end
		end
		if self:Health() < self:GetMaxHealth() *0.4 && self:GetStimCount() > 0 && curTime > self.NextHealT && math.random(1,10) == 1 then
			self.LookForHidingSpot = true
		end
		if goalPos then
			if IsValid(enemy) && goalPos:Distance(enemy:GetPos()) < 300 then
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
			if (heightDif > 200 or self:GetPos():Distance(goalPos) > 600) && self:VisibleVec(tr.HitPos) && math.random(1,20) == 1 then
				self:LongJumpCode(goalPos)
			end
		end
		if IsValid(enemy) then
			if !self:GetCloaked() && self:GetState() == VJ_STATE_NONE && curTime > self.NextCloakT && dist > self.AttackDistance *3 && !enemy.VJ_AVP_Xenomorph then
				self:Camo(!self:GetCloaked())
				if !self:IsBusy() then
					self:PlayAnimation("vjges_predator_" .. (self:GetEquipment() == 5 && "speargun" or "claws") .. "_console_use",false,false,false,0,{AlwaysUseGesture=true})
					self.NextChaseTime = 0
				end
				self.NextCloakT = curTime +1
			end
			if enemy.VJ_AVP_Xenomorph then
				self:SetVisionMode(2)
				self.DisableChasingEnemy = false
				self.Cur_Walk = nil
				self.Cur_Run = nil
			else
				if enemy.VJ_AVP_IsTech then
					self:SetVisionMode(3)
				else
					self:SetVisionMode(1)
				end
				if !enemy.VJ_AVP_Predator && (enemy:IsPlayer() or enemy:IsNPC() && enemy:GetEnemy() != self) && dist > 600 && !self:IsBusy() && (self.StalkEnemyTime > curTime or self.StalkEnemyTime <= curTime && math.random(1,1) == (self.NextFindStalkPos > curTime && 0 or 15)) then
					self.DisableChasingEnemy = true
					if curTime > self.NextFindStalkPos then
						local nodePos = math.random(1,3) == 1 && self:FindNodePos(enemy:GetPos(),768,2048,math.random(1,3) == 1 && 24,enemy) or self:FindNodePos(self:GetPos(),512,768)
						if !nodePos then
							-- Entity(1):ChatPrint("No nodes found, default code running!")
							local vsched = vj_ai_schedule.New("SCHEDULE_GOTO_POSITION")
							vsched:EngTask("TASK_GET_PATH_TO_RANDOM_NODE", 400)
							vsched:EngTask("TASK_RUN_PATH", 0)
							vsched:EngTask("TASK_WAIT_FOR_MOVEMENT", 0)
							vsched.ResetOnFail = true
							vsched.CanBeInterrupted = true
							self:StartSchedule(schedIdleWander)
							self.Cur_Walk = ACT_RUN
							self.Cur_Run = ACT_RUN
						else
							-- Entity(1):ChatPrint("Going to vantage point to wait out the enemy!")
							self:SetLastPosition(nodePos)
							self:SCHEDULE_GOTO_POSITION("TASK_RUN_PATH")
							self.Cur_Walk = ACT_RUN
							self.Cur_Run = ACT_RUN
						end
						self.NextFindStalkPos = curTime +math.Rand(5,15)
					end
					-- if curTime > self.NextFindStalkPos then
					-- 	local vis = self:Visible(enemy)
					-- 	local vsched = vj_ai_schedule.New("SCHEDULE_GOTO_POSITION")
					-- 	if vis then
					-- 		vsched:EngTask("TASK_GET_PATH_TO_RANDOM_NODE", 3000)
					-- 	else
					-- 		vsched:EngTask("TASK_GET_PATH_TO_ENEMY_LOS", 0)
					-- 	end
					-- 	vsched:EngTask("TASK_WAIT_FOR_MOVEMENT", 0)
					-- 	vsched.HasMovement = true
					-- 	if vis && math.random(1,2) == 1 then
					-- 		-- self:SetMovementActivity(VJ.PICK(self.AnimTbl_Walk))
					-- 		self.Cur_Walk = ACT_WALK
					-- 		self.Cur_Run = ACT_WALK
					-- 		vsched.MoveType = 0
					-- 		vsched.TurnData = {Type = VJ.FACE_ENEMY_VISIBLE}
					-- 	else
					-- 		-- self:SetMovementActivity(VJ.PICK(self.AnimTbl_Run))
					-- 		self.Cur_Walk = ACT_RUN
					-- 		self.Cur_Run = ACT_RUN
					-- 		vsched.MoveType = 1
					-- 	end
					-- 	self:StartSchedule(vsched)
					-- 	self.NextFindStalkPos = curTime +math.Rand(5,vis && 20 or 7)
					-- end
				else
					-- Entity(1):ChatPrint("Chasing enemy! " .. (self.StalkEnemyTime > curTime && "Stalk time greater than curTime" or  "Stalk time less than curTime"))
					self.DisableChasingEnemy = false
					self.Cur_Walk = nil
					self.Cur_Run = nil
				end
			end
		else
			if !self:GetCloaked() && self:GetState() == VJ_STATE_NONE && curTime > self.NextCloakT && math.random(1,100) == 1 then
				self:Camo(!self:GetCloaked())
				if !self:IsBusy() then
					self:PlayAnimation("vjges_predator_" .. (self:GetEquipment() == 5 && "speargun" or "claws") .. "_console_use",false,false,false,0,{AlwaysUseGesture=true})
					self.NextChaseTime = 0
				end
				self.NextCloakT = curTime +1
			end
		end
	end

	if self.FootData then
		local checkPos = self:GetPos()
		for attName, var in pairs(self.FootData) do
			if !var.AttID then continue end
	
			local footPos = self:GetAttachment(var.AttID).Pos
			checkPos.x = footPos.x
			checkPos.y = footPos.y	
			if ((footPos -checkPos):LengthSqr()) > (var.Range *var.Range) then
				var.OnGround = false
			elseif !var.OnGround then
				var.OnGround = true
				self:FootStep(footPos, attName)
			end
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnPlaySound(sdFile)
	if VJ.HasValue(self.SoundTbl_Idle,sdFile) then
		local ply = self.VJ_TheController
		if IsValid(ply) && IsValid(ply.VJ_AVP_ViewModel) then
			local wep = ply.VJ_AVP_ViewModel
			wep:OnPlaySound(sdFile)
		end
	end
	return sdFile
end
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.SoundTbl_FootSteps = {
	[MAT_DIRT] = {
		"cpthazama/avp/predator/footsteps/walk/prd_fs_dirt_01.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_dirt_02.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_dirt_03.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_dirt_04.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_dirt_05.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_dirt_06.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_dirt_07.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_dirt_08.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_dirt_09.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_dirt_10.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_dirt_11.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_dirt_12.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_dirt_13.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_dirt_14.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_dirt_15.ogg"
	},
	[MAT_GRASS] = {
		"cpthazama/avp/predator/footsteps/walk/prd_fs_forest_01.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_forest_02.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_forest_03.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_forest_04.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_forest_05.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_forest_06.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_forest_07.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_forest_08.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_forest_09.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_forest_10.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_forest_11.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_forest_12.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_forest_13.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_forest_14.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_forest_15.ogg"
	},
	[MAT_FOLIAGE] = {
		"cpthazama/avp/predator/footsteps/walk/prd_fs_forest_01.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_forest_02.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_forest_03.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_forest_04.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_forest_05.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_forest_06.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_forest_07.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_forest_08.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_forest_09.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_forest_10.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_forest_11.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_forest_12.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_forest_13.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_forest_14.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_forest_15.ogg"
	},
	[MAT_WOOD] = {
		"cpthazama/avp/predator/footsteps/walk/prd_fs_wood_01.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_wood_02.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_wood_03.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_wood_04.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_wood_05.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_wood_06.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_wood_07.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_wood_08.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_wood_09.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_wood_10.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_wood_11.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_wood_12.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_wood_13.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_wood_14.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_wood_15.ogg"
	},
	[MAT_CONCRETE] = {
		"cpthazama/avp/predator/footsteps/walk/prd_fs_stone_01.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_stone_02.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_stone_03.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_stone_04.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_stone_05.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_stone_06.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_stone_07.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_stone_08.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_stone_09.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_stone_10.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_stone_11.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_stone_12.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_stone_13.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_stone_14.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_stone_15.ogg"
	},
	[MAT_METAL] = {
		"cpthazama/avp/predator/footsteps/walk/prd_fs_metal_01.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_metal_02.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_metal_03.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_metal_04.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_metal_05.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_metal_06.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_metal_07.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_metal_08.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_metal_09.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_metal_10.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_metal_11.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_metal_12.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_metal_13.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_metal_14.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_metal_15.ogg"
	},
	[MAT_GRATE] = {
		"cpthazama/avp/predator/footsteps/walk/prd_fs_metal_01.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_metal_02.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_metal_03.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_metal_04.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_metal_05.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_metal_06.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_metal_07.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_metal_08.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_metal_09.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_metal_10.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_metal_11.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_metal_12.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_metal_13.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_metal_14.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_metal_15.ogg"
	},
	[MAT_GLASS] = {
		"cpthazama/avp/predator/footsteps/walk/prd_fs_metal_01.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_metal_02.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_metal_03.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_metal_04.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_metal_05.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_metal_06.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_metal_07.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_metal_08.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_metal_09.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_metal_10.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_metal_11.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_metal_12.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_metal_13.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_metal_14.ogg",
		"cpthazama/avp/predator/footsteps/walk/prd_fs_metal_15.ogg"
	}
}
--
function ENT:FootStep(pos,name)
	if !self:IsOnGround() then return end
	local tbl = self.SoundTbl_FootSteps
	if !tbl then return end
	local tr = util.TraceLine({
		start = self:GetPos(),
		endpos = self:GetPos() +Vector(0,0,-150),
		filter = {self}
	})
	local mat = tr.MatType
	if mat && tbl[mat] == nil then
		mat = MAT_CONCRETE
	end
	if tr.Hit && tbl[mat] then
		VJ.EmitSound(self,VJ.PICK(tbl[mat]),self:GetCloaked() && 55 or (self.FootstepSoundLevel or 65),self:GetSoundPitch(self.FootstepSoundPitch))
	end
	if self:WaterLevel() > 0 && self:WaterLevel() < 3 then
		VJ.EmitSound(self,"player/footsteps/wade" .. math.random(1,8) .. ".wav",self.FootstepSoundLevel,self:GetSoundPitch(self.FootstepSoundPitch))
	end
	if self.OnStep then
		self:OnStep(pos,name)
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
			self:GetActiveWeapon():SetMaterial(" ")
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local bit_band = bit.band
--
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnDamaged(dmginfo, hitgroup, status)
	if status == "PreDamage" then
		if self.ActivatedSelfDestruct then return end
		local dmgType = dmginfo:GetDamageType()
		if (self.IsBlocking or self.AI_IsBlocking) && (bit_band(dmgType,DMG_CLUB) == DMG_CLUB or bit_band(dmgType,DMG_SLASH) == DMG_SLASH or bit_band(dmgType,DMG_VEHICLE) == DMG_VEHICLE) then
			local attacker = dmginfo:GetAttacker()
			if !IsValid(attacker) then
				attacker = dmginfo:GetInflictor()
			end
			local isBigDmg = (dmginfo:GetDamage() > (attacker.VJ_ID_Boss && 40 or 65) or bit_band(dmgType,DMG_VEHICLE) == DMG_VEHICLE)
			if IsValid(attacker) && isBigDmg then
				local attackerLookDir = attacker:GetAimVector()
				local dotForward = attackerLookDir:Dot(self:GetForward())
				local dotRight = attackerLookDir:Dot(self:GetRight())
				if dotForward > 0.5 then -- Hit from the front
					self:PlayAnimation("predator_claws_guard_block_broken_back",true,false,false)
				elseif dotForward < -0.5 then -- Hit from the back
					self:PlayAnimation("predator_claws_guard_block_broken",true,false,false)
				elseif dotRight > 0.5 then -- Hit from the left
					self:PlayAnimation("predator_claws_flinch_lfoot_head_medium_bl",true,false,false)
				elseif dotRight < -0.5 then -- Hit from the right
					self:PlayAnimation("predator_claws_flinch_lfoot_head_medium_br",true,false,false)
				end
				self.SpecialBlockAnimTime = CurTime() +1
				self.IsBlocking = false
				self.AI_IsBlocking = false
			else
				dmginfo:SetDamage(0)
				if IsValid(attacker) && attacker.OnAttackBlocked then
					attacker:OnAttackBlocked(self)
				end

				sound.Play("cpthazama/avp/weapons/predator/wrist_blades/prd_wrist_blades_block_0" .. math.random(1,5) .. ".ogg",dmginfo:GetDamagePosition(),70)
				local _,animTime = self:PlayAnimation({"predator_claws_guard_block_left","predator_claws_guard_block_right"},true,false,false,0,{AlwaysUseGesture=true})
				self.BlockAnimTime = CurTime() +animTime
				if IsValid(attacker) && attacker:IsPlayer() then
					attacker:ViewPunch(Angle(-15,math.random(-3,3),math.random(-3,3)))
					local impact = math.random(5,10)
					local ang = attacker:EyeAngles()
					ang.p = ang.p +math.random(-impact,impact)
					ang.y = ang.y +math.random(-impact,impact)
					attacker:SetEyeAngles(ang)
				end
				local effectData = EffectData()
				effectData:SetOrigin(dmginfo:GetDamagePosition())
				effectData:SetNormal(dmginfo:GetDamageForce():GetNormalized())
				effectData:SetMagnitude(3)
				effectData:SetScale(1)
				util.Effect("ElectricSpark", effectData)
				if self.AI_IsBlocking && !IsValid(self.VJ_TheController) && math.random(1,3) == 1 then
					self.AI_IsBlocking = false
					self.IsBlocking = false
					self:HeavyAttackCode()
				end
			end
		elseif dmginfo:IsBulletDamage() && (self.IsBlocking or self.AI_IsBlocking) then
			self.IsBlocking = false
			self.BlockAnimTime = 0
			self.AI_IsBlocking = false
			self.AI_BlockTime = 0
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnAttackBlocked(ent)
	sound.Play("cpthazama/avp/weapons/predator/wrist_blades/prd_wrist_blades_block_0" .. math.random(1,5) .. ".ogg",ent:GetPos() +ent:OBBCenter(),70)
	self.AttackSide = self.AttackSide or "left"
	local _,dir = self:PlayAnimation("predator_claws_attack_" .. self.AttackSide .. "_countered",true,false,false)
	self.BlockAttackT = CurTime() +(dir *1.4)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnBleed(dmginfo,hitgroup)
	if self.ActivatedSelfDestruct then return end
	if self.DisableChasingEnemy then
		self:StopMoving()
		self.DisableChasingEnemy = false
		self.Cur_Walk = nil
		self.Cur_Run = nil
		self.NextFindStalkPos = CurTime() +math.Rand(15,20)
	end
	local explosion = dmginfo:IsExplosionDamage()
	local dmg = dmginfo:GetDamage()
	if CurTime() > (self.SpecialBlockAnimTime or 0) && !self.InFatality && !self.DoingFatality && self:Health() > 0 && (explosion or dmg > 125 or bit_band(dmginfo:GetDamageType(),DMG_SNIPER) == DMG_SNIPER or (bit_band(dmginfo:GetDamageType(),DMG_VEHICLE) == DMG_VEHICLE && (dmg >= 65 or (dmg < 65 && math.random(1,3) == 1))) or (dmginfo:GetAttacker().VJ_ID_Boss && bit_band(dmginfo:GetDamageType(),DMG_CRUSH) == DMG_CRUSH && dmg >= 65)) then
		if CurTime() < self.NextKnockdownT then return end
		local dmgAng = ((explosion && dmginfo:GetDamagePosition() or dmginfo:GetAttacker():GetPos()) -self:GetPos()):Angle()
		dmgAng.p = 0
		dmgAng.r = 0
		self:TaskComplete()
		self:StopMoving()
		self:ClearSchedule()
		self:ClearGoal()
		self:SetAngles(dmgAng)
		if !self.ActivatedSelfDestruct && self:Health() < self:GetMaxHealth() *0.2 && (self:GetStimCount() <= 0 or math.random(1,self:Health() < self:GetMaxHealth() *0.1 && 3 or 25) == 1) && math.random(1,2) == 1 then
		-- if !self.ActivatedSelfDestruct then
			self:DoCountdownAttack()
			self.HasDeathAnimation = false
			self.ActivatedSelfDestruct = true
			return
		end
		self:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK)
		-- self.CanFlinch = false
		local dmgDir = self:GetDamageDirection(dmginfo)
		-- self.Flinching = true
		local _,dir = self:PlayAnimation(dmgDir == 4 && "predator_plasma_knockdown_forward" or "predator_plasma_knockdown_back",true,false,false,0,{OnFinish=function(interrupted)
			if interrupted then
			-- if interrupted && self.NextFlinchT < CurTime() then
				-- self.Flinching = false
				return
			end
			self:SetState()
			-- self.Flinching = false
			-- self.CanFlinch = true
		end})
		self.NextKnockdownT = CurTime() +(dir *0.5)
		self.NextDamageAllyResponseT = CurTime() +1
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnFlinch(dmginfo, hitgroup, status)
	if status == "Execute" then
		self:SetState()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnDeath(dmginfo, hitgroup, status)
	if status == "Initial" then
		if !self.HasDeathAnimation && self:GetState() == VJ_STATE_NONE then
			for i = 1,self:GetBoneCount() -1 do
				if math.random(1,4) <= 3 then continue end
				local bone = self:GetBonePosition(i)
				if bone then
					local particle = ents.Create("info_particle_system")
					particle:SetKeyValue("effect_name", VJ.PICK(self.BloodParticle))
					particle:SetPos(bone +VectorRand() *15)
					particle:Spawn()
					particle:Activate()
					particle:Fire("Start")
					particle:Fire("Kill", "", 0.1)
				end
			end
		end
		if IsValid(self.FatalityEnt) then
			self.FatalityEnt:SetHealth(0)
			self.FatalityEnt.GodMode = false
			self.FatalityEnt:TakeDamage(1000,self,self)
			self.FatalityEnt = nil
		end
	elseif status == "DeathAnim" then
		if self:GetCloaked() then
			self:Camo(false)
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
		VJ.STOPSOUND(self.CurrentSpeechSound)
		VJ.STOPSOUND(self.CurrentIdleSound)
	end
	local sndName = VJ.PICK(sndTbl)
	local snd = VJ.CreateSound(self,sndName,level or 75,pitch or self:GetSoundPitch(false))
	if setCurSnd then
		self.CurrentVoiceLine = snd
	end
	self.DeleteSounds = self.DeleteSounds or {}
	table.insert(self.DeleteSounds,snd)
	return SoundDuration(sndName)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
	VJ.STOPSOUND(self.CurrentVoiceLine)
	VJ.STOPSOUND(self.NuclearLoopFX)
	VJ.STOPSOUND(self.SuicideStartFX)
	VJ.STOPSOUND(self.SuicideFX)
	if self.DeleteSounds then
		for _,v in pairs(self.DeleteSounds) do
			VJ.STOPSOUND(v)
		end
	end
	if IsValid(self.FatalityEnt) then
		self.FatalityEnt:SetHealth(0)
		self.FatalityEnt.GodMode = false
		self.FatalityEnt:TakeDamage(1000,self,self)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GetDamageDirection(dmginfo)
	local dir = (self:GetPos() +self:OBBCenter()) -dmginfo:GetDamagePosition()
	dir:Normalize()
	dir.z = 0.5

	local hitDir = 1
	local forward = self:GetForward()
	local angle = math_deg(math_atan2(dir:Dot(forward:Cross(Vector(0,0,1))),dir:Dot(forward)))
	if angle >= 45 and angle <= 135 then
		-- print("NPC was hit from the left")
		hitDir = 2
	elseif angle >= -135 and angle <= -45 then
		-- print("NPC was hit from the right")
		hitDir = 3
	elseif angle >= 135 or angle <= -135 then
		-- print("NPC was hit from the front")
		hitDir = 1
	else
		-- print("NPC was hit from the back")
		hitDir = 4
	end

	return hitDir
end
---------------------------------------------------------------------------------------------------------------------------------------------
local angY45 = Angle(0, 45, 0)
local angYN45 = Angle(0, -45, 0)
local angY90 = Angle(0, 90, 0)
local angYN90 = Angle(0, -90, 0)
local angY135 = Angle(0, 135, 0)
local angYN135 = Angle(0, -135, 0)
local angY180 = Angle(0, 180, 0)
local defAng = Angle(0, 0, 0)
--
function ENT:Controller_Movement(cont, ply, bullseyePos)
	if self.MovementType != VJ_MOVETYPE_STATIONARY then
		local gerta_lef = ply:KeyDown(IN_MOVELEFT)
		local gerta_rig = ply:KeyDown(IN_MOVERIGHT)
		local gerta_arak = ply:KeyDown(IN_SPEED)
		local aimVector = ply:GetAimVector()
		local FT = FrameTime() *(self.TurningSpeed *2.25)

		self.ControllerParams.TurnAngle = self.ControllerParams.TurnAngle or defAng
		
		if ply:KeyDown(IN_FORWARD) then
			if self.MovementType == VJ_MOVETYPE_AERIAL or self.MovementType == VJ_MOVETYPE_AQUATIC then
				self:AA_MoveTo(cont.VJCE_Bullseye, true, gerta_arak and "Alert" or "Calm", {IgnoreGround=true})
			else
				self.ControllerParams.TurnAngle = LerpAngle(FT, self.ControllerParams.TurnAngle, gerta_lef && angY45 or gerta_rig && angYN45 or defAng)
				self:StartMovement(aimVector, self.ControllerParams.TurnAngle)
			end
		elseif ply:KeyDown(IN_BACK) then
			self.ControllerParams.TurnAngle = LerpAngle(FT, self.ControllerParams.TurnAngle, gerta_lef && angY135 or gerta_rig && angYN135 or angY180)
			self:StartMovement(aimVector, self.ControllerParams.TurnAngle)
		elseif gerta_lef then
			self.ControllerParams.TurnAngle = LerpAngle(FT, self.ControllerParams.TurnAngle, angY90)
			self:StartMovement(aimVector, self.ControllerParams.TurnAngle)
		elseif gerta_rig then
			self.ControllerParams.TurnAngle = LerpAngle(FT, self.ControllerParams.TurnAngle, angYN90)
			self:StartMovement(aimVector, self.ControllerParams.TurnAngle)
		else
			self:StopMoving()
			if self.MovementType == VJ_MOVETYPE_AERIAL or self.MovementType == VJ_MOVETYPE_AQUATIC then
				self:AA_StopMoving()
			end
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:StartMovement(Dir, Rot)
	local cont = self.VJ_TheControllerEntity
	local ply = cont.VJCE_Player
	if self:GetState() != VJ_STATE_NONE then return end

	local DEBUG = false
	local plyAimVec = Dir
	plyAimVec.z = 0
	plyAimVec:Rotate(Rot)

	local selfPos = self:GetPos()
	local centerToPos = self:OBBCenter():Distance(self:OBBMins()) // self:OBBMaxs().z
	local NPCPos = selfPos + self:GetUp()*centerToPos
	local groundSpeed = math.Clamp(self:GetSequenceGroundSpeed(self:GetSequence()), 300, 9999)
	local defaultFilter = {cont, self, ply}
	local forwardTr = util.TraceHull({start = NPCPos, endpos = NPCPos + plyAimVec * groundSpeed, filter = defaultFilter, mins = Vector(-4,-4,-4), maxs = Vector(4,4,4)})
	local forwardDist = NPCPos:Distance(forwardTr.HitPos)
	local wallToSelf = forwardDist - (self:OBBMaxs().y *2.5) -- Use Y instead of X because X is left/right whereas Y is forward/backward
	if DEBUG then
		VJ.DEBUG_TempEnt(NPCPos, cont:GetAngles(), Color(0, 255, 255)) -- NPC's calculated position
		VJ.DEBUG_TempEnt(forwardTr.HitPos, cont:GetAngles(), Color(255, 255, 0)) -- forward trace position
	end
	if forwardDist >= 1 then
		local finalPos = Vector((selfPos + plyAimVec * wallToSelf).x, (selfPos + plyAimVec * wallToSelf).y, forwardTr.HitPos.z)
		local downTr = util.TraceLine({start = finalPos, endpos = finalPos + cont:GetUp()*-(200 + centerToPos), filter = defaultFilter})
		local downDist = (finalPos.z - centerToPos) - downTr.HitPos.z
		if downDist >= 150 then -- If the drop is this big, then don't move!
			//wallToSelf = wallToSelf - downDist -- No need, we are returning anyway
			return
		end
		if forwardDist <= 225 && !forwardTr.Hit then
			finalPos = Vector((selfPos + plyAimVec * groundSpeed).x, (selfPos + plyAimVec * groundSpeed).y, forwardTr.HitPos.z)
		else
			finalPos = Vector((selfPos + plyAimVec * wallToSelf).x, (selfPos + plyAimVec * wallToSelf).y, forwardTr.HitPos.z)
		end
		if DEBUG then
			VJ.DEBUG_TempEnt(downTr.HitPos, cont:GetAngles(), Color(255, 0, 255)) -- Down trace position
			VJ.DEBUG_TempEnt(finalPos, cont:GetAngles(), Color(0, 255, 0)) -- Final move position
		end
		self:SetLastPosition(finalPos)
		self:SCHEDULE_GOTO_POSITION(ply:KeyDown(IN_SPEED) and "TASK_RUN_PATH" or "TASK_WALK_PATH", function(x)
			if ply:KeyDown(IN_ATTACK2) && self.IsVJBaseSNPC_Human then
				x.TurnData = {Type = VJ.FACE_ENEMY}
				x.CanShootWhenMoving = true
			else
				if cont.VJC_BullseyeTracking then
					x.TurnData = {Type = VJ.FACE_ENEMY}
				else
					x:EngTask("TASK_FACE_LASTPOSITION", 0)
				end
			end
		end)
	end
end