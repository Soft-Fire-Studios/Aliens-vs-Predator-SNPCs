AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "obj_vj_projectile_base"
ENT.PrintName		= "Projectile"
ENT.Author 			= "Cpt. Hazama"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if !SERVER then return end

ENT.Model = {"models/cpthazama/avp/predators/equipment/spear.mdl"}
ENT.ProjectileType = VJ.PROJ_TYPE_GRAVITY
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
	self.IsGrounded = false

	-- if self.LifeTime then
		SafeRemoveEntityDelayed(self,60)
	-- end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnThink()
	if self.DoesContactDamage != true then
		sound.EmitHint(SOUND_DANGER, self:GetPos() +self:GetVelocity(), self.RadiusDamageRadius *1.5, 0.2, self)
	end

	if IsValid(self.Predator) then
		local pred = self.Predator
		if self.IsGrounded then
			if self:GetPos():Distance(pred:GetPos() +pred:OBBCenter()) <= 150 then
				pred:OnGrabSpear(self)
				self:Remove()
				return
			end
		end
	else
		self:Remove()
		return
	end

	if self.OnThink2 then
		self:OnThink2()
	end

	self:NextThink(CurTime())
	return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnCollision(data, phys)
	if data.HitEntity == Entity(0) or data.HitWorld then
		phys:EnableGravity(false)
		phys:EnableCollisions(false)
		self:SetMoveType(MOVETYPE_NONE)
		self:SetLocalVelocity(Vector(0,0,0))
		self:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
		self:SetSolid(SOLID_NONE)
		self.DoesDirectDamage = false
		self.IsGrounded = true
		VJ.EmitSound(self,"cpthazama/avp/weapons/predator/spear/prd_spear_impact_metal_0" .. math.random(1,2) .. ".ogg",80)
		local fx = EffectData()
		fx:SetOrigin(data.HitPos)
		fx:SetScale(5)
		fx:SetMagnitude(2)
		fx:SetNormal(data.HitNormal)
		util.Effect("ElectricSpark",fx)
		self:SetPos(data.HitPos +data.HitNormal *-20)
		local ang = data.HitNormal:Angle()
		-- local ang2 = self:GetAngles()
		-- ang.y = ang2.y +15
		self:SetAngles(ang)
	else
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
	if !self.IsBeingGrabbed && IsValid(self.Predator) then
		self.Predator:SetBodygroup(self.Predator:FindBodygroupByName("equip_spear"),1)
	end
	for _,snd in pairs(self.DeleteSounds) do
		if snd then
			snd:Stop()
		end
	end
end