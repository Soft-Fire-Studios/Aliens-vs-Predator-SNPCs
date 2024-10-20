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

SWEP.PrintName					= "M42C Scoped Rifle"
SWEP.ViewModel					= "models/cpthazama/avp/weapons/hud_scopedrifle.mdl"
SWEP.WorldModel					= "models/cpthazama/avp/weapons/w_scopedrifle.mdl"
SWEP.HoldType 					= "ar2"
SWEP.Spawnable					= true
SWEP.AdminSpawnable				= false

SWEP.WorldModel_UseCustomPosition = true
SWEP.WorldModel_CustomPositionAngle = Vector(-12, 0, 180)
SWEP.WorldModel_CustomPositionOrigin = Vector(-1, 3.75, 0.3)
SWEP.WorldModel_CustomPositionBone = "ValveBiped.Bip01_R_Hand"

SWEP.HasMotionTracker			= true
SWEP.PrimaryEffects_MuzzleParticles = {"vj_avp_muzzle_big_main_2"}

SWEP.Primary.Damage				= 95
SWEP.Primary.ClipSize			= 6
SWEP.Primary.RPM				= 300
SWEP.Primary.AccurateRange 		= 65
SWEP.Primary.Automatic			= false
SWEP.Primary.Ammo				= "SniperRound"
SWEP.Primary.Delay				= 60 /SWEP.Primary.RPM
SWEP.Primary.Cone				= (3 /SWEP.Primary.AccurateRange) *75
SWEP.Primary.Recoil				= 5
SWEP.NPC_NextPrimaryFire 		= SWEP.Primary.Delay *(SWEP.Primary.Automatic == false && 3.5 or 0.9)

SWEP.AnimTbl_PrimaryFire 		= {ACT_VM_PRIMARYATTACK}
SWEP.AnimTbl_SecondaryFire 		= false

SWEP.NPC_FiringDistanceScale = 1.75
SWEP.NPC_CustomSpread = 0.225

SWEP.Primary.Sound = {"cpthazama/avp/weapons/human/scoped_rifle/scoped_rifle_new_01_st.ogg"}
-- SWEP.Primary.DistantSound = {"cpthazama/avp/weapons/human/scoped_rifle/scoped_rifle_new_01_mn.ogg"}

SWEP.ViewModelAdjust = {
	Pos = {Right = 0,Forward = 0,Up = 0},
	Ang = {Right = 0,Up = 0,Forward = 0}
}
SWEP.ViewModelZoomAdjust = {
	Pos = {Right = -3.9,Forward = -12,Up = -2},
	Ang = {Right = 0,Up = -1,Forward = 0}
}

SWEP.UsesZoom = true
SWEP.ZoomLevel = 20
--
local table_Count = table.Count
local table_insert = table.insert
local table_remove = table.remove

local matGradientTech = Material("hud/cpthazama/avp/scope_gradient.png")
local matCrosshair = Material("hud/cpthazama/avp/scope/crosshair.png")
local matCrosshairGlint = Material("hud/cpthazama/avp/scope/glass_glint.png")
local matScope = Material("hud/cpthazama/avp/scope/main_scope.png")

if SERVER then
	util.AddNetworkString("VJ.AVP.SniperHalos")
else
	net.Receive("VJ.AVP.SniperHalos",function(len,pl)
		local self = net.ReadEntity()
		local ent = net.ReadEntity()
		local bool = net.ReadBool()

		self.HighlightEnts = self.HighlightEnts or {}
		if bool && !VJ.HasValue(self.HighlightEnts,ent) then
			table_insert(self.HighlightEnts,ent)
		else
			if #self.HighlightEnts > 0 then
				table.Empty(self.HighlightEnts)
			end
		end
	end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnInit2()
	if SERVER then
		self.HighlightT = 0
		self.HighlightEnts = {}
	elseif CLIENT then
		self.HighlightT = 0
		self.HighlightEnts = {}
		hook.Add("PreDrawHalos",self,function(self)
			if self:GetZoomed() then
				self.HighlightT = CurTime() +0.05
			end
			local highTbl = self.HighlightEnts
			for x,v in ipairs(highTbl) do
				if IsValid(v) && v:GetPos():Distance(self:GetPos()) > 8000 then
					table_remove(self.HighlightEnts,x)
				end
			end
			highTbl = self.HighlightEnts
			if self.HighlightT > CurTime() && table_Count(highTbl) > 0 then
				halo.Add(highTbl,Color(199,250,255),1,1,4,true,true)
			end
		end)

		local render_GetLightColor = render.GetLightColor
		hook.Add("RenderScreenspaceEffects",self,function(self)
			if self:GetZoomed() then
				local hitPos = self:GetOwner():GetEyeTrace().HitPos +self:GetOwner():GetAimVector() *-10
				local lightLevel = render_GetLightColor(hitPos):Length()
				local contrast = lightLevel < 0.2 && lightLevel *-3 or lightLevel *0.1
				self.ContrastLevel = Lerp(FrameTime() *5,self.ContrastLevel or 0,contrast)
				DrawMotionBlur(0.1,0.8,0.01)
				DrawBloom(self.ContrastLevel,0.5,1,1,0,0,2,2,2)
				DrawTexturize(0,matGradientTech)

				if lightLevel < 0.135 then
					local dLight = DynamicLight(self:EntIndex())
					if (dLight) then
						dLight.pos = hitPos
						dLight.r = 15
						dLight.g = 15
						dLight.b = 15
						dLight.Brightness = 1
						dLight.Size = 4000
						dLight.Decay = 0
						dLight.DieTime = CurTime() +0.05
						dLight.Style = 0
					end
				end
			end
		end)

		local function ScreenPos(x,y)
			local w = ScrW()
			local h = ScrH()
			local pos = {}
			pos.x = w *0.5 +w *x *0.01
			pos.y = h *0.5 +w *y *0.01
	
			return pos
		end
	
		local function ScreenScale(x,y)
			local w = ScrW()
			local h = ScrH()
			local size = {}
			size.x = (w *x *0.01)
			size.y = (w *y *0.01)
	
			return size
		end
	
		local function DrawIcon(mat,x,y,width,height,r,g,b,a,ang)
			surface.SetDrawColor(Color(r or 255,g or 255,b or 255,a or 255))
			surface.SetMaterial(mat)
			local pos = ScreenPos(x,y)
			local size = ScreenScale(width,height)
			surface.DrawTexturedRectRotated(pos.x,pos.y,size.x,size.y,ang or 0)
		end
	
		local distortedColor = Color(170,238,255)
		local function DrawIcon_D(mat,x,y,width,height,r,g,b,a,ang)
			local distortion = math.abs(math.sin(CurTime() *2) *50)
			local a = a or 255
			surface.SetDrawColor(Color(distortedColor.r,distortedColor.g,distortedColor.b,math.Clamp(a +math.random(-distortion,distortion),0,255)))
			surface.SetMaterial(mat)
			local pos = ScreenPos(x +math.Rand(-0.2,0.2),y +math.Rand(-0.2,0.2))
			local size = ScreenScale(width,height)
			surface.DrawTexturedRectRotated(pos.x,pos.y,size.x,size.y,ang or 0)
	
			surface.SetDrawColor(Color(r or 255,g or 255,b or 255,a or 255))
			surface.SetMaterial(mat)
			local pos = ScreenPos(x,y)
			surface.DrawTexturedRectRotated(pos.x,pos.y,size.x,size.y,ang or 0)
		end

		hook.Add("HUDPaint",self,function(self)
			if self:GetZoomed() then
				DrawIcon(matScope,0,0,138,138)
				DrawIcon_D(matCrosshair,0.35,0.125,60,60)
				local lightLevel = render_GetLightColor(self:GetOwner():EyePos()):Length()
				DrawIcon(matCrosshairGlint,0.35,0.125,60,60,255,255,255,math.Clamp(lightLevel *255,0,255))
			end
		end)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnPrimaryAttack_BulletCallback(attacker, tr, dmginfo)
	dmginfo:SetDamageType(bit.bor(DMG_BULLET,DMG_SNIPER))
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
	if !owner:IsPlayer() then return end

	if self:GetZoomed() then
		self.HighlightT = CurTime() +0.05
	end

	if self.HighlightT > CurTime() then
		for _,v in ents.Iterator() do
			if self:GetZoomed() && !VJ.HasValue(self.HighlightEnts,v) && (v:IsNPC() or v:IsPlayer() && v != owner or v:IsNextBot()) && !v:IsFlagSet(FL_NOTARGET) && v:GetPos():Distance(self:GetPos()) <= 8000 then
				net.Start("VJ.AVP.SniperHalos")
					net.WriteEntity(self)
					net.WriteEntity(v)
					net.WriteBool(true)
				net.Broadcast()
				table_insert(self.HighlightEnts,v)
			end
		end
	else
		for _,v in pairs(self.HighlightEnts) do
			net.Start("VJ.AVP.SniperHalos")
				net.WriteEntity(self)
				net.WriteEntity(b)
				net.WriteBool(false)
			net.Broadcast()
		end
		self.HighlightEnts = {}
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
-- function SWEP:CustomOnSecondaryAttack()
-- 	local owner = self:GetOwner()
-- 	VJ.EmitSound(self, "cpthazama/avp/weapons/human/pulse_rifle/pulse_rifle_grenade_fire_04.ogg", 85)

-- 	if SERVER then
-- 		local proj = ents.Create("obj_vj_avp_m103")
-- 		proj:SetPos(owner:GetShootPos())
-- 		proj:SetAngles(owner:GetAimVector():Angle())
-- 		proj:SetOwner(owner)
-- 		proj:Spawn()
-- 		proj:Activate()
-- 		local phys = proj:GetPhysicsObject()
-- 		if IsValid(phys) then
-- 			phys:Wake()
-- 			phys:SetVelocity(owner:GetAimVector() * 2000)
-- 		end
-- 	end

-- 	owner:ViewPunch(Angle(-self.Primary.Recoil *15, 0, 0))
-- 	return true
-- end