SWEP.Base 						= "weapon_vj_base"
SWEP.Author 					= "Cpt. Hazama"
SWEP.Contact					= "http://steamcommunity.com/groups/vrejgaming"
SWEP.Purpose					= "This weapon is made for Players and NPCs"
SWEP.Instructions				= "Controls are like a regular weapon."
SWEP.Category					= "Aliens vs Predator"

if CLIENT then
	SWEP.Slot						= 2
	SWEP.SlotPos					= 4
	SWEP.SwayScale 					= 1
	SWEP.UseHands					= true
end

SWEP.PrintName					= "Aliens vs Predator"
SWEP.ViewModel					= ""
SWEP.WorldModel					= ""
SWEP.HoldType 					= "ar2"
SWEP.Spawnable					= false
SWEP.AdminSpawnable				= false

SWEP.PrimaryEffects_MuzzleParticles = {"vj_avp_wep_rifle_muzzle"}
SWEP.PrimaryEffects_SpawnShells = true
SWEP.PrimaryEffects_ShellType = "ShellEject" -- Pistol = ShellEject | Rifle = RifleShellEject | Shotgun = ShotgunShellEject
SWEP.Primary.SoundPitch	= VJ_Set(100, 100)

SWEP.NPC_TimeUntilFire = 0
SWEP.NPC_NextPrimaryFire = 1.5
SWEP.NPC_TimeUntilFireExtraTimers = {}

SWEP.SoundTbl_Reload = {}

SWEP.ZoomLevel = 60
SWEP.ViewModelAdjust = {
	Pos = {Right = 0,Forward = 0,Up = 0},
	Ang = {Right = 0,Up = 0,Forward = 0}
}
SWEP.ViewModelZoomAdjust = {
	Pos = {Right = -0.25,Forward = 2,Up = 0},
	Ang = {Right = 0,Up = 0,Forward = 0}
}
--
local IRONSIGHT_TIME = 0.15
local SPRINT_TIME = 0.25
--
if CLIENT then
    matproxy.Add({
        name = "AVP_GunHeat",
        init = function(self,mat,values)
            self.Result = values.resultvar
        end,
        bind = function(self,mat,ent)
            if (!IsValid(ent)) then return end

			if ent:GetClass() == "viewmodel" then
				local ply = ent:GetOwner()
				if IsValid(ply) && ply:IsPlayer() then
					mat:SetFloat(self.Result,ply:GetActiveWeapon().Mat_HeatFactor or 0)
				end
				return
			end
			ent.Mat_HeatFactor = ent.Mat_HeatFactor or 0
			local curValue = ent.Mat_HeatFactor
			local finalResult = curValue or 0
			if ent.GetOverHeat then
				finalResult = ent:GetOverHeat()
			end
			ent.Mat_HeatFactor = Lerp(FrameTime() *2,curValue,finalResult)
			mat:SetFloat(self.Result,ent.Mat_HeatFactor)
        end
    })
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:SetupDataTables()
	self:NetworkVar("Bool", 0, "Zoomed")
	self:NetworkVar("Bool", 1, "Sprinting")
	self:NetworkVar("Float", 0, "OverHeat")

	if self.Vars then
		for _,v in pairs(self.Vars) do
			self:NetworkVar(v.Type, v.Index, v.Name)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnDeploy()
	if SERVER then
		local snd = VJ.PICK(self.SoundTbl_Equip)
		if snd != false then
			self:GetOwner():EmitSound(snd, 55)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnInitialize()
	if SERVER then
		self:SetZoomed(false)
		self:SetSprinting(false)
	end

	self.SprintDelayT = 0
	self.SprintSide = 1
	self.CoolDownT = 0
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:DoViewPunch(viewPunch,viewAng)
	local owner = self:GetOwner()
	if !owner:IsPlayer() then return end
	if istable(viewPunch) then
		for _,v in pairs(viewPunch) do
			timer.Simple(v,function()
				if IsValid(self) && IsValid(owner) && owner:GetActiveWeapon() == self then
					owner:ViewPunch(AngleRand() *0.035)
				end
			end)
		end
	else
		timer.Simple(viewPunch,function()
			if IsValid(self) && IsValid(owner) && owner:GetActiveWeapon() == self then
				owner:ViewPunch(viewAng or AngleRand() *0.035)
			end
		end)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:PlayViewAnimation(anim,viewPunch)
	local anim = VJ.PICK(anim)
	local owner = self:GetOwner()
	local animTime = VJ.AnimDuration(owner:GetViewModel(), anim)
	self:SendWeaponAnim(anim)
	self.NextIdleT = CurTime() + animTime
	self.NextReloadT = CurTime() + animTime
	if viewPunch then
		self:DoViewPunch(viewPunch)
	end
	return animTime
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:PlayDelayedSound(snd,time,vol,pit,ent)
	ent = ent or self
	local owner = self:GetOwner()
	timer.Simple(time,function()
		if IsValid(self) && IsValid(owner) && owner:GetActiveWeapon() == self && IsValid(ent) then
			VJ.EmitSound(ent, snd, vol or 75, pit or 100)
		end
	end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
local math_Clamp = math.Clamp
--
function SWEP:CustomOnPrimaryAttack_AfterShoot()
	if self.OnShoot then
		self:OnShoot()
	end
	if CLIENT then return end
	self:SetOverHeat(math_Clamp(self:GetOverHeat() +0.008,0,1))
	self.CoolDownT = CurTime() +(self:GetOverHeat() *6)
end
---------------------------------------------------------------------------------------------------------------------------------------------
local sprintAng = Angle(0,0.5,0.8)
local string_find = string.find
--
function SWEP:CustomOnThink()
	local owner = self:GetOwner()
	local curTime = CurTime()
	if self.OnThink then
		self:OnThink(owner)
	end
	if curTime > self.CoolDownT then
		self:SetOverHeat(math_Clamp(self:GetOverHeat() -0.0025,0,1))
	end
	if !owner:IsPlayer() then return end
	if self:GetSprinting() then
		self:SetHoldType((self.HoldType == "crossbow" or self.HoldType == "smg" or self.HoldType == "rpg" or self.HoldType == "shotgun" or self.HoldType == "ar2" or self.HoldType == "physgun") && "passive" or "normal")
	else
		self:SetHoldType(self.HoldType)
	end
	if !SERVER then return end

	if owner:KeyDown(IN_SPEED) && owner:GetVelocity():Length() > 5 && owner:OnGround() then
		if self:GetSprinting() == false then
			self:SetSprinting(true)
			self.SprintDelayT = CurTime() +(SPRINT_TIME *0.7)
			if self:GetZoomed() == true then
				self:Zoom(true)
			end
		end
	else
		if self:GetSprinting() == true then
			self:SetSprinting(false)
			self.SprintDelayT = CurTime() +(SPRINT_TIME *0.7)
		end
	end

	if owner:KeyDown(IN_ATTACK) && owner:KeyDown(IN_USE) then
		self:DoInspection()
	end

	if owner:KeyDown(IN_ATTACK2) && self.UsesZoom then
		if self:GetZoomed() == false then
			self:Zoom()
		end
	else
		if self:GetZoomed() == true then
			self:Zoom()
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnReload()
	if self.OnReload then
		self:OnReload()
	end
	if self:GetZoomed() == true then
		self:SetZoomed(false)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:GetZoomViewModelPosition()
	return self:GetZoomed(), self.ViewModelZoomAdjust.Pos, self.ViewModelZoomAdjust.Ang
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:GetViewModelAdjustPosition()
	return self.ViewModelAdjust.Pos, self.ViewModelAdjust.Ang
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnSecondaryAttack()
	return self.UsesZoom
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CanPrimaryAttack()
	if self.Reloading then return false end
	if self:GetSprinting() == true then return false end
	if CurTime() <= self.SprintDelayT then return end
	if self.Weapon:Clip1() <= 0 then
		self:EmitSound("Weapon_Pistol.Empty")
		self:SetNextPrimaryFire(CurTime() +0.2)
		self:Reload()
		return false
	end
	return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CanSecondaryAttack()
	return CurTime() > self:GetNextSecondaryFire() && !self.Reloading && self:GetSprinting() == false && CurTime() > self.SprintDelayT
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CanSpecialSecondaryAttack()
	return CurTime() > self:GetNextSecondaryFire() && !self.Reloading && self:GetSprinting() == false && CurTime() > self.SprintDelayT
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:SecondaryAttack()
	if !self:CanSecondaryAttack() or self.Reloading then return end
	if self:CustomOnSecondaryAttack() == false then return end
	
	local owner = self:GetOwner()
	self:TakeSecondaryAmmo(self.Secondary.TakeAmmo)
	owner:SetAnimation(PLAYER_ATTACK1)
	local anim = VJ.PICK(self.AnimTbl_SecondaryFire)
	local animTime = VJ.AnimDuration(owner:GetViewModel(), anim)
	self:SendWeaponAnim(anim)
	self.NextIdleT = CurTime() + animTime
	self.NextReloadT = CurTime() + animTime
	
	self:SetNextSecondaryFire(CurTime() + (self.Secondary.Delay == false and animTime or self.Secondary.Delay))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CanReload()
	return self:GetSprinting() == false && self:GetZoomed() == false && CurTime() > self.SprintDelayT
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:Reload()
	if !IsValid(self) then return end
	local owner = self:GetOwner()
	if self:CanReload() == false then return end
	if !IsValid(owner) or !owner:IsPlayer() or !owner:Alive() or owner:GetAmmoCount(self.Primary.Ammo) == 0 or self.Reloading or CurTime() < self.NextReloadT then return end // or !owner:KeyDown(IN_RELOAD)
	if self:Clip1() < self.Primary.ClipSize then
		self.Reloading = true
		self:CustomOnReload()
		if SERVER && self.HasReloadSound == true then owner:EmitSound(VJ.PICK(self.ReloadSound), 50, math.random(90, 100)) end
		-- Handle clip
		timer.Simple(self.Reload_TimeUntilAmmoIsSet, function()
			if IsValid(self) && self:CustomOnReload_Finish() != false then
				local ammoUsed = math.Clamp(self.Primary.ClipSize - self:Clip1(), 0, owner:GetAmmoCount(self:GetPrimaryAmmoType())) -- Amount of ammo that it will use (Take from the reserve)
				owner:RemoveAmmo(ammoUsed, self.Primary.Ammo)
				self:SetClip1(self:Clip1() + ammoUsed)
				self:CustomOnReload_Finish()
			end
		end)
		-- Handle animation
		owner:SetAnimation(PLAYER_RELOAD)
		local anim = VJ.PICK(self.AnimTbl_Reload)
		local animTime = VJ.AnimDuration(owner:GetViewModel(), anim)
		self:SendWeaponAnim(anim)
		self.NextIdleT = CurTime() + animTime
		timer.Simple(animTime, function()
			if IsValid(self) then
				self.Reloading = false
			end
		end)
		return true
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:Zoom(override)
	if self.Reloading then return end
	if !override && self:GetSprinting() then return end
	if self:GetNextSecondaryFire() > CurTime() then return end
	if self.DelayZoom && CurTime() < self.DelayZoom then return end
	local zoomed = self:GetZoomed()
	self:SetZoomed(!zoomed)
	-- self:GetOwner():SetFOV(self:GetZoomed() && (self.ZoomLevel or 40) or (GetConVar("fov_desired"):GetInt() or 90), 0.25)
	-- self.Primary.Cone = (self:GetZoomed() && self.Original_Cone *0.5) or self.Original_Cone
	-- self.Primary.Recoil = (self:GetZoomed() && self.Original_Recoil *0.25) or self.Original_Recoil
	self:EmitSound(self:GetZoomed() && "cpthazama/cs2/weapons/weapon_zoom_out_02.wav" or "cpthazama/cs2/weapons/weapon_zoom_out_03.wav", 50, 115)
	self.DelayZoom = CurTime() +IRONSIGHT_TIME
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:GetViewModelPosition(pos,ang)
	local defaultPos, defaultAng = self:GetViewModelAdjustPosition(pos,ang)

	pos:Add(ang:Right() *(defaultPos.Right))
	pos:Add(ang:Forward() *(defaultPos.Forward))
	pos:Add(ang:Up() *(defaultPos.Up))
	ang:RotateAroundAxis(ang:Right(),defaultAng.Right)
	ang:RotateAroundAxis(ang:Up(),defaultAng.Up)
	ang:RotateAroundAxis(ang:Forward(),defaultAng.Forward)

	local shouldZoom, zoomPos, zoomAng = self:GetZoomViewModelPosition()

	if !self.ZoomT then
		self.ZoomT = 0
	end
	if shouldZoom != self.ShouldZoom then
		self.ShouldZoom = shouldZoom
		self.ZoomT = self.ZoomT > CurTime() && CurTime() +(self.ZoomT -CurTime()) or CurTime()
	end
	
	local ZoomT = self.ZoomT or 0

	if !(!shouldZoom && ZoomT < CurTime() -IRONSIGHT_TIME) then
		local Mul = 1
		if ZoomT > CurTime() -IRONSIGHT_TIME then
			Mul = math.Clamp((CurTime() -ZoomT) /IRONSIGHT_TIME,0,1)
			if !shouldZoom then
				Mul = 1 -Mul
			end
		end

		pos:Add(ang:Right() *(zoomPos.Right *Mul))
		pos:Add(ang:Forward() *(zoomPos.Forward *Mul))
		pos:Add(ang:Up() *(zoomPos.Up *Mul))
		ang:RotateAroundAxis(ang:Right(),zoomAng.Right *Mul)
		ang:RotateAroundAxis(ang:Up(),zoomAng.Up *Mul)
		ang:RotateAroundAxis(ang:Forward(),zoomAng.Forward *Mul)
	end

	return pos,ang
end
---------------------------------------------------------------------------------------------------------------------------------------------
local math_Clamp = math.Clamp
local math_AngleDifference = math.AngleDifference
local math_min = math.min
local math_max = math.max
local math_abs = math.abs
local math_sin = math.sin
local math_cos = math.cos
--
function SWEP:CalcViewModelView(vm, OldEyePos, OldEyeAng, EyePos, EyeAng)
	local EyePos, EyeAng = self:GetViewModelPosition(OldEyePos, OldEyeAng)
	local ply = self:GetOwner()
	local EyePos = OldEyePos
	local EyeAng = OldEyeAng
	local zoomed = self:GetZoomed()
	local sprinting = self:GetSprinting()
	lookDelta = lookDelta or Angle()
	lookAng = lookAng or Angle()
	avoidanceAng = avoidanceAng or Angle()
	compensation = compensation or Angle()

	if !self.OffsetPos then
		self.OffsetPos = Vector()
	end

    local pitch = EyeAng.p
    local pitch_modifier = math_Clamp(pitch /90,-1,1)
    local forward_movement = pitch_modifier *3
    EyePos = EyePos +EyeAng:Forward() *forward_movement
    
	local targetSpeed = sprinting && 400 or 200
	local maxSpeed = sprinting && ply:GetRunSpeed() or ply:GetWalkSpeed()
	local speedFrac = (maxSpeed /targetSpeed)
	local vel = ply:GetVelocity():Length2D()
	local realspeed = ply:GetVelocity():Length2D() /maxSpeed
	local speed = math_Clamp(ply:GetVelocity():Length2DSqr() /maxSpeed,0.25,1) *((sprinting && 2 or 1.2) *speedFrac)

	local bob_x_val = CurTime() *8
	local bob_y_val = CurTime() *18
	
	local bob_x = math_sin(bob_x_val *(vel > 20 && 1 or 0.15)) *(zoomed && 0.01 or 0.2)
	local bob_y = math_sin(bob_y_val *0.15) *(zoomed && 0.0075 or 0.1)
	EyePos = EyePos +EyeAng:Right() *bob_x
	EyePos = EyePos +EyeAng:Up() *bob_y
	EyeAng:RotateAroundAxis(EyeAng:Forward(),5 *bob_x)
	
	local speed_mul = zoomed && 0.4 or 2
	if realspeed > 0.1 then
		local bobspeed = self:GetOwner():OnGround() && math_Clamp(realspeed *1,0,1.5) or 0.15
		local bob_x = math_sin(bob_x_val *speed) *0.2 *bobspeed
		local bob_y = math_cos(bob_y_val *speed) *0.075 *bobspeed
		EyePos = EyePos +EyeAng:Right() *bob_x *speed_mul *1
		EyePos = EyePos +EyeAng:Up() *bob_y *speed_mul *2
	end

	local moveMult = (sprinting && 0 or zoomed && 0.2) or 1
	-- if !sprinting && !zoomed then
		if !self.SwayPos then
			self.SwayPos = Vector()
		end
		if !self.SwayAng then
			self.SwayAng = Angle()
		end

		local vel = ply:GetVelocity()
		vel = WorldToLocal(vel, Angle(), Vector(), ply:EyeAngles())
		vel.x = math_Clamp(vel.x/255,-2,2) *moveMult
		vel.y = math_Clamp(vel.y/255,-2,2) *moveMult
		vel.z = math_Clamp(vel.z/255,-1.5,1) *moveMult
		local velAng = Angle(vel.x *1,vel.y *1.25,vel.y *-2.5)
		
		self.SwayPos = LerpVector(FrameTime() *10,self.SwayPos,-vel)
		self.SwayAng = LerpAngle(FrameTime() *10,self.SwayAng,velAng)

		EyePos = EyePos +self.SwayPos
		EyeAng = EyeAng +self.SwayAng
	-- end

	if ply:Crouching() && !zoomed then
		self.OffsetPos = LerpVector(FrameTime() *10,self.OffsetPos,EyeAng:Up() *(realspeed > 0.1 && -1.5 or -3))
	else
		if realspeed > 0.1 && !sprinting then
			self.OffsetPos = LerpVector(FrameTime() *10,self.OffsetPos,EyeAng:Up() *-1.5)
		else
			self.OffsetPos = LerpVector(FrameTime() *10,self.OffsetPos,Vector())
		end
	end

	local eyeAngles = ply:EyeAngles()
	oldEyeAngles = oldEyeAngles or eyeAngles
	local refreshRate = zoomed && 1 or 5
	local deltaScale = 1.1 -math_min((math_abs(lookAng.p) +math_abs(lookAng.y) +math_abs(lookAng.r)) /20,1)
	lookDelta.p = math_AngleDifference(eyeAngles.p,oldEyeAngles.p) /0.01 /120 *deltaScale
	lookDelta.y = math_AngleDifference(eyeAngles.y,oldEyeAngles.y) /0.01 /120 *deltaScale
	lookDelta.r = math_AngleDifference(eyeAngles.r,oldEyeAngles.r) /0.01 /120 *deltaScale
	oldEyeAngles = eyeAngles
	avoidanceAng = LerpAngle(0.01 *(refreshRate *0.96),avoidanceAng,-lookAng)
	lookAng = LerpAngle(0.01 *refreshRate,lookAng,lookDelta)

	EyeAng = EyeAng +lookAng
	EyePos = EyePos +self.OffsetPos

	local EyePos, EyeAng = self:GetViewModelPosition(EyePos, EyeAng)
	return EyePos, EyeAng
end
---------------------------------------------------------------------------------------------------------------------------------------------
if CLIENT then
	function SWEP:DrawWorldModel()
		if !IsValid(self) then return end
		
		local noDraw = false
		if !self:CustomOnDrawWorldModel() or self:GetNW2Bool("VJ_WorldModel_Invisible") == true or self.WorldModel_Invisible == true then noDraw = true end
		
		if self.WorldModel_NoShadow == true then
			self:DrawShadow(false)
		end

		if self.WorldModel_UseCustomPosition == true then
			local owner = self:GetOwner()
			if IsValid(owner) then
				if owner:IsPlayer() && owner:InVehicle() then return end
				local wepPos = self:GetWeaponCustomPosition(owner)
				if wepPos == nil then return end
				self:SetRenderOrigin(wepPos.pos)
				self:SetRenderAngles(wepPos.ang)
				-- self:FrameAdvance(FrameTime())
				-- self:SetupBones()
				if noDraw == false then self:DrawModel() end
			else
				self:SetRenderOrigin(nil)
				self:SetRenderAngles(nil)
				if noDraw == false then self:DrawModel() end
			end
		else
			if noDraw == false then self:DrawModel() end
		end
	end
end