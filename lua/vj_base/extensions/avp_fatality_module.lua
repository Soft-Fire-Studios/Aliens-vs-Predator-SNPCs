local math_acos = math.acos
local math_abs = math.abs
local math_rad = math.rad
local math_cos = math.cos
--
function ENT:CanUseFatality(ent)
	local inFront = (ent:GetForward():Dot((self:GetPos() -ent:GetPos()):GetNormalized()) > math_cos(math_rad(80)))
	if ent.VJ_AVP_NPC && (ent.Flinching or ent:Health() <= (ent:GetMaxHealth() *0.15) or !inFront) && !ent.Dead && !ent.InFatality && !IsValid(self.FatalityEnt) && !IsValid(ent.FatalityEnt) then
		return true, inFront
	end
	return false, inFront
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
		if !tbl then return false end
		self.FatalityEnt = ent
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
					if int then self:ResetFatality(ent) return end
					ent:SetState()
					ent.GodMode = false
					ent.InFatality = false
					if !counter && IsValid(self) then
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
				if int then self:ResetFatality(ent) return end
				self:SetState()
				self:ResetFatality(ent)
			end})
		else
			local counter = math.random(1,3) == 1
			if ent.OnFatality then
				ent:OnFatality(self,inFront,counter,fType)
			end
			self:VJ_ACT_PLAYACTIVITY(tbl.Grab,true,false,true,0,{OnFinish=function(int,anim)
				if int then self:ResetFatality(ent) return end
				if IsValid(ent) then
					if ent.AnimTbl_FatalitiesResponse && ent.AnimTbl_FatalitiesResponse[tbl.Lift] then
						ent:VJ_ACT_PLAYACTIVITY(ent.AnimTbl_FatalitiesResponse[tbl.Lift],true,false,true)
					end
				end
				if tbl.Lift then
					self:VJ_ACT_PLAYACTIVITY(tbl.Lift,true,false,true,0,{OnFinish=function(int)
						if int then self:ResetFatality(ent) return end
						local anim = counter && tbl.Counter or tbl.Kill
						anim = VJ.PICK(anim)
						if IsValid(ent) then
							if ent.AnimTbl_FatalitiesResponse && ent.AnimTbl_FatalitiesResponse[anim] then
								ent:VJ_ACT_PLAYACTIVITY(ent.AnimTbl_FatalitiesResponse[anim],true,false,true,0,{OnFinish=function(int)
									if int then self:ResetFatality(ent) return end
									ent:SetState()
									ent.GodMode = false
									ent.InFatality = false
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
							if int then self:ResetFatality(ent) return end
							self:SetState()
							self:ResetFatality(ent)
						end})
					end})
				else
					local anim = counter && tbl.Counter or tbl.Kill
					anim = VJ.PICK(anim)
					if IsValid(ent) then
						if ent.AnimTbl_FatalitiesResponse && ent.AnimTbl_FatalitiesResponse[anim] then
							ent:VJ_ACT_PLAYACTIVITY(ent.AnimTbl_FatalitiesResponse[anim],true,false,true,0,{OnFinish=function(int)
								if int then self:ResetFatality(ent) return end
								ent:SetState()
								ent.GodMode = false
								ent.InFatality = false
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
						if int then self:ResetFatality(ent) return end
						self:SetState()
						self:ResetFatality(ent)
					end})
				end
			end})
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:ResetFatality(ent)
	self.FatalityEnt = nil
	self:SetState()
	self:SetMaxYawSpeed(self.TurningSpeed)
	if IsValid(ent) then
		ent.GodMode = false
		ent.InFatality = false
		ent.FatalityKiller = nil
		ent:SetState()
		ent.FatalityEnt = nil
		ent:SetMaxYawSpeed(ent.TurningSpeed)
	end
end