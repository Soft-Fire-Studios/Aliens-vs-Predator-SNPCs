SWEP.Base 						= "weapon_vj_avp_base"
SWEP.Author 					= "Cpt. Hazama"
SWEP.Contact					= "http://steamcommunity.com/groups/vrejgaming"
SWEP.Purpose					= "This weapon is made for Players and NPCs"
SWEP.Instructions				= "Controls are like a regular weapon."
SWEP.Category					= "VJ Base - Aliens vs Predator"

if CLIENT then
	SWEP.Slot						= 1
	SWEP.SlotPos					= 4
end

SWEP.PrintName					= "VP78 Pistol"
SWEP.ViewModel					= "models/cpthazama/avp/weapons/hud_pistol.mdl"
SWEP.WorldModel					= "models/cpthazama/avp/weapons/pistol.mdl"
SWEP.HoldType 					= "pistol"
SWEP.Spawnable					= true
SWEP.AdminSpawnable				= false

SWEP.WorldModel_UseCustomPosition = true
SWEP.WorldModel_CustomPositionAngle = Vector(-5, 0, 180)
SWEP.WorldModel_CustomPositionOrigin = Vector(-1, 3.5, 1)
SWEP.WorldModel_CustomPositionBone = "ValveBiped.Bip01_R_Hand"

SWEP.HasMotionTracker			= true

SWEP.Primary.Damage				= 12
SWEP.Primary.ClipSize			= 15
SWEP.Primary.RPM				= 700
SWEP.Primary.AccurateRange 		= 28
SWEP.Primary.Automatic			= false
SWEP.Primary.Ammo				= "Pistol"
SWEP.Primary.Delay				= 60 /SWEP.Primary.RPM
SWEP.Primary.Cone				= (3 /SWEP.Primary.AccurateRange) *75
SWEP.Primary.Recoil				= (3 /SWEP.Primary.AccurateRange) *7.5
SWEP.NPC_NextPrimaryFire 		= SWEP.Primary.Delay *(SWEP.Primary.Automatic == false && 1.2 or 0.9)

SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "Pistol"

SWEP.AnimTbl_PrimaryFire 		= {ACT_VM_PRIMARYATTACK}

SWEP.Primary.Sound = {"cpthazama/avp/weapons/human/pistol/pistol_fire_01.ogg"}
SWEP.Primary.DistantSound = {"cpthazama/avp/weapons/human/pistol/pistol_fire_suicide_01.ogg"}

SWEP.ViewModelAdjust = {
	Pos = {Right = 0,Forward = -1,Up = -0.35},
	Ang = {Right = 0,Up = 0,Forward = -1}
}
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnInit()
	self.NextBurstFireT = 0
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnReload()
	self:DoViewPunch(0,Angle(1,-4,1))
	-- self:DoViewPunch(0.4,Angle(1,-4,1))
	-- self:DoViewPunch(1.3,Angle(-2,1,1))
	-- self:DoViewPunch(1.8,Angle(2,-1,1))
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