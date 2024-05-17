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
SWEP.Primary.RPM				= 400
SWEP.Primary.AccurateRange 		= 28
SWEP.Primary.Automatic			= false
SWEP.Primary.Ammo				= "Pistol"
SWEP.Primary.Delay				= 60 /SWEP.Primary.RPM
SWEP.Primary.Cone				= (3 /SWEP.Primary.AccurateRange) *75
SWEP.Primary.Recoil				= (3 /SWEP.Primary.AccurateRange) *7.5
SWEP.NPC_NextPrimaryFire 		= 0.3

SWEP.Secondary.Automatic = true
-- SWEP.Secondary.Automatic = false
-- SWEP.Secondary.Ammo = "Pistol"
SWEP.Secondary.Cone = SWEP.Primary.Cone

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

	self.BurstFireShots = 0
	self.ResetBurstFireT = 0
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnReload()
	self:DoViewPunch(0,Angle(1,-4,1))
	-- self:DoViewPunch(0.4,Angle(1,-4,1))
	-- self:DoViewPunch(1.3,Angle(-2,1,1))
	-- self:DoViewPunch(1.8,Angle(2,-1,1))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnThink()
	if self.BurstFireShots > 0 && CurTime() > self.ResetBurstFireT then
		self.BurstFireShots = 0
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnSecondaryAttack()
	return CurTime() > self.NextBurstFireT
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnSecondaryAttack()
	if CurTime() < self.NextBurstFireT then return end
	local owner = self:GetOwner()
	local oldDelay = self.Primary.Delay
	local oldCone = self.Primary.Cone
	local oldDamage = self.Primary.Damage
	self.Primary.Delay = 0.1
	self.Primary.Cone = 20
	self.Primary.Damage = 18
	self:PrimaryAttack()
	self.Primary.Delay = oldDelay
	self.Primary.Cone = oldCone
	self.Primary.Damage = oldDamage

	self.BurstFireShots = self.BurstFireShots +1
	self.ResetBurstFireT = CurTime() +1
	if self.BurstFireShots >= 3 then
		self.BurstFireShots = 0
		self.NextBurstFireT = CurTime() +0.45
		self:SetNextPrimaryFire(CurTime() +0.45)
		self:SetNextSecondaryFire(CurTime() +0.45)
	else
		self:SetNextPrimaryFire(CurTime() +0.075)
		self:SetNextSecondaryFire(CurTime() +0.075)
	end
	-- self.NextBurstFireT = CurTime() +0.1
end