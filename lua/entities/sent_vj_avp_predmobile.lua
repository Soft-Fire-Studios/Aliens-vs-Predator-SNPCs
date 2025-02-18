AddCSLuaFile()

ENT.Base 			= "base_gmodentity"
ENT.Type 			= "anim"
ENT.PrintName 		= ""
ENT.Author 			= "Cpt. Hazama"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Category		= ""

ENT.Spawnable = false
ENT.AdminOnly = false
ENT.AutomaticFrameAdvance = true
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetupDataTables()
	self:NetworkVar("Bool",0,"Cloaked")
end
---------------------------------------------------------------------------------------------------------------------------------------------
if CLIENT then
	function ENT:Draw()
		self:DrawModel()
	end
	
	function ENT:DrawTranslucent()
		self:Draw()
	end
	return
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Initialize()
	self:SetModel("models/cpthazama/avp/misc/predmobile.mdl")
	self:SetSolid(SOLID_NONE)
	self:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
	-- self:AddFlags(FL_OBJECT)

	local bullseye = ents.Create("obj_vj_bullseye")
	bullseye:SetPos(self:GetPos())
	bullseye:SetAngles(self:GetAngles())
	bullseye:SetParent(self)
	bullseye.VJ_NPC_Class = {"CLASS_PREDATOR","CLASS_YAUTJA"}
	bullseye:Spawn()
	bullseye:Activate()
	bullseye:Fire("SetParentAttachment", "engine")
	bullseye:SetNoDraw(true)
	bullseye:DrawShadow(false)
	self:DeleteOnRemove(bullseye)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Think()
	self:NextThink(CurTime())

	if IsValid(self:GetOwner()) && !self.Init then
		self:GetOwner():SetRelationshipMemory(self, VJ.MEM_OVERRIDE_DISPOSITION, D_LI)
		self.Init = true
	end
	return true
end