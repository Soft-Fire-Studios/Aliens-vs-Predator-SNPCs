AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "obj_vj_projectile_base"
ENT.PrintName		= "Projectile"
ENT.Author 			= "Cpt. Hazama"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Information		= "Projectiles for my addons"
ENT.Category		= "Projectiles"
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if !SERVER then return end

ENT.Model = {"models/spitball_large.mdl"}

-- ENT.MoveType = MOVETYPE_FLY
---------------------------------------------------------------------------------------------------------------------------------------------
-- function ENT:CustomOnInitializeBeforePhys()
-- 	self:PhysicsInitSphere(1, "plastic")
-- end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomPhysicsObjectOnInitialize(phys)
	phys:SetMass(1)
	phys:EnableGravity(false)
	phys:EnableDrag(false)
	phys:EnableCollisions(true)
	phys:SetBuoyancyRatio(0)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetAttackType(aType,dmg,dmgtype,radius,force,realistic)
	if aType == 1 then -- Direct
		self.DoesContactDamage = false
		self.DoesRadiusDamage = false
		self.DoesDirectDamage = true

		self.DirectDamage = dmg
		self.DirectDamageType = dmgtype
		self.RemoveOnHit = true
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
		self.RemoveOnHit = true
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:AddSound(snd,lvl,pit)
	local cSnd = VJ_CreateSound(self,VJ_PICK(snd) or snd,lvl or 70,pit or 100)
	table.insert(self.DeleteSounds,cSnd)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:DrawShadow(false)
	self:SetSolid(SOLID_BBOX)
	-- self:SetSize(6)
	
	self.DeleteSounds = {}

	if self.OnInit then
		self:OnInit()
	end

	if self.LifeTime then
		SafeRemoveEntityDelayed(self,self.LifeTime)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	if self.DoesContactDamage != true then
		sound.EmitHint(SOUND_DANGER, self:GetPos() +self:GetVelocity(), self.RadiusDamageRadius *1.5, 0.2, self)
	end

	if self.OnThink then
		self:OnThink()
	end

	self:NextThink(CurTime())
	return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
local defAngle = Angle(0, 0, 0)
--
function ENT:DeathEffects(data, phys)
	if self.OnDeath then
		self:OnDeath(data, defAngle, data.HitPos)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
	for _,snd in pairs(self.DeleteSounds) do
		if snd then
			snd:Stop()
		end
	end
end