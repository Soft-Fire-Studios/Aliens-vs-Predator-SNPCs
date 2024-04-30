SWEP.Base 						= "weapon_vj_base"
SWEP.Author 					= "Cpt. Hazama"
SWEP.Contact					= "http://steamcommunity.com/groups/vrejgaming"
SWEP.Purpose					= "This weapon is made for Players and NPCs"
SWEP.Instructions				= "Controls are like a regular weapon."
SWEP.Category					= "VJ Base - Aliens vs Predator"

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
-- SWEP.PrimaryEffects_MuzzleParticles = {"vj_muzzle_main"}
-- SWEP.PrimaryEffects_MuzzleParticles = {"vj_muzzle_main","vj_avp_wep_rifle_muzzle"}
-- SWEP.PrimaryEffects_MuzzleParticlesAsOne = true
SWEP.PrimaryEffects_SpawnShells = false
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

SWEP.Primary.UsesLoopedSound 	= false
SWEP.Primary.StartSound 		= {}
SWEP.Primary.EndSound 			= {}
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
	self.Original_Recoil = self.Primary.Recoil
	self.Original_Cone = self.Primary.Cone

	if self.Primary.UsesLoopedSound then
		self.PrimarySound = self.Primary.Sound
		self.Primary.Sound = nil
		self.PrimaryLoop = CreateSound(self, VJ.PICK(self.PrimarySound))
		self.PrimaryLoop:SetSoundLevel(self.Primary.SoundLevel or 75)
	end

	self.PrimaryLoopSoundT = 0

	if self.OnInit then
		self:OnInit()
	end
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

	if self.Primary.UsesLoopedSound then
		self.PrimaryLoopSoundT = CurTime() +0.1
		if math.random(1,7) == 1 && self.PrimaryLoop:IsPlaying() && #self.PrimarySound > 1 then
			self.PrimaryLoop:Stop()
			self.PrimaryLoop = CreateSound(self, VJ.PICK(self.PrimarySound))
			self.PrimaryLoop:SetSoundLevel(self.Primary.SoundLevel or 75)
			self.PrimaryLoop:Play()
		end
	end

	if CLIENT then return end
	if math.random(1,2) == 1 then
		self:SetOverHeat(math_Clamp(self:GetOverHeat() +0.008,0,1))
	end
	self.CoolDownT = CurTime() +(self:GetOverHeat() *6)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:IsBusy()
	return self.Reloading
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OwnerChanged()
	if self.Primary.UsesLoopedSound && self.PrimaryLoop then
		self.PrimaryLoop:Stop()
	end

	local owner = self:GetOwner()
	if IsValid(owner) then
		self:OnNewOwner(owner)
	else
		self:OnNoOwner()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnNewOwner(owner) end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnNoOwner() end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:AdjustMouseSensitivity()
	return self:GetZoomed() && 0.25 or 1
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

	if SERVER && self.HasMotionTracker && owner:IsNPC() then
		VJ_AVP_MotionTracker(owner)
	end

	if self.PrimaryLoop then
		if CurTime() > self.PrimaryLoopSoundT && self.PrimaryLoopSoundT > 0 then
			self.PrimaryLoop:Stop()
			self.PrimaryLoopSoundT = 0
			if IsValid(owner) then
				local fireSd = VJ.PICK(self.Primary.EndSound)
				if fireSd != false then
					sound.Play(fireSd, owner:GetPos(), self.Primary.SoundLevel, math.random(self.Primary.SoundPitch.a, self.Primary.SoundPitch.b), self.Primary.SoundVolume)
				end
			end
		elseif self.PrimaryLoopSoundT > CurTime() && !self.PrimaryLoop:IsPlaying() then
			self.PrimaryLoop:Play()
			if IsValid(owner) then
				local fireSd = VJ.PICK(self.Primary.StartSound)
				if fireSd != false then
					sound.Play(fireSd, owner:GetPos(), self.Primary.SoundLevel, math.random(self.Primary.SoundPitch.a, self.Primary.SoundPitch.b), self.Primary.SoundVolume)
				end
			end
		end
		self:NextThink(CurTime())
	end

	if !owner:IsPlayer() then return end
	if self:GetSprinting() then
		self:SetHoldType((self.HoldType == "crossbow" or self.HoldType == "smg" or self.HoldType == "rpg" or self.HoldType == "shotgun" or self.HoldType == "ar2" or self.HoldType == "physgun") && "passive" or "normal")
	else
		self:SetHoldType(self.HoldType)
	end

	if !SERVER then return end

	if owner:KeyDown(IN_SPEED) && owner:GetVelocity():Length() > 5 && owner:OnGround() then
		if owner:KeyDown(IN_DUCK) then return end
		if self:GetSprinting() == false then
			self:SetSprinting(true)
			self.AppliedMovementAnimation = false
			self.AnimTbl_Idle = {ACT_VM_MISSCENTER2}
			if !self:IsBusy() then
				self.NextIdleT = 0
			end
			self.SprintDelayT = CurTime() +(SPRINT_TIME *0.7)
			if self:GetZoomed() == true then
				self:Zoom(true)
			end
		end
	else
		local moving = owner:GetVelocity():Length() > 5 && owner:OnGround()
		if self:GetSprinting() == true then
			self:SetSprinting(false)
			if moving then
				if !self.AppliedMovementAnimation then
					self.AppliedMovementAnimation = true
					self.AnimTbl_Idle = {ACT_VM_MISSCENTER}
				end
			else
				self.AnimTbl_Idle = {ACT_VM_IDLE}
			end
			if !self:IsBusy() then
				self.NextIdleT = 0
			end
			self.SprintDelayT = CurTime() +(SPRINT_TIME *0.7)
		end
		local vm = owner:GetViewModel()
		if moving then
			if !self.AppliedMovementAnimation then
				self.AppliedMovementAnimation = true
				self.AnimTbl_Idle = {ACT_VM_MISSCENTER}
				if !self:IsBusy() then
					self.NextIdleT = 0
				end
			end
			if vm:GetSequenceActivity(vm:GetSequence()) == ACT_VM_MISSCENTER then
				vm:SetPlaybackRate(math.Clamp((owner:GetVelocity():Length() /owner:GetWalkSpeed()) *1.5,0.5,1.5))
			else
				vm:SetPlaybackRate(1)
			end
		else
			if self.AppliedMovementAnimation then
				self.AppliedMovementAnimation = false
				self.AnimTbl_Idle = {ACT_VM_IDLE}
				if !self:IsBusy() then
					self.NextIdleT = 0
				end
			end
			vm:SetPlaybackRate(1)
		end
	end

	if owner:KeyDown(IN_ATTACK) && owner:KeyDown(IN_USE) && self:CanSpecialSecondaryAttack() then
		self:MeleeAttack(owner)
	end

	if owner:KeyDown(IN_ATTACK2) && !owner:KeyDown(IN_USE) && self.UsesZoom then
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
function SWEP:GetNearestPoint(argent,SameZ)
	if !IsValid(argent) then return end
	SameZ = SameZ or false -- Should the Z of the pos be the same as the NPC's?
	local myNearestPoint = self:GetOwner():EyePos()
	local NearestPositions = {MyPosition=Vector(0,0,0), EnemyPosition=Vector(0,0,0)}
	local Pos_Enemy, Pos_Self = argent:NearestPoint(myNearestPoint + argent:OBBCenter()), self:NearestPoint(argent:GetPos() + self:OBBCenter())
	Pos_Enemy.z, Pos_Self.z = argent:GetPos().z, myNearestPoint.z
	if SameZ == true then
		Pos_Enemy = Vector(Pos_Enemy.x,Pos_Enemy.y,self:SetNearestPointToEntityPosition().z)
		Pos_Self = Vector(Pos_Self.x,Pos_Self.y,self:SetNearestPointToEntityPosition().z)
	end
	NearestPositions.MyPosition = Pos_Self
	NearestPositions.EnemyPosition = Pos_Enemy
	return NearestPositions
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:DealDamage(v)
	local applyDmg = DamageInfo()
	applyDmg:SetDamage(self.MeleeAttackDamage or 10)
	applyDmg:SetDamageType(self.MeleeAttackDamageType or DMG_CLUB)
	applyDmg:SetDamagePosition(self:GetNearestPoint(v).MyPosition)
	applyDmg:SetDamageForce(self:GetForward() *((applyDmg:GetDamage() +100) *70))
	applyDmg:SetInflictor(self)
	applyDmg:SetAttacker(self:GetOwner())
	v:TakeDamageInfo(applyDmg,self:GetOwner())
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnMeleeHit(entities,hitType,owner) end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnMeleeHit(entities)
	local owner = self:GetOwner()
	local hitType = 0
	if #entities <= 0 then
		local tr = util.TraceLine({
			start = owner:GetShootPos(),
			endpos = owner:GetShootPos() +owner:GetAimVector() *120,
			filter = {owner,self}
		})
		if tr.Hit then
			sound.Play("cpthazama/avp/weapons/blocking/block_hit_generic_mono_0" .. math.random(1,3) .. ".ogg", tr.HitPos, 75)
			hitType = 1
		else
			VJ.CreateSound(self,"cpthazama/avp/weapons/human/melee/marine_melee_swing_0" .. math.random(1,2) .. ".ogg",70)
			hitType = 2
		end
	else
		sound.Play("cpthazama/avp/weapons/impacts/melee/melee_impact_flesh_01.ogg", owner:EyePos(), 75)
		hitType = 3
	end

	self:CustomOnMeleeHit(entities,hitType,owner)
end
---------------------------------------------------------------------------------------------------------------------------------------------
if CLIENT then
	net.Receive("VJ.AVP.AnimationSync",function(len)
		local owner = net.ReadEntity()
		local anim = net.ReadInt(16)
		if IsValid(owner) then
			owner:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, anim or ACT_GMOD_GESTURE_MELEE_SHOVE_2HAND, true)
		end
	end)
else
	util.AddNetworkString("VJ.AVP.AnimationSync")
end
--
function SWEP:PlayPlayerAnimation(anim)
	local owner = self:GetOwner()
	owner:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD,anim,true)
	net.Start("VJ.AVP.AnimationSync")
		net.WriteEntity(owner)
		net.WriteInt(anim,16)
	net.Send(owner)
end
---------------------------------------------------------------------------------------------------------------------------------------------
local IsProp = VJ.IsProp
--
function SWEP:MeleeAttack(owner)
	local anim = VJ.AnimExists(owner:GetViewModel(),ACT_VM_HITCENTER) && ACT_VM_HITCENTER
	if !anim then return end
	local animTime = VJ.AnimDuration(owner:GetViewModel(),anim)
	self:SendWeaponAnim(anim)
	self:PlayPlayerAnimation(ACT_GMOD_GESTURE_MELEE_SHOVE_2HAND)
	self.NextIdleT = CurTime() +animTime
	self.NextReloadT = CurTime() +animTime

	if SERVER then
		timer.Simple(0.1,function()
			if IsValid(owner) && IsValid(self) && owner:GetActiveWeapon() == self then
				local tbl = {}
				for _,v in ipairs(ents.FindInSphere(owner:GetShootPos(),120)) do
					if owner:Visible(v) && v != self && v != owner && (v:IsNPC() or v:IsPlayer() or v:IsNextBot() or IsProp(v)) && (owner:GetAimVector():Angle():Forward():Dot(((v:GetPos() +v:OBBCenter()) - owner:GetShootPos()):GetNormalized()) > math.cos(math.rad(45))) then
						table.insert(tbl,v)
						self:DealDamage(v)
					end
				end
				self:OnMeleeHit(tbl)
			end
		end)
	end
	
	self:SetNextPrimaryFire(CurTime() +animTime)
	self:SetNextSecondaryFire(CurTime() +animTime)
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
	if self:GetOwner():IsPlayer() && self:GetOwner():KeyDown(IN_USE) then return false end
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
function SWEP:ThrowFlare(owner)
	local anim = VJ.AnimExists(owner:GetViewModel(),ACT_VM_RECOIL1) && ACT_VM_RECOIL1
	local animTime = 0.6
	if anim then
		animTime = VJ.AnimDuration(owner:GetViewModel(),anim)
		self:SendWeaponAnim(anim)
		self:PlayPlayerAnimation(ACT_GMOD_GESTURE_ITEM_THROW)
		self.NextIdleT = CurTime() +animTime
		self.NextReloadT = CurTime() +animTime
	end
	timer.Simple(0.3,function()
		if IsValid(owner) && IsValid(self) && owner:GetActiveWeapon() == self then
			SafeRemoveEntity(owner.VJ_AVP_Flare)
			local flare = ents.Create("obj_vj_flareround")
			flare:SetPos(owner:GetShootPos() +owner:GetUp() *-5)
			flare:SetAngles(owner:EyeAngles())
			flare:SetOwner(owner)
			flare:Spawn()
			flare:Activate()
			local phys = flare:GetPhysicsObject()
			if IsValid(phys) then
				phys:Wake()
				phys:SetVelocity(owner:GetAimVector() *850)
			end
			owner.VJ_AVP_Flare = flare
			owner:SetNW2Entity("AVP.Flare",flare)
		end
	end)
	
	self:SetNextSecondaryFire(CurTime() +(self.Secondary.Delay == false && animTime or self.Secondary.Delay))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:SecondaryAttack()
	if !self:CanSecondaryAttack() or self.Reloading then return end
	if self:CustomOnSecondaryAttack() == false then return end
	
	local owner = self:GetOwner()
	if owner:IsPlayer() && owner:KeyDown(IN_USE) && !IsValid(owner.VJ_AVP_Flare) then
		self:ThrowFlare(owner)
		return
	end

	self:TakeSecondaryAmmo(self.Secondary.TakeAmmo)
	owner:SetAnimation(PLAYER_ATTACK1)
	local anim = VJ.PICK(self.AnimTbl_SecondaryFire)
	local animTime = 0.25
	if anim then
		animTime = VJ.AnimDuration(owner:GetViewModel(), anim)
		self:SendWeaponAnim(anim)
		self.NextIdleT = CurTime() + animTime
		self.NextReloadT = CurTime() + animTime
	end

	if self.OnSecondaryAttack then
		self:OnSecondaryAttack(anim,animTime)
	end
	
	self:SetNextSecondaryFire(CurTime() + (self.Secondary.Delay == false && animTime or self.Secondary.Delay))
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
	self:GetOwner():SetFOV(self:GetZoomed() && (self.ZoomLevel or 40) or (GetConVar("fov_desired"):GetInt() or 90), 0.25)
	self.Primary.Cone = (self:GetZoomed() && self.Original_Cone *0.5) or self.Original_Cone
	self.Primary.Recoil = (self:GetZoomed() && self.Original_Recoil *0.25) or self.Original_Recoil
	-- self:EmitSound(self:GetZoomed() && "cpthazama/cs2/weapons/weapon_zoom_out_02.wav" or "cpthazama/cs2/weapons/weapon_zoom_out_03.wav", 50, 115)
	self.DelayZoom = CurTime() +IRONSIGHT_TIME
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnHolster(newWep)
	VJ.STOPSOUND(self.PrimaryLoop)
	return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnRemove()
	self:StopParticles()
	VJ.STOPSOUND(self.PrimaryLoop)
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
    local pitch_modifier = math_Clamp(pitch /90,-1,0.2)
    local forward_movement = pitch_modifier *3
    EyePos = EyePos +EyeAng:Forward() *forward_movement

	if sprinting then
		EyePos = EyePos +EyeAng:Forward() *1.5
	end
    
	local targetSpeed = sprinting && 400 or 200
	local maxSpeed = sprinting && ply:GetRunSpeed() or ply:GetWalkSpeed()
	local speedFrac = (maxSpeed /targetSpeed)
	-- local vel = ply:GetVelocity():Length2D()
	local vel = 0
	local realspeed = 0
	-- local realspeed = ply:GetVelocity():Length2D() /maxSpeed
	local speed = math_Clamp(ply:GetVelocity():Length2DSqr() /maxSpeed,0.25,1) *((sprinting && 2 or 1.2) *speedFrac)

	local bob_x_val = CurTime() *8
	local bob_y_val = CurTime() *18
	
	local bob_x = math_sin(bob_x_val *(vel > 20 && 1 or 0.15)) *(zoomed && 0.01 or 0.2)
	local bob_y = math_sin(bob_y_val *0.15) *(zoomed && 0.0075 or 0.1)
	EyePos = EyePos +EyeAng:Right() *bob_x
	EyePos = EyePos +EyeAng:Up() *bob_y
	EyeAng:RotateAroundAxis(EyeAng:Forward(),5 *bob_x)
	
	local speed_mul = zoomed && 0.4 or 2
	-- if realspeed > 0.1 then
	-- 	local bobspeed = self:GetOwner():OnGround() && math_Clamp(realspeed *1,0,1.5) or 0.15
	-- 	local bob_x = math_sin(bob_x_val *speed) *0.2 *bobspeed
	-- 	local bob_y = math_cos(bob_y_val *speed) *0.075 *bobspeed
	-- 	EyePos = EyePos +EyeAng:Right() *bob_x *speed_mul *1
	-- 	EyePos = EyePos +EyeAng:Up() *bob_y *speed_mul *2
	-- end

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
	local deltaScale = 4 -math_min((math_abs(lookAng.p) +math_abs(lookAng.y) +math_abs(lookAng.r)) /20,1)
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

		local owner = self:GetOwner()
		if IsValid(owner) && owner.VJ_AVP_Marine then
			self.WorldModel_UseCustomPosition = false
		else
			self.WorldModel_UseCustomPosition = true
		end

		if self.WorldModel_UseCustomPosition == true then
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