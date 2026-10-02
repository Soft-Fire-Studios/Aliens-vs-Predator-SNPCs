AddCSLuaFile()

ENT.Base = "sent_vj_avp_ammo"
ENT.Type = "anim"
ENT.PrintName = "Ammo/Weapon Pickup"
ENT.Author = "Cpt. Hazama"
ENT.Category = "Aliens vs Predator"
ENT.Spawnable = false
ENT.AdminOnly = true
ENT.VJ_AVP_TDMPickup = true

if CLIENT then return end

function ENT:Think()
    local curTime = CurTime()
    if self:GetResetTime() < curTime && self.Disabled then
        self.Disabled = false
        local pickupType = self:GetPickupType()
        local effect = ((pickupType >= 1 && pickupType <= 6) && "vj_avp_pickup_ammo") or (pickupType == 7 && "vj_avp_pickup_grenade") or "vj_avp_pickup_stim"
        ParticleEffectAttach(effect, PATTACH_ABSORIGIN_FOLLOW, self, 0)
    end

    self:NextThink(CurTime() + 0.05)
    return true
end
