AddCSLuaFile()

ENT.Base 			= "base_gmodentity"
ENT.Type 			= "anim"
ENT.PrintName 		= "Ammo/Weapon Pickup"
ENT.Author 			= "Cpt. Hazama"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Category		= "Aliens vs Predator"
ENT.AutomaticFrameAdvance = true

-- ENT.Spawnable 		= true
-- ENT.AdminSpawnable 	= true

ENT.VJ_AVP_Ammo = true

ENT.PickupType = 0 -- 0 = Stimpack, 1 = Pulse Rifle, 2 = Pistol, 3 = Shotgun, 4 = Flamethrower, 5 = Scoped Rifle, 6 = Smartgun, 7 = Grenades

local RESET_TIMES = {
	[1] = 30, -- Stimpack
	[2] = 60, -- Pulse Rifle
	[3] = 60, -- Pistol
	[4] = 60, -- Shotgun
	[5] = 120, -- Flamethrower
	[6] = 120, -- Scoped Rifle
	[7] = 180, -- Smartgun
	[8] = 120, -- Grenades
}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetupDataTables()
	self:NetworkVar("Float","ResetTime")
	self:NetworkVar("Int","PickupType")
end
---------------------------------------------------------------------------------------------------------------------------------------------
if CLIENT then
	local WIRE_MAT = Material("models/wireframe")
	local MODELLIST = {
		[1] = "models/items/healthkit.mdl",
		[2] = "models/cpthazama/avp/weapons/w_pulserifle.mdl",
		[3] = "models/cpthazama/avp/weapons/pistol.mdl",
		[4] = "models/cpthazama/avp/weapons/w_shotgun.mdl",
		[5] = "models/cpthazama/avp/weapons/w_flamethrower.mdl",
		[6] = "models/cpthazama/avp/weapons/w_scopedrifle.mdl",
		[7] = "models/cpthazama/avp/weapons/w_smartgun.mdl",
		[8] = "models/weapons/ar2_grenade.mdl",
	}
	local WEAPONMOD = {
		[1] = {PosOffset = Vector(0,-2,5), Scale = 0.4},
		[2] = {PosOffset = Vector(0,-5,10), Scale = 1},
		[3] = {PosOffset = Vector(0,-3,10), Scale = 1},
		[4] = {PosOffset = Vector(0,-10,10), Scale = 1},
		[5] = {PosOffset = Vector(0,-13,10), Scale = 1},
		[6] = {PosOffset = Vector(0,-4,10), Scale = 1},
		[7] = {PosOffset = Vector(0,-25,7), Scale = 1},
		[8] = {PosOffset = Vector(0,0,7), AngleOffset = Angle(-90,0,0), Scale = 2.5}
	}

    function ENT:EnsureWeaponCSM()
        if !IsValid(self.CS_Weapon) then
			local pickUpType = self:GetPickupType()
            self.CS_Weapon = ClientsideModel(MODELLIST[pickUpType +1],RENDERGROUP_TRANSLUCENT)
            if IsValid(self.CS_Weapon) then
                self.CS_Weapon:SetNoDraw(true)
				self.CS_Weapon:SetModelScale(WEAPONMOD[pickUpType +1].Scale)
				if WEAPONMOD[pickUpType +1].AngleOffset then
					self.CS_Weapon:SetAngles(self:GetAngles() + WEAPONMOD[pickUpType +1].AngleOffset)
				else
					self.CS_Weapon:SetAngles(self:GetAngles())
				end
            end
        end
    end

	function ENT:Draw()
		if CurTime() < self:GetResetTime() then
			return false
		end
        self:EnsureWeaponCSM()
        if !IsValid(self.CS_Weapon) then return end
		local pickUpType = self:GetPickupType()
		local offset = WEAPONMOD[pickUpType +1].PosOffset
        self.CS_Weapon:SetPos(self:GetPos() + self:GetUp() * offset.z + self:GetRight() * offset.x + self:GetForward() * offset.y)
        render.SuppressEngineLighting(true)
        render.SetBlend(1)
		if pickUpType >= 1 && pickUpType <= 6 then
        	render.SetColorModulation(0.788,1,1)
		elseif pickUpType == 7 then
			render.SetColorModulation(0.988,1,0.345)
		else
			render.SetColorModulation(0.298,1,0.357)
		end
        render.MaterialOverride(WIRE_MAT)
        self.CS_Weapon:DrawModel()
        render.MaterialOverride()
        render.SetColorModulation(1,1,1)
        render.SetBlend(1)
        render.SuppressEngineLighting(false)
	end
	
	function ENT:DrawTranslucent()
		self:Draw()
	end

    function ENT:OnRemove()
        if IsValid(self.CS_Weapon) then
            self.CS_Weapon:Remove()
            self.CS_Weapon = nil
        end
    end
	return
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Initialize()
	self:SetModel("models/cpthazama/avp/misc/rc_battery.mdl")
	self:SetSolid(SOLID_NONE)
	self:SetUseType(SIMPLE_USE)
	self:SetAngles(Angle(0,VJ.PICK({0,90,180,270}),0))
	ParticleEffectAttach(((self.PickupType >= 1 && self.PickupType <= 6) && "vj_avp_pickup_ammo" or self.PickupType == 7 && "vj_avp_pickup_grenade") or "vj_avp_pickup_stim",PATTACH_ABSORIGIN_FOLLOW,self,0)

	if self.PickupType == 1 then
		self.WeaponPickup = "weapon_vj_avp_pulserifle"
	elseif self.PickupType == 2 then
		self.WeaponPickup = "weapon_vj_avp_pistol"
	elseif self.PickupType == 3 then
		self.WeaponPickup = "weapon_vj_avp_shotgun"
	elseif self.PickupType == 4 then
		self.WeaponPickup = "weapon_vj_avp_flamethrower"
	elseif self.PickupType == 5 then
		self.WeaponPickup = "weapon_vj_avp_scopedrifle"
	elseif self.PickupType == 6 then
		self.WeaponPickup = "weapon_vj_avp_smartgun"
	end

	self:SetPickupType(self.PickupType)

	self.Disabled = false
end
---------------------------------------------------------------------------------------------------------------------------------------------
local math_Clamp = math.Clamp
--
function ENT:GrabEquip(ent)
	self:SetResetTime(CurTime() +RESET_TIMES[self.PickupType +1])
	self.Disabled = true
	self:StopParticles()
	local pickupType = self.PickupType
	if pickupType == 0 then
		ent:SetHealth(math_Clamp(ent:Health() +50,0,ent:GetMaxHealth()))
		ent:ChatPrint("Picked up a Stimpack! Health +50")
		VJ.EmitSound(ent,"cpthazama/avp/shared/pickup_health.ogg",70)
	elseif pickupType >= 1 && pickupType <= 6 then
		if !ent:HasWeapon(self.WeaponPickup) then
			local wep = ent:Give(self.WeaponPickup)
			ent:ChatPrint("Picked up a " .. (wep.PrintName or wep:GetName()) .. "!")
			VJ.EmitSound(ent,"cpthazama/avp/shared/pickup_weapon.ogg",70)
		else
			local wep = ent:GetWeapon(self.WeaponPickup)
			if IsValid(wep) then
				local ammoType = wep:GetPrimaryAmmoType()
				if ammoType then
					ent:GiveAmmo(wep:GetMaxClip1() *2,ammoType,true)
					ent:ChatPrint("Picked up ammo for " .. (wep.PrintName or wep:GetName()) .. "!")
				end
			end
			VJ.EmitSound(ent,"cpthazama/avp/shared/pickup_ammo.ogg",70)
		end
	elseif pickupType == 7 then
		ent:GiveAmmo(2,"SMG1_Grenade",true)
		ent:ChatPrint("Picked up 2 underbarrel grenades!")
		VJ.EmitSound(ent,"cpthazama/avp/shared/pickup_tool.ogg",70)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Think()
	local curTime = CurTime()
	local resetT = self:GetResetTime()
	if resetT < curTime && self.Disabled then
		self.Disabled = false
		ParticleEffectAttach(((self.PickupType >= 1 && self.PickupType <= 6) && "vj_avp_pickup_ammo" or self.PickupType == 7 && "vj_avp_pickup_grenade") or "vj_avp_pickup_stim",PATTACH_ABSORIGIN_FOLLOW,self,0)
	elseif !self.Disabled then
		for _,v in pairs(ents.FindInSphere(self:GetPos(), 25)) do
			if v:IsPlayer() && v:Alive() then
				self:GrabEquip(v)
				break
			end
		end
	end

	self:NextThink(CurTime())
	return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnRemove()
	self:StopParticles()
end