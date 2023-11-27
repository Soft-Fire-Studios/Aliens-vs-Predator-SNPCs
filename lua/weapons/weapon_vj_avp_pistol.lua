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
	SWEP.UseHands					= true
	SWEP.ViewModelFOV				= 70
end

SWEP.NPC_NextPrimaryFire 		= 0.17
SWEP.NPC_CustomSpread	 		= 0.8

SWEP.ViewModel					= "models/cpthazama/avp/weapons/hud_pistol.mdl"
SWEP.WorldModel					= "models/cpthazama/avp/weapons/pistol.mdl"
SWEP.HoldType 					= "pistol"

SWEP.Spawnable					= true
SWEP.AdminSpawnable				= false

SWEP.Primary.Damage = 12
SWEP.Primary.Force = 5
SWEP.Primary.ClipSize = 15
SWEP.Primary.Recoil = 0.3
SWEP.Primary.Cone = 5
SWEP.Primary.Delay = 0.175
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "Pistol"

SWEP.Primary.Sound = {"cpthazama/avp/weapons/human/pistol/pistol_fire_01.ogg"}
SWEP.Primary.DistantSound = {"cpthazama/avp/weapons/human/pistol/pistol_fire_suicide_01.ogg"}

SWEP.PrimaryEffects_MuzzleAttachment = 1
SWEP.PrimaryEffects_ShellAttachment = "shell"
SWEP.PrimaryEffects_ShellType = "ShellEject"

SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "Pistol"
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnInitialize()
	self.NextBurstFireT = 0
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnSecondaryAttack()
	if CurTime() < self.NextBurstFireT then return end
	local owner = self:GetOwner()
	for i = 1,3 do
		timer.Simple(i *0.1,function()
			if IsValid(self) && IsValid(owner) && owner:GetActiveWeapon() == self then
				self.Primary.Delay = 0.1
				self.Primary.Cone = 20
				self:PrimaryAttack()
				self.Primary.Delay = 0.175
				self.Primary.Cone = 5
			end
		end)
	end

	self.NextBurstFireT = CurTime() +0.5
	return false
end