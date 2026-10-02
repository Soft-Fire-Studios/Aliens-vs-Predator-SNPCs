AddCSLuaFile()

ENT.Base = "base_gmodentity"
ENT.Type = "anim"
ENT.PrintName = ""
ENT.Author = "Cpt. Hazama"
ENT.Contact = "http://steamcommunity.com/groups/vrejgaming"
ENT.Category = "Aliens vs Predator"
ENT.AutomaticFrameAdvance = true
ENT.Spawnable = false
---------------------------------------------------------------------------------------------------------------------------------------------
if CLIENT then
	function ENT:Draw() end
	function ENT:DrawTranslucent() end
	return
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Initialize()
	self:SetModel("models/cpthazama/avp/marines/ani_valve_mesh.mdl")
	self:SetSolid(SOLID_NONE)
	self:SetMoveType(MOVETYPE_NONE)
	self._AVPAnimToken = 0
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:PlayAnim(animation, lockAnim, lockAnimTime, faceEnemy, animDelay, extraOptions)
	animation = VJ.PICK(animation)
	if !animation or !VJ.AnimExists(self, animation) then return ACT_INVALID, 0, VJ.ANIM_TYPE_NONE end

	extraOptions = extraOptions or {}
	animDelay = tonumber(animDelay) or 0
	self._AVPAnimToken = (self._AVPAnimToken or 0) + 1
	local token = self._AVPAnimToken

	local function Play()
		if !IsValid(self) or token != self._AVPAnimToken then return end
		self:ResetSequence(animation)
		self:ResetSequenceInfo()
		local rate = extraOptions.PlayBackRate or 1
		self:SetPlaybackRate(rate)
		self:SetCycle(0)

		local duration = self:SequenceDuration(self:LookupSequence(animation))
		if rate > 0 then duration = duration / rate end
		if duration <= 0 then duration = VJ.AnimDuration(self, animation) end

		if extraOptions.OnFinish then
			timer.Simple(duration, function()
				if IsValid(self) && token == self._AVPAnimToken then
					extraOptions.OnFinish(false, animation)
				end
			end)
		end
	end

	if animDelay > 0 then
		timer.Simple(animDelay, Play)
	else
		Play()
	end

	local duration = VJ.AnimDuration(self, animation)
	return animation, animDelay + duration, VJ.ANIM_TYPE_SEQUENCE
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Think()
	self:NextThink(CurTime())
	return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnRemove()
	self._AVPAnimToken = (self._AVPAnimToken or 0) + 1
	self:StopParticles()
end