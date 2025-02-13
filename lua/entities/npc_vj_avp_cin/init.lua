AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2012-2025 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/avp/predators/base.mdl"}
ENT.SightDistance = 1
ENT.SightAngle = 1
ENT.StartHealth = 999999999
ENT.MovementType = VJ_MOVETYPE_STATIONARY
ENT.CanTurnWhileStationary = false

ENT.HasMeleeAttack = false
ENT.CanAlly = false
ENT.DisableMakingSelfEnemyToNPCs = true
ENT.DisableFindEnemy = true
ENT.DisableWandering = true
ENT.DisableChasingEnemy = true
ENT.DamageResponse = "OnlyMove"
ENT.DisableTouchFindEnemy = true
ENT.GodMode = true
ENT.Bleeds = false
ENT.Behavior = VJ_BEHAVIOR_PASSIVE_NATURE

ENT.GeneralSoundPitch1 = 100
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Init()
	self:AddFlags(FL_NOTARGET)

	if IsValid(self:GetOwner()) then
		local owner = self:GetOwner()
		local fake = ents.Create("prop_vj_animatable")
		fake:SetModel(owner:GetModel())
		fake:SetPos(self:GetPos())
		fake:SetAngles(self:GetAngles())
		fake:SetParent(self)
		fake:Spawn()
		fake:Activate()
		fake:AddEffects(bit.bor(EF_BONEMERGE,EF_BONEMERGE_FASTCULL,EF_PARENT_ANIMATES))
		fake:SetSkin(owner:GetSkin())
		for i = 0, fake:GetNumBodyGroups() do
			fake:SetBodygroup(i,owner:GetBodygroup(i))
		end
		self:DeleteOnRemove(fake)
		self:SetNoDraw(true)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnInput(key, activator, caller, data)
	if IsValid(self:GetOwner()) then
		self:GetOwner():OnInput(key, activator, caller, data)
	end
end