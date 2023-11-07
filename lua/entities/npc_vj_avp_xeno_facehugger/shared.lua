ENT.Base 			= "npc_vj_creature_base"
ENT.Type 			= "ai"
ENT.PrintName 		= ""
ENT.Author 			= "Cpt. Hazama"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Purpose 		= "Spawn it and fight with it!"
ENT.Instructions 	= "Click on the spawnicon to spawn it."
ENT.Category		= ""

ENT.VJ_AVP_Xenomorph = true

if CLIENT then
	local string_EndsWith = string.EndsWith
	local string_Replace = string.Replace
	local file_Exists = file.Exists
	function ENT:Initialize()
		self.SubMaterials = {}
		self.SubMaterials.Normal = {}
		self.SubMaterials.XenoVision = {}
		for i = 0, #self:GetMaterials() - 1 do
			local mat = self:GetSubMaterial(i)
			if string_EndsWith(mat,"_xv") then
				self.SubMaterials.XenoVision[i] = mat
			else
				self.SubMaterials.Normal[i] = mat
			end
		end
	end

	function ENT:CustomOnDraw()
		local ply = LocalPlayer()
		if ply.VJTag_IsControllingNPC && ply.VJCE_NPC.VJ_AVP_Predator && ply.VJCE_NPC.PreviousVisionMode == 2 then
			for i = 0, #self:GetMaterials() - 1 do
				local mat = self:GetSubMaterial(i)
				if !string_EndsWith(mat,"_xv") && self.SubMaterials.XenoVision[i] then
					self:SetSubMaterial(i,mat .. "_xv")
				end
			end
		else
			for i = 0, #self:GetMaterials() - 1 do
				-- local mat = self:GetSubMaterial(i)
				-- if string_EndsWith(mat,"_xv") then
					self:SetSubMaterial(i,"")
				-- end
			end
		end
	end
end