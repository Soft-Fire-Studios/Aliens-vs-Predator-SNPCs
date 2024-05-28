SWEP.Base 						= "weapon_vj_avp_base"
SWEP.Author 					= "Cpt. Hazama"
SWEP.Contact					= "http://steamcommunity.com/groups/vrejgaming"
SWEP.Purpose					= "This weapon is made for Players and NPCs"
SWEP.Instructions				= "Controls are like a regular weapon."
SWEP.Category					= "VJ Base - Aliens vs Predator"

if CLIENT then
	SWEP.Slot						= 2
	SWEP.SlotPos					= 4
end

SWEP.PrintName					= "M41A Pulse Rifle"
SWEP.ViewModel					= "models/cpthazama/avp/weapons/hud_pulserifle.mdl"
SWEP.WorldModel					= "models/cpthazama/avp/weapons/w_pulserifle.mdl"
SWEP.HoldType 					= "ar2"
SWEP.Spawnable					= true
SWEP.AdminSpawnable				= false

SWEP.WorldModel_UseCustomPosition = true
SWEP.WorldModel_CustomPositionAngle = Vector(-12, 0, 180)
SWEP.WorldModel_CustomPositionOrigin = Vector(-1, 3.75, 0.3)
SWEP.WorldModel_CustomPositionBone = "ValveBiped.Bip01_R_Hand"

SWEP.HasMotionTracker			= true

SWEP.Primary.Damage				= 14
SWEP.Primary.ClipSize			= 99
SWEP.Primary.RPM				= 900
SWEP.Primary.AccurateRange 		= 28
SWEP.Primary.Automatic			= true
SWEP.Primary.Ammo				= "SMG1"
SWEP.Primary.Delay				= 60 /SWEP.Primary.RPM
SWEP.Primary.Cone				= (3 /SWEP.Primary.AccurateRange) *75
SWEP.Primary.Recoil				= (3 /SWEP.Primary.AccurateRange) *7.5
SWEP.NPC_NextPrimaryFire 		= SWEP.Primary.Delay *(SWEP.Primary.Automatic == false && 1.2 or 0.9)

SWEP.Secondary.Ammo = "SMG1_Grenade"

SWEP.AnimTbl_PrimaryFire 		= {ACT_VM_PRIMARYATTACK}

SWEP.Primary.Sound = {
	"cpthazama/avp/weapons/human/pulse_rifle/pulse_rifle_01_shot_loopmono_01.wav",
	"cpthazama/avp/weapons/human/pulse_rifle/pulse_rifle_01_shot_loopmono_02.wav",
	"cpthazama/avp/weapons/human/pulse_rifle/pulse_rifle_01_shot_loopmono_03.wav",
	"cpthazama/avp/weapons/human/pulse_rifle/pulse_rifle_01_shot_loopmono_04.wav",
}
SWEP.Primary.UsesLoopedSound 	= true

SWEP.ViewModelAdjust = {
	Pos = {Right = 0,Forward = -1,Up = -0.2},
	Ang = {Right = 0,Up = 0,Forward = 4}
}
SWEP.ViewModelZoomAdjust = {
	Pos = {Right = -3.33,Forward = -6,Up = 0.4},
	Ang = {Right = 0,Up = -0.1,Forward = 0}
}
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnReload()
	self:DoViewPunch(0,Angle(1,-4,1))
	-- self:DoViewPunch(0.4,Angle(1,-4,1))
	-- self:DoViewPunch(1.3,Angle(-2,1,1))
	-- self:DoViewPunch(1.8,Angle(2,-1,1))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnSecondaryAttack(anim,animTime)
	local owner = self:GetOwner()
	VJ.EmitSound(self, "cpthazama/avp/weapons/human/pulse_rifle/pulse_rifle_grenade_fire_04.ogg", 85)

	if SERVER then
		local proj = ents.Create("obj_vj_avp_m103")
		proj:SetPos(owner:GetShootPos())
		proj:SetAngles(owner:GetAimVector():Angle())
		proj:SetOwner(owner)
		proj:Spawn()
		proj:Activate()
		local phys = proj:GetPhysicsObject()
		if IsValid(phys) then
			phys:Wake()
			phys:SetVelocity(owner:GetAimVector() * 2000)
		end
	end

	owner:ViewPunch(Angle(-self.Primary.Recoil *15, 0, 0))
end