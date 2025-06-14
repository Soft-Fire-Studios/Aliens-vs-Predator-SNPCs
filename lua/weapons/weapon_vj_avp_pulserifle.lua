SWEP.Base 						= "weapon_vj_avp_base"
SWEP.Author 					= "Cpt. Hazama"
SWEP.Contact					= "http://steamcommunity.com/groups/vrejgaming"
SWEP.Category					= "VJ Base - Aliens vs Predator"

if CLIENT then
	SWEP.Slot						= 2
	SWEP.SlotPos					= 4
end

sound.Add({
	name = "AVP.PulseRifle.ClipOut",
	sound = "cpthazama/avp/weapons/human/pulse_rifle/pulse_rifle_exit_clip_01.ogg",
	channel = CHAN_STATIC,
	volume = 1,
	level = 65,
})

sound.Add({
	name = "AVP.PulseRifle.ClipIn",
	sound = "cpthazama/avp/weapons/human/pulse_rifle/pulse_rifle_insert_clip_01.ogg",
	channel = CHAN_STATIC,
	volume = 1,
	level = 65,
})

sound.Add({
	name = "AVP.PulseRifle.Slide",
	sound = "cpthazama/avp/weapons/human/pulse_rifle/pulse_rifle_side_catch_01.ogg",
	channel = CHAN_STATIC,
	volume = 1,
	level = 65,
})

SWEP.PrintName					= "M41A Pulse Rifle"
SWEP.ViewModel					= "models/cpthazama/avp/weapons/hud_pulserifle.mdl"
SWEP.WorldModel					= "models/cpthazama/avp/weapons/w_pulserifle.mdl"
SWEP.HoldType 					= "ar2"
SWEP.Spawnable					= true

SWEP.WorldModel_UseCustomPosition = true
SWEP.WorldModel_CustomPositionAngle = Vector(-12, 0, 180)
SWEP.WorldModel_CustomPositionOrigin = Vector(-1, 3.75, 0.3)
SWEP.WorldModel_CustomPositionBone = "ValveBiped.Bip01_R_Hand"

SWEP.HasMotionTracker			= true
SWEP.PrimaryEffects_MuzzleParticles = {"vj_avp_muzzle_big_main"}

SWEP.Primary.Damage				= 11
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
	Pos = {Right = 0,Forward = 0,Up = -0.2},
	Ang = {Right = 0,Up = 0,Forward = 4}
}
SWEP.ViewModelZoomAdjust = {
	Pos = {Right = -3.33,Forward = -6,Up = 0.4},
	Ang = {Right = 0,Up = -0.1,Forward = 0}
}
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnInit()
	if CLIENT then
		hook.Add("PostDrawViewModel",self, function(self,vm, ply, weapon)
			if !IsValid(weapon) or weapon != self then return end

			local bone = vm:LookupBone("Pulserifle_body")
			if !bone then return end

			local pos, ang = vm:GetBonePosition(bone)
			pos = pos +ang:Right() *1.355 + ang:Forward() *-1.45 + ang:Up() *6.45
			ang:RotateAroundAxis(ang:Right(), 115)
			ang:RotateAroundAxis(ang:Forward(), 0)
			ang:RotateAroundAxis(ang:Up(), 177)

			cam.Start3D2D(pos, ang, 0.02)
				draw.SimpleTextOutlined("00", "VJFont_AVP_Ammo",0, 0,Color(255,0,0,25), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER,1, Color(0, 0, 0))
				draw.SimpleTextOutlined(weapon:Clip1(), "VJFont_AVP_AmmoBlur",0, 0,Color(255,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER,1, Color(0, 0, 0))
				draw.SimpleTextOutlined(weapon:Clip1(), "VJFont_AVP_Ammo",0, 0,Color(255,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER,1, Color(0, 0, 0))
			cam.End3D2D()
		end)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnReload()
	self:DoViewPunch(0,Angle(1,-4,1))
	-- self:DoViewPunch(0.4,Angle(1,-4,1))
	-- self:DoViewPunch(1.3,Angle(-2,1,1))
	-- self:DoViewPunch(1.8,Angle(2,-1,1))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CanSecondaryAttack()
	local owner = self:GetOwner()
	if owner:IsPlayer() && owner:GetAmmoCount(self.Secondary.Ammo) <= 0 then
		return false
	end
	return CurTime() > self:GetNextSecondaryFire() && !self.Reloading && self:GetSprinting() == false && CurTime() > self.SprintDelayT
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnSecondaryAttack2(anim,animTime)
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