SWEP.Base 						= "weapon_base"
SWEP.PrintName					= ""
SWEP.Author 					= "Cpt. Hazama"
SWEP.Contact					= ""
SWEP.Purpose					= ""
SWEP.Instructions				= ""
SWEP.RenderGroup 				= RENDERGROUP_OPAQUE

SWEP.ViewModel					= "models/vj_weapons/c_controller.mdl"
SWEP.WorldModel					= "models/gibs/humans/brain_gib.mdl"
SWEP.HoldType 					= "pistol"
SWEP.Spawnable					= false
SWEP.AdminSpawnable				= false
SWEP.UseHands 					= false
SWEP.VJBase_IsControllerWeapon 	= true

SWEP.Primary.ClipSize 			= -1
SWEP.Primary.DefaultClip		= -1
SWEP.Primary.Automatic 			= false
SWEP.Primary.Ammo 				= "none"
SWEP.Secondary.ClipSize 		= -1
SWEP.Secondary.DefaultClip 		= -1
SWEP.Secondary.Automatic 		= false
SWEP.Secondary.Ammo 			= "none"

SWEP.AnimTbl_Idle = {ACT_SPRINT}
SWEP.DeploySound = {"cpthazama/avp/weapons/predator/wrist_blades/prd_wrist_blades_draw_01.ogg","cpthazama/avp/weapons/predator/wrist_blades/prd_wrist_blades_draw_02.ogg"}
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:Initialize()
	self.LastIdleType = 0
	self.NextFidgetT = CurTime() +math.Rand(1,3)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:PlayWeaponAnimation(anim,speed,cycle)
	local owner = self:GetOwner()
	local vm = owner:GetViewModel()
	if !IsValid(vm) then return end

	if istable(anim) then
		anim = VJ.PICK(anim)
	end

	if isstring(anim) then
		local seq = vm:LookupSequence(anim)
		vm:ResetSequence(seq)
		vm:ResetSequenceInfo()
		vm:SetPlaybackRate(speed or 1)
		vm:SetCycle(cycle or 0)
	elseif isnumber(anim) then
		self:SendWeaponAnim(anim)
	end

	local animDur = VJ.AnimDuration(owner:GetViewModel(), anim)
	self.NextIdleT = CurTime() +animDur -0.15
	return animDur
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:Deploy()
	local owner = self:GetOwner()
	if owner:IsPlayer() then
		if self.HasDeploySound == true then self:EmitSound(VJ.PICK(self.DeploySound), 50, math.random(90, 100)) end
		
		local curTime = CurTime()
		local anim = VJ.PICK(self.AnimTbl_Deploy or ACT_VM_DRAW)
		local animTime = VJ.AnimDuration(owner:GetViewModel(), anim)
		self:SendWeaponAnim(anim)
		self:SetNextPrimaryFire(curTime + animTime)
		self:SetNextSecondaryFire(curTime + animTime)
		self.NextIdleT = curTime + animTime
	end
	return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:PrimaryAttack()
	local owner = self:GetOwner()
	if CLIENT or owner:IsNPC() then return end
	
	-- local curTime = CurTime()
	-- local anim = VJ.PICK({ACT_VM_FIDGET})
	-- -- self:SendWeaponAnim(anim)
	-- local animTime = self:PlayWeaponAnimation("predator_hud_claws_retract")
	-- self:SetNextPrimaryFire(curTime + animTime)
	-- self:SetNextSecondaryFire(curTime + animTime)
	-- self.NextReloadT = curTime + animTime
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnPlaySound(sdFile)
	local curTime = CurTime()
	if curTime > (self.NextFidgetT or 0) && !self:IsBusy(true) then
		local animTime = self:PlayWeaponAnimation({"predator_hud_claws_fidget_inspect_claw","predator_hud_claws_fidget_stretch","predator_hud_claws_fidget_wipe_wrist_pc"})
		self.NextFidgetT = curTime +animTime
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:IsBusy(checkMove)
	local primaryAttackT = self:GetNextPrimaryFire()
	local secondaryAttackT = self:GetNextSecondaryFire()
	local npc = self:GetOwner().VJ_AVP_ViewModelNPC
	local busyNPC = false
	if IsValid(npc) && checkMove then
		busyNPC = npc:IsBusy() or npc:IsMoving()
	end

	if primaryAttackT > CurTime() or secondaryAttackT > CurTime() or busyNPC then
		return true
	end
	return false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:Think()
	if CLIENT then return end
	local curTime = CurTime()
	-- if curTime > (self.NextFidgetT or 0) then
	-- 	self:SendWeaponAnim(ACT_VM_FIDGET)
	-- 	self.NextIdleT = curTime +3
	-- 	self.NextFidgetT = curTime +math.Rand(5,15)
	-- end

	self:DoIdleAnimation()

	local npc = self:GetOwner().VJ_AVP_ViewModelNPC
	if IsValid(npc) then
		if !self:IsBusy() then
			if npc:IsMoving() && !npc:GetSprinting() && self.LastIdleType != 2 then
				self.NextIdleT = 0
				self.LastIdleType = 2
				self.IdleSpeed = 1
				self.AnimTbl_Idle = {"predator_hud_claws_run"}
				-- self:DoIdleAnimation()
			elseif npc:GetSprinting() && self.LastIdleType != 3 then
				self.NextIdleT = 0
				self.LastIdleType = 3
				self.IdleSpeed = 1.5
				self.AnimTbl_Idle = {"predator_hud_claws_sprint"}
				-- self:DoIdleAnimation()
			elseif !npc:IsMoving() && !npc:GetSprinting() && self.LastIdleType != 1 then
				self.NextIdleT = 0
				self.LastIdleType = 1
				self.IdleSpeed = 1
				self.AnimTbl_Idle = {"predator_hud_claws_rest"}
				-- self:DoIdleAnimation()
			end
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:SecondaryAttack() return false end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:DoIdleAnimation()
	-- local curTime = CurTime()

	-- if curTime < self.NextIdleT then return false end

	-- self:SendWeaponAnim(ACT_VM_IDLE_1)
	-- self.NextIdleT = curTime +1
	-- print("IDLE")

	if CurTime() < self.NextIdleT then return end
	local owner = self:GetOwner()
	if IsValid(owner) then
		-- owner:SetAnimation(PLAYER_IDLE)
		print(self.LastIdleType,self.AnimTbl_Idle[1])
		local anim = VJ.PICK(self.AnimTbl_Idle or ACT_VM_IDLE_1)
		local animTime = self:PlayWeaponAnimation(anim,self.IdleSpeed or 1)
		-- self:SendWeaponAnim(anim)
		self.NextIdleT = CurTime() +animTime
	end
end