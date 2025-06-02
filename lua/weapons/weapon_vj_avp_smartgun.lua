SWEP.Base 						= "weapon_vj_avp_base"
SWEP.Author 					= "Cpt. Hazama"
SWEP.Contact					= "http://steamcommunity.com/groups/vrejgaming"
SWEP.Category					= "VJ Base - Aliens vs Predator"

if CLIENT then
	SWEP.Slot						= 2
	SWEP.SlotPos					= 4
end

sound.Add({
	name = "AVP.SmartGun.Fire",
	channel = CHAN_WEAPON,
	volume = 1,
	level = SNDLVL_GUNFIRE,
	sound = {"cpthazama/avp/weapons/human/minigun/minigun_shoot_loop_01.wav"}
})
sound.Add({
	name = "AVP.SmartGun.ClipIn",
	sound = "cpthazama/avp/weapons/human/shotgun/shotgun_clip_in_01.ogg",
	channel = CHAN_STATIC,
	volume = 1,
	level = 65,
})
sound.Add({
	name = "AVP.SmartGun.ClipOut",
	sound = "cpthazama/avp/weapons/human/shotgun/shotgun_clip_out_01.ogg",
	channel = CHAN_STATIC,
	volume = 1,
	level = 65,
})

SWEP.PrintName					= "M56 Smartgun"
SWEP.ViewModel					= "models/cpthazama/avp/weapons/hud_smartgun.mdl"
SWEP.WorldModel					= "models/cpthazama/avp/weapons/w_smartgun.mdl"
SWEP.HoldType 					= "crossbow"
SWEP.Spawnable					= true

SWEP.DeploySound = {"cpthazama/avp/shared/marine_weapon_draw_with_kit_02.ogg"}

SWEP.WorldModel_UseCustomPosition = true
SWEP.WorldModel_CustomPositionAngle = Vector(0, 0, 180)
SWEP.WorldModel_CustomPositionOrigin = Vector(-1, 0, 0.3)
SWEP.WorldModel_CustomPositionBone = "ValveBiped.Bip01_R_Hand"

SWEP.HasMotionTracker			= true
SWEP.PrimaryEffects_MuzzleParticles = {"vj_avp_muzzle_lmg_main"}

SWEP.Primary.Damage				= 15
SWEP.Primary.ClipSize			= 500
SWEP.Primary.RPM				= 1100
SWEP.Primary.AccurateRange 		= 36
SWEP.Primary.Automatic			= true
SWEP.Primary.Ammo				= "AR2"
SWEP.Primary.Delay				= 60 /SWEP.Primary.RPM
SWEP.Primary.Cone				= (3 /SWEP.Primary.AccurateRange) *75
SWEP.Primary.Recoil				= 0.25
SWEP.NPC_NextPrimaryFire 		= SWEP.Primary.Delay *(SWEP.Primary.Automatic == false && 1.2 or 0.9)

SWEP.AnimTbl_PrimaryFire 		= {ACT_VM_PRIMARYATTACK}

SWEP.Primary.UsesLoopedSound 	= true
SWEP.Primary.Sound 				= {"AVP.SmartGun.Fire"}
SWEP.Primary.StartSound 		= {"cpthazama/avp/weapons/human/minigun/minigun_shoot_start_01.ogg"}
SWEP.Primary.EndSound 			= {"cpthazama/avp/weapons/human/minigun/minigun_shoot_end_01.ogg"}

SWEP.ViewModelAdjust = {
	Pos = {Right = 0,Forward = 0,Up = 0.45},
	Ang = {Right = -0.65,Up = 0,Forward = -4}
}

SWEP.DisableSprint = true
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:AddVars()
	self:NetworkVar("Entity", 0, "LockOn")
end
---------------------------------------------------------------------------------------------------------------------------------------------
local table_Count = table.Count
local table_insert = table.insert
local table_Empty = table.Empty

if SERVER then
	util.AddNetworkString("VJ.AVP.SmartGunHalo")
else
	net.Receive("VJ.AVP.SmartGunHalo",function(len,pl)
		local self = net.ReadEntity()
		local ent = net.ReadEntity()
		local bool = net.ReadBool()

		self.HighlightEnts = self.HighlightEnts or {}
		if bool && IsValid(ent) then
			self.HighlightEnts = {}
			table_insert(self.HighlightEnts,ent)
		else
			self.HighlightEnts = {}
		end
	end)
end
--
function SWEP:OnInit()
	self.LastTarget = NULL
	self.LastTargetT = 0

	if CLIENT then
		self.HighlightEnts = {}
		hook.Add("PreDrawHalos",self,function(self)
			if table_Count(self.HighlightEnts) > 0 then
				local ent = self.HighlightEnts[1]
				if !IsValid(ent) then table_Empty(self.HighlightEnts) return end
				halo.Add(self.HighlightEnts,Color(199,250,255),1,1,4,true,true)
			end
		end)
		hook.Add("PostDrawViewModel",self, function(self,vm, ply, weapon)
			if !IsValid(weapon) or weapon != self then return end

			local bone = vm:LookupBone("Minigun")
			if !bone then return end
			local pos, ang = vm:GetBonePosition(bone)
			pos = pos +ang:Right() *20.2 + ang:Forward() *-7.57 + ang:Up() *-4.5
			ang:RotateAroundAxis(ang:Right(), 180)
			ang:RotateAroundAxis(ang:Forward(), 300)
			ang:RotateAroundAxis(ang:Up(), 180)

			cam.Start3D2D(pos, ang, 0.0227)
				draw.SimpleTextOutlined("000", "VJFont_AVP_Ammo",0, 0,Color(199,250,255,25), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER,1, Color(0, 0, 0))
				draw.SimpleTextOutlined(weapon:Clip1(), "VJFont_AVP_AmmoBlur",0, 0,Color(199,250,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER,1, Color(0, 0, 0))
				draw.SimpleTextOutlined(weapon:Clip1(), "VJFont_AVP_Ammo",0, 0,Color(199,250,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER,1, Color(0, 0, 0))
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
function SWEP:OnThink2(owner)
	if !SERVER then return end
	if owner:IsPlayer() then
		local trPos = owner:GetEyeTrace().HitPos
		local curTarget
		local curDist = 9999999
		if trPos:Distance(self:GetPos()) < 4000 then
			for _,v in pairs(ents.FindInSphere(trPos,300)) do
				if (v:IsNPC() && v:Disposition(owner) != D_LI or v:IsPlayer() && GetConVar("sbox_playershurtplayers"):GetBool() or v:IsNextBot()) && v != owner && v:GetPos():Distance(self:GetPos()) < curDist then
					if IsValid(self.LastTarget) && v != self.LastTarget then
						if v:GetPos():Distance(self:GetPos()) < self.LastTarget:GetPos():Distance(self:GetPos()) then
							curTarget = v
							curDist = v:GetPos():Distance(self:GetPos())
						end
					else
						curTarget = v
						curDist = v:GetPos():Distance(self:GetPos())
					end
				end
			end
		end
		if IsValid(curTarget) && curTarget != self.LastTarget then
			self.LastTarget = curTarget
			VJ.EmitSound(self, "cpthazama/avp/weapons/human/minigun/minigun_trigger_01.ogg", 75)
			net.Start("VJ.AVP.SmartGunHalo")
				net.WriteEntity(self)
				net.WriteEntity(curTarget)
				net.WriteBool(true)
			net.Broadcast()
			self.LastTargetT = CurTime() +5
		elseif IsValid(curTarget) && curTarget == self.LastTarget then
			self.LastTargetT = CurTime() +5
		end
		if IsValid(self.LastTarget) then
			if CurTime() > self.LastTargetT or self.LastTarget:IsNPC() && self.LastTarget:Disposition(owner) == D_LI then
				self.LastTargetT = 0
				self.LastTarget = NULL
				net.Start("VJ.AVP.SmartGunHalo")
					net.WriteEntity(self)
					net.WriteEntity(nil)
					net.WriteBool(false)
				net.Broadcast()
				VJ.EmitSound(self, "cpthazama/avp/weapons/human/minigun/minigun_trigger_01.ogg", 75, 85)
				return
			end
			if !owner:KeyDown(IN_USE) && owner:KeyDown(IN_ATTACK2) then
				local target = self.LastTarget
				local targetPos = target:GetPos() +target:OBBCenter()
				local targetAng = (targetPos -owner:GetShootPos()):Angle()
				targetAng.r = 0
				owner:SetEyeAngles(LerpAngle(0.1,owner:EyeAngles(),targetAng))
			end
		end
	end
end