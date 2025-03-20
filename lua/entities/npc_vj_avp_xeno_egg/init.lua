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
ENT.SightAngle = 360
ENT.MovementType = VJ_MOVETYPE_STATIONARY
ENT.CanTurnWhileStationary = false

ENT.BloodColor = VJ.BLOOD_COLOR_YELLOW
ENT.BloodParticle = {"vj_avp_blood_xeno"}
ENT.BloodDecal = {"VJ_AVP_BloodXenomorph"}
ENT.HasBloodPool = false
ENT.VJ_NPC_Class = {"CLASS_XENOMORPH"}

ENT.HasMeleeAttack = false
ENT.CallForHelp = false

ENT.HasDeathCorpse = true
ENT.DeathCorpseEntityClass = "prop_vj_animatable"
---------------------------------------------------------------------------------------------------------------------------------------------
local table_insert = table.insert
--
function ENT:CustomOnInitialize()
	self.Opened = false

	self:SetAngles(Angle(0,math.random(0,360),0))
	self:AddFlags(FL_NOTARGET)

	if self.VJ_AVP_K_Xenomorph then
		self.VJ_NPC_Class = {"CLASS_XENOMORPH_KSERIES"}
		if GetConVar("vj_avp_kseries_ally"):GetBool() then
			table_insert(self.VJ_NPC_Class,"CLASS_WEYLAND_YUTANI")
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:TranslateActivity(act)
	if act == ACT_IDLE && self.Opened then
		return ACT_IDLE_ANGRY
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Open()
	self:PlayAnim(ACT_ARM,true,false,false)
	VJ.EmitSound(self,"cpthazama/avp/xeno/egg/egg_open_0" .. math.random(1,3) .. ".ogg",75)
	timer.Simple(0.5,function()
		if IsValid(self) then
			local royal = self.VJ_AVP_XenomorphEggRoyal
			for _ = 1, (royal && 3 or 1) do
				local facehugger
				if self.VJ_AVP_K_Xenomorph then
					facehugger = ents.Create(royal && "npc_vj_avp_kxeno_facehugger_queen" or "npc_vj_avp_kxeno_facehugger")
				else
					facehugger = ents.Create(royal && "npc_vj_avp_xeno_facehugger_queen" or "npc_vj_avp_xeno_facehugger")
				end
				facehugger:SetPos(self:GetPos() +(royal && (self:GetUp() *self:OBBMaxs().z +VectorRand() *6) or vector_origin))
				facehugger:SetAngles(self:GetAngles() +Angle(0,math.random(0,360),0))
				facehugger:SetOwner(self)
				facehugger:Spawn()
				facehugger:Activate()
				facehugger:SetOwner(self)
				facehugger:ForceSetEnemy(self:GetEnemy(),true)
				if royal then
					facehugger:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
					facehugger:SetGroundEntity(NULL)
					local vec = VectorRand(-150,150)
					vec.z = math.abs(vec.z)
					facehugger:SetVelocity(vec)
					timer.Simple(0.15,function()
						if IsValid(facehugger) then
							facehugger:SetCollisionGroup(COLLISION_GROUP_NPC)
						end
					end)
				else
					facehugger:SetNoDraw(true)
					facehugger:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK)
					timer.Simple(0.15,function()
						if IsValid(facehugger) then
							facehugger:SetNoDraw(false)
						end
					end)
					facehugger:PlayAnim(ACT_ARM,true,false,false,0,{OnFinish=function(i,anim)
						if i then return end
						facehugger:SetPos(facehugger:GetBonePosition(2))
						facehugger:SetState()
					end})
				end
			end
			SafeRemoveEntityDelayed(self,30)
		end
	end)
	self.Opened = true
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnAlert(ent)
	if !self.Opened then
		self:Open()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnDamaged(dmginfo, hitgroup, status)
	if status == "PreDamage" then
		local dmgInflictor = dmginfo:GetInflictor()
		local dmgAttacker = dmginfo:GetAttacker()
		local isFireDmg = self:IsOnFire() && IsValid(dmgInflictor) && IsValid(dmgAttacker) && dmgInflictor:GetClass() == "entityflame" && dmgAttacker:GetClass() == "entityflame"
		if isFireDmg then
			dmginfo:ScaleDamage(2)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnBleed(dmginfo,hitgroup)
	self:Acid(dmginfo:GetDamagePosition())
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnMaintainRelationships(ent, entFri, entDist)
	if entFri && ent.VJ_AVP_XenomorphCarrier && !self.Opened && entDist <= 400 && ent:GetFacehuggerCount() < 9 then
		self:Open()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnDeath(dmginfo, hitgroup, status)
	if status == "Finish" then
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
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnCreateDeathCorpse(dmginfo, hitgroup, corpse)
	corpse:SetPos(self:GetPos() +self:GetUp() *-4)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
	if IsValid(self.Queen) then
		for _,v in ipairs(self.Queen.Eggs) do
			if IsValid(v) && v == self then
				table.remove(self.Queen.Eggs,_)
			end
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local math_acos = math.acos
local math_deg = math.deg
local math_abs = math.abs
--
function ENT:OnThinkActive()
	local pos = self:GetPos()
	local len = self:GetUp() *50
	local ang = self:GetAngles()
	local ang_y = Angle(0,ang.y,0)
	local refreshRate = FrameTime() *20
	local _, maxs = self:GetCollisionBounds()
	-- mins = mins *2
	-- maxs = maxs *2
	local posForward, posBackward, posRight, posLeft
	local directionVectors = {
		forward = ang_y:Forward(),
		backward = ang_y:Forward() * -1,
		right = ang_y:Right(),
		left = ang_y:Right() * -1,
	}
	local hits = {}
	for direction, vector in pairs(directionVectors) do
		local startPos = pos + vector * ((vector == directionVectors.right or vector == directionVectors.left) and maxs.y or maxs.x)
		local tr = util.TraceLine({
			start = startPos,
			endpos = startPos - len,
			filter = self
		})
		hits[direction] = tr.HitPos
		if direction == "forward" then
			posForward = startPos
		elseif direction == "backward" then
			posBackward = startPos
		elseif direction == "right" then
			posRight = startPos
		elseif direction == "left" then
			posLeft = startPos
		end
	end

	local hitForward = hits.forward
	local hitBackward = hits.backward
	local hitRight = hits.right
	local hitLeft = hits.left
	local pitch
	local roll
	local pitchDif = math_abs(hitForward.z -hitBackward.z)
	local rollDif = math_abs(hitLeft.z -hitRight.z)
	if posForward:Distance(hitForward) > posBackward:Distance(hitBackward) then
		pitch = 90 -math_deg(math_acos(pitchDif /hitForward:Distance(posBackward)))
	else
		pitch = -(90 -math_deg(math_acos(pitchDif /hitBackward:Distance(posForward))))
	end
	if posLeft:Distance(hitLeft) > posRight:Distance(hitRight) then
		roll = -(90 -math_deg(math_acos(rollDif /hitLeft:Distance(posRight))))
	else
		roll = 90 -math_deg(math_acos(rollDif /hitRight:Distance(posLeft)))
	end

	local tr = util.TraceLine({
		start = pos,
		endpos = pos -len,
		filter = self
	})

	self.Incline = pitch
	self:ManipulateBonePosition(0,Vector(0,0,Lerp(refreshRate,self:GetManipulateBonePosition(0).z,-(tr.HitPos +tr.HitNormal):Distance(pos))))
	self:SetAngles(LerpAngle(refreshRate,self:GetAngles(),Angle(pitch,ang.y,roll)))
end