AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "obj_vj_projectile_base"
ENT.PrintName		= "Projectile"
ENT.Author 			= "Cpt. Hazama"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Information		= "Projectile, usually used for NPCs & Weapons"
ENT.Category		= "Projectiles"

function ENT:SetupDataTables()
	self:NetworkVar("Entity",0,"TagOwner")
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if !SERVER then return end

ENT.Model = "models/vj_base/projectiles/spit_acid_large.mdl"

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
		self.CollisionBehavior = VJ.PROJ_COLLISION_REMOVE
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
		self.CollisionBehavior = VJ.PROJ_COLLISION_REMOVE
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

	if self.LifeTime then
		SafeRemoveEntityDelayed(self,self.LifeTime)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnThink()
	if self.DoesContactDamage != true then
		sound.EmitHint(SOUND_DANGER, self:GetPos() +self:GetVelocity(), self.RadiusDamageRadius *1.5, 0.2, self)
	end

	if self.OnThink2 then
		self:OnThink2()
	end

	self:NextThink(CurTime())
	return true
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
	for _,snd in pairs(self.DeleteSounds) do
		if snd then
			snd:Stop()
		end
	end
end