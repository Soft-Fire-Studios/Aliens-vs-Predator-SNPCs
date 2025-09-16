SWEP.Base 						= "weapon_base"
SWEP.Author 					= "Cpt. Hazama"
SWEP.Contact					= "http://steamcommunity.com/groups/vrejgaming"
SWEP.Category					= "VJ Base - Aliens vs Predator"

if CLIENT then
	SWEP.Slot						= 4
	SWEP.SlotPos					= 4
end

SWEP.PrintName					= "Stimpack"
SWEP.ViewModel					= "models/cpthazama/avp/weapons/hud_stimpack.mdl"
SWEP.WorldModel					= "models/cpthazama/avp/weapons/stimpack.mdl"
SWEP.HoldType 					= "none"
SWEP.Spawnable					= true
SWEP.UseHands 					= true
SWEP.ViewModelFOV				= 75

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:Initialize()
    self:SetHoldType(self.HoldType)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:PrimaryAttack()
    if !IsFirstTimePredicted() then return end
    local owner = self:GetOwner()
    if !IsValid(owner) then return end

	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
    owner:SetAnimation(PLAYER_ATTACK1)

    local duration = 0.4
    local vm = owner:GetViewModel()
    if IsValid(vm) then
        local seqDur = vm:SequenceDuration()
        if seqDur && seqDur > 0 then
            duration = seqDur
        end
    end

    self:SetNextPrimaryFire(CurTime() +duration)

    if SERVER then
        timer.Simple(duration *0.3,function()
            if !IsValid(self) then return end
            local ply = self:GetOwner()
            if IsValid(ply) then
                ply:EmitSound("cpthazama/avp/humans/marine_stim_open_01.ogg",70)
            end
        end)
        timer.Simple(duration *0.45,function()
            if !IsValid(self) then return end
            local ply = self:GetOwner()
            if IsValid(ply) then
                ply:EmitSound("cpthazama/avp/humans/marine_stim_spit_01.ogg",70)
            end
        end)
        timer.Simple(duration *0.6,function()
            if !IsValid(self) then return end
            local ply = self:GetOwner()
            if IsValid(ply) then
                ply:EmitSound("cpthazama/avp/humans/marine_stim_inject_01.ogg",70)
                ply:SetHealth(math.Clamp(ply:Health() +50,0,ply:GetMaxHealth()))
            end
        end)
        timer.Simple(duration, function()
            if !IsValid(self) then return end
            local ply = self:GetOwner()
            if IsValid(ply) then
                ply:StripWeapon(self:GetClass())
            else
                self:Remove()
            end
        end)
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:Reload()
    return false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:ShouldDropOnDie()
    return false
end