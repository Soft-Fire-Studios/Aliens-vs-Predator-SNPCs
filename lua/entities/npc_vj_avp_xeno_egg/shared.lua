ENT.Base 			= "npc_vj_creature_base"
ENT.Type 			= "ai"
ENT.PrintName 		= ""
ENT.Author 			= "Cpt. Hazama"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Category		= ""

ENT.VJ_AVP_NPC = true
ENT.VJ_AVP_Xenomorph = true
ENT.VJ_AVP_XenomorphEgg = true

if CLIENT then
	local string_EndsWith = string.EndsWith
	local string_Replace = string.Replace
	local file_Exists = file.Exists

	ENT.XenoMaterials = {
		["models/cpthazama/avp/xeno/egg/ab_egg"] = "models/cpthazama/avp/xeno/egg/ab_egg_xv",
		["models/cpthazama/avp/xeno/egg/ab_egg_innards"] = "models/cpthazama/avp/xeno/egg/ab_egg_innards_xv",
		["models/cpthazama/avp/xeno/egg/ld_egg_damage"] = "models/cpthazama/avp/xeno/egg/ld_egg_damage_xv",
	}

	function ENT:Initialize()
	-- 	-- for i,v in pairs(self:GetMaterials()) do
	-- 	-- 	print(v)
	-- 	-- end
		self.HasResetMaterials = true
	end

	function ENT:Draw()
		self:DrawModel()
		local ply = LocalPlayer()
		if ply.VJ_IsControllingNPC && ply.VJCE_NPC.VJ_AVP_Predator && ply.VJCE_NPC.PreviousVisionMode == 2 then
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