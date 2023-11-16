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

function ENT:SetupDataTables()
	self:NetworkVar("Bool",0,"Sprinting")
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

	local halo_Add = halo.Add
	local col_xeno = Color(203,120,120)
	local col_tech = Color(81,44,118)
	local col_pred = Color(0,255,8)
	local col_enemy = Color(0,170,255)
	local table_Count = table.Count
	local table_insert = table.insert
	local VJ_HasValue = VJ.HasValue
	net.Receive("VJ_AVP_Xeno_Client",function(len,pl)
		local delete = net.ReadBool()
		local ent = net.ReadEntity()

		hook.Add("Think","VJ_AVP_Xeno_VisionLight",function()
			if IsValid(ent) then
				local light = DynamicLight(ent:EntIndex())
				if (light) then
					light.Pos = ent:GetPos()
					light.r = 3
					light.g = 3
					light.b = 3
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
			local tbl = select(2,ents.Iterator())
			for _,v in pairs(tbl) do
				if !IsValid(v) then continue end
				if v:IsNPC() or v:IsPlayer() or v:IsNextBot() then
					if v:GetClass() == "obj_vj_bullseye" then continue end
					if (v.VJ_AVP_Xenomorph or v:GetNW2Bool("AVP.Xenomorph",false)) && !VJ_HasValue(VJ_AVP_HALOS.Xenomorphs,v) then
						table_insert(VJ_AVP_HALOS.Xenomorphs,v)
						-- print("Added",v,"Xeno")
						continue
					elseif v.VJ_AVP_Predator && !VJ_HasValue(VJ_AVP_HALOS.Predators,v) then
						table_insert(VJ_AVP_HALOS.Predators,v)
						-- print("Added",v,"Predator")
						continue
					elseif (v:GetNW2Bool("AVP.IsTech",false) or v.VJ_AVP_IsTech) && !VJ_HasValue(VJ_AVP_HALOS.Tech,v) then
						table_insert(VJ_AVP_HALOS.Tech,v)
						-- print("Added",v,"Tech")
						continue
					elseif !(v.VJ_AVP_Xenomorph or v:GetNW2Bool("AVP.Xenomorph",false)) && !v.VJ_AVP_Predator && !(v:GetNW2Bool("AVP.IsTech",false) or v.VJ_AVP_IsTech) then
						if !VJ_HasValue(VJ_AVP_HALOS.Other,v) then
							table_insert(VJ_AVP_HALOS.Other,v)
							-- print("Added",v,"Other")
						end
					end
				end
			end
			halo_Add(VJ_AVP_HALOS.Xenomorphs,col_xeno,4,4,15,true,true)
			halo_Add(VJ_AVP_HALOS.Predators,col_pred,4,4,15,true,true)
			halo_Add(VJ_AVP_HALOS.Tech,col_tech,4,4,15,true,true)
			halo_Add(VJ_AVP_HALOS.Other,col_enemy,4,4,15,true,true)
		end)
		if delete == true then hook.Remove("PreDrawHalos","VJ_AVP_Xeno_Halo") end
	end)
end