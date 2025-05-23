local math_acos = math.acos
local math_abs = math.abs
local math_rad = math.rad
local math_cos = math.cos
local string_find = string.find
---------------------------------------------------------------------------------------------------------------------------------------------
cvars.AddChangeCallback("vj_avp_fatalities", function(convar_name, oldValue, newValue)
	if tonumber(newValue) == 0 then
		VJ_AVP_FATALITIES = false
	else
		VJ_AVP_FATALITIES = true
	end
end)
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CanUseFatality(ent)
	if !VJ_AVP_FATALITIES or self.InFatality or self.DoingFatality or /*!ent.AnimTbl_Fatalities or*/ !ent.AnimTbl_FatalitiesResponse or !self.AnimTbl_Fatalities or !self.AnimTbl_FatalitiesResponse or self.DisableFatalities then return false, false end
	local inFront = (ent:GetForward():Dot((self:GetPos() -ent:GetPos()):GetNormalized()) > math_cos(math_rad(80)))
	if !ent.Dead && !ent.InFatality && !ent.DoingFatality && CurTime() > (self.NextFatalityTime or 0) && (ent.Flinching or ent:Health() <= (ent:GetMaxHealth() *0.15) or !inFront or string_find(ent:GetSequenceName(ent:GetSequence()),"knockdown") or string_find(ent:GetSequenceName(ent:GetSequence()),"big_flinch") or CurTime() < (ent.SpecialBlockAnimTime or 0)) then
		if ent.VJ_AVP_XenomorphLarge == true && self.VJ_AVP_XenomorphLarge != true then
			return false, inFront
		end
		return true, inFront
	end
	return false, inFront
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:IsBusy()
	if self.Base == "npc_vj_creature_base" or self.Base == "npc_vj_human_base" then
		return baseclass.Get(self.Base).IsBusy(self) or self.InFatality or self.DoingFatality or self.IsBlocking or self:GetInFatality()
	end
	return self.InFatality or self.DoingFatality or self.IsBlocking or self:GetInFatality()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:ResetFatality()
	self.InFatality = false
	self.FatalityEnt = nil
	self.FatalityKiller = nil
	self.DoingFatality = false
	self.GodMode = false
	self:SetInFatality(false)
	self:SetFatalityTarget(nil)
	self:SetMoveType(MOVETYPE_STEP)
	self:SetState()
	self:SetMaxYawSpeed(self.TurningSpeed)
	self.NextFatalityTime = CurTime() +3
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DoFatality(ent,inFront)
	local fType = "Human"
	local tbl = self.AnimTbl_Fatalities.Human
	if ent.VJ_AVP_Xenomorph then
		tbl = self.AnimTbl_Fatalities.Alien
		fType = "Alien"
	elseif ent.VJ_AVP_Predator then
		tbl = self.AnimTbl_Fatalities.Predator
		fType = "Predator"
	end
	if self.OnBeforeDoFatality then
		tbl = self:OnBeforeDoFatality(ent,fType) or tbl
	end
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
	local names = ent.PoseParameterLooking_Names
	if names then
		for x = 1, #names.pitch do
			ent:SetPoseParameter(names.pitch[x],0)
		end
		for x = 1, #names.yaw do
			ent:SetPoseParameter(names.yaw[x],0)
		end
		for x = 1, #names.roll do
			ent:SetPoseParameter(names.roll[x],0)
		end
	end
	if tbl && (inFront && tbl.Trophy or tbl.Stealth) then
		tbl = inFront && tbl.Trophy or tbl.Stealth
		if !tbl or self.DoingFatality or self.InFatality or ent.DoingFatality or ent.InFatality then return false end
		self.FatalityEnt = ent
		self:SetFatalityTarget(ent)
		self.DoingFatality = true
		self:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK)
		self:SetMaxYawSpeed(0)
		self:SetInFatality(true)
		if ent.SetInFatality then
			ent:SetInFatality(true)
		end
		ent.GodMode = true
		ent.InFatality = true
		ent.FatalityKiller = self
		local ang = self:GetAngles()
		if inFront then
			ang.y = ang.y +180
		end
		ent:StopMoving()
		ent:SetAngles(ang)
		-- local offset = ent.GetFatalityOffset && ent:GetFatalityOffset(self) or (self:OBBMaxs().y +ent:OBBMaxs().y) *2 // OBSOLETE
		-- print(self:GetCollisionBounds()," | ",ent:GetCollisionBounds())
		local myCol,entCol = self:GetCollisionBounds().y, ent:GetCollisionBounds().y
		myCol = math_abs(myCol)
		entCol = math_abs(entCol)
		local offset = (myCol +entCol) +2.5
		ent:SetPos(self:GetPos() +self:GetForward() *offset)
		ent:StopAttacks(true)
		ent:ClearSchedule()
		ent:ClearGoal()
		ent:StopMoving()
		ent:SetMaxYawSpeed(0)
		ent:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK)
		self:SetLocalVelocity(Vector(0,0,0))
		ent:SetLocalVelocity(Vector(0,0,0))
		self:SetVelocity(Vector(0,0,0))
		ent:SetVelocity(Vector(0,0,0))
		self:SetNavType(NAV_GROUND)
		self:SetMoveType(MOVETYPE_NONE)
		ent:SetNavType(NAV_GROUND)
		ent:SetMoveType(MOVETYPE_NONE)
		if IsValid(ent.VJ_TheController) then
			VJ_AVP_CSound(ent.VJ_TheController,"cpthazama/avp/shared/grapple/grapple_sting_0" .. math.random(1,5) .. ".ogg")
		end
		if self.OnHit then
			self:OnHit({ent})
		end
		local biped
		if ent.VJ_AVP_CanUseBiped then
			biped = ents.Create("sent_vj_avp_fatality")
			biped:SetPos(ent:GetPos())
			biped:SetAngles(ent:GetAngles())
			-- biped:SetModel("models/cpthazama/avp/marines/ani_valve_mesh.mdl")
			biped:Spawn()
			biped.Owner = ent
			ent:SetParent(biped)
			ent:AddEffects(bit.bor(EF_BONEMERGE,EF_PARENT_ANIMATES))
			ent:DeleteOnRemove(biped)
			ent.VJ_AVP_Biped = biped
		end
		if tbl.OnlyKill then
			if ent.OnFatality then
				ent:OnFatality(self,inFront,false,fType)
			end
			ent.CurrentEmote = VJ_AVP_EXP_FEAR
			local anim = tbl.Kill
			anim = VJ.PICK(anim)
			if ent.AnimTbl_FatalitiesResponse && ent.AnimTbl_FatalitiesResponse[anim] then
				ent:PlayAnim(ent.AnimTbl_FatalitiesResponse[anim],true,false,true,0,{OnFinish=function(int)
					-- if int then return end
					if ent.ResetFatality then
						ent:ResetFatality()
					end
					if IsValid(ent.VJ_AVP_Biped) then
						ent:SetParent(nil)
						SafeRemoveEntityDelayed(ent.VJ_AVP_Biped,0.02)
					end
					if IsValid(ent) then
						local dmginfo = DamageInfo()
						dmginfo:SetDamage(ent:Health())
						dmginfo:SetDamageType(DMG_SLASH)
						dmginfo:SetDamageForce(IsValid(self) && self:GetForward() *250 or ent:GetForward() *-250)
						dmginfo:SetAttacker(IsValid(self) && self or ent)
						dmginfo:SetInflictor(IsValid(self) && self or ent)
						ent.HasDeathSounds = false
						ent:TakeDamageInfo(dmginfo)
					end
				end})
			end
			self:PlayAnim(anim,true,false,true,0,{OnFinish=function(int)
				-- if int then return end
				self:SetState()
				self:ResetFatality()
				if IsValid(ent) then
					if ent.ResetFatality then
						ent:ResetFatality()
					end
					if IsValid(ent.VJ_AVP_Biped) then
						ent:SetParent(nil)
						SafeRemoveEntityDelayed(ent.VJ_AVP_Biped,0.02)
					end
					ent.HasDeathAnimation = false
					local dmginfo = DamageInfo()
					dmginfo:SetDamage(ent:Health())
					dmginfo:SetDamageType(DMG_SLASH)
					dmginfo:SetDamageForce(self:GetForward() *250)
					dmginfo:SetAttacker(self)
					dmginfo:SetInflictor(self)
					ent.HasDeathSounds = false
					ent:TakeDamageInfo(dmginfo)
				end
			end})
		else
			local counter = math.random(1,!inFront && 200 or 100) <= (100 *(ent:Health() /ent:GetMaxHealth()))
			if ent.OnFatality then
				ent:OnFatality(self,inFront,counter,fType)
			end
			ent.CurrentEmote = VJ_AVP_EXP_FEAR
			local grabAnim = ent.AnimTbl_FatalitiesResponse && ent.AnimTbl_FatalitiesResponse[tbl.Grab] or ent.GenericFatalitiesResponse
			if grabAnim then
				ent:PlayAnim(grabAnim,true,false,true)
				-- Entity(1):ChatPrint("Fatality Response: " .. grabAnim)
			end
			self:PlayAnim(tbl.Grab,true,false,true,0,{OnFinish=function(int,anim)
				-- if int then return end
				if IsValid(ent) then
					if ent.AnimTbl_FatalitiesResponse && ent.AnimTbl_FatalitiesResponse[tbl.Lift] then
						ent:PlayAnim(ent.AnimTbl_FatalitiesResponse[tbl.Lift],true,false,true)
						-- Entity(1):ChatPrint("Fatality Response: " .. ent.AnimTbl_FatalitiesResponse[tbl.Lift])
					end
				end
				if tbl.Lift then
					self:PlayAnim(tbl.Lift,true,false,true,0,{OnFinish=function(int)
						-- if int then return end
						local anim = counter && tbl.Counter or tbl.Kill
						anim = VJ.PICK(anim)
						if IsValid(ent) then
							if ent.AnimTbl_FatalitiesResponse && ent.AnimTbl_FatalitiesResponse[anim] then
								ent:PlayAnim(ent.AnimTbl_FatalitiesResponse[anim],true,false,true,0,{OnFinish=function(int)
									-- if int then return end
									if ent.ResetFatality then
										ent:ResetFatality()
									end
									if IsValid(ent.VJ_AVP_Biped) then
										ent:SetParent(nil)
										SafeRemoveEntityDelayed(ent.VJ_AVP_Biped,0.02)
									end
									if !counter && IsValid(ent) then
										ent.HasDeathAnimation = false
										local dmginfo = DamageInfo()
										dmginfo:SetDamage(ent:Health())
										dmginfo:SetDamageType(DMG_SLASH)
										dmginfo:SetDamageForce(IsValid(self) && self:GetForward() *250 or ent:GetForward() *-250)
										dmginfo:SetAttacker(IsValid(self) && self or ent)
										dmginfo:SetInflictor(IsValid(self) && self or ent)
										ent.HasDeathSounds = false
										ent:TakeDamageInfo(dmginfo)
									end
								end})
								-- Entity(1):ChatPrint("Fatality Response: " .. ent.AnimTbl_FatalitiesResponse[anim])
							end
						end
						self:PlayAnim(anim,true,false,true,0,{OnFinish=function(int)
							-- if int then return end
							self:SetState()
							self:ResetFatality()
							if IsValid(ent) then
								if ent.ResetFatality then
									ent:ResetFatality()
								end
								if IsValid(ent.VJ_AVP_Biped) then
									ent:SetParent(nil)
									SafeRemoveEntityDelayed(ent.VJ_AVP_Biped,0.02)
								end
								if !counter then
									ent.HasDeathAnimation = false
									local dmginfo = DamageInfo()
									dmginfo:SetDamage(ent:Health())
									dmginfo:SetDamageType(DMG_SLASH)
									dmginfo:SetDamageForce(self:GetForward() *250)
									dmginfo:SetAttacker(self)
									dmginfo:SetInflictor(self)
									ent.HasDeathSounds = false
									ent:TakeDamageInfo(dmginfo)
								end
							end
						end})
					end})
				else
					local anim = counter && tbl.Counter or tbl.Kill
					anim = VJ.PICK(anim)
					if IsValid(ent) then
						if counter then
							ent.CurrentEmote = VJ_AVP_EXP_COMBAT
						end
						if ent.AnimTbl_FatalitiesResponse && ent.AnimTbl_FatalitiesResponse[anim] then
							ent:PlayAnim(ent.AnimTbl_FatalitiesResponse[anim],true,false,true,0,{OnFinish=function(int)
								-- if int then return end
								if ent.ResetFatality then
									ent:ResetFatality()
								end
								if IsValid(ent.VJ_AVP_Biped) then
									ent:SetParent(nil)
									SafeRemoveEntityDelayed(ent.VJ_AVP_Biped,0.02)
								end
								if !counter && IsValid(ent) then
									ent.HasDeathAnimation = false
									local dmginfo = DamageInfo()
									dmginfo:SetDamage(ent:Health())
									dmginfo:SetDamageType(DMG_SLASH)
									dmginfo:SetDamageForce(IsValid(self) && self:GetForward() *250 or ent:GetForward() *-250)
									dmginfo:SetAttacker(IsValid(self) && self or ent)
									dmginfo:SetInflictor(IsValid(self) && self or ent)
									ent.HasDeathSounds = false
									ent:TakeDamageInfo(dmginfo)
								end
							end})
							-- Entity(1):ChatPrint("Fatality Response: " .. ent.AnimTbl_FatalitiesResponse[anim])
						end
					end
					self:PlayAnim(anim,true,false,true,0,{OnFinish=function(int)
						-- if int then return end
						self:SetState()
						self:ResetFatality()
						if IsValid(ent) then
							if ent.ResetFatality then
								ent:ResetFatality()
							end
							if IsValid(ent.VJ_AVP_Biped) then
								ent:SetParent(nil)
								SafeRemoveEntityDelayed(ent.VJ_AVP_Biped,0.02)
							end
							if !counter then
								ent.HasDeathAnimation = false
								local dmginfo = DamageInfo()
								dmginfo:SetDamage(ent:Health())
								dmginfo:SetDamageType(DMG_SLASH)
								dmginfo:SetDamageForce(self:GetForward() *250)
								dmginfo:SetAttacker(self)
								dmginfo:SetInflictor(self)
								ent.HasDeathSounds = false
								ent:TakeDamageInfo(dmginfo)
							end
						end
					end})
				end
			end})
		end
	end
end