/*--------------------------------------------------
	=============== Autorun File ===============
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
------------------ Addon Information ------------------
local PublicAddonName = "Aliens vs Predator SNPCs"
local AddonName = "Aliens vs Predator"
local AddonType = "SNPC"
local AutorunFile = "autorun/vj_avp_spawn.lua"
-------------------------------------------------------
local VJExists = file.Exists("lua/autorun/vj_base_autorun.lua","GAME")
if VJExists == true then
	include('autorun/vj_controls.lua')

	VJ.AddConVar("vj_avp_fatalities",1,bit.bor(FCVAR_ARCHIVE,FCVAR_NOTIFY))
	VJ.AddConVar("vj_avp_predmobile",1,bit.bor(FCVAR_ARCHIVE,FCVAR_NOTIFY))
	VJ.AddConVar("vj_avp_xenostealth",1,bit.bor(FCVAR_ARCHIVE,FCVAR_NOTIFY))
	VJ.AddConVar("vj_avp_survival_bots",1,bit.bor(FCVAR_ARCHIVE,FCVAR_NOTIFY))
	VJ.AddConVar("vj_avp_survival_maxbots",0,bit.bor(FCVAR_ARCHIVE,FCVAR_NOTIFY))
	VJ.AddConVar("vj_avp_survival_music",1,bit.bor(FCVAR_ARCHIVE,FCVAR_NOTIFY))
	VJ.AddConVar("vj_avp_bosstheme_a",0,bit.bor(FCVAR_ARCHIVE,FCVAR_NOTIFY))
	VJ.AddConVar("vj_avp_bosstheme_p",0,bit.bor(FCVAR_ARCHIVE,FCVAR_NOTIFY))
	VJ.AddConVar("vj_avp_bosstheme_m",0,bit.bor(FCVAR_ARCHIVE,FCVAR_NOTIFY))
	VJ.AddClientConVar("vj_avp_hud", 0, "Should players have the Marine HUD?")
	VJ.AddClientConVar("vj_avp_hud_ping", 1, "Enable Pinging?")

	VJ_AVP_CVAR_XENOSTEALTH = GetConVar("vj_avp_xenostealth"):GetBool()

	local vCat = "Aliens vs Predator"
	local vCat_M = "Aliens vs Predator - Humans"
	local vCat_P = "Aliens vs Predator - Predators"
	local vCat_A = "Aliens vs Predator - Xenomorphs"
	local vCat_AK = "Aliens vs Predator - Xenomorphs (K-Series)"
	VJ.AddCategoryInfo(vCat_M,{Icon = "vj_icons/avp_marine16.png"})
	VJ.AddCategoryInfo(vCat_P,{Icon = "vj_icons/avp_pred16.png"})
	VJ.AddCategoryInfo(vCat_A,{Icon = "vj_icons/avp_xeno16.png"})
	VJ.AddCategoryInfo(vCat_AK,{Icon = "vj_icons/avp_kxeno16.png"})
	
	VJ.AddNPC("Survival Mode","sent_vj_avp_survival",vCat)
	VJ.AddNPC("RC Battery","sent_vj_avp_battery",vCat)

	-- VJ.AddNPC("Xenomorph Chestburster","npc_vj_avp_xeno_chestburster",vCat_A)
	VJ.AddNPC("Xenomorph Facehugger","npc_vj_avp_xeno_facehugger",vCat_A)
	VJ.AddNPC("Xenomorph Royal Facehugger","npc_vj_avp_xeno_facehugger_queen",vCat_A)
	VJ.AddNPC("Xenomorph Queen","npc_vj_avp_xeno_queen",vCat_A)
	VJ.AddNPC("Xenomorph Warrior","npc_vj_avp_xeno_warrior",vCat_A)
	VJ.AddNPC("Xenomorph Drone","npc_vj_avp_xeno_drone",vCat_A)
	VJ.AddNPC("Xenomorph Runner","npc_vj_avp_xeno_jungle",vCat_A)
	VJ.AddNPC("Xenomorph Warrior Ridged","npc_vj_avp_xeno_ridged",vCat_A)
	VJ.AddNPC("Xenomorph Praetorian","npc_vj_avp_xeno_praetorian",vCat_A)
	VJ.AddNPC("Xenomorph Carrier","npc_vj_avp_xeno_carrier",vCat_A)
	VJ.AddNPC("Xenomorph Egg","npc_vj_avp_xeno_egg",vCat_A)
	VJ.AddNPC("The Abomination","npc_vj_avp_xeno_predalien",vCat_A)
	VJ.AddNPC("Nethead","npc_vj_avp_xeno_nethead",vCat_A)
	VJ.AddNPC("Specimen Six","npc_vj_avp_xeno_six",vCat_A)
	VJ.AddNPC("The Matriarch","npc_vj_avp_xeno_matriarch",vCat_A)
	
	-- VJ.AddNPC("Xenomorph Chestburster","npc_vj_avp_kxeno_chestburster",vCat_AK)
	VJ.AddNPC("Xenomorph Facehugger","npc_vj_avp_kxeno_facehugger",vCat_AK)
	VJ.AddNPC("Xenomorph Royal Facehugger","npc_vj_avp_kxeno_facehugger_queen",vCat_AK)
	VJ.AddNPC("Xenomorph Queen","npc_vj_avp_kxeno_queen",vCat_AK)
	VJ.AddNPC("Xenomorph Warrior","npc_vj_avp_kxeno_warrior",vCat_AK)
	VJ.AddNPC("Xenomorph Drone","npc_vj_avp_kxeno_drone",vCat_AK)
	VJ.AddNPC("Xenomorph Runner","npc_vj_avp_kxeno_jungle",vCat_AK)
	VJ.AddNPC("Xenomorph Warrior Ridged","npc_vj_avp_kxeno_ridged",vCat_AK)
	VJ.AddNPC("Xenomorph Praetorian","npc_vj_avp_kxeno_praetorian",vCat_AK)
	VJ.AddNPC("Xenomorph Carrier","npc_vj_avp_kxeno_carrier",vCat_AK)
	VJ.AddNPC("Xenomorph Predalien","npc_vj_avp_kxeno_predalien",vCat_AK)

	VJ.AddNPC("Young Blood","npc_vj_avp_pred",vCat_P)
	VJ.AddNPC("Dark","npc_vj_avp_pred_dark",vCat_P)
	VJ.AddNPC("Claw","npc_vj_avp_pred_claw",vCat_P)
	VJ.AddNPC("Stalker","npc_vj_avp_pred_stalker",vCat_P)
	VJ.AddNPC("Hunter","npc_vj_avp_pred_hunter",vCat_P)
	VJ.AddNPC("Wolf","npc_vj_avp_pred_wolf",vCat_P)
	VJ.AddNPC("Spartan","npc_vj_avp_pred_spartan",vCat_P)
	VJ.AddNPC("Lord","npc_vj_avp_pred_lord",vCat_P)
	VJ.AddNPC("Serpent Hunter","npc_vj_avp_pred_alien",vCat_P)
	VJ.AddNPC("Pred-Lord","npc_vj_avp_pred_predlord",vCat_P)

	VJ.AddNPC("Sentry Gun","npc_vj_avp_hum_sentrygun",vCat_M)
	-- VJ.AddNPC_HUMAN("Marine Base","npc_vj_avp_hum_male",{"weapon_vj_avp_pistol"},vCat_M)
	VJ.AddNPC_HUMAN("Van Zandt","npc_vj_avp_hum_van",{"weapon_vj_avp_pistol"},vCat_M)
	VJ.AddNPC_HUMAN("Connor","npc_vj_avp_hum_connor",{"weapon_vj_avp_pistol"},vCat_M)
	VJ.AddNPC_HUMAN("Franco","npc_vj_avp_hum_franco",{"weapon_vj_avp_pistol"},vCat_M)
	VJ.AddNPC_HUMAN("Gibson","npc_vj_avp_hum_gibson",{"weapon_vj_avp_pistol"},vCat_M)
	VJ.AddNPC_HUMAN("Johnson","npc_vj_avp_hum_johnson",{"weapon_vj_avp_pistol"},vCat_M)
	VJ.AddNPC_HUMAN("Rookie","npc_vj_avp_hum_rookie",{"weapon_vj_avp_pistol"},vCat_M)
	VJ.AddNPC_HUMAN("Kaneko","npc_vj_avp_hum_kaneko",{"weapon_vj_avp_pistol"},vCat_M)
	VJ.AddNPC_HUMAN("Colonist","npc_vj_avp_hum_colonist",{"weapon_vj_avp_pistol"},vCat_M)
	VJ.AddNPC_HUMAN("Security Guard","npc_vj_avp_hum_secuirty",{"weapon_vj_avp_pistol"},vCat_M)
	VJ.AddNPC_HUMAN("Combat Android","npc_vj_avp_hum_android",{"weapon_vj_avp_pistol"},vCat_M)
	VJ.AddNPC_HUMAN("Combat Android Elite","npc_vj_avp_hum_android_elite",{"weapon_vj_avp_pistol"},vCat_M)
	VJ.AddNPC_HUMAN("Weyland Yutani","npc_vj_avp_hum_weyland",{"weapon_vj_avp_pistol"},vCat_M)

	VJ.AddNPC_HUMAN("Katya","npc_vj_avp_hum_katya",{"weapon_vj_avp_pistol"},vCat_M)
	VJ.AddNPC_HUMAN("Teresa Aquila","npc_vj_avp_hum_tequila",{"weapon_vj_avp_pistol"},vCat_M)
	// For some reason only the generic males got official names, so we're just gonna make the names up using an online name generator for the generic females LOL
	VJ.AddNPC_HUMAN("Butch","npc_vj_avp_hum_butch",{"weapon_vj_avp_pistol"},vCat_M)
	VJ.AddNPC_HUMAN("Elaine","npc_vj_avp_hum_blonde",{"weapon_vj_avp_pistol"},vCat_M)
	VJ.AddNPC_HUMAN("Charity","npc_vj_avp_hum_black",{"weapon_vj_avp_pistol"},vCat_M)
	VJ.AddNPC_HUMAN("Monica","npc_vj_avp_hum_black2",{"weapon_vj_avp_pistol"},vCat_M)

	/*
		Colonist/Marine - HP = 100
		Tequila - HP = 200
		Sentrygun - HP = 1000
		Android - HP = 200
		Android Elite - HP = 500
		Xenomorph Facehugger - HP = 15
		Xenomorph Warrior - HP = 140
		Xenomorph Jungle - HP = 60
		Xenomorph Praetorian - HP = 1000
	*/
	
	cvars.AddChangeCallback("vj_avp_xenostealth", function(convar_name, oldValue, newValue)
		VJ_AVP_CVAR_XENOSTEALTH = tonumber(newValue) == 1
	end)

	if SERVER then
		util.AddNetworkString("VJ_AVP_Marine_Client")
		util.AddNetworkString("VJ_AVP_Predator_Client")
		util.AddNetworkString("VJ_AVP_Xeno_Client")
		util.AddNetworkString("VJ_AVP_Xeno_Darkness")
		util.AddNetworkString("VJ_AVP_CSound")
		util.AddNetworkString("VJ_AVP_PingTable")

		net.Receive("VJ_AVP_Xeno_Darkness",function(len,pl)
			local ent = net.ReadEntity()
			local light = net.ReadFloat()
			if IsValid(ent) then
				ent.DarknessLevel = light
				ent.LastNetworkT = CurTime()
				ent.HasIdleSounds = false
				ent.HasAlertSounds = false
			end
		end)

		function VJ_AVP_CSound(ent,snd)
			net.Start("VJ_AVP_CSound")
				net.WriteString(snd)
				net.WriteEntity(ent)
			net.Send(ent)
		end

		VJ_AVP_MAX_EGGS = 50

		local table_insert = table.insert
		local math_abs = math.abs
		local math_cos = math.cos
		local math_rad = math.rad

		local moveEnts = {func_door=true,func_door_rotating=true,func_train=true,prop_dynamic_override=true,prop_door=true,prop_door_rotating=true}

		local function FindEntitiesInConeAndRadius(self)
			local origin = self:GetPos()
			local radius = 2250
			local coneAngle = 360
			-- local coneAngle = 180
			local height = 1250
			local zPosition = origin.z
			local entities = ents.FindInSphere(origin, radius)
			local result = {}

			for _, ent in pairs(entities) do
				if ent == self then continue end
				if !(ent:IsNPC() or ent:IsPlayer() or VJ.IsProp(ent) or moveEnts[ent:GetClass()]) then continue end
				if (ent:IsNPC() or ent:IsPlayer()) && (self:IsNPC() && self:CheckRelationship(ent) == D_LI or self:IsPlayer() && ent:IsNPC() && ent:Disposition(self) == D_LI) then continue end
				if self:IsNPC() && ent:IsPlayer() && VJ_CVAR_IGNOREPLAYERS then continue end
				if (ent:IsNPC() && (ent:GetMoveVelocity():Length() > 1 && ent:GetMoveVelocity():Length() or ent:GetVelocity():Length()) or ent:GetVelocity():Length()) <= 1 then continue end
				local direction = (ent:GetPos() - origin):GetNormalized()
				local forward = self:GetForward()
				local dot = direction:Dot(forward)
				local deltaZ = math_abs(ent:GetPos().z - origin.z)

				if dot >= math_cos(math_rad(coneAngle / 2)) and deltaZ <= height then
					table_insert(result, ent)
				end
			end

			return result
		end

		function VJ_AVP_MotionTracker(self)
			local curTime = CurTime()
			self:SetNW2Float("AVP.MotionTracker.Ping",self.Ping_NextPingT or 0)
			if curTime > (self.Ping_NextPingT or 0) then
				self.Ping_NextPingT = curTime +0.85
				local pingEnts = FindEntitiesInConeAndRadius(self)
				net.Start("VJ_AVP_PingTable")
					net.WriteEntity(self)
					net.WriteTable(pingEnts)
				net.Broadcast()
				local closestEnt = NULL
				local closestDist = 0
				for _,v in pairs(pingEnts) do
					if IsValid(v) then
						local dist = self:GetPos():Distance(v:GetPos())
						if closestEnt == NULL or dist < closestDist then
							closestEnt = v
							closestDist = dist
						end
					end
				end
				if IsValid(closestEnt) then
					self.Ping_ClosestDist = closestDist
					self.Ping_ClosestEnt = closestEnt
					local perDist = (closestDist /2250)
					local sndPitch = 100
					if closestDist <= 100 then
						sndPitch = 140
					else
						sndPitch = 100 +((1 -perDist) *40)
					end
					VJ.EmitSound(self,"cpthazama/avp/shared/motion_tracker_bleep_stevie.ogg",55,sndPitch)
					if self.IsVJBaseSNPC && self.CanInvestigate && self.NextInvestigationMove < CurTime() then
						if closestEnt:IsNPC() or closestEnt:IsPlayer() or closestEnt:IsNextBot() then
							if self:Visible(closestEnt) then
								self:StopMoving()
								self:SetTarget(closestEnt)
								self:VJ_TASK_FACE_X("TASK_FACE_TARGET")
								self.NextInvestigationMove = CurTime() +0.3
							elseif self.IsFollowing == false && math.random(1,15) == 1 then
								self:SetLastPosition(closestEnt:GetPos())
								self:VJ_TASK_GOTO_LASTPOS("TASK_WALK_PATH")
								self.NextInvestigationMove = CurTime() +10
							end
							self:CustomOnInvestigate(v)
							if self.VJ_AVP_NPC && math.random(1,6) == 1 then
								self:PlaySoundSystem("InvestigateSound",perDist > 0.8 && self.SoundTbl_MotionTracker_Far or perDist <= 0.8 && perDist > 0.4 && self.SoundTbl_MotionTracker_Mid or self.SoundTbl_MotionTracker_Close)
							end
						end
					end
				else
					VJ.EmitSound(self,"cpthazama/avp/shared/motion_tracker_pulse_01.ogg",55)
				end
			end
		end

		hook.Add("Think","VJ_AVP_HUD_Setup",function()
			for _,ply in ents.Iterator() do
				if ply:IsPlayer() && ply:GetInfoNum("vj_avp_hud",0) == 1 && !ply.VJTag_IsControllingNPC then
					if GetConVar("ai_ignoreplayers"):GetBool() then return end
					if ply:GetInfoNum("vj_avp_hud_ping",1) == 0 then return end
					VJ_AVP_MotionTracker(ply)
				end
			end
		end)
	else
		net.Receive("VJ_AVP_CSound",function(len,pl)
			local sound = net.ReadString()
			local ent = net.ReadEntity()

			ent:EmitSound(sound,0)
			-- print("Playing sound " .. sound .. " on " .. ent:Nick())
		end)

		hook.Add("PlayerBindPress","VJ.AVP.BindPressFix",function(ply,bind,pressed)
			if ply.VJTag_IsControllingNPC == true && IsValid(ply.VJCE_NPC) && ply.VJCE_NPC.VJ_AVP_NPC then
				if bind == "invprev" or bind == "invnext" then
					return true
				end
			end
		end)

		hook.Add("CalcViewModelView","VJ_AVP_ViewModel",function(wep,vm,opos,oang,pos,ang)
			local ply = LocalPlayer()
			if IsValid(ply) then
				local possessing = ply.VJCE_NPC
				if IsValid(possessing) && possessing.VJ_AVP_Predator && possessing.VJ_AVP_ViewModelData then
					local att = vm:LookupAttachment("pov")
					local data = possessing.VJ_AVP_ViewModelData
					local pos2 = data.origin
					local ang2 = data.angles
					local seq = vm:GetSequenceName(vm:GetSequence())
					-- if att > 0 then
						-- local attPos = vm:GetAttachment(att)
						-- if attPos then
							-- local localVec = ply:WorldToLocal(attPos.Pos)
							-- local diff = localVec -pos2
							-- print(localVec,diff)
							-- print("-------------------")
							-- print("Pos2",pos2,"attPos",attPos.Pos,"Diff",diff,"pos2 +diff",pos2 +diff)
							-- pos2 = pos2 +diff
							-- pos2 = pos2 +Vector(0,0,5)
						-- end
					-- end
					local origin = pos2 + (opos - pos)
					local angles = ang2 + (oang - ang)

					angles.p = math.Clamp(angles.p,-40,78)
					if possessing:GetInFatality() then
						angles.p = 0
						angles.y = possessing:GetAngles().y
					elseif seq == "Predator_Hud_Battery_Interaction" or seq == "Predator_Hud_Disable_Interaction" then
						angles.p = 0
						angles.y = possessing:GetAngles().y
						origin = origin +angles:Forward() *-15
					end

					ply.VJ_AVP_ViewModelCalcData = {origin,angles}
		
					return origin, angles
				end
			end
		end)
		
		hook.Add("PreDrawViewModel","VJ_AVP_ViewModel",function(vm,ply)
			local possessing = ply.VJCE_NPC
			if IsValid(possessing) && possessing.VJ_AVP_Predator then
				if !IsValid(possessing:GetVM()) or ply.VJC_Camera_Mode != 2 then
					return true
				end
			end
		end)

		surface.CreateFont("VJFont_AVP_Marine", {
			font = "Orbitron Regular",
			size = 32,
			weight = 600,
			blursize = 1,
			antialias = true,
			italic = false,
		})

		surface.CreateFont("VJFont_AVP_MarineSmall", {
			font = "Orbitron Regular",
			size = 29,
			weight = 600,
			blursize = 1,
			antialias = true,
			italic = false,
		})
	end

	VJ.AddParticle("particles/vj_avp_blood.pcf",{
		"vj_avp_blood_predator",
		"vj_avp_blood_xeno",
	})
	VJ.AddParticle("particles/vj_avp_android.pcf",{
		"vj_avp_android_death_charge",
		"vj_avp_android_death",
	})
	VJ.AddParticle("particles/vj_avp_xenomorph.pcf",{
		"vj_avp_xeno_blackgoo",
		"vj_avp_xeno_spit",
		"vj_avp_xeno_spit_impact",
		"vj_avp_xeno_queenmarker",
		"vj_avp_xeno_queenmarker_pointer",
	})
	VJ.AddParticle("particles/vj_avp_rc_battery.pcf",{
		"vj_avp_rc_battery_sap",
	})
	VJ.AddParticle("particles/vj_avp_predator.pcf",{})
	VJ.AddParticle("particles/vj_avp_ins_muzzle.pcf",{
		"vj_avp_wep_rifle_muzzle",
	})
	VJ.AddParticle("particles/vj_avp_predator_hud.pcf",{
		"vj_avp_predator_hud_landing",
		"vj_avp_predator_hud_landing_heat",
		"vj_avp_predator_hud_landing_xeno",
		"vj_avp_predator_hud_landing_mech",
	})

	game.AddDecal("VJ_AVP_BloodPredator", {"decals/cpthazama/avp/predator1","decals/cpthazama/avp/predator2","decals/cpthazama/avp/predator3","decals/cpthazama/avp/predator4"})
	game.AddDecal("VJ_AVP_BloodXenomorph", {"decals/cpthazama/avp/xeno1","decals/cpthazama/avp/xeno2","decals/cpthazama/avp/xeno3","decals/cpthazama/avp/xeno4"})

	local function AddWep(name,class)
		VJ.AddNPCWeapon("VJ_" .. name, class, vCat)
		VJ.AddWeapon(name, class, false, vCat)
	end

	AddWep("VP78 Pistol","weapon_vj_avp_pistol")

	if CLIENT then
		hook.Add("PopulateToolMenu", "VJ_ADDTOMENU_AVP", function()
			spawnmenu.AddToolMenuOption("DrVrej", "SNPC Configures", "Aliens vs Predator", "Aliens vs Predator", "", "", function(Panel)
				local vj_icon = vgui.Create("DImage")
				vj_icon:SetSize(512,60)
				vj_icon:SetImage("vgui/avp/spacer.png")
				Panel:AddPanel(vj_icon)
				Panel:AddControl("Label", {Text = "General Settings"})
				Panel:AddControl("Checkbox", {Label = "Enable Fatalities", Command = "vj_avp_fatalities"})

				local vj_icon = vgui.Create("DImage")
				vj_icon:SetSize(512,130)
				vj_icon:SetImage("vgui/avp/faction_alien.png")
				Panel:AddPanel(vj_icon)
				Panel:AddControl("Label", {Text = "Xenomorph Settings"})
				Panel:AddControl("Checkbox", {Label = "Enable Boss Themes", Command = "vj_avp_bosstheme_a"})
				Panel:AddControl("Checkbox", {Label = "Enable Xenomorph Stealth", Command = "vj_avp_xenostealth"})
				Panel:AddControl("Label", {Text = "Note: Due to the way this code is handled, it is quite taxing on the game. Disable if you experience performance issues."})

				local vj_icon = vgui.Create("DImage")
				vj_icon:SetSize(512,130)
				vj_icon:SetImage("vgui/avp/faction_predator.png")
				Panel:AddPanel(vj_icon)
				Panel:AddControl("Label", {Text = "Predator Settings"})
				Panel:AddControl("Checkbox", {Label = "Enable Boss Themes", Command = "vj_avp_bosstheme_p"})
				Panel:AddControl("Checkbox", {Label = "Enable Unique Spawns", Command = "vj_avp_predmobile"})

				local vj_icon = vgui.Create("DImage")
				vj_icon:SetSize(512,130)
				vj_icon:SetImage("vgui/avp/faction_marine.png")
				Panel:AddPanel(vj_icon)
				Panel:AddControl("Label", {Text = "Human Settings"})
				Panel:AddControl("Checkbox", {Label = "Enable Boss Themes", Command = "vj_avp_bosstheme_m"})
			end)
		end)
	end

	KEY_MOUSESCROLL_UP = 112
	KEY_MOUSESCROLL_DOWN = 113
	VJ_AVP_HALOS = {}
	VJ_AVP_HALOS.Xenomorphs = {}
	VJ_AVP_HALOS.KXenomorphs = {}
	VJ_AVP_HALOS.Predators = {}
	VJ_AVP_HALOS.Tech = {}
	VJ_AVP_HALOS.Other = {}
	VJ_AVP_FATALITIES = GetConVar("vj_avp_fatalities"):GetBool()

	VJ_AVP_XENOS = {}

	local NPC = FindMetaTable("NPC")
	
	function NPC:Acid(pos,dist,dmg)
		VJ.AVP_ApplyRadiusDamage(self,self,pos or self:GetPos(),dist or 65,dmg or 5,DMG_ACID,true,true,{},function(ent)
			if ent.VJ_AVP_Xenomorph then
				return false
			end
		end)

		-- VJ.ApplyRadiusDamage(self, self, pos or self:GetPos(), dist or 65, dmg or 5, DMG_ACID, true, true)
	end

	if CLIENT then
		local P_LerpVec = Vector(0,0,0)
		local P_LerpAng = Angle(0,0,0)
		hook.Add("CalcView","VJ_AVP_TrophyKillView",function(ply,pos,angles,fov)
			local canView = ply:GetNWBool("VJ_AVP_TrophyKill")
			local viewVec = ply:GetNWVector("VJ_AVP_TrophyKillVector")
			local viewBone = ply:GetNWInt("VJ_AVP_TrophyKillBone")
			local viewEntity = ply:GetNWEntity("VJ_AVP_TrophyKillEntity")
			if canView then
				if IsValid(ply:GetViewEntity()) && ply:GetViewEntity():GetClass() == "gmod_cameraprop" then
					return
				end
				local forward,right,up = viewVec[1],viewVec[2],viewVec[3]
				local bpos,bang = viewEntity:GetBonePosition(viewBone)
				local function Position(ply,origin,angles,dist,cPos)
					local tr = util.TraceHull({
						start = bpos +viewEntity:GetForward() *forward +viewEntity:GetRight() *right +viewEntity:GetUp() *up,
						endpos = bpos,
						mask = MASK_SHOT,
						filter = player.GetAll(),
						mins = Vector(-8,-8,-8),
						maxs = Vector(8,8,8)
					})
					return tr.HitPos +tr.HitNormal *5
				end

				pos = Position(ply,viewVec,angles,40,viewVec)
				P_LerpVec = LerpVector(FrameTime() *15,P_LerpVec,pos)
				P_LerpAng = LerpAngle(FrameTime() *15,P_LerpAng,ply:EyeAngles())

				local view = {}
				view.origin = P_LerpVec
				view.angles = P_LerpAng
				view.fov = fov
				return view
			end
		end)
	end
	if SERVER then
		function VJ_AVP_QueenExists(self)
			for _,v in ipairs(VJ_AVP_XENOS) do
				if v.VJ_AVP_Xenomorph_Queen && v != self then
					if self.VJ_AVP_K_Xenomorph && !v.VJ_AVP_K_Xenomorph or v.VJ_AVP_K_Xenomorph && !self.VJ_AVP_K_Xenomorph then continue end
					return true
				end
			end
			return false
		end

		function VJ_AVP_MatriarchExists(self)
			for _,v in ipairs(VJ_AVP_XENOS) do
				if v.VJ_AVP_Xenomorph_Matriarch && v != self then
					return true
				end
			end
			return false
		end

		local specialDmgEnts = {npc_strider=true, npc_combinedropship=true, npc_combinegunship=true, npc_helicopter=true} -- Entities that need special code to be damaged
		local math_clamp = math.Clamp
		local math_round = math.Round
		local math_floor = math.floor
		local math_clamp = math.Clamp
		--
		function VJ.AVP_ApplyRadiusDamage(attacker, inflictor, startPos, dmgRadius, dmgMax, dmgType, ignoreInnocents, realisticRadius, extraOptions, customFunc)
			startPos = startPos or attacker:GetPos()
			dmgRadius = dmgRadius or 150
			dmgMax = dmgMax or 15
			extraOptions = extraOptions or {}
				local disableVisibilityCheck = extraOptions.DisableVisibilityCheck or false
				local baseForce = extraOptions.Force or false
			local dmgFinal = dmgMax
			local hitEnts = {}
			for _, v in ipairs((isnumber(extraOptions.UseConeDegree) and VJ.FindInCone(startPos, extraOptions.UseConeDirection or attacker:GetForward(), dmgRadius, extraOptions.UseConeDegree or 90, {AllEntities=true})) or ents.FindInSphere(startPos, dmgRadius)) do
				if (v.IsVJBaseBullseye && v.VJ_IsBeingControlled) or v.VJTag_IsControllingNPC then continue end -- Don't damage bulleyes used by the NPC controller OR entities that are controlling others (Usually players)
				local nearestPos = v:NearestPoint(startPos) -- From the enemy position to the given position
				if realisticRadius != false then -- Decrease damage from the nearest point all the way to the enemy point then clamp it!
					dmgFinal = math_clamp(dmgFinal * ((dmgRadius - startPos:Distance(nearestPos)) + 150) / dmgRadius, dmgMax / 2, dmgFinal)
				end
				
				if (disableVisibilityCheck == false && (v:VisibleVec(startPos) or v:Visible(attacker))) or (disableVisibilityCheck == true) then
					local function DoDamageCode()
						local shouldContinue = true
						if (customFunc) then
							shouldContinue = customFunc(v)
						end
						if shouldContinue == false then return end
						hitEnts[#hitEnts + 1] = v
						if specialDmgEnts[v:GetClass()] then
							v:TakeDamage(dmgFinal, attacker, inflictor)
						else
							local dmgInfo = DamageInfo()
							dmgInfo:SetDamage(dmgFinal)
							dmgInfo:SetAttacker(attacker)
							dmgInfo:SetInflictor(inflictor)
							dmgInfo:SetDamageType(dmgType or DMG_BLAST)
							dmgInfo:SetDamagePosition(nearestPos)
							if baseForce != false then
								local force = baseForce
								local forceUp = extraOptions.UpForce or false
								if VJ.IsProp(v) or v:GetClass() == "prop_ragdoll" then
									local phys = v:GetPhysicsObject()
									if IsValid(phys) then
										if forceUp == false then forceUp = force / 9.4 end
										//v:SetVelocity(v:GetUp()*100000)
										if v:GetClass() == "prop_ragdoll" then force = force * 1.5 end
										phys:ApplyForceCenter(((v:GetPos() + v:OBBCenter() + v:GetUp() * forceUp) - startPos) * force) //+attacker:GetForward()*vForcePropPhysics
									end
								else
									force = force * 1.2
									if forceUp == false then forceUp = force end
									dmgInfo:SetDamageForce(((v:GetPos() + v:OBBCenter() + v:GetUp() * forceUp) - startPos) * force)
								end
							end
							VJ.DamageSpecialEnts(attacker, v, dmgInfo)
							v:TakeDamageInfo(dmgInfo)
						end
					end
					-- Self
					if v:EntIndex() == attacker:EntIndex() then
						if extraOptions.DamageAttacker then DoDamageCode() end -- If it can't self hit, then skip
					-- Other entities
					elseif (ignoreInnocents == false) or (!v:IsNPC() && !v:IsPlayer()) or (v:IsNPC() && v:GetClass() != attacker:GetClass() && v:Health() > 0 && (attacker:IsPlayer() or (attacker:IsNPC() && attacker:Disposition(v) != D_LI))) or (v:IsPlayer() && v:Alive() && (attacker:IsPlayer() or (!VJ_CVAR_IGNOREPLAYERS && !v:IsFlagSet(FL_NOTARGET)))) then
						DoDamageCode()
					end
				end
			end
			return hitEnts
		end

		local table_insert = table.insert
		local table_remove = table.remove
		local noAccept = {npc_grenade_frag=true,npc_bullseye=true,obj_vj_bullseye=true}
		hook.Add("OnEntityCreated","VJ_AVP_Classify",function(ent)
			if ent:IsNPC() && ent.VJ_AVP_Xenomorph then
				table_insert(VJ_AVP_XENOS,ent)
			end
			if ent:IsNPC() && !noAccept[ent:GetClass()] && ent.VJ_AVP_IsTech == nil then
				timer.Simple(0,function()
					if IsValid(ent) then
						local class = ent:Classify()
						if !ent.IsVJBaseSNPC then
							if class == 10 or class == 9 or class == 13 or class == 16 or class == 25 or class == 26 or class == 24 or class == 15 then
								ent:SetNW2Bool("AVP.IsTech",true)
								ent.VJ_AVP_IsTech = true
							end
						else
							local isCombine = VJ.HasValue(ent.VJ_NPC_Class,"CLASS_COMBINE")
							local pos = ent:EyePos()
							local tr = util.TraceLine({
								start = pos +ent:GetForward() *-30,
								endpos = pos +ent:GetForward() *30,
								mask = MASK_SHOT,
								mins = Vector(-4,-4,-4),
								maxs = Vector(4,4,4)
							})
							local mat = tr.MatType
							if (isCombine && ent.IsVJBaseSNPC_Human && ent.VJTag_ID_Police != true) or (isCombine && !ent.IsVJBaseSNPC_Human) or ent.VJTag_ID_Vehicle == true or (mat == MAT_METAL or mat == MAT_GLASS) then
								ent:SetNW2Bool("AVP.IsTech",true)
								ent.VJ_AVP_IsTech = true
							end
						end
					end
				end)
			end
		end)

		VJ_AVP_PMV = {
			["Tech"] = {
				"models/player/combine_soldier.mdl",
				"models/player/combine_soldier_prisonguard.mdl",
				"models/player/combine_super_soldier.mdl",
			},
			["Xeno"] = {},
		}
		hook.Add("PlayerSetModel","VJ_AVP_Classify",function(ent)
			timer.Simple(0,function()
				if IsValid(ent) then
					if VJ_AVP_PMV["Tech"][ent:GetModel()] then
						ent:SetNW2Bool("AVP.IsTech",true)
						ent.VJ_AVP_IsTech = true
					elseif VJ_AVP_PMV["Xeno"][ent:GetModel()] then
						ent:SetNW2Bool("AVP.Xenomorph",true)
						ent.VJ_AVP_Xenomorph = true
					end
				end
			end)
		end)

		hook.Add("EntityRemoved","VJ_AVP_XenoRemoveCheck",function(ent)
			if ent:IsNPC() && ent.VJ_AVP_Xenomorph then
				for k,v in ipairs(VJ_AVP_XENOS) do
					if v == ent then
						table_remove(VJ_AVP_XENOS,k)
					end
				end
			end
		end)
	end

-- !!!!!! DON'T TOUCH ANYTHING BELOW THIS !!!!!! -------------------------------------------------------------------------------------------------------------------------
	AddCSLuaFile(AutorunFile)
	VJ.AddAddonProperty(AddonName,AddonType)
else
	if (CLIENT) then
		chat.AddText(Color(0,200,200),PublicAddonName,
		Color(0,255,0)," was unable to install, you are missing ",
		Color(255,100,0),"VJ Base!")
	end
	timer.Simple(1,function()
		if not VJF then
			if (CLIENT) then
				VJF = vgui.Create("DFrame")
				VJF:SetTitle("ERROR!")
				VJF:SetSize(790,560)
				VJF:SetPos((ScrW()-VJF:GetWide())/2,(ScrH()-VJF:GetTall())/2)
				VJF:MakePopup()
				VJF.Paint = function()
					draw.RoundedBox(8,0,0,VJF:GetWide(),VJF:GetTall(),Color(200,0,0,150))
				end
				
				local VJURL = vgui.Create("DHTML",VJF)
				VJURL:SetPos(VJF:GetWide()*0.005, VJF:GetTall()*0.03)
				VJURL:Dock(FILL)
				VJURL:SetAllowLua(true)
				VJURL:OpenURL("https://sites.google.com/site/vrejgaming/vjbasemissing")
			elseif (SERVER) then
				timer.Create("VJBASEMissing",5,0,function() print("VJ Base is Missing! Download it from the workshop!") end)
			end
		end
	end)
end