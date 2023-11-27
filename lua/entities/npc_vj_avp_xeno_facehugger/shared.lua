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

	ENT.XenoMaterials = {
		["models/cpthazama/avp/xeno/facehugger/facehugger"] = "models/cpthazama/avp/xeno/facehugger/facehugger_xv",
		["models/cpthazama/avp/xeno/facehugger/facehugger_royal"] = "models/cpthazama/avp/xeno/facehugger/facehugger_royal_xv",

	}

	function ENT:Initialize()
		self.HasResetMaterials = true
	end

	function ENT:Draw()
		self:DrawModel()
		local ply = LocalPlayer()
		if ply.VJTag_IsControllingNPC && ply.VJCE_NPC.VJ_AVP_Predator && ply.VJCE_NPC.PreviousVisionMode == 2 then
		-- if ply:Health() == 100 then
			self.HasResetMaterials = false
			for i,v in pairs(self:GetMaterials()) do
				if self.XenoMaterials[v] then
					local xvMat = self.XenoMaterials[v]
					local mat = self:GetSubMaterial(i)
					if (mat == "" or mat != xvMat) then
						self:SetSubMaterial(i -1,xvMat)
					end
				end
			end
		else
			if !self.HasResetMaterials then
				self.HasResetMaterials = true
				self:SetSubMaterial()
			end
		end
	end
end