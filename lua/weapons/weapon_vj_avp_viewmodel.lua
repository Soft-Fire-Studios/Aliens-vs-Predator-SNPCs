SWEP.Base 						= "weapon_base"
SWEP.PrintName					= ""
SWEP.Author 					= "Cpt. Hazama"
SWEP.Contact					= ""
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

SWEP.Translations = {
	["predator_claws_console_use"] = "predator_hud_console_open",
	["predator_mine_throw"] = "predator_hud_predmine_console_use",
	["predator_battledisc_throw"] = "predator_hud_battledisc_throw_complete",
	["predator_plasma_caster_extend"] = "predator_hud_plasma_console_open",
	["predator_spear_2nd_throw"] = "predator_hud_spear_throw",
	["Predator_Battery_Interaction"] = "predator_hud_Battery_Interaction",
	["Predator_Disable_Interaction"] = "predator_hud_Disable_Interaction",
	["predator_mine_fire_into"] = "predator_hud_predmine_into_fire_test",
	["predator_mine_fire_loop"] = "predator_hud_predmine_loop_fire_test",
	["predator_mine_fire_out"] = "predator_hud_predmine_out_fire_test",
	["predator_battledisc_throw"] = "predator_hud_battledisc_throw_complete",
}
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:Initialize()
	self.SequenceTime = 0
	self.LastIdleType = 0
	self.NextFidgetT = CurTime() +math.Rand(1,3)
end
---------------------------------------------------------------------------------------------------------------------------------------------
/*
	Bodygroup (2)
		0 = None
		1 = Stim
		2 = Mine
		3 = Disc
		4 = Spear
		5 = SpearGun
*/
--
function SWEP:OnPlayAnimation(anim,vm,animDur)
	-- local owner = self:GetOwner()
	-- local npc = IsValid(owner) && owner.VJ_AVP_ViewModelNPC
	-- if npc:GetEquipment() != 5 then
	-- 	vm:SetBodygroup(2,0)
	-- end
	if anim == "predator_hud_claws_healthstab" then
		timer.Simple(animDur *0.15,function()
			if IsValid(vm) then
				vm:SetBodygroup(2,1)
			end
		end)
		timer.Simple(animDur *0.9,function()
			if IsValid(vm) then
				vm:SetBodygroup(2,0)
			end
		end)
	elseif anim == "predator_hud_speargun_healthstab" then
		timer.Simple(animDur *0.15,function()
			if IsValid(vm) then
				vm:SetBodygroup(2,1)
			end
		end)
		timer.Simple(animDur *0.9,function()
			if IsValid(vm) then
				vm:SetBodygroup(2,0)
			end
		end)
	elseif anim == "predator_hud_predmine_into_fire_test" then
		vm:SetBodygroup(2,2)
	elseif anim == "predator_hud_predmine_out_fire_test" then
		timer.Simple(1,function()
			if IsValid(vm) then
				vm:SetBodygroup(2,0)
			end
		end)
	elseif anim == "predator_hud_battledisc_extend" then
		vm:SetBodygroup(2,3)
	elseif anim == "predator_hud_battledisc_throw_complete" then
		timer.Simple(0.5,function()
			if IsValid(vm) then
				vm:SetBodygroup(2,0)
			end
		end)
	elseif anim == "predator_hud_battledisc_catch" then
		vm:SetBodygroup(2,3)
		timer.Simple(0.6,function()
			if IsValid(vm) then
				vm:SetBodygroup(2,0)
			end
		end)
	elseif anim == "predator_hud_spear_extend" then
		vm:SetBodygroup(2,4)
	elseif anim == "predator_hud_spear_throw" then
		timer.Simple(0.4,function()
			if IsValid(vm) then
				vm:SetBodygroup(2,0)
			end
		end)
	elseif anim == "predator_hud_spear_retract" then
		vm:SetBodygroup(2,4)
		timer.Simple(1,function()
			if IsValid(vm) then
				vm:SetBodygroup(2,0)
			end
		end)
	end
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

	self.PLY_NextIdleAnimT = CurTime() +animDur -0.15
	self.LastIdleType = 0

	self:OnPlayAnimation(isnumber(anim) && VJ.SequenceToActivity(vm,anim) or anim,vm,animDur)

	return animDur
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:Deploy()
	local owner = self:GetOwner()
	local npc = IsValid(owner) && owner.VJ_AVP_ViewModelNPC
	if owner:IsPlayer() then
		if IsValid(npc) && npc.VJ_AVP_Xenomorph then return end
		self:EmitSound(VJ.PICK(self.DeploySound), 50, math.random(90, 100))
		self:PlayWeaponAnimation("predator_hud_claws_extend")
	end
	return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnPlaySound(sdFile)
	local curTime = CurTime()
	if curTime > (self.NextFidgetT or 0) && !self:IsBusy(true) then
		local owner = self:GetOwner()
		local npc = IsValid(owner) && owner.VJ_AVP_ViewModelNPC
		if IsValid(npc) && npc:GetEquipment() == 5 then return end
		if npc.VJ_AVP_Xenomorph then return end
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
local string_EndsWith = string.EndsWith
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

	local check = npc.VJ_AVP_Xenomorph && "alien" or "predator"
	local curSeq = act or npc:GetSequenceName(npc:GetSequence())
	local curSeqEdit = string_replace(curSeq,check .. "_",check .. "_hud_")
	local vmSeq = vm:GetSequenceName(vm:GetSequence())
	local vmSeqEdit = string_replace(vmSeq,"_hud_","_")
	local trans = self.Translations[curSeq]
	local lastSeq = self.LastSequence
	-- print("Requested:",curSeq)
	if string_EndsWith(curSeq,"_rest") then return end
	if trans then
		if vmSeq != trans then
			self.PLY_NextIdleAnimT = CurTime() +self:PlayWeaponAnimation(trans)
			return
		end
	else
		if VJ.AnimExists(vm,curSeqEdit) && vmSeq != curSeqEdit then
			self.PLY_NextIdleAnimT = CurTime() +self:PlayWeaponAnimation(curSeqEdit)
			return
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
-- function SWEP:ShouldDrawViewModel()
-- 	local npc = owner.VJ_AVP_ViewModelNPC
-- 	if IsValid(npc) && npc.VJ_AVP_Xenomorph && !npc:GetStanding() then
-- 		return false
-- 	end
-- 	return true
-- end
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
				if npc.VJ_AVP_Xenomorph then
					local standing = npc:GetStanding()
					if npc:OnGround() && npc:IsMoving() && !npc:GetSprinting() && self.LastIdleType != 2 then
						self.PLY_NextIdleAnimT = 0
						self.LastIdleType = 2
						self.IdleSpeed = 1
						self.AnimTbl_Idle = {"Alien_hud_standing_walk"}
					elseif npc:OnGround() && npc:GetSprinting() && self.LastIdleType != 3 then
						self.PLY_NextIdleAnimT = 0
						self.LastIdleType = 3
						self.IdleSpeed = 1.5
						self.AnimTbl_Idle = {"Alien_hud_standing_run"}
					elseif !npc:IsMoving() && !npc:GetSprinting() && self.LastIdleType != 1 then
						self.PLY_NextIdleAnimT = 0
						self.LastIdleType = 1
						self.IdleSpeed = 1
						self.AnimTbl_Idle = {"Alien_hud_standing_idle"}
					end
				else
					local animSet = npc:GetEquipment() == 5 && "speargun" or "claws"
					if npc:OnGround() && npc:IsMoving() && !npc:GetSprinting() && self.LastIdleType != 2 then
						self.PLY_NextIdleAnimT = 0
						self.LastIdleType = 2
						self.IdleSpeed = 1
						self.AnimTbl_Idle = {"predator_hud_" .. animSet .. "_run"}
					elseif npc:OnGround() && npc:GetSprinting() && self.LastIdleType != 3 then
						self.PLY_NextIdleAnimT = 0
						self.LastIdleType = 3
						self.IdleSpeed = 1.5
						self.AnimTbl_Idle = {"predator_hud_" .. animSet .. "_sprint"}
					elseif !npc:IsMoving() && !npc:GetSprinting() && self.LastIdleType != 1 then
						self.PLY_NextIdleAnimT = 0
						self.LastIdleType = 1
						self.IdleSpeed = 1
						self.AnimTbl_Idle = {"predator_hud_" .. animSet .. "_rest"}
					end
				end
			end
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
	if CurTime() < self.PLY_NextIdleAnimT then return end
	local owner = self:GetOwner()
	if IsValid(owner) then
		local anim = VJ.PICK(self.AnimTbl_Idle or ACT_VM_IDLE_1)
		local animTime = self:PlayWeaponAnimation(anim,self.IdleSpeed or 1,nil,true)
		self.PLY_NextIdleAnimT = CurTime() +animTime
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
if CLIENT then
	function SWEP:DrawWorldModel()
		if !IsValid(self) then return end
		self:DrawShadow(false)
	end
end