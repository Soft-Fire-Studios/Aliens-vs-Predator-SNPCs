SWEP.Base 						= "weapon_base"
SWEP.PrintName					= ""
SWEP.Author 					= "Cpt. Hazama"
SWEP.Contact					= ""
SWEP.Purpose					= ""
SWEP.Instructions				= ""
SWEP.RenderGroup 				= RENDERGROUP_OPAQUE

SWEP.SwayScale 					= 0.2
SWEP.BobScale 					= 0

SWEP.ViewModel					= ""
SWEP.WorldModel					= ""
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

SWEP.DeploySound = {"cpthazama/avp/weapons/predator/wrist_blades/prd_wrist_blades_draw_01.ogg","cpthazama/avp/weapons/predator/wrist_blades/prd_wrist_blades_draw_02.ogg"}

SWEP.Translations = {}
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:Initialize()
	self.SequenceTime = 0
	self.LastIdleType = 0
	self.NextFidgetT = CurTime() +math.Rand(1,3)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:PlayWeaponAnimation(anim,speed,cycle,isIdle)
	local owner = self:GetOwner()
	local vm = owner:GetViewModel()
	if !IsValid(vm) then return end

	if istable(anim) then
		anim = VJ.PICK(anim)
	end

	local animDur = 0
	if isstring(anim) then
		local seq = vm:LookupSequence(anim)
		vm:ResetSequence(seq)
		vm:ResetSequenceInfo()
		vm:SetPlaybackRate(speed or 1)
		vm:SetCycle(cycle or 0)
		animDur = vm:SequenceDuration(seq)
		if !isIdle then
			self.SequenceTime = CurTime() +animDur
		end
	elseif isnumber(anim) then
		self:SendWeaponAnim(anim)
		animDur = VJ.AnimDuration(vm, anim)
	end

	self.NextIdleT = CurTime() +animDur -0.15
	return animDur
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:Deploy()
	local owner = self:GetOwner()
	if owner:IsPlayer() then
		self:EmitSound(VJ.PICK(self.DeploySound), 50, math.random(90, 100))
		self:PlayWeaponAnimation("predator_hud_claws_extend")
	end
	return true
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
local string_find = string.find
local string_replace = string.Replace
--
function SWEP:OnChangeActivity(npc,act)
	local curTime = CurTime()
	local owner = self:GetOwner()
	local vm = owner:GetViewModel()
	if !IsValid(vm) then return end

	if isnumber(act) then
		act = npc:GetSequenceName(npc:SelectWeightedSequence(act))
		if act == "Not Found!" or act == "Unknown" then
			act = nil
		end
	end

	local curSeq = act or npc:GetSequenceName(npc:GetSequence())
	local curSeqEdit = string_replace(curSeq,"predator_","predator_hud_")
	local vmSeq = vm:GetSequenceName(vm:GetSequence())
	local vmSeqEdit = string_replace(vmSeq,"_hud_","_")
	local trans = self.Translations[curSeq]
	local lastSeq = self.LastSequence
	if trans then
		if vmSeq != trans then
			self.NextIdleT = CurTime() +self:PlayWeaponAnimation(trans)
			return
		end
	else
		if VJ.AnimExists(vm,curSeqEdit) && vmSeq != curSeqEdit then
			-- if vm:GetCycle() >= 1 or lastSeq == curSeqEdit then return end
			self.NextIdleT = CurTime() +self:PlayWeaponAnimation(curSeqEdit)
			return
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:Think()
	if CLIENT then return end
	local curTime = CurTime()
	local owner = self:GetOwner()
	local vm = owner:GetViewModel()

	local npc = owner.VJ_AVP_ViewModelNPC
	if IsValid(npc) then
		if IsValid(vm) then
			if !self:IsBusy() && curTime > (self.SequenceTime or 0) then
				if npc:OnGround() && npc:IsMoving() && !npc:GetSprinting() && self.LastIdleType != 2 then
					self.NextIdleT = 0
					self.LastIdleType = 2
					self.IdleSpeed = 1
					self.AnimTbl_Idle = {"predator_hud_claws_run"}
				elseif npc:OnGround() && npc:GetSprinting() && self.LastIdleType != 3 then
					self.NextIdleT = 0
					self.LastIdleType = 3
					self.IdleSpeed = 1.5
					self.AnimTbl_Idle = {"predator_hud_claws_sprint"}
				elseif !npc:IsMoving() && !npc:GetSprinting() && self.LastIdleType != 1 then
					self.NextIdleT = 0
					self.LastIdleType = 1
					self.IdleSpeed = 1
					self.AnimTbl_Idle = {"predator_hud_claws_rest"}
				end
			end
			-- local curSeq = npc:GetSequenceName(npc:GetSequence())
			-- local curSeqEdit = string_replace(curSeq,"predator_","predator_hud_")
			-- local vmSeq = vm:GetSequenceName(vm:GetSequence())
			-- local vmSeqEdit = string_replace(vmSeq,"_hud_","_")
			-- local trans = self.Translations[curSeq]
			-- local lastSeq = self.LastSequence
			-- if trans then
			-- 	if vmSeq != trans then
			-- 		self.NextIdleT = CurTime() +self:PlayWeaponAnimation(trans)
			-- 		return
			-- 	end
			-- else
			-- 	if VJ.AnimExists(vm,curSeqEdit) && vmSeq != curSeqEdit then
			-- 		if vm:GetCycle() >= 1 or lastSeq == curSeqEdit then return end
			-- 		self.NextIdleT = CurTime() +self:PlayWeaponAnimation(curSeqEdit)
			-- 		return
			-- 	end
			-- end
		end
	end

	self:DoIdleAnimation()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:PrimaryAttack() return false end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:SecondaryAttack() return false end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:Reload() return false end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:DoIdleAnimation()
	if CurTime() < self.NextIdleT then return end
	local owner = self:GetOwner()
	if IsValid(owner) then
		local anim = VJ.PICK(self.AnimTbl_Idle or ACT_VM_IDLE_1)
		local animTime = self:PlayWeaponAnimation(anim,self.IdleSpeed or 1,nil,true)
		self.NextIdleT = CurTime() +animTime
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
if CLIENT then
	function SWEP:DrawWorldModel()
		if !IsValid(self) then return end
		self:DrawShadow(false)
	end
end