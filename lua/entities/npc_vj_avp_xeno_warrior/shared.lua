ENT.Base 			= "npc_vj_creature_base"
ENT.Type 			= "ai"
ENT.PrintName 		= ""
ENT.Author 			= "Cpt. Hazama"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Purpose 		= "Spawn it and fight with it!"
ENT.Instructions 	= "Click on the spawnicon to spawn it."
ENT.Category		= ""

ENT.VJ_AVP_XenomorphID = "warrior"
ENT.VJ_AVP_NPC = true
ENT.VJ_AVP_Xenomorph = true
ENT.VJ_AVP_CanBecomeQueen = true
ENT.VJ_AVP_XenoHUD = 0

function ENT:SetupDataTables()
	self:NetworkVar("Bool",0,"Sprinting")
	self:NetworkVar("Bool",1,"Vision")
	self:NetworkVar("Bool",2,"JumpAbility")
	self:NetworkVar("Bool",3,"InFatality")
	self:NetworkVar("Bool",4,"Standing")
	self:NetworkVar("Vector",0,"JumpPosition")
	self:NetworkVar("Vector",1,"QueenMarker")
	self:NetworkVar("Int",0,"HP")
	self:NetworkVar("Entity",0,"VM")
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

	local matList = {
		Material("hud/cpthazama/avp/blood/red_1.png","smooth additive"),
		Material("hud/cpthazama/avp/blood/red_2.png","smooth additive"),
		Material("hud/cpthazama/avp/blood/red_3.png","smooth additive"),
		Material("hud/cpthazama/avp/blood/red_4.png","smooth additive"),
		Material("hud/cpthazama/avp/blood/white_1.png","smooth additive"),
		Material("hud/cpthazama/avp/blood/white_2.png","smooth additive"),
		Material("hud/cpthazama/avp/blood/white_3.png","smooth additive"),
		Material("hud/cpthazama/avp/blood/white_4.png","smooth additive"),
		Material("hud/cpthazama/avp/blood/green_1.png","smooth additive"),
		Material("hud/cpthazama/avp/blood/green_2.png","smooth additive"),
		Material("hud/cpthazama/avp/blood/green_3.png","smooth additive"),
		Material("hud/cpthazama/avp/blood/green_4.png","smooth additive")
	}
	net.Receive("VJ.AVP.XenoEat",function(len,pl)
		local ply = LocalPlayer()
		local corpse = net.ReadEntity()
		local bloodData = net.ReadTable()
		local col = bloodData.Color
		local mat = math.random(1,4)
		if col == "White" then
			mat = mat +4
		elseif col == "Green" then
			mat = mat +8
		end
	
		ply.VJ_AVP_NPCDamageSplatter = ply.VJ_AVP_NPCDamageSplatter or {}
		for i = 1,math.random(70,90) do
			local time = CurTime() +math.Rand(3,5)
			ply.VJ_AVP_NPCDamageSplatter[#ply.VJ_AVP_NPCDamageSplatter +1] = {Remain=time,Init=time,MatID=mat,MatTable=matList}
		end
	end)

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
		["models/cpthazama/avp/xeno/queen/rc_queen_egg_body"] = "models/cpthazama/avp/xeno/queen/rc_queen_egg_body_xv",

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

		["models/cpthazama/avp/xeno/carrier/praetorian_body"] = "models/cpthazama/avp/xeno/praetorian/praetorian_body_xv",
		["models/cpthazama/avp/xeno/carrier/praetorian_head"] = "models/cpthazama/avp/xeno/praetorian/praetorian_head_xv",
		["models/cpthazama/avp/xeno/carrier/alien_carrier_head"] = "models/cpthazama/avp/xeno/warrior/alien_warrior_head_xv",
		["models/cpthazama/avp/xeno/carrier/alien_carrier_dome"] = "models/cpthazama/avp/xeno/drone/alien_warrior_dome_xv",
		["models/cpthazama/avp/xeno/carrier/praetorian_chunk_bits"] = "models/cpthazama/avp/xeno/praetorian/praetorian_chunk_bits_xv",
		["models/cpthazama/avp/xeno/carrier/alien_carrier_gib"] = "models/cpthazama/avp/xeno/warrior/alien_carrier_gib_xv",

		["models/cpthazama/avp/xeno/ranger/head"] = "models/cpthazama/avp/xeno/ranger/head_xv",
		["models/cpthazama/avp/xeno/ranger/body"] = "models/cpthazama/avp/xeno/ranger/body_xv",

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

		["models/cpthazama/avp/xeno/carrier/alien_carrier_head_k"] = "models/cpthazama/avp/xeno/warrior/alien_warrior_head_xv",
		["models/cpthazama/avp/xeno/carrier/alien_carrier_dome_k"] = "models/cpthazama/avp/xeno/drone/alien_warrior_dome_xv",

		["models/cpthazama/avp/xeno/ranger/head_k"] = "models/cpthazama/avp/xeno/ranger/head_xv",
		["models/cpthazama/avp/xeno/ranger/body_k"] = "models/cpthazama/avp/xeno/ranger/body_xv",
	}

	function ENT:Initialize()
		-- for i,v in pairs(self:GetMaterials()) do
		-- 	print(v)
		-- end
		self.HasResetMaterials = true
		self.NextDarknessT = 0

		self.QueenMarkerPoints = {}
	end

	function ENT:OnRemove()
		if IsValid(self.QueenMarkerFX) then
			self.QueenMarkerFX:StopEmission(false,true)
			self.QueenMarkerFX = nil
		end
		for _,v in pairs(self.QueenMarkerPoints) do
			if IsValid(v) then
				v:StopEmission(false,true)
				v = nil
			end
		end
	end

	local vec0 = Vector(0, 0, 0)
	local vec1 = Vector(1, 1, 1)
	function ENT:Controller_CalcView(ply, origin, angles, myFOV, camera, cameraMode)
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
		self.VJ_AVP_ViewModelData = {origin = pos, angles = ang, fov = newFOV}
		return {origin = pos, angles = ang, fov = newFOV}
	end

	local render_GetLightColor = render.GetLightColor
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

		if VJ_AVP_CVAR_XENOSTEALTH then
			local light = render_GetLightColor(self:GetPos() +self:OBBCenter()):Length()
			if CurTime() > self.NextDarknessT && light <= 1 then
				net.Start("VJ_AVP_Xeno_Darkness")
					net.WriteEntity(self)
					net.WriteFloat(light,4)
				net.SendToServer()
				self.NextDarknessT = CurTime() +math.Rand(1,2)
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

	local matHud = Material("hud/cpthazama/avp/alien_hud.png","smooth additive")
	local matSixHud = Material("hud/cpthazama/avp/alien_six_hud.png","smooth additive")
	local matGridHud = Material("hud/cpthazama/avp/alien_grid_hud.png","smooth additive")
	local matHP = Material("hud/cpthazama/avp/avp_a_health_bar_new.png","smooth additive")
	local matHP_Base = Material("hud/cpthazama/avp/avp_a_health_bg_full.png","smooth additive")
	local matHP_B = Material("hud/cpthazama/avp/avp_a_health_bar_b.png","smooth additive")
	local matHP_Base_B = Material("hud/cpthazama/avp/avp_a_health_bg_b.png","smooth additive")
	local matHP_Full = Material("hud/cpthazama/avp/avp_a_health_bar_full.png","smooth additive")
	local matOrient = Material("hud/cpthazama/avp/avp_a_orient_ret2.png","smooth additive")
	local matOrient_CanJump = Material("hud/cpthazama/avp/avp_a_orient_ret1.png","smooth additive")
	local matOrient_NoJump = Material("hud/cpthazama/avp/avp_a_reticle_halo1.png","smooth additive")

	local matHUD_Blood = {
		Material("hud/cpthazama/avp/blood/yellow_1.png","smooth additive"),
		Material("hud/cpthazama/avp/blood/yellow_2.png","smooth additive"),
		Material("hud/cpthazama/avp/blood/yellow_3.png","smooth additive"),
		Material("hud/cpthazama/avp/blood/yellow_4.png","smooth additive")
	}

	local tab_xeno = {
		["$pp_colour_addr"] 		= 0.65,
		["$pp_colour_addg"] 		= 0.03,
		["$pp_colour_addb"] 		= 0,
		["$pp_colour_brightness"] 	= 0.2,
		["$pp_colour_contrast"] 	= 1,
		["$pp_colour_colour"] 		= 1,
		["$pp_colour_mulr"] 		= 0,
		["$pp_colour_mulg"] 		= 0,
		["$pp_colour_mulb"] 		= 0,
		["$pp_colour_inv"] 			= 1,
	}
	local tab_default = {
		["$pp_colour_addr"] 		= 0,
		["$pp_colour_addg"] 		= 0,
		["$pp_colour_addb"] 		= 0,
		["$pp_colour_brightness"] 	= 0.1,
		["$pp_colour_contrast"] 	= 1,
		["$pp_colour_colour"] 		= 1,
		["$pp_colour_mulr"] 		= 0,
		["$pp_colour_mulg"] 		= 0,
		["$pp_colour_mulb"] 		= 0,
		["$pp_colour_inv"] 			= 0,
	}

	// Credits to Dopey and/or Umbree for the below functions; I suck doo-doo at HUD scaling/UV stuff so I nabbed this. Full credits will be given on release
	local function ScreenPos(x,y)
		local w = ScrW()
		local h = ScrH()
		local pos = {}
		pos.x = w *0.5 +w *x *0.01
		pos.y = h *0.5 +w *y *0.01

		return pos
	end

	local function ScreenScale(x,y)
		local w = ScrW()
		local h = ScrH()
		local size = {}
		size.x = (w *x *0.01)
		size.y = (w *y *0.01)

		return size
	end

	local function DrawIcon(mat,x,y,width,height,r,g,b,a,ang)
		surface.SetDrawColor(Color(r or 255,g or 255,b or 255,a or 255))
		surface.SetMaterial(mat)
		local pos = ScreenPos(x,y)
		local size = ScreenScale(width,height)
		surface.DrawTexturedRectRotated(pos.x,pos.y,size.x,size.y,ang or 0)
	end

	local function DrawIcon_UV(mat,x,y,width,height,uv,r,g,b,a)
		local uv = uv or {0,0,1,1}
		surface.SetDrawColor(Color(r or 255,g or 255,b or 255,a or 255))
		surface.SetMaterial(mat)
		local pos = ScreenPos(x,y)
		local size = ScreenScale(width,height)
		surface.DrawTexturedRectUV(pos.x,pos.y,size.x,size.y,uv[1],uv[2],uv[3],uv[4])
	end

	local orients = {255,255,255}
	local math_Clamp = math.Clamp

	net.Receive("VJ_AVP_Xeno_Client",function(len,pl)
		local delete = net.ReadBool()
		local ent = net.ReadEntity()
		local cont = net.ReadEntity()
		local ply = cont

		hook.Add("HUDPaint","VJ_AVP_Xenomorph_HUD",function()
			if !IsValid(ent) then return end
			local xenoHUD = ent.VJ_AVP_XenoHUD

			local dmgSplatter = ply.VJ_AVP_NPCDamageSplatter or {}
			if #dmgSplatter > 0 then
				for id,data in ipairs(dmgSplatter) do
					if data.Pos == nil then
						data.Pos = {math.random(-50,50),math.random(-30,30)}
						data.MatID = data.MatID or math.random(1,4)
						data.Size = math.random(20,40)
						data.Ang = math.random(0,360)
					end
					if data.Remain == nil then
						data.Remain = CurTime()
					end
					local time = data.Remain -CurTime()
					local alpha = math_Clamp(time *255,0,255)
					if alpha <= 0 then
						table.remove(dmgSplatter,id)
						continue
					end
					local tbl = data.MatTable or matHUD_Blood
					DrawIcon(tbl[data.MatID],data.Pos[1],data.Pos[2],data.Size,data.Size,255,255,255,alpha,data.Ang)
				end
			end
		
			surface.SetDrawColor(color_white)
			surface.SetMaterial(xenoHUD == 1 && matSixHud or xenoHUD == 2 && matGridHud or matHud)
			surface.DrawTexturedRect(0,0,ScrW(),ScrH())

			ent.AVP_HUD_HPLerp = Lerp(FrameTime() *5,ent.AVP_HUD_HPLerp or 0,ent:GetHP())
			local maxHP = ent:GetMaxHealth()
			local hpPer = ent.AVP_HUD_HPLerp /maxHP
			local hpColor = ent.VJ_AVP_K_Xenomorph && Color(255,214,127) or Color(191,255,127)
			local a = 255
			local blink = 2
			local danger = hpPer <= 0.4
			if hpPer <= 0.5 && hpPer > 0.25 then
				hpColor = Color(255,145,0)
			elseif hpPer <= 0.24 then
				hpColor = Color(255,0,0)
				blink = 4
			end
			if ent:GetVision() then
				hpColor = Color(255 -hpColor.r,255 -hpColor.g,255 -hpColor.b)
			end
			ent.AVP_HUD_HPColor = LerpVector(FrameTime() *2,ent.AVP_HUD_HPColor or Vector(255,255,255),Vector(hpColor.r,hpColor.g,hpColor.b))
			hpColor = Color(ent.AVP_HUD_HPColor.x,ent.AVP_HUD_HPColor.y,ent.AVP_HUD_HPColor.z)

			DrawIcon(matHP_Base,0,-22.3,70,5,hpColor.r,hpColor.g,hpColor.b,a)
			DrawIcon_UV(matHP_Full,-22.85,-23.9,45 *hpPer,2.2,{0,0,hpPer,1},hpColor.r,hpColor.g,hpColor.b,danger && math.abs(math.sin(CurTime() *blink) *a) or a)

			if ent.GetJumpAbility && ent:GetJumpAbility() == true then
				local tr1 = util.TraceLine({
					start = cont:EyePos(),
					endpos = cont:EyePos() +cont:GetAimVector() *1100,
					filter = {ent,cont}
				})

				local orient = 1
				local hitPos = tr1.HitPos
				local hitNormal = tr1.HitNormal
				local hitX = math.abs(hitNormal.x)
				local hitY = math.abs(hitNormal.y)
				if hitX > 0 or hitY > 0 then
					orient = 2
				elseif hitNormal.z == -1 then
					orient = 3
				end
				for i = 1,3 do
					orients[i] = Lerp(FrameTime() *10,orients[i],orient == i && 255 or 0)
				end
				local ang = -ent:GetAngles().r
				DrawIcon(matOrient,0,0,8,8,hpColor.r,hpColor.g,hpColor.b,orients[1],ang)
				DrawIcon(matOrient_CanJump,0,0,5,5,hpColor.r,hpColor.g,hpColor.b,orients[2],ang)
				DrawIcon(matOrient_NoJump,0,0,5,5,hpColor.r,hpColor.g,hpColor.b,orients[3],ang)
			end
		end)
		if delete == true then hook.Remove("HUDPaint","VJ_AVP_Xenomorph_HUD") end

		hook.Add("Think","VJ_AVP_Xeno_VisionLight",function()
			if IsValid(ent) then
				local vision = ent:GetVision()
				if vision then
					local dLight = DynamicLight(ent:EntIndex())
					if dLight then
						dLight.Pos = ent:GetPos() +ent:OBBCenter()
						dLight.r = 5
						dLight.g = 5
						dLight.b = 5
						dLight.Brightness = 2
						dLight.Size = 4000
						dLight.Decay = 0
						dLight.DieTime = CurTime() +0.2
						dLight.Style = 0
					end
					if cont.VisionSound == nil then
						cont.VisionSound = CreateSound(cont,"cpthazama/avp/weapons/alien/alien_vision_loop.wav")
						cont.VisionSound:SetSoundLevel(0)
						cont.VisionSound:Play()
						cont.VisionSound:ChangeVolume(1)
					end
					local queenMarker = ent:GetQueenMarker()
					ent.LastQueenMarker = ent.LastQueenMarker or queenMarker
					if ent.LastQueenMarker != queenMarker then
						ent.LastQueenMarker = queenMarker
						if IsValid(ent.QueenMarkerFX) then
							ent.QueenMarkerFX:StopEmission(false,true)
							ent.QueenMarkerFX = nil
						end
					end
					if queenMarker != vector_origin then
						if !IsValid(ent.QueenMarkerFX) then
							ent.QueenMarkerFX = CreateParticleSystemNoEntity("vj_avp_xeno_queenmarker",queenMarker)
							ent.QueenMarkerFX:SetControlPoint(0,queenMarker)
						end
						local startPos = ent:EyePos() +ent:GetVelocity()
						for i = 1,5 do
							if !IsValid(ent.QueenMarkerPoints[i]) then
								ent.QueenMarkerPoints[i] = CreateParticleSystemNoEntity("vj_avp_xeno_queenmarker_pointer",queenMarker)
							else
								if IsValid(ent.QueenMarkerFX) then
									local ang = (queenMarker -startPos):Angle():Forward() *(100 *i)
									local tr = util.TraceLine({
										start = startPos,
										endpos = startPos +ang,
										filter = {ent,cont}
									})
									ent.QueenMarkerPoints[i]:SetControlPoint(0,tr.HitPos +tr.HitNormal *4)
								end
							end
						end
					else
						if IsValid(ent.QueenMarkerFX) then
							ent.QueenMarkerFX:StopEmission(false,true)
							ent.QueenMarkerFX = nil
						end
						for _,v in pairs(ent.QueenMarkerPoints) do
							if IsValid(v) then
								v:StopEmission(false,true)
								v = nil
							end
						end
					end
				else
					if cont.VisionSound then
						cont.VisionSound:Stop()
						cont.VisionSound = nil
					end
					if IsValid(ent.QueenMarkerFX) then
						ent.QueenMarkerFX:StopEmission(false,true)
						ent.QueenMarkerFX = nil
					end
					if ent.QueenMarkerPoints then
						for _,v in pairs(ent.QueenMarkerPoints) do
							if IsValid(v) then
								v:StopEmission(false,true)
								v = nil
							end
						end
					end
				end
				-- if render_GetLightColor(ent:GetPos() +ent:OBBCenter()):Length() <= 0.1 then
					-- local light = DynamicLight(ent:EntIndex())
					-- if (light) then
					-- 	light.Pos = ent:GetPos()
					-- 	light.r = 1
					-- 	light.g = 1
					-- 	light.b = 1
					-- 	light.Brightness = 6
					-- 	light.Size = 2000
					-- 	light.Decay = 0
					-- 	light.DieTime = CurTime() +0.3
					-- 	light.Style = 0
					-- end
				-- end
			end
		end)
		if delete == true then
			hook.Remove("Think","VJ_AVP_Xeno_VisionLight")
			if cont.VisionSound then
				cont.VisionSound:Stop()
			end
			if IsValid(ent.QueenMarkerFX) then
				ent.QueenMarkerFX:StopEmission(false,true)
				ent.QueenMarkerFX = nil
			end
			if IsValid(ent.QueenMarkerPointerFX) then
				ent.QueenMarkerPointerFX:StopEmission(false,true)
				ent.QueenMarkerPointerFX = nil
			end
		end

		hook.Add("RenderScreenspaceEffects","VJ_AVP_Xeno_Vision",function()
			if !IsValid(ent) then return end
			local lightColor = render_GetLightColor(ent:GetPos() +ent:OBBCenter())
			tab_default["$pp_colour_brightness"] = Lerp(FrameTime() *5,tab_default["$pp_colour_brightness"],lightColor:Length() <= 0.1 && 0.3 or 0.1)
			DrawColorModify(ent:GetVision() && tab_xeno or tab_default)
		end)
		if delete == true then hook.Remove("RenderScreenspaceEffects","VJ_AVP_Xeno_Vision") end

		hook.Add("PreDrawHalos","VJ_AVP_Xeno_Halo",function()
			if !IsValid(ent) then return end
			for _,v in ents.Iterator() do
				if !IsValid(v) then continue end
				if v:IsNPC() or v:IsPlayer() or v:IsNextBot() then
					if v:GetClass() == "obj_vj_bullseye" or v:GetPos():Distance(ent:GetPos()) > 2000 then continue end
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
			halo_Add(VJ_AVP_HALOS.Xenomorphs,col_xeno,10,10,15,true,true)
			halo_Add(VJ_AVP_HALOS.KXenomorphs,col_kxeno,10,10,15,true,true)
			halo_Add(VJ_AVP_HALOS.Predators,col_pred,10,10,15,true,true)
			halo_Add(VJ_AVP_HALOS.Tech,col_tech,10,10,15,true,true)
			halo_Add(VJ_AVP_HALOS.Other,col_enemy,10,10,15,true,true)
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