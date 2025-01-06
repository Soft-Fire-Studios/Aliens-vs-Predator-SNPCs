/*--------------------------------------------------
	*** Copyright (c) 2012-2025 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "obj_vj_projectile_base"
ENT.PrintName		= "Rifle Grenade"
ENT.Author 			= "Cpt. Hazama"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Information		= "Projectile, usually used for NPCs & Weapons"
ENT.Category		= "VJ Base"

ENT.Spawnable = false
ENT.AdminOnly = false

ENT.VJ_ID_Danger = true
---------------------------------------------------------------------------------------------------------------------------------------------
if CLIENT then
	local Name = "M103 HE Grenade"
	local LangName = "obj_vj_avp_m103"
	language.Add(LangName, Name)
	killicon.Add(LangName,"HUD/killicons/default",Color(255,80,0,255))
	language.Add("#"..LangName, Name)
	killicon.Add("#"..LangName,"HUD/killicons/default",Color(255,80,0,255))
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if !SERVER then return end

ENT.Model = {"models/weapons/ar2_grenade.mdl"} -- Model(s) to spawn with | Picks a random one if it's a table
ENT.ProjectileType = VJ.PROJ_TYPE_GRAVITY
ENT.DoesRadiusDamage = true -- Should it deal radius damage when it collides with something?
ENT.RadiusDamageRadius = 150
ENT.RadiusDamage = 80
ENT.RadiusDamageUseRealisticRadius = true -- Should the damage decrease the farther away the hit entity is from the radius origin?
ENT.RadiusDamageType = DMG_BLAST
ENT.RadiusDamageForce = 90 -- Damage force to apply to the hit entity | false = Don't apply any force
ENT.CollisionDecals = {"Scorch"} -- Decals that paint when the projectile dies | It picks a random one from this table
ENT.OnRemoveSoundLevel = 100

---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:InitPhys()
	self:PhysicsInitSphere(5, "metal_bouncy")
	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:AddAngleVelocity(Vector(0, math.random(300, 400), 0))
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Init()
	ParticleEffectAttach("smoke_gib_01", PATTACH_ABSORIGIN_FOLLOW, self, 0)
	ParticleEffectAttach("Rocket_Smoke_Trail", PATTACH_ABSORIGIN_FOLLOW, self, 0)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnDestroy()
	local myPos = self:GetPos()
	
	local effectData = EffectData()
	effectData:SetOrigin(myPos)
	//effectData:SetScale( 500 )
	util.Effect("HelicopterMegaBomb", effectData)
	util.Effect("ThumperDust", effectData)
	util.Effect("VJ_Small_Explosion1", effectData)
	sound.Play("cpthazama/avp/weapons/human/pulse_rifle/pulse_rifle_grenade_explode_01.ogg",myPos,110)
	sound.Play("cpthazama/avp/weapons/human/pulse_rifle/pulse_rifle_grenade_explode_near_01.ogg",myPos,80)

	local expLight = ents.Create("light_dynamic")
	expLight:SetKeyValue("brightness", "4")
	expLight:SetKeyValue("distance", "300")
	expLight:SetLocalPos(myPos)
	expLight:SetLocalAngles(self:GetAngles())
	expLight:Fire("Color", "255 150 0")
	expLight:SetParent(self)
	expLight:Spawn()
	expLight:Activate()
	expLight:Fire("TurnOn", "", 0)
	self:DeleteOnRemove(expLight)
	
	util.ScreenShake(myPos, 100, 200, 1, 2500)
end