SWEP.Base 						= "weapon_vj_base"
SWEP.PrintName					= "VP78 Pistol"
SWEP.Author 					= "Cpt. Hazama"
SWEP.Contact					= ""
SWEP.Purpose					= ""
SWEP.Instructions				= ""
SWEP.Category					= "VJ Base - Aliens vs Predator"

if CLIENT then
	SWEP.Slot						= 1
	SWEP.SlotPos					= 1
end

SWEP.NPC_NextPrimaryFire 		= 0.25
SWEP.NPC_CustomSpread	 		= 0.8

SWEP.ViewModel					= "models/vj_weapons/v_glock.mdl"
SWEP.WorldModel					= "models/cpthazama/avp/weapons/pistol.mdl"
SWEP.HoldType 					= "pistol"

SWEP.Spawnable					= true
SWEP.AdminSpawnable				= false

SWEP.Primary.Damage = 12
SWEP.Primary.Force = 5
SWEP.Primary.ClipSize = 15
SWEP.Primary.Recoil = 0.3
SWEP.Primary.Cone = 5
SWEP.Primary.Delay = 0.25
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "Pistol"

SWEP.Primary.Sound = {"vj_weapons/glock_17/glock17_single.wav"}
SWEP.Primary.DistantSound = {"vj_weapons/glock_17/glock17_single_dist.wav"}

SWEP.PrimaryEffects_MuzzleAttachment = 1
SWEP.PrimaryEffects_ShellAttachment = "shell"
SWEP.PrimaryEffects_ShellType = "ShellEject"

SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "Pistol"
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnSecondaryAttack()
	self.Primary.Delay = 0.175
	self.Primary.Cone = 20
	self:PrimaryAttack()
	self.Primary.Delay = 0.25
	self.Primary.Cone = 5

	self:SetNextSecondaryFire(CurTime() + 0.175)
	return false
end