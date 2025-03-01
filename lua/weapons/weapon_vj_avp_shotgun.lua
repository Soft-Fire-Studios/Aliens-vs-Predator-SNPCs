SWEP.Base 						= "weapon_vj_avp_base"
SWEP.Author 					= "Cpt. Hazama"
SWEP.Contact					= "http://steamcommunity.com/groups/vrejgaming"
SWEP.Category					= "VJ Base - Aliens vs Predator"

sound.Add({
	name = "AVP.Shotgun.ClipIn",
	sound = "cpthazama/avp/weapons/human/shotgun/shotgun_clip_in_01.ogg",
	channel = CHAN_STATIC,
	volume = 1,
	level = 65,
})
sound.Add({
	name = "AVP.Shotgun.ClipOut",
	sound = "cpthazama/avp/weapons/human/shotgun/shotgun_clip_out_01.ogg",
	channel = CHAN_STATIC,
	volume = 1,
	level = 65,
})
sound.Add({
	name = "AVP.Shotgun.Pump",
	sound = "cpthazama/avp/weapons/human/shotgun/shotgun_reload_01.ogg",
	channel = CHAN_STATIC,
	volume = 1,
	level = 65,
})

if CLIENT then
	SWEP.Slot						= 2
	SWEP.SlotPos					= 4
end

SWEP.PrintName					= "ZX-76 Shotgun"
SWEP.ViewModel					= "models/cpthazama/avp/weapons/hud_shotgun.mdl"
SWEP.WorldModel					= "models/cpthazama/avp/weapons/w_shotgun.mdl"
SWEP.HoldType 					= "ar2"
SWEP.IsShotgun 					= true
SWEP.Spawnable					= true

SWEP.WorldModel_UseCustomPosition = true
SWEP.WorldModel_CustomPositionAngle = Vector(-12, 0, 180)
SWEP.WorldModel_CustomPositionOrigin = Vector(-1, 3.75, 0.3)
SWEP.WorldModel_CustomPositionBone = "ValveBiped.Bip01_R_Hand"

SWEP.HasMotionTracker			= true
SWEP.PrimaryEffects_MuzzleParticles = {"vj_avp_muzzle_sg_main"}

SWEP.Primary.Damage				= 12
SWEP.Primary.ClipSize			= 8
SWEP.Primary.NumberOfShots		= 7
SWEP.Primary.RPM				= 80
SWEP.Primary.AccurateRange 		= 14
SWEP.Primary.Automatic			= false
SWEP.Primary.Ammo				= "BuckShot"
SWEP.Primary.Delay				= 60 /SWEP.Primary.RPM
SWEP.Primary.Cone				= (3 /SWEP.Primary.AccurateRange) *75
SWEP.Primary.Recoil				= 8
SWEP.NPC_NextPrimaryFire 		= SWEP.Primary.Delay *(SWEP.Primary.Automatic == false && 3.5 or 0.9)

SWEP.NPC_FiringDistanceScale = 0.25

SWEP.AnimTbl_PrimaryFire 		= {ACT_VM_PRIMARYATTACK}
SWEP.AnimTbl_SecondaryFire 		= false

SWEP.Primary.Sound = {"cpthazama/avp/weapons/human/shotgun/shotgun_fire_02.ogg"}
SWEP.Primary.DistantSound = {"cpthazama/avp/weapons/human/shotgun/shotgun_fire_01.ogg"}

SWEP.ViewModelAdjust = {
	Pos = {Right = 0,Forward = -0.5,Up = -0.1},
	Ang = {Right = 0,Up = 0,Forward = 0}
}