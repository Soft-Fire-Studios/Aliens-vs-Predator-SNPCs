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
ENT.VJ_AVP_XenoHUD = 0

function ENT:SetupDataTables()
	self:NetworkVar("Bool",0,"Sprinting")
	self:NetworkVar("Vector",0,"JumpPosition")
end

if CLIENT then
    -- matproxy.Add({
    --     name = "AVP_XenoVision",
    --     init = function(self,mat,values)
    --         self.Result = values.resultvar
	-- 		print("INIT")
	-- 		-- self.LightwarpTexture = mat:GetString("$lightwarptexture") or ""
    --     end,
    --     bind = function(self,mat,ent)
    --         if (!IsValid(ent)) then return end

	-- 		ent.Mat_XVFactor = ent.Mat_XVFactor or 0
	-- 		ent.Mat_XVLightwarp = ent.Mat_XVLightwarp or ""
	-- 		local curValue = ent.Mat_XVFactor
	-- 		local finalResult = curValue or 0
	-- 		local lightwarp = "models/cpthazama/avp/xeno_gradient"
	-- 		local ply = LocalPlayer()
	-- 		-- if ply.VJTag_IsControllingNPC && ply.VJCE_NPC.VJ_AVP_Predator && ply.VJCE_NPC.PreviousVisionMode == 2 then
	-- 		if ply:Health() == 99 then
	-- 			finalResult = 1
	-- 			-- lightwarp = "models/cpthazama/avp/xeno_gradient"
	-- 		else
	-- 			finalResult = 0
	-- 			-- lightwarp = ""
	-- 		end
	-- 		print(finalResult,lightwarp)
	-- 		ent.Mat_XVFactor = finalResult
	-- 		ent.Mat_XVLightwarp = lightwarp
	-- 		mat:SetFloat(self.Result,ent.Mat_XVFactor)
	-- 		mat:SetString("$lightwarptexture",ent.Mat_XVLightwarp)
	-- 		PrintTable(mat:GetKeyValues())
	-- 		print("Enabled",mat:GetFloat(self.Result))
	-- 		print("Lightwarp",mat:GetString("$lightwarptexture"))
    --     end
    -- })

	local string_EndsWith = string.EndsWith
	local string_Replace = string.Replace
	local file_Exists = file.Exists

	ENT.XenoMaterials = {
		["models/cpthazama/avp/xeno/warrior/alien_warrior_body"] = "models/cpthazama/avp/xeno/warrior/alien_warrior_body_xv",
		["models/cpthazama/avp/xeno/warrior/alien_warrior_head"] = "models/cpthazama/avp/xeno/warrior/alien_warrior_head_xv",
		["models/cpthazama/avp/xeno/warrior/alien_warrior_gib"] = "models/cpthazama/avp/xeno/warrior/alien_warrior_gib_xv",
		["models/cpthazama/avp/xeno/warrior/alien_warrior_chunk_bits"] = "models/cpthazama/avp/xeno/warrior/alien_warrior_chunk_bits_xv",
		["models/cpthazama/avp/xeno/warrior/dismemberedalien_innards"] = "models/cpthazama/avp/xeno/warrior/dismemberedalien_innards_xv",

		["models/cpthazama/avp/xeno/praetorian/praetorian_body"] = "models/cpthazama/avp/xeno/praetorian/praetorian_body_xv",
		["models/cpthazama/avp/xeno/praetorian/praetorian_head"] = "models/cpthazama/avp/xeno/praetorian/praetorian_head_xv",
		["models/cpthazama/avp/xeno/praetorian/praetorian_chunk_bits"] = "models/cpthazama/avp/xeno/praetorian/praetorian_chunk_bits_xv",

		["models/cpthazama/avp/xeno/predalien/predalien_hybrid_head"] = "models/cpthazama/avp/xeno/predalien/predalien_hybrid_head_xv",
		["models/cpthazama/avp/xeno/predalien/predalien_hybrid_body"] = "models/cpthazama/avp/xeno/predalien/predalien_hybrid_body_xv",
		["models/cpthazama/avp/xeno/predalien/dreads"] = "models/cpthazama/avp/xeno/predalien/dreads_xv",

		["models/cpthazama/avp/xeno/queen/alien_queen_body"] = "models/cpthazama/avp/xeno/queen/alien_queen_body_xv",
		["models/cpthazama/avp/xeno/queen/alien_queen_head"] = "models/cpthazama/avp/xeno/queen/alien_queen_head_xv",

		["models/cpthazama/avp/xeno/runner/jungle_alien_body"] = "models/cpthazama/avp/xeno/runner/jungle_alien_body_xv",
		["models/cpthazama/avp/xeno/runner/jungle_alien_head"] = "models/cpthazama/avp/xeno/runner/jungle_alien_head_xv",
		["models/cpthazama/avp/xeno/runner/jungle_alien_dome"] = "models/cpthazama/avp/xeno/runner/jungle_alien_dome_xv",
		["models/cpthazama/avp/xeno/runner/jungle_alien_chunk_bits"] = "models/cpthazama/avp/xeno/runner/jungle_alien_chunk_bits_xv",
		["models/cpthazama/avp/xeno/runner/jungle_alien_chunk"] = "models/cpthazama/avp/xeno/runner/jungle_alien_chunk_xv",
		["models/cpthazama/avp/xeno/runner/dismemberedalien_innards"] = "models/cpthazama/avp/xeno/runner/dismemberedalien_innards_xv",

		["models/cpthazama/avp/xeno/warrior/rigid_alien_head"] = "models/cpthazama/avp/xeno/warrior/rigid_alien_head_xv",
		["models/cpthazama/avp/xeno/drone/alien_warrior_dome"] = "models/cpthazama/avp/xeno/drone/alien_warrior_dome_xv",
		["models/cpthazama/avp/xeno/warrior/grid_alien_head"] = "models/cpthazama/avp/xeno/warrior/grid_alien_head_xv",
		["models/cpthazama/avp/xeno/warrior/grid_alien_head_dismemberment"] = "models/cpthazama/avp/xeno/warrior/grid_alien_head_dismemberment_xv",

		["models/cpthazama/avp/xeno/hag/hag_body"] = "models/cpthazama/avp/xeno/hag/hag_body_xv",
		["models/cpthazama/avp/xeno/hag/hag_crown"] = "models/cpthazama/avp/xeno/hag/hag_crown_xv",
		["models/cpthazama/avp/xeno/hag/hag_face"] = "models/cpthazama/avp/xeno/hag/hag_face_xv",
		["models/cpthazama/avp/xeno/hag/hag_limb"] = "models/cpthazama/avp/xeno/hag/hag_limb_xv",

		// K-Series
		["models/cpthazama/avp/xeno/warrior/alien_warrior_body_k"] = "models/cpthazama/avp/xeno/warrior/alien_warrior_body_xv",
		["models/cpthazama/avp/xeno/warrior/alien_warrior_head_k"] = "models/cpthazama/avp/xeno/warrior/alien_warrior_head_xv",
		["models/cpthazama/avp/xeno/warrior/alien_warrior_chunk_bits_k"] = "models/cpthazama/avp/xeno/warrior/alien_warrior_chunk_bits_xv",

		["models/cpthazama/avp/xeno/praetorian/praetorian_body_k"] = "models/cpthazama/avp/xeno/praetorian/praetorian_body_xv",
		["models/cpthazama/avp/xeno/praetorian/praetorian_head_k"] = "models/cpthazama/avp/xeno/praetorian/praetorian_head_xv",
		["models/cpthazama/avp/xeno/praetorian/praetorian_chunk_bits_k"] = "models/cpthazama/avp/xeno/praetorian/praetorian_chunk_bits_xv",

		["models/cpthazama/avp/xeno/predalien/predalien_hybrid_head_k"] = "models/cpthazama/avp/xeno/predalien/predalien_hybrid_head_xv",
		["models/cpthazama/avp/xeno/predalien/predalien_hybrid_body_k"] = "models/cpthazama/avp/xeno/predalien/predalien_hybrid_body_xv",
		["models/cpthazama/avp/xeno/predalien/dreads_k"] = "models/cpthazama/avp/xeno/predalien/dreads_xv",

		["models/cpthazama/avp/xeno/queen/alien_queen_body_k"] = "models/cpthazama/avp/xeno/queen/alien_queen_body_xv",
		["models/cpthazama/avp/xeno/queen/alien_queen_head_k"] = "models/cpthazama/avp/xeno/queen/alien_queen_head_xv",

		["models/cpthazama/avp/xeno/runner/jungle_alien_body_k"] = "models/cpthazama/avp/xeno/runner/jungle_alien_body_xv",
		["models/cpthazama/avp/xeno/runner/jungle_alien_head_k"] = "models/cpthazama/avp/xeno/runner/jungle_alien_head_xv",
		["models/cpthazama/avp/xeno/runner/jungle_alien_dome_k"] = "models/cpthazama/avp/xeno/runner/jungle_alien_dome_xv",
		["models/cpthazama/avp/xeno/runner/jungle_alien_chunk_bits_k"] = "models/cpthazama/avp/xeno/runner/jungle_alien_chunk_bits_xv",

		["models/cpthazama/avp/xeno/warrior/rigid_alien_head_k"] = "models/cpthazama/avp/xeno/warrior/rigid_alien_head_xv",
		["models/cpthazama/avp/xeno/drone/alien_warrior_dome_k"] = "models/cpthazama/avp/xeno/drone/alien_warrior_dome_xv",
	}

	function ENT:Initialize()
		-- for i,v in pairs(self:GetMaterials()) do
		-- 	print(v)
		-- end
		self.HasResetMaterials = true
	end

	local vec0 = Vector(0, 0, 0)
	local vec1 = Vector(1, 1, 1)
	function ENT:CustomOnCalcView(ply, origin, angles, myFOV, camera, cameraMode)
		local pos = origin -- The position that will be set
		local ang = ply:EyeAngles()
		local newFOV = myFOV
		self.VJC_FP_Bone = ply.VJC_FP_Bone
		if cameraMode == 2 then -- First person
			local setPos = self:EyePos() + self:GetForward()*20
			local offset = ply.VJC_FP_Offset
			//camera:SetLocalPos(camera:GetLocalPos() + ply.VJC_TP_Offset) -- Help keep the camera stable
			if ply.VJC_FP_Bone != -1 then -- If the bone does exist, then use the bone position
				local bonePos, boneAng = self:GetBonePosition(ply.VJC_FP_Bone)
				setPos = bonePos
				if ply.VJC_FP_CameraBoneAng > 0 then
					ang[3] = boneAng[ply.VJC_FP_CameraBoneAng] + ply.VJC_FP_CameraBoneAng_Offset
				end
				if ply.VJC_FP_ShrinkBone then
					self:ManipulateBoneScale(ply.VJC_FP_Bone, vec0) -- Bone manipulate to make it easier to see
					for _,v in pairs(self:GetChildBones(ply.VJC_FP_Bone)) do
						self:ManipulateBoneScale(v, vec0)
					end
				end
			end
			pos = setPos + (self:GetForward()*offset.x + self:GetRight()*offset.y + self:GetUp()*offset.z)
			newFOV = 130
		else -- Third person
			if ply.VJC_FP_Bone != -1 then -- Reset the NPC's bone manipulation!
				self:ManipulateBoneScale(ply.VJC_FP_Bone, vec1)
				for _,v in pairs(self:GetChildBones(ply.VJC_FP_Bone)) do
					self:ManipulateBoneScale(v, vec1)
				end
			end
			local offset = ply.VJC_TP_Offset + Vector(0, 0, self:OBBMaxs().z - self:OBBMins().z) // + vectp
			//camera:SetLocalPos(camera:GetLocalPos() + ply.VJC_TP_Offset) -- Help keep the camera stable
			local tr = util.TraceHull({
				start = self:GetPos() + self:OBBCenter(),
				endpos = self:GetPos() + self:OBBCenter() + angles:Forward()*-camera.Zoom + (self:GetForward()*offset.x + self:GetRight()*offset.y + self:GetUp()*offset.z),
				filter = {ply, camera, self},
				mins = Vector(-5, -5, -5),
				maxs = Vector(5, 5, 5),
				mask = MASK_SHOT,
			})
			pos = tr.HitPos + tr.HitNormal*2
			newFOV = 75
		end
		if self:GetSprinting() then
			newFOV = newFOV +10
		end
		newFOV = Lerp(FrameTime() *5,self.LastFOV or myFOV,newFOV)
		if ply:GetFOV() != GetConVarNumber("fov_desired") then
			newFOV = nil
		end
		self.LastFOV = newFOV
		return {origin = pos, angles = ang, fov = newFOV}
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

	local halo_Add = halo.Add
	local col_xeno = Color(203,120,120)
	local col_kxeno = Color(202,203,120)
	local col_tech = Color(81,44,118)
	local col_pred = Color(0,255,8)
	local col_enemy = Color(0,170,255)
	local table_Count = table.Count
	local table_insert = table.insert
	local VJ_HasValue = VJ.HasValue
	local matHud = Material("hud/cpthazama/avp/alien_hud.png")
	local matSixHud = Material("hud/cpthazama/avp/alien_six_hud.png")
	local matGridHud = Material("hud/cpthazama/avp/alien_grid_hud.png")
	local render_GetLightColor = render.GetLightColor
	local tab_xeno = {
		["$pp_colour_addr"] 		= 0,
		["$pp_colour_addg"] 		= 0.25,
		["$pp_colour_addb"] 		= 1,
		["$pp_colour_brightness"] 	= 0.3,
		["$pp_colour_contrast"] 	= 0.15,
		["$pp_colour_colour"] 		= 0.3,
		["$pp_colour_mulr"] 		= 0,
		["$pp_colour_mulg"] 		= 0.5,
		["$pp_colour_mulb"] 		= 1,
	}
	net.Receive("VJ_AVP_Xeno_Client",function(len,pl)
		local delete = net.ReadBool()
		local ent = net.ReadEntity()

		hook.Add("HUDPaint","VJ_AVP_Xenomorph_HUD",function()
			if !IsValid(ent) then return end
			local xenoHUD = ent.VJ_AVP_XenoHUD
		
			surface.SetDrawColor(color_white)
			surface.SetMaterial(xenoHUD == 1 && matSixHud or xenoHUD == 2 && matGridHud or matHud)
			surface.DrawTexturedRect(0,0,ScrW(),ScrH())
		end)
		if delete == true then hook.Remove("HUDPaint","VJ_AVP_Xenomorph_HUD") end

		hook.Add("Think","VJ_AVP_Xeno_VisionLight",function()
			if IsValid(ent) then
				if render_GetLightColor(ent:GetPos() +ent:OBBCenter()):Length() <= 0.1 then
					local light = DynamicLight(ent:EntIndex())
					if (light) then
						light.Pos = ent:GetPos()
						light.r = 1
						light.g = 1
						light.b = 1
						light.Brightness = 6
						light.Size = 2000
						light.Decay = 0
						light.DieTime = CurTime() +0.3
						light.Style = 0
					end
				end
			end
		end)
		if delete == true then hook.Remove("Think","VJ_AVP_Xeno_VisionLight") end

		hook.Add("RenderScreenspaceEffects","VJ_AVP_Xeno_Vision",function()
			if !IsValid(ent) then return end
			tab_xeno["$pp_colour_brightness"] = Lerp(FrameTime() *2,tab_xeno["$pp_colour_brightness"],render_GetLightColor(ent:GetPos() +ent:OBBCenter()):Length() <= 0.1 && 0.6 or 0.3)
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
					if (v.VJ_AVP_Xenomorph or v:GetNW2Bool("AVP.Xenomorph",false)) && !v.VJ_AVP_K_Xenomorph && !VJ_HasValue(VJ_AVP_HALOS.Xenomorphs,v) && v != ent then
						table_insert(VJ_AVP_HALOS.Xenomorphs,v)
						-- print("Added",v,"Xeno")
						continue
					elseif (v.VJ_AVP_Xenomorph or v:GetNW2Bool("AVP.Xenomorph",false)) && v.VJ_AVP_K_Xenomorph && !VJ_HasValue(VJ_AVP_HALOS.KXenomorphs,v) && v != ent then
						table_insert(VJ_AVP_HALOS.KXenomorphs,v)
						-- print("Added",v,"KXeno")
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
			halo_Add(VJ_AVP_HALOS.KXenomorphs,col_kxeno,4,4,15,true,true)
			halo_Add(VJ_AVP_HALOS.Predators,col_pred,4,4,15,true,true)
			halo_Add(VJ_AVP_HALOS.Tech,col_tech,4,4,15,true,true)
			halo_Add(VJ_AVP_HALOS.Other,col_enemy,4,4,15,true,true)
		end)
		if delete == true then
			hook.Remove("PreDrawHalos","VJ_AVP_Xeno_Halo")
			-- if GetConVar("mat_fullbright"):GetInt() != 0 then
			-- 	RunConsoleCommand("mat_fullbright","0")
			-- end
		else
		-- 	if GetConVar("mat_fullbright"):GetInt() != 1 then
		-- 		RunConsoleCommand("mat_fullbright","1")
		-- 	end
		end
	end)
end