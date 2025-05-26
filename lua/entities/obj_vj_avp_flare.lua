/*--------------------------------------------------
	*** Copyright (c) 2025 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName		= "Flare Round"
ENT.Author 			= "Cpt. Hazama"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Category		= "VJ Base"
---------------------------------------------------------------------------------------------------------------------------------------------
if CLIENT then
	VJ.AddKillIcon("obj_vj_avp_flare", ENT.PrintName, VJ.KILLICON_PROJECTILE)
	
	function ENT:Draw()
		self:DrawModel()
	end
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if !SERVER then return end

ENT.FuseTime = 15
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Initialize()
	self:SetModel("models/props_junk/flare.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)

	-- self:PhysicsInitSphere(1, "metal")

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:Wake()
		phys:EnableGravity(true)
		phys:SetBuoyancyRatio(0)
		phys:SetMass(5)
	end
		
	local prop = ents.Create("prop_physics")
	prop:SetModel("models/props_junk/popcan01a.mdl")
	prop:Spawn()
	prop:Activate()
	prop:SetPos(self:GetAttachment(1).Pos +self:GetUp())
	prop:SetAngles(self:GetUp():Angle())
	prop:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
	prop:SetModelScale(0)
	prop:SetParent(self)
	self:DeleteOnRemove(prop)

	ParticleEffectAttach("vj_avp_flare", PATTACH_POINT_FOLLOW, prop, 0)

	local light = ents.Create("light_dynamic")
	light:SetKeyValue("brightness", "0.01")
	light:SetKeyValue("distance", "1500")
	light:SetLocalPos(self:GetPos())
	light:SetLocalAngles( self:GetAngles() )
	light:Fire("Color", "255 0 0")
	light:SetParent(self)
	light:Spawn()
	light:Activate()
	light:Fire("TurnOn", "", 0)
	self:DeleteOnRemove(light)

	VJ.EmitSound(self,"cpthazama/avp/weapons/human/flare/flare_01_shot.ogg",60)

	self.CurrentIdleSound = CreateSound(self,"cpthazama/avp/weapons/human/flare/flare_01_loop.wav")
	self.CurrentIdleSound:SetSoundLevel(60)
	self.CurrentIdleSound:PlayEx(1, 100)
	
	timer.Simple(self.FuseTime, function()
		if IsValid(self) then
			self:Remove()
		end
	end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Use(activator, caller)
	if IsValid(activator) && activator:IsPlayer() then
		activator:PickupObject(self)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:PhysicsCollide(data, physobj)
	local hitEnt = data.HitEntity
	if IsValid(hitEnt) && (hitEnt:IsNPC() or hitEnt:IsPlayer() or hitEnt:IsNextBot()) then
		local dmg = DamageInfo()
		dmg:SetDamage(math.random(4,8))
		dmg:SetDamageType(DMG_BURN)
		dmg:SetAttacker(self)
		dmg:SetInflictor(self)
		dmg:SetDamagePosition(data.HitPos)
		hitEnt:TakeDamageInfo(dmg,self)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnTakeDamage(dmginfo)
	self:GetPhysicsObject():AddVelocity(dmginfo:GetDamageForce() *0.1)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnRemove()
	if self.CurrentIdleSound then
		self.CurrentIdleSound:Stop()
	end
	self:StopParticles()
end