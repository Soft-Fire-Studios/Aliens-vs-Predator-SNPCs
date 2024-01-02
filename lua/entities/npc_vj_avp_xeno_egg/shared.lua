ENT.Base 			= "npc_vj_creature_base"
ENT.Type 			= "ai"
ENT.PrintName 		= ""
ENT.Author 			= "Cpt. Hazama"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Purpose 		= "Spawn it and fight with it!"
ENT.Instructions 	= "Click on the spawnicon to spawn it."
ENT.Category		= ""

ENT.VJ_AVP_NPC = true
ENT.VJ_AVP_Xenomorph = true

if CLIENT then
	local string_EndsWith = string.EndsWith
	local string_Replace = string.Replace
	local file_Exists = file.Exists

	-- ENT.XenoMaterials = {
	-- 	["models/cpthazama/avp/xeno/warrior/alien_warrior_body"] = "models/cpthazama/avp/xeno/warrior/alien_warrior_body_xv",
	-- 	["models/cpthazama/avp/xeno/warrior/alien_warrior_head"] = "models/cpthazama/avp/xeno/warrior/alien_warrior_head_xv",
	-- 	["models/cpthazama/avp/xeno/warrior/alien_warrior_gib"] = "models/cpthazama/avp/xeno/warrior/alien_warrior_gib_xv",
	-- 	["models/cpthazama/avp/xeno/warrior/alien_warrior_chunk_bits"] = "models/cpthazama/avp/xeno/warrior/alien_warrior_chunk_bits_xv",
	-- 	["models/cpthazama/avp/xeno/warrior/dismemberedalien_innards"] = "models/cpthazama/avp/xeno/warrior/dismemberedalien_innards_xv",

	-- 	["models/cpthazama/avp/xeno/praetorian/praetorian_body"] = "models/cpthazama/avp/xeno/praetorian/praetorian_body_xv",
	-- 	["models/cpthazama/avp/xeno/praetorian/praetorian_head"] = "models/cpthazama/avp/xeno/praetorian/praetorian_head_xv",
	-- 	["models/cpthazama/avp/xeno/praetorian/praetorian_chunk_bits"] = "models/cpthazama/avp/xeno/praetorian/praetorian_chunk_bits_xv",

	-- 	["models/cpthazama/avp/xeno/predalien/predalien_hybrid_head"] = "models/cpthazama/avp/xeno/predalien/predalien_hybrid_head_xv",
	-- 	["models/cpthazama/avp/xeno/predalien/predalien_hybrid_body"] = "models/cpthazama/avp/xeno/predalien/predalien_hybrid_body_xv",
	-- 	["models/cpthazama/avp/xeno/predalien/dreads"] = "models/cpthazama/avp/xeno/predalien/dreads_xv",

	-- 	["models/cpthazama/avp/xeno/queen/alien_queen_body"] = "models/cpthazama/avp/xeno/queen/alien_queen_body_xv",
	-- 	["models/cpthazama/avp/xeno/queen/alien_queen_head"] = "models/cpthazama/avp/xeno/queen/alien_queen_head_xv",

	-- 	["models/cpthazama/avp/xeno/runner/jungle_alien_body"] = "models/cpthazama/avp/xeno/runner/jungle_alien_body_xv",
	-- 	["models/cpthazama/avp/xeno/runner/jungle_alien_head"] = "models/cpthazama/avp/xeno/runner/jungle_alien_head_xv",
	-- 	["models/cpthazama/avp/xeno/runner/jungle_alien_dome"] = "models/cpthazama/avp/xeno/runner/jungle_alien_dome_xv",
	-- 	["models/cpthazama/avp/xeno/runner/jungle_alien_chunk_bits"] = "models/cpthazama/avp/xeno/runner/jungle_alien_chunk_bits_xv",
	-- 	["models/cpthazama/avp/xeno/runner/jungle_alien_chunk"] = "models/cpthazama/avp/xeno/runner/jungle_alien_chunk_xv",
	-- 	["models/cpthazama/avp/xeno/runner/dismemberedalien_innards"] = "models/cpthazama/avp/xeno/runner/dismemberedalien_innards_xv",

	-- 	["models/cpthazama/avp/xeno/warrior/rigid_alien_head"] = "models/cpthazama/avp/xeno/warrior/rigid_alien_head_xv",
	-- 	["models/cpthazama/avp/xeno/drone/alien_warrior_dome"] = "models/cpthazama/avp/xeno/drone/alien_warrior_dome_xv",
	-- 	["models/cpthazama/avp/xeno/warrior/grid_alien_head"] = "models/cpthazama/avp/xeno/warrior/grid_alien_head_xv",
	-- 	["models/cpthazama/avp/xeno/warrior/grid_alien_head_dismemberment"] = "models/cpthazama/avp/xeno/warrior/grid_alien_head_dismemberment_xv",

	-- 	["models/cpthazama/avp/xeno/hag/hag_body"] = "models/cpthazama/avp/xeno/hag/hag_body_xv",
	-- 	["models/cpthazama/avp/xeno/hag/hag_crown"] = "models/cpthazama/avp/xeno/hag/hag_crown_xv",
	-- 	["models/cpthazama/avp/xeno/hag/hag_face"] = "models/cpthazama/avp/xeno/hag/hag_face_xv",
	-- 	["models/cpthazama/avp/xeno/hag/hag_limb"] = "models/cpthazama/avp/xeno/hag/hag_limb_xv",

	-- 	// K-Series
	-- 	["models/cpthazama/avp/xeno/warrior/alien_warrior_body_k"] = "models/cpthazama/avp/xeno/warrior/alien_warrior_body_xv",
	-- 	["models/cpthazama/avp/xeno/warrior/alien_warrior_head_k"] = "models/cpthazama/avp/xeno/warrior/alien_warrior_head_xv",
	-- 	["models/cpthazama/avp/xeno/warrior/alien_warrior_chunk_bits_k"] = "models/cpthazama/avp/xeno/warrior/alien_warrior_chunk_bits_xv",

	-- 	["models/cpthazama/avp/xeno/praetorian/praetorian_body_k"] = "models/cpthazama/avp/xeno/praetorian/praetorian_body_xv",
	-- 	["models/cpthazama/avp/xeno/praetorian/praetorian_head_k"] = "models/cpthazama/avp/xeno/praetorian/praetorian_head_xv",
	-- 	["models/cpthazama/avp/xeno/praetorian/praetorian_chunk_bits_k"] = "models/cpthazama/avp/xeno/praetorian/praetorian_chunk_bits_xv",

	-- 	["models/cpthazama/avp/xeno/predalien/predalien_hybrid_head_k"] = "models/cpthazama/avp/xeno/predalien/predalien_hybrid_head_xv",
	-- 	["models/cpthazama/avp/xeno/predalien/predalien_hybrid_body_k"] = "models/cpthazama/avp/xeno/predalien/predalien_hybrid_body_xv",
	-- 	["models/cpthazama/avp/xeno/predalien/dreads_k"] = "models/cpthazama/avp/xeno/predalien/dreads_xv",

	-- 	["models/cpthazama/avp/xeno/queen/alien_queen_body_k"] = "models/cpthazama/avp/xeno/queen/alien_queen_body_xv",
	-- 	["models/cpthazama/avp/xeno/queen/alien_queen_head_k"] = "models/cpthazama/avp/xeno/queen/alien_queen_head_xv",

	-- 	["models/cpthazama/avp/xeno/runner/jungle_alien_body_k"] = "models/cpthazama/avp/xeno/runner/jungle_alien_body_xv",
	-- 	["models/cpthazama/avp/xeno/runner/jungle_alien_head_k"] = "models/cpthazama/avp/xeno/runner/jungle_alien_head_xv",
	-- 	["models/cpthazama/avp/xeno/runner/jungle_alien_dome_k"] = "models/cpthazama/avp/xeno/runner/jungle_alien_dome_xv",
	-- 	["models/cpthazama/avp/xeno/runner/jungle_alien_chunk_bits_k"] = "models/cpthazama/avp/xeno/runner/jungle_alien_chunk_bits_xv",

	-- 	["models/cpthazama/avp/xeno/warrior/rigid_alien_head_k"] = "models/cpthazama/avp/xeno/warrior/rigid_alien_head_xv",
	-- 	["models/cpthazama/avp/xeno/drone/alien_warrior_dome_k"] = "models/cpthazama/avp/xeno/drone/alien_warrior_dome_xv",
	-- }

	-- function ENT:Initialize()
	-- 	-- for i,v in pairs(self:GetMaterials()) do
	-- 	-- 	print(v)
	-- 	-- end
	-- 	self.HasResetMaterials = true
	-- end

	function ENT:Draw()
		self:DrawModel()
		local ply = LocalPlayer()
		-- if ply.VJTag_IsControllingNPC && ply.VJCE_NPC.VJ_AVP_Predator && ply.VJCE_NPC.PreviousVisionMode == 2 then
		-- -- if ply:Health() == 100 then
		-- 	self.HasResetMaterials = false
		-- 	for i,v in pairs(self:GetMaterials()) do
		-- 		if self.XenoMaterials[v] then
		-- 			local xvMat = self.XenoMaterials[v]
		-- 			local mat = self:GetSubMaterial(i)
		-- 			if (mat == "" or mat != xvMat) then
		-- 				self:SetSubMaterial(i -1,xvMat)
		-- 			end
		-- 		end
		-- 	end
		-- else
		-- 	if !self.HasResetMaterials then
		-- 		self.HasResetMaterials = true
		-- 		self:SetSubMaterial()
		-- 	end
		-- end
	end
end