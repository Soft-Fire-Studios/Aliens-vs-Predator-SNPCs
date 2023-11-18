local math_acos = math.acos
local math_abs = math.abs
local math_rad = math.rad
local math_cos = math.cos
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
	if !VJ_AVP_FATALITIES or self.InFatality or self.DoingFatality then return false, false end
	local inFront = (ent:GetForward():Dot((self:GetPos() -ent:GetPos()):GetNormalized()) > math_cos(math_rad(80)))
	if ent.VJ_AVP_NPC && !ent.Dead && !ent.InFatality && !ent.DoingFatality && CurTime() > (self.NextFatalityTime or 0) && (ent.Flinching or ent:Health() <= (ent:GetMaxHealth() *0.15) or !inFront) then
		if ent.VJ_AVP_XenomorphLarge == true && self.VJ_AVP_XenomorphLarge != true then
			return false, inFront
		end
		return true, inFront
	end
	return false, inFront
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:IsBusy()
	return self:BusyWithActivity() or self:IsBusyWithBehavior() or self.InFatality or self.DoingFatality
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:ResetFatality()
	self.InFatality = false
	self.FatalityEnt = nil
	self.FatalityKiller = nil
	self.DoingFatality = false
	self.GodMode = false
	self:SetState()
	self:SetMaxYawSpeed(self.TurningSpeed)
	self.NextFatalityTime = CurTime() +3
	print(self,"Reset Fatality")
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
	if tbl && (inFront && tbl.Trophy or tbl.Stealth) then
		tbl = inFront && tbl.Trophy or tbl.Stealth
		if !tbl or self.DoingFatality or self.InFatality or ent.DoingFatality or ent.InFatality then return false end
		print(self,ent,self.DoingFatality,self.InFatality,ent.DoingFatality,ent.InFatality)
		self.FatalityEnt = ent
		self.DoingFatality = true
		self:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK)
		self:SetMaxYawSpeed(0)
		ent.GodMode = true
		ent.InFatality = true
		ent.FatalityKiller = self
		local ang = self:GetAngles()
		if inFront then
			ang.y = ang.y +180
		end
		ent:StopMoving()
		ent:SetAngles(ang)
		local offset = ent.GetFatalityOffset && ent:GetFatalityOffset(self) or (self:OBBMaxs().y +ent:OBBMaxs().y) *2
		ent:SetPos(self:GetPos() +self:GetForward() *offset)
		ent:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK)
		ent:StopAttacks(true)
		ent:ClearSchedule()
		ent:ClearGoal()
		ent:StopMoving()
		ent:SetMaxYawSpeed(0)
		if self.OnHit then
			self:OnHit({ent})
		end
		if tbl.OnlyKill then
			if ent.OnFatality then
				ent:OnFatality(self,inFront,false,fType)
			end
			local anim = tbl.Kill
			anim = VJ.PICK(anim)
			if ent.AnimTbl_FatalitiesResponse && ent.AnimTbl_FatalitiesResponse[anim] then
				ent:VJ_ACT_PLAYACTIVITY(ent.AnimTbl_FatalitiesResponse[anim],true,false,true,0,{OnFinish=function(int)
					if int then return end
					if ent.ResetFatality then
						ent:ResetFatality()
					end
					if IsValid(self) then
						local dmginfo = DamageInfo()
						dmginfo:SetDamage(ent:Health())
						dmginfo:SetDamageType(DMG_SLASH)
						dmginfo:SetDamageForce(self:GetForward() *250)
						dmginfo:SetAttacker(self)
						dmginfo:SetInflictor(self)
						ent:TakeDamageInfo(dmginfo)
					end
				end})
			end
			self:VJ_ACT_PLAYACTIVITY(anim,true,false,true,0,{OnFinish=function(int)
				if int then return end
				self:SetState()
				self:ResetFatality()
			end})
		else
			local counter = math.random(1,100) <= (100 *(ent:Health() /ent:GetMaxHealth()))
			if ent.OnFatality then
				ent:OnFatality(self,inFront,counter,fType)
			end
			self:VJ_ACT_PLAYACTIVITY(tbl.Grab,true,false,true,0,{OnFinish=function(int,anim)
				if int then return end
				if IsValid(ent) then
					if ent.AnimTbl_FatalitiesResponse && ent.AnimTbl_FatalitiesResponse[tbl.Lift] then
						ent:VJ_ACT_PLAYACTIVITY(ent.AnimTbl_FatalitiesResponse[tbl.Lift],true,false,true)
					end
				end
				if tbl.Lift then
					self:VJ_ACT_PLAYACTIVITY(tbl.Lift,true,false,true,0,{OnFinish=function(int)
						if int then return end
						local anim = counter && tbl.Counter or tbl.Kill
						anim = VJ.PICK(anim)
						if IsValid(ent) then
							if ent.AnimTbl_FatalitiesResponse && ent.AnimTbl_FatalitiesResponse[anim] then
								ent:VJ_ACT_PLAYACTIVITY(ent.AnimTbl_FatalitiesResponse[anim],true,false,true,0,{OnFinish=function(int)
									if int then return end
									if ent.ResetFatality then
										ent:ResetFatality()
									end
									if !counter && IsValid(self) then
										ent.HasDeathAnimation = false
										local dmginfo = DamageInfo()
										dmginfo:SetDamage(ent:Health())
										dmginfo:SetDamageType(DMG_SLASH)
										dmginfo:SetDamageForce(self:GetForward() *250)
										dmginfo:SetAttacker(self)
										dmginfo:SetInflictor(self)
										ent:TakeDamageInfo(dmginfo)
									end
								end})
							end
						end
						self:VJ_ACT_PLAYACTIVITY(anim,true,false,true,0,{OnFinish=function(int)
							if int then return end
							self:SetState()
							self:ResetFatality()
						end})
					end})
				else
					local anim = counter && tbl.Counter or tbl.Kill
					anim = VJ.PICK(anim)
					if IsValid(ent) then
						if ent.AnimTbl_FatalitiesResponse && ent.AnimTbl_FatalitiesResponse[anim] then
							ent:VJ_ACT_PLAYACTIVITY(ent.AnimTbl_FatalitiesResponse[anim],true,false,true,0,{OnFinish=function(int)
								if int then return end
								if ent.ResetFatality then
									ent:ResetFatality()
								end
								if !counter && IsValid(self) then
									ent.HasDeathAnimation = false
									local dmginfo = DamageInfo()
									dmginfo:SetDamage(ent:Health())
									dmginfo:SetDamageType(DMG_SLASH)
									dmginfo:SetDamageForce(self:GetForward() *250)
									dmginfo:SetAttacker(self)
									dmginfo:SetInflictor(self)
									ent:TakeDamageInfo(dmginfo)
								end
							end})
						end
					end
					self:VJ_ACT_PLAYACTIVITY(anim,true,false,true,0,{OnFinish=function(int)
						if int then return end
						self:SetState()
						self:ResetFatality()
					end})
				end
			end})
		end
	end
end