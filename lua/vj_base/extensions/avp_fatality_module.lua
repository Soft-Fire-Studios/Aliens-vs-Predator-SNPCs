local math_abs = math.abs
local math_rad = math.rad
local math_cos = math.cos
local string_find = string.find
local vecZero = Vector(0, 0, 0)

AVP = AVP or {}
AVP.Fatalities = AVP.Fatalities or {}

if !AVP.Fatalities._CVarCallbacksInstalled then
	cvars.AddChangeCallback("vj_avp_fatalities", function(convar_name, oldValue, newValue)
		VJ_AVP_FATALITIES = tonumber(newValue) != 0
	end, "VJ.AVP.Fatalities.Enabled")
	cvars.AddChangeCallback("vj_avp_fatalities_lowhp", function(convar_name, oldValue, newValue)
		VJ_AVP_FATALITIES_LOWHP = tonumber(newValue) != 0
	end, "VJ.AVP.Fatalities.LowHP")
	AVP.Fatalities._CVarCallbacksInstalled = true
end
---------------------------------------------------------------------------------------------------------------------------------------------
local function IsAlive(ent)
	return IsValid(ent) && !ent.Dead && ent:Health() > 0
end
---------------------------------------------------------------------------------------------------------------------------------------------
local function ZeroLookPose(ent)
	if !IsValid(ent) then return end
	local names = ent.PoseParameterLooking_Names
	if !istable(names) then return end
	for _, name in ipairs(names.pitch or {}) do ent:SetPoseParameter(name, 0) end
	for _, name in ipairs(names.yaw or {}) do ent:SetPoseParameter(name, 0) end
	for _, name in ipairs(names.roll or {}) do ent:SetPoseParameter(name, 0) end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local function CaptureState(ent)
	if !IsValid(ent) then return nil end
	local entIndex = ent:EntIndex()
	local state = {
		MoveType = ent:GetMoveType(),
		GodMode = ent.GodMode == true,
		NoTarget = ent.IsFlagSet && ent:IsFlagSet(FL_NOTARGET) or false,
		MaxYawSpeed = ent.GetMaxYawSpeed && ent:GetMaxYawSpeed() or nil,
		NavType = ent.GetNavType && ent:GetNavType() or nil,
		AIState = ent.GetState && ent:GetState() or nil,
		StateTimer = timer.TimeLeft("state_reset" .. entIndex),
		PauseAttacks = ent.PauseAttacks == true,
		AttackPauseTimer = timer.TimeLeft("attack_pause_reset" .. entIndex),
		AnimLockTime = ent.AnimLockTime,
		NextChaseTime = ent.NextChaseTime,
		NextIdleTime = ent.NextIdleTime,
	}
	return state
end
---------------------------------------------------------------------------------------------------------------------------------------------
local function CleanupBiped(ent)
	if !IsValid(ent) then return end
	local biped = ent.VJ_AVP_Biped
	if IsValid(biped) then
		ent:SetParent(nil)
		ent:RemoveEffects(bit.bor(EF_BONEMERGE, EF_PARENT_ANIMATES))
		SafeRemoveEntityDelayed(biped, 0)
	end
	ent.VJ_AVP_Biped = nil
end
---------------------------------------------------------------------------------------------------------------------------------------------
local function RestoreState(ent)
	if !IsValid(ent) then return end
	local state = ent._AVPFatalitySavedState

	ent.InFatality = false
	ent.DoingFatality = false
	ent.FatalityEnt = nil
	ent.FatalityKiller = nil
	if ent.SetInFatality then ent:SetInFatality(false) end
	if ent.SetFatalityTarget then ent:SetFatalityTarget(NULL) end

	CleanupBiped(ent)

	if !ent.Dead && ent:Health() > 0 then
		if state then
			ent.GodMode = state.GodMode == true
			if state.MoveType != nil then ent:SetMoveType(state.MoveType) end
			if state.NavType != nil && ent.SetNavType then ent:SetNavType(state.NavType) end
			if state.MaxYawSpeed != nil && ent.SetMaxYawSpeed then ent:SetMaxYawSpeed(state.MaxYawSpeed) end
			if state.NoTarget then
				ent:AddFlags(FL_NOTARGET)
			elseif ent.RemoveFlags then
				ent:RemoveFlags(FL_NOTARGET)
			end

			ent.PauseAttacks = state.PauseAttacks == true
			if state.AnimLockTime != nil then ent.AnimLockTime = state.AnimLockTime end
			if state.NextChaseTime != nil then ent.NextChaseTime = state.NextChaseTime end
			if state.NextIdleTime != nil then ent.NextIdleTime = state.NextIdleTime end

			local attackPauseTimerName = "attack_pause_reset" .. ent:EntIndex()
			timer.Remove(attackPauseTimerName)
			if state.AttackPauseTimer && state.AttackPauseTimer > 0 then
				timer.Create(attackPauseTimerName, state.AttackPauseTimer, 1, function()
					if IsValid(ent) then ent.PauseAttacks = false end
				end)
			end

			if ent.SetState then
				ent:SetState(state.AIState, state.StateTimer && math.max(state.StateTimer, 0) or -1)
			end
		else
			ent.GodMode = false
			if ent:GetMoveType() == MOVETYPE_NONE then ent:SetMoveType(MOVETYPE_STEP) end
			if ent.SetMaxYawSpeed && ent.TurningSpeed then ent:SetMaxYawSpeed(ent.TurningSpeed) end
			if ent.SetState then ent:SetState() end
		end

		if ent.SCHEDULE_IDLE_STAND then ent:SCHEDULE_IDLE_STAND() end
	end

	ent._AVPFatalitySavedState = nil
	ent._AVPFatalityContext = nil
	ent.NextFatalityTime = CurTime() + 3

	if ent.NextCloakT then ent.NextCloakT = CurTime() + 0.5 end
	if ent.VJ_AVP_Predator or ent.NextCloakT != nil then
		ent.NextCloakT = CurTime() + 0.25
		if ent.SetCloakDisruptTime then ent:SetCloakDisruptTime(0) end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local function ReleasePair(ctx)
	if !ctx then return end
	local attacker = ctx.Attacker
	local victim = ctx.Victim
	if IsValid(attacker) then RestoreState(attacker) end
	if IsValid(victim) then RestoreState(victim) end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local function AbortFatality(ctx)
	if !ctx or ctx.Finished then return end
	ctx.Finished = true
	ReleasePair(ctx)
end
---------------------------------------------------------------------------------------------------------------------------------------------
local function KillFatalityVictim(ctx)
	if !ctx or ctx.VictimKilled then return end
	ctx.VictimKilled = true
	local victim = ctx.Victim
	local attacker = ctx.Attacker
	if !IsValid(victim) || victim.Dead || victim:Health() <= 0 then return end

	victim.GodMode = false
	victim.HasDeathAnimation = false
	victim.HasDeathSounds = false
	victim:SetHealth(1)

	local dmginfo = DamageInfo()
	dmginfo:SetDamage((AVP && AVP.fFatalDamageAmount) or 1000000)
	dmginfo:SetDamageType(DMG_SLASH)
	dmginfo:SetDamageForce(IsValid(attacker) && attacker:GetForward() * 250 or victim:GetForward() * -250)
	dmginfo:SetAttacker(IsValid(attacker) && attacker or victim)
	dmginfo:SetInflictor(IsValid(attacker) && attacker or victim)
	victim:TakeDamageInfo(dmginfo)
end
---------------------------------------------------------------------------------------------------------------------------------------------
local function KillVictimOnResponseFinish(ctx, completed)
	if !completed or !ctx or ctx.Finished or ctx.VictimKilled then return end
	local victim = ctx.Victim
	if IsValid(victim) then CleanupBiped(victim) end
	KillFatalityVictim(ctx)
end
---------------------------------------------------------------------------------------------------------------------------------------------
local function FinishFatality(ctx, killVictim)
	if !ctx or ctx.Finished then return end
	ctx.Finished = true
	local attacker = ctx.Attacker
	local victim = ctx.Victim
	if IsValid(victim) then CleanupBiped(victim) end
	if killVictim then KillFatalityVictim(ctx) end
	if IsValid(attacker) then RestoreState(attacker) end
	if IsValid(victim) then RestoreState(victim) end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local function PickAnim(anim)
	if !anim then return nil end
	return VJ.PICK(anim)
end
---------------------------------------------------------------------------------------------------------------------------------------------
local function AnimExists(ent, anim)
	if !IsValid(ent) or anim == nil then return false end
	if IsValid(ent.VJ_AVP_Biped) then
		return VJ.AnimExists(ent.VJ_AVP_Biped, anim)
	end
	return VJ.AnimExists(ent, anim)
end
---------------------------------------------------------------------------------------------------------------------------------------------
local function PlayStage(ctx, actor, anim, onFinish)
	if !ctx or ctx.Finished or !IsAlive(actor) then
		AbortFatality(ctx)
		return false
	end
	anim = PickAnim(anim)
	if !AnimExists(actor, anim) then
		AbortFatality(ctx)
		return false
	end

	actor:PlayAnim(anim, true, false, true, 0, {OnFinish = function(interrupted, playedAnim)
		if !ctx or ctx.Finished then return end
		if interrupted or !IsAlive(ctx.Attacker) or !IsValid(ctx.Victim) then
			AbortFatality(ctx)
			return
		end
		if onFinish then onFinish(playedAnim or anim) end
	end})
	return true, anim
end
---------------------------------------------------------------------------------------------------------------------------------------------
local function PlayVictimResponse(ctx, attackerAnim, onFinish)
	if !ctx or ctx.Finished then return false end
	local victim = ctx.Victim
	if !IsAlive(victim) then
		AbortFatality(ctx)
		return false
	end

	local response = victim.AnimTbl_FatalitiesResponse && victim.AnimTbl_FatalitiesResponse[attackerAnim] or nil
	if !response then response = victim.GenericFatalitiesResponse end
	if !response or !AnimExists(victim, response) then
		if onFinish then onFinish(false) end
		return false
	end

	local animEnt = IsValid(victim.VJ_AVP_Biped) && victim.VJ_AVP_Biped or victim
	animEnt:PlayAnim(response, true, false, true, 0, {OnFinish = function(interrupted)
		if !ctx or ctx.Finished then return end
		if onFinish then onFinish(!interrupted) end
	end})
	return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
local function PrepareActor(ent, isVictim)
	if !IsValid(ent) then return end
	ent._AVPFatalitySavedState = ent._AVPFatalitySavedState or CaptureState(ent)
	ent:StopMoving()
	if ent.StopAttacks then ent:StopAttacks(true) end
	if ent.ClearSchedule then ent:ClearSchedule() end
	if ent.ClearGoal then ent:ClearGoal() end
	ent:SetLocalVelocity(vecZero)
	ent:SetVelocity(vecZero)
	if ent:GetMoveType() != MOVETYPE_NONE then ent:SetMoveType(MOVETYPE_NONE) end
	if ent.SetState then ent:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK) end
	if ent.SetMaxYawSpeed then ent:SetMaxYawSpeed(0) end
	if isVictim then ent.GodMode = true end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CanUseFatality(ent)
	if !VJ_AVP_FATALITIES or !IsAlive(self) or !IsAlive(ent) or ent == self then return false, false end
	if self.InFatality or self.DoingFatality or self.IsCrawler or self.DisableFatalities then return false, false end
	if ent.InFatality or ent.DoingFatality or ent.VJ_AVP_IsFacehugged then return false, false end
	if !self.AnimTbl_Fatalities or !self.AnimTbl_FatalitiesResponse or !ent.AnimTbl_FatalitiesResponse then return false, false end
	if CurTime() <= (self.NextFatalityTime or 0) then return false, false end

	if VJ_AVP_FATALITIES_LOWHP && !IsValid(self.VJ_TheController) && ent:Health() > (ent:GetMaxHealth() * 0.25) then
		return false, false
	end

	local inFront = ent:GetForward():Dot((self:GetPos() - ent:GetPos()):GetNormalized()) > math_cos(math_rad(80))
	local sequenceName = ent:GetSequenceName(ent:GetSequence()) or ""
	local vulnerable = ent.Flinching or ent:Health() <= (ent:GetMaxHealth() * 0.15) or !inFront or string_find(sequenceName, "knockdown", 1, true) or string_find(sequenceName, "big_flinch", 1, true) or CurTime() < (ent.SpecialBlockAnimTime or 0)
	if !vulnerable then return false, inFront end

	if ent.VJ_AVP_XenomorphLarge == true && self.VJ_AVP_XenomorphLarge != true then
		return false, inFront
	end
	return true, inFront
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:IsBusy()
	local fatalityBusy = self.InFatality or self.DoingFatality or self.IsBlocking or (self.GetInFatality && self:GetInFatality())
	if self.Base == "npc_vj_creature_base" or self.Base == "npc_vj_human_base" then
		return baseclass.Get(self.Base).IsBusy(self) or fatalityBusy
	end
	return fatalityBusy
end
---------------------------------------------------------------------------------------------------------------------------------------------
function AVP.Fatalities.ResetEntity(ent)
	if !IsValid(ent) then return end
	local ctx = ent._AVPFatalityContext
	if ctx && !ctx.Finished then
		AbortFatality(ctx)
	else
		RestoreState(ent)
	end
end

function ENT:ResetFatality()
	AVP.Fatalities.ResetEntity(self)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DoFatality(ent, inFront)
	local canUse, computedFront = self:CanUseFatality(ent)
	if !canUse then return false end
	if inFront == nil then inFront = computedFront end

	local fType = "Human"
	local speciesTable = self.AnimTbl_Fatalities.Human
	if ent.VJ_AVP_Xenomorph then
		speciesTable = self.AnimTbl_Fatalities.Alien
		fType = "Alien"
	elseif ent.VJ_AVP_Predator then
		speciesTable = self.AnimTbl_Fatalities.Predator
		fType = "Predator"
	end
	if self.OnBeforeDoFatality then
		speciesTable = self:OnBeforeDoFatality(ent, fType) or speciesTable
	end
	if !speciesTable then return false end

	local fatality = inFront && speciesTable.Trophy or speciesTable.Stealth
	if !fatality then return false end

	local firstAnim = fatality.OnlyKill && PickAnim(fatality.Kill) or PickAnim(fatality.Grab)
	if !AnimExists(self, firstAnim) then return false end

	local ctx = {
		Attacker = self,
		Victim = ent,
		Finished = false,
		VictimKilled = false,
		Started = CurTime(),
		InFront = inFront,
		Type = fType,
	}
	self._AVPFatalityContext = ctx
	ent._AVPFatalityContext = ctx
	self._AVPFatalitySavedState = CaptureState(self)
	ent._AVPFatalitySavedState = CaptureState(ent)

	self.FatalityEnt = ent
	self:SetFatalityTarget(ent)
	self.DoingFatality = true
	self:SetInFatality(true)
	ent.InFatality = true
	ent.DoingFatality = false
	ent.FatalityKiller = self
	if ent.SetInFatality then ent:SetInFatality(true) end

	ZeroLookPose(self)
	ZeroLookPose(ent)
	PrepareActor(self, false)
	PrepareActor(ent, true)

	local ang = self:GetAngles()
	if inFront then ang.y = ang.y + 180 end
	ent:SetAngles(ang)

	local offset
	-- if ent.GetFatalityOffset then
	-- 	offset = tonumber(ent:GetFatalityOffset(self))
	-- end
	if offset == nil then
		local _, myMax = self:GetCollisionBounds()
		local _, victimMax = ent:GetCollisionBounds()
		offset = math_abs(myMax.y) + math_abs(victimMax.y) + 5
	end
	ent:SetPos(self:GetPos() + self:GetForward() * offset)
	ent:SetLocalVelocity(vecZero)
	self:SetLocalVelocity(vecZero)

	if IsValid(ent.VJ_TheController) then
		VJ_AVP_CSound(ent.VJ_TheController, "cpthazama/avp/shared/grapple/grapple_sting_0" .. math.random(1, 5) .. ".ogg")
	end
	if self.OnHit then self:OnHit({ent}) end

	if ent.VJ_AVP_CanUseBiped then
		local biped = ents.Create("sent_vj_avp_fatality")
		if IsValid(biped) then
			biped:SetPos(ent:GetPos())
			biped:SetAngles(ent:GetAngles())
			biped.Owner = ent
			biped:Spawn()
			ent:SetParent(biped)
			ent:AddEffects(bit.bor(EF_BONEMERGE, EF_PARENT_ANIMATES))
			ent:DeleteOnRemove(biped)
			ent.VJ_AVP_Biped = biped
		end
	end

	timer.Simple(18, function()
		if ctx && !ctx.Finished then AbortFatality(ctx) end
	end)

	if fatality.OnlyKill then
		if ent.OnFatality then ent:OnFatality(self, inFront, false, fType) end
		ent.CurrentEmote = VJ_AVP_EXP_FEAR
		local killAnim = firstAnim
		PlayVictimResponse(ctx, killAnim, function(completed)
			KillVictimOnResponseFinish(ctx, completed)
		end)
		return PlayStage(ctx, self, killAnim, function()
			FinishFatality(ctx, true)
		end)
	end

	local healthFrac = math.Clamp(ent:Health() / math.max(ent:GetMaxHealth(), 1), 0, 1)
	local counter = math.random(1, !inFront && 200 or 100) <= (100 * healthFrac)
	if counter && !fatality.Counter then counter = false end
	if !counter && ent:IsNPC() then ent:AddFlags(FL_NOTARGET) end
	if ent.OnFatality then ent:OnFatality(self, inFront, counter, fType) end
	ent.CurrentEmote = VJ_AVP_EXP_FEAR

	local function PlayFinalStage()
		if !ctx or ctx.Finished then return end
		local finalAnim = counter && fatality.Counter or fatality.Kill
		finalAnim = PickAnim(finalAnim)
		if !AnimExists(self, finalAnim) then
			AbortFatality(ctx)
			return
		end
		if counter then ent.CurrentEmote = VJ_AVP_EXP_COMBAT end
		if counter then
			PlayVictimResponse(ctx, finalAnim)
		else
			PlayVictimResponse(ctx, finalAnim, function(completed)
				KillVictimOnResponseFinish(ctx, completed)
			end)
		end
		PlayStage(ctx, self, finalAnim, function()
			FinishFatality(ctx, !counter)
		end)
	end

	local grabAnim = firstAnim
	PlayVictimResponse(ctx, grabAnim)
	PlayStage(ctx, self, grabAnim, function()
		if !ctx or ctx.Finished then return end
		if fatality.Lift then
			local liftAnim = PickAnim(fatality.Lift)
			if !AnimExists(self, liftAnim) then
				AbortFatality(ctx)
				return
			end
			PlayVictimResponse(ctx, liftAnim)
			PlayStage(ctx, self, liftAnim, PlayFinalStage)
		else
			PlayFinalStage()
		end
	end)

	return true
end
