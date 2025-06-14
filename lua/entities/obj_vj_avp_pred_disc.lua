AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "obj_vj_projectile_base"
ENT.PrintName		= "Projectile"
ENT.Author 			= "Cpt. Hazama"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if !SERVER then return end

ENT.Model = {"models/cpthazama/avp/predators/equipment/battledisc.mdl"}

ENT.Speed = 1200
ENT.CollisionBehavior = VJ.PROJ_COLLISION_PERSIST
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:InitPhys()
	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableCollisions(true)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetAttackType(aType,dmg,dmgtype,radius,force,realistic)
	if aType == 1 then -- Direct
		self.DoesContactDamage = false
		self.DoesRadiusDamage = false
		self.DoesDirectDamage = true

		self.DirectDamage = dmg
		self.DirectDamageType = dmgtype
	elseif aType == 2 then -- Radius
		self.DoesContactDamage = false
		self.DoesDirectDamage = false
		self.DoesRadiusDamage = true
		
		self.RadiusDamageRadius = radius
		self.RadiusDamageUseRealisticRadius = realistic
		self.RadiusDamage = dmg
		self.RadiusDamageType = dmgtype
		self.RadiusDamageForce = force or 100
		self.RadiusDamageDisableVisibilityCheck = !realistic
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:AddSound(snd,lvl,pit)
	local cSnd = VJ.CreateSound(self,VJ.PICK(snd) or snd,lvl or 70,pit or 100)
	table.insert(self.DeleteSounds,cSnd)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Init()
	self:DrawShadow(false)
	self:SetSolid(SOLID_BBOX)
	-- self:SetSize(6)
	
	self.DeleteSounds = {}
	self.ReturnTime = CurTime() +6.5
	self.HitT = 0
	self.HitDir = Vector(0,0,0)

	local snd = "cpthazama/avp/weapons/predator/battle_disc/disc_loop_0" .. math.random(1,6) .. ".wav"
	self.Loop = CreateSound(self,snd)
	self.Loop:SetSoundLevel(70)
	self.Loop:Play()
	self.Loop:ChangePitch(math.random(90,110))
	self.NextSndT = CurTime() +SoundDuration(snd)

	util.SpriteTrail(self,0,Color(255,55,55),true,80,1,0.15,1 /(10 +1) *0.5,"VJ_Base/sprites/trail.vmt")

	SafeRemoveEntityDelayed(self,15)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnThink()
	if self.DoesContactDamage != true then
		sound.EmitHint(SOUND_DANGER, self:GetPos() +self:GetVelocity(), self.RadiusDamageRadius *1.5, 0.2, self)
	end

	if self.OnThink2 then
		self:OnThink2()
	end

	if CurTime() > self.NextSndT then
		local snd = "cpthazama/avp/weapons/predator/battle_disc/disc_loop_0" .. math.random(1,6) .. ".wav"
		self.Loop:Stop()
		self.Loop = CreateSound(self,snd)
		self.Loop:SetSoundLevel(70)
		self.Loop:Play()
		self.NextSndT = CurTime() +SoundDuration(snd)
	end

	if IsValid(self.Predator) then
		local pred = self.Predator
		local lockOn = pred:GetLockOn()
		local goalPos = IsValid(pred.VJ_TheController) && (IsValid(lockOn) && lockOn:Visible(self) && lockOn:EyePos() or !IsValid(lockOn) && pred:GetEnemy():EyePos()) or !IsValid(pred.VJ_TheController) && (IsValid(pred:GetEnemy()) && pred:GetEnemy():EyePos() or false)
		if CurTime() > self.ReturnTime then
			self.ReturnTo = true
			goalPos = pred:GetPos() +pred:OBBCenter()
			if self:GetPos():Distance(goalPos) <= 150 then
				pred:OnCatchDisc(self)
				self:Remove()
				return
			end
		end
		if !goalPos then
			local att = pred:GetAttachment(pred:LookupAttachment("laser"))
			local tr = util.TraceLine({
				start = att.Pos,
				endpos = att.Pos +att.Ang:Forward() *2000,
				filter = {self,pred},
				mask = MASK_SHOT
			})
			goalPos = tr.HitPos
		end

		local phys = self:GetPhysicsObject()
		if self.HitT > CurTime() then
			phys:SetVelocity(self.HitDir *-self.Speed)
		else
			phys:SetVelocity((goalPos -self:GetPos()):GetNormal() * self.Speed)
		end
		self:SetAngles(self:GetVelocity():GetNormal():Angle())
	else
		self:Remove()
		return
	end

	self:NextThink(CurTime())
	return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Touch(ent)
	local data = {
		HitEntity = ent,
		HitPos = self:GetPos(),
		HitNormal = self:GetForward(),
		HitGroup = 0,
		HitDistance = 0,
		HitWorld = ent:IsWorld(),
	}
	self:DealDamage(data, self:GetPhysicsObject())
	if VJ.IsProp(ent) then
		local phys = ent:GetPhysicsObject()
		if IsValid(phys) then
			phys:ApplyForceCenter(self:GetForward() *1000)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnCollision(data, phys)
	if data.HitEntity == Entity(0) or data.HitWorld then
		self.HitT = CurTime() +(self.ReturnTo && 0.05 or 0.15)
		self.HitDir = data.HitNormal +Vector(math.Rand(-0.3,0.3),math.Rand(-0.3,0.3),math.Rand(-0.3,0.3))
		VJ.EmitSound(self,"cpthazama/avp/weapons/predator/battle_disc/disc_impact_generic_short_0" .. math.random(1,6) .. ".ogg",80)
		local fx = EffectData()
		fx:SetOrigin(data.HitPos)
		fx:SetScale(5)
		fx:SetMagnitude(2)
		fx:SetNormal(data.HitNormal)
		util.Effect("ElectricSpark",fx)
	else
		local pred = self.Predator
		if data.HitEntity == self.Predator or IsValid(pred) && data.HitEntity == pred.VJ_TheController then return end
		self.HitT = CurTime() +(self.ReturnTo && 0.05 or 0.25)
		self.HitDir = data.HitNormal +Vector(math.Rand(-0.3,0.3),math.Rand(-0.3,0.3),math.Rand(-0.3,0.3))
		VJ.EmitSound(self,"cpthazama/avp/weapons/predator/wrist_blades/prd_wrist_impact_flesh_mn_0" .. math.random(1,3) .. ".ogg",75)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local defAngle = Angle(0, 0, 0)
--
function ENT:OnDestroy(data, phys)
	if self.OnDeath then
		self:OnDeath(data, defAngle, data.HitPos)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
	self.Loop:Stop()
	for _,snd in pairs(self.DeleteSounds) do
		if snd then
			snd:Stop()
		end
	end
	if IsValid(self.Predator) then
		self.Predator:OnCatchDisc(self)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:PhysicsCollide(data, phys)
	if self.Dead then return end
	//self.Dead = true
	if self:OnCollision(data, phys) != false then
		local colBehavior = self.CollisionBehavior
		if !colBehavior then return end
		if colBehavior == VJ.PROJ_COLLISION_REMOVE then
			self.Dead = true
			-- self:DealDamage(data, phys)
			self:PlaySound("OnCollide")
			if !self.PaintedFinalDecal then
				local decals = VJ.PICK(self.CollisionDecal)
				if decals then
					self.PaintedFinalDecal = true
					util.Decal(decals, data.HitPos + data.HitNormal, data.HitPos - data.HitNormal)
				end
			end
			if self.ShakeWorldOnDeath == true then util.ScreenShake(data.HitPos, self.ShakeWorldOnDeathAmplitude or 16, self.ShakeWorldOnDeathFrequency or 200, self.ShakeWorldOnDeathDuration or 1, self.ShakeWorldOnDeathRadius or 3000) end -- !!!!!!!!!!!!!! DO NOT USE THIS VARIABLE !!!!!!!!!!!!!! [Backwards Compatibility!]
			self:Destroy(data, phys)
		elseif colBehavior == VJ.PROJ_COLLISION_PERSIST then
			if CurTime() < self.NextPersistCollisionT then return end
			-- self:DealDamage(data, phys)
			self:PlaySound("OnCollide")
			if !self.PaintedFinalDecal then
				local decals = VJ.PICK(self.CollisionDecal)
				if decals then
					util.Decal(decals, data.HitPos + data.HitNormal, data.HitPos - data.HitNormal)
				end
			end
			self:OnCollisionPersist(data, phys)
			self.NextPersistCollisionT = CurTime() + 1
		end
	end
end