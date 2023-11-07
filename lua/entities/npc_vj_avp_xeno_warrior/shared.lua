ENT.Base 			= "npc_vj_creature_base"
ENT.Type 			= "ai"
ENT.PrintName 		= ""
ENT.Author 			= "Cpt. Hazama"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Purpose 		= "Spawn it and fight with it!"
ENT.Instructions 	= "Click on the spawnicon to spawn it."
ENT.Category		= ""

ENT.VJ_AVP_Xenomorph = true

function ENT:SetupDataTables()
	self:NetworkVar("Entity",0,"EnemyCS")
end

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

	local vec0 = Vector(0,0,0)
	local vec1 = Vector(1,1,1)
	function ENT:CustomOnCalcView(ply, origin, angles, fov, camera, cameraMode)
		if cameraMode == 2 then
			if ply.VJC_FP_Bone != -1 then
				for _,v in pairs(self:GetChildBones(ply.VJC_FP_Bone)) do
					self:ManipulateBoneScale(v,vec0)
				end
			end
		else
			if ply.VJC_FP_Bone != -1 then
				for _,v in pairs(self:GetChildBones(ply.VJC_FP_Bone)) do
					self:ManipulateBoneScale(v,vec1)
				end
			end
		end
		return false
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

	net.Receive("VJ_AVP_Xeno_Client",function(len,pl)
		local delete = net.ReadBool()
		local ent = net.ReadEntity()

		hook.Add("Think","VJ_AVP_Xeno_VisionLight",function()
			if IsValid(ent) then
				local light = DynamicLight(ent:EntIndex())
				if (light) then
					light.Pos = ent:GetPos()
					light.r = 0
					light.g = 10
					light.b = 1
					light.Brightness = 0
					light.Size = 2000
					light.Decay = 0
					light.DieTime = CurTime() +0.2
					light.Style = 0
				end
			end
		end)
		if delete == true then hook.Remove("Think","VJ_AVP_Xeno_VisionLight") end

		hook.Add("RenderScreenspaceEffects","VJ_AVP_Xeno_Vision",function()
			local tab_xeno = {
				["$pp_colour_addr"] 		= -0.4,
				["$pp_colour_addg"] 		= -0.37,
				["$pp_colour_addb"] 		= -0,
				["$pp_colour_brightness"] 	= 0.34,
				["$pp_colour_contrast"] 	= 0.2,
				["$pp_colour_colour"] 		= 0.3,
				["$pp_colour_mulr"] 		= 0,
				["$pp_colour_mulg"] 		= 0,
				["$pp_colour_mulb"] 		= 0,
			}
			DrawColorModify(tab_xeno) 
			DrawBloom(0,1,1,1,8,3,5,5,2.5)
		end)
		if delete == true then hook.Remove("RenderScreenspaceEffects","VJ_AVP_Xeno_Vision") end

		hook.Add("PreDrawHalos","VJ_AVP_Xeno_Halo",function()
			local tbFriends = {}
			local tbEnemies = {}
			for _,v in pairs(ents.GetAll()) do
				if v:IsNPC() or v:IsPlayer() or v:IsNextBot() then
					if v.VJ_AVP_Xenomorph then
						table.insert(tbFriends,v)
					else
						if v:GetClass() != "obj_vj_bullseye" then
							table.insert(tbEnemies,v)
						end
					end
				end
			end
			halo.Add(tbFriends,Color(0,172,6),4,4,3,true,true)
			halo.Add(tbEnemies,Color(234,135,54),4,4,3,true,true)
		end)
		if delete == true then hook.Remove("PreDrawHalos","VJ_AVP_Xeno_Halo") end
	end)
end