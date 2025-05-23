AddCSLuaFile()

ENT.Base 			= "base_gmodentity"
ENT.Type 			= "anim"
ENT.PrintName 		= ""
ENT.Author 			= "Cpt. Hazama"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Category		= "Aliens vs Predator"
ENT.AutomaticFrameAdvance = true
ENT.Spawnable		= false
---------------------------------------------------------------------------------------------------------------------------------------------
if CLIENT then
	function ENT:Draw()
		-- self:DrawModel()
	end
	
	function ENT:DrawTranslucent()
		-- self:Draw()
	end
	return
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Initialize()
	self:SetModel("models/cpthazama/avp/marines/ani_valve_mesh.mdl")
	self:SetSolid(SOLID_NONE)
	self:SetMoveType(MOVETYPE_NONE)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:PlayAnim(animation)
	self:ResetSequence(animation)
	self:ResetSequenceInfo()
	self:SetPlaybackRate(1)
	self:SetCycle(0)

	return animation, VJ.AnimDuration(self, animation)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Think()
	local curTime = CurTime()

	self:NextThink(curTime)
	return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnRemove()
	self:StopParticles()
end