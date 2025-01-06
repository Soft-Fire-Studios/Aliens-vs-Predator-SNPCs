/*--------------------------------------------------
	=============== Autorun File ===============
	*** Copyright (c) 2025 by Cpt. Hazama, All rights reserved. ***
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
	include("autorun/vj_controls.lua")

	VJ.AddConVar("vj_avp_fatalities",1,bit.bor(FCVAR_ARCHIVE,FCVAR_NOTIFY))
	VJ.AddConVar("vj_avp_predmobile",1,bit.bor(FCVAR_ARCHIVE,FCVAR_NOTIFY))
	VJ.AddConVar("vj_avp_xenostealth",1,bit.bor(FCVAR_ARCHIVE,FCVAR_NOTIFY))
	VJ.AddConVar("vj_avp_flashlight",0,bit.bor(FCVAR_ARCHIVE,FCVAR_NOTIFY))
	VJ.AddConVar("vj_avp_survival_bots",1,bit.bor(FCVAR_ARCHIVE,FCVAR_NOTIFY))
	VJ.AddConVar("vj_avp_survival_maxbots",0,bit.bor(FCVAR_ARCHIVE,FCVAR_NOTIFY))
	VJ.AddConVar("vj_avp_survival_respawn",1,bit.bor(FCVAR_ARCHIVE,FCVAR_NOTIFY))
	VJ.AddConVar("vj_avp_survival_plybots",0,bit.bor(FCVAR_ARCHIVE,FCVAR_NOTIFY))
	VJ.AddConVar("vj_avp_bosstheme_a",0,bit.bor(FCVAR_ARCHIVE,FCVAR_NOTIFY))
	VJ.AddConVar("vj_avp_bosstheme_p",0,bit.bor(FCVAR_ARCHIVE,FCVAR_NOTIFY))
	VJ.AddConVar("vj_avp_bosstheme_m",0,bit.bor(FCVAR_ARCHIVE,FCVAR_NOTIFY))
	VJ.AddConVar("vj_avp_pred_info",1,bit.bor(FCVAR_ARCHIVE,FCVAR_NOTIFY))
	VJ.AddConVar("vj_avp_kseries_ally",0,bit.bor(FCVAR_ARCHIVE,FCVAR_NOTIFY))
	VJ.AddClientConVar("vj_avp_hud", 0, "Should players have the Marine HUD?")
	VJ.AddClientConVar("vj_avp_hud_ping", 1, "Enable Pinging?")
	VJ.AddClientConVar("vj_avp_hud_predinfo", 1, "Enable Predator HUD info display?")
	VJ.AddClientConVar("vj_avp_survival_music", 1, "Enable Pinging?")
	VJ.AddClientConVar("vj_avp_moviepred", 0, "Enable AVP movie sounds for Predator Vision")

	VJ_AVP_CVAR_XENOSTEALTH = GetConVar("vj_avp_xenostealth"):GetBool()
	VJ_AVP_CVAR_FLASHLIGHT = GetConVar("vj_avp_flashlight"):GetBool()

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
	-- VJ.AddNPC("Predator Survival Mode","sent_vj_avp_survival_predator",vCat)
	-- VJ.AddNPC("Predator Hunt","sent_vj_avp_hunt",vCat) // Discontinued
	VJ.AddNPC("RC Battery","sent_vj_avp_battery",vCat)

	-- VJ.AddNPC("Xenomorph Chestburster","npc_vj_avp_xeno_chestburster",vCat_A)
	VJ.AddNPC("Xenomorph Facehugger","npc_vj_avp_xeno_facehugger",vCat_A)
	VJ.AddNPC("Xenomorph Royal Facehugger","npc_vj_avp_xeno_facehugger_queen",vCat_A)
	VJ.AddNPC("Xenomorph Queen","npc_vj_avp_xeno_queen",vCat_A)
	VJ.AddNPC("Xenomorph Warrior","npc_vj_avp_xeno_warrior",vCat_A)
	VJ.AddNPC("Xenomorph Drone","npc_vj_avp_xeno_drone",vCat_A)
	VJ.AddNPC("Xenomorph Jungle Drone","npc_vj_avp_xeno_jungle",vCat_A)
	VJ.AddNPC("Xenomorph Runner","npc_vj_avp_xeno_runner",vCat_A)
	VJ.AddNPC("Xenomorph Warrior Ridged","npc_vj_avp_xeno_ridged",vCat_A)
	VJ.AddNPC("Xenomorph Praetorian","npc_vj_avp_xeno_praetorian",vCat_A)
	VJ.AddNPC("Xenomorph Carrier","npc_vj_avp_xeno_carrier",vCat_A)
	VJ.AddNPC("Xenomorph Venator","npc_vj_avp_xeno_royal",vCat_A)
	VJ.AddNPC("Xenomorph Ravager","npc_vj_avp_xeno_ravager",vCat_A)
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
	VJ.AddNPC("Xenomorph Runner","npc_vj_avp_kxeno_runner",vCat_AK)
	VJ.AddNPC("Xenomorph Warrior Ridged","npc_vj_avp_kxeno_ridged",vCat_AK)
	VJ.AddNPC("Xenomorph Praetorian","npc_vj_avp_kxeno_praetorian",vCat_AK)
	VJ.AddNPC("Xenomorph Carrier","npc_vj_avp_kxeno_carrier",vCat_AK)
	VJ.AddNPC("Xenomorph Venator","npc_vj_avp_kxeno_royal",vCat_AK)
	VJ.AddNPC("Xenomorph Ravager","npc_vj_avp_kxeno_ravager",vCat_AK)
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
	VJ.AddNPC("Extinction","npc_vj_avp_pred_extinction",vCat_P)
	VJ.AddNPC("Tech","npc_vj_avp_pred_tech",vCat_P)
	VJ.AddNPC("Ancient","npc_vj_avp_pred_predlord",vCat_P)

	/*
		weapon_vj_avp_pistol
		weapon_vj_avp_pulserifle
		weapon_vj_avp_scopedrifle
		weapon_vj_avp_smartgun
		weapon_vj_avp_flamethrower
		weapon_vj_avp_shotgun
	*/

	local wepMarines = {
		"weapon_vj_avp_pulserifle","weapon_vj_avp_pulserifle","weapon_vj_avp_pulserifle","weapon_vj_avp_pulserifle","weapon_vj_avp_pulserifle","weapon_vj_avp_pulserifle",
		"weapon_vj_avp_shotgun","weapon_vj_avp_shotgun","weapon_vj_avp_shotgun",
		"weapon_vj_avp_scopedrifle",
		"weapon_vj_avp_flamethrower",
		-- "weapon_vj_avp_smartgun",
		-- "weapon_vj_avp_pistol",
	}

	VJ.AddNPC("Sentry Gun","npc_vj_avp_hum_sentrygun",vCat_M)
	VJ.AddNPC("Random Marine","sent_vj_avp_marine",vCat_M)
	VJ.AddNPC_HUMAN("Van Zandt","npc_vj_avp_hum_van",wepMarines,vCat_M)
	VJ.AddNPC_HUMAN("Connor","npc_vj_avp_hum_connor",wepMarines,vCat_M)
	VJ.AddNPC_HUMAN("Franco","npc_vj_avp_hum_franco",wepMarines,vCat_M)
	VJ.AddNPC_HUMAN("Gibson","npc_vj_avp_hum_gibson",wepMarines,vCat_M)
	VJ.AddNPC_HUMAN("Johnson","npc_vj_avp_hum_johnson",wepMarines,vCat_M)
	VJ.AddNPC_HUMAN("Rookie","npc_vj_avp_hum_rookie",wepMarines,vCat_M)
	VJ.AddNPC_HUMAN("Moss","npc_vj_avp_hum_moss",wepMarines,vCat_M)
	VJ.AddNPC_HUMAN("Thomas","npc_vj_avp_hum_youngwhite",wepMarines,vCat_M)
	VJ.AddNPC_HUMAN("Martinez","npc_vj_avp_hum_hispanic",wepMarines,vCat_M)
	-- VJ.AddNPC_HUMAN("Kaneko","npc_vj_avp_hum_kaneko",wepMarines,vCat_M)
	-- VJ.AddNPC_HUMAN("Colonist","npc_vj_avp_hum_colonist",{},vCat_M)
	VJ.AddNPC_HUMAN("Archaeologist","npc_vj_avp_hum_archa",{},vCat_M)
	VJ.AddNPC_HUMAN("Security Guard","npc_vj_avp_hum_secuirty",{"weapon_vj_avp_pistol"},vCat_M)
	VJ.AddNPC_HUMAN("Combat Android","npc_vj_avp_hum_android",{"weapon_vj_avp_pulserifle","weapon_vj_avp_flamethrower","weapon_vj_avp_scopedrifle"},vCat_M)
	VJ.AddNPC_HUMAN("Combat Android Elite","npc_vj_avp_hum_android_elite",{"weapon_vj_avp_pulserifle","weapon_vj_avp_shotgun","weapon_vj_avp_scopedrifle","weapon_vj_avp_shotgun","weapon_vj_avp_scopedrifle"},vCat_M)
	VJ.AddNPC_HUMAN("Weyland Yutani","npc_vj_avp_hum_weyland",{"weapon_vj_avp_shotgun"},vCat_M)

	-- VJ.AddNPC_HUMAN("Katya","npc_vj_avp_hum_katya",wepMarines,vCat_M)
	VJ.AddNPC_HUMAN("Teresa Aquila","npc_vj_avp_hum_tequila",wepMarines,vCat_M)
	// For some reason only the generic males got official names, so we're just gonna make the names up using an online name generator for the generic females LOL
	VJ.AddNPC_HUMAN("Butch","npc_vj_avp_hum_butch",wepMarines,vCat_M)
	VJ.AddNPC_HUMAN("Elaine","npc_vj_avp_hum_blonde",wepMarines,vCat_M)
	VJ.AddNPC_HUMAN("Charity","npc_vj_avp_hum_black",wepMarines,vCat_M)
	VJ.AddNPC_HUMAN("Monica","npc_vj_avp_hum_black2",wepMarines,vCat_M)

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

	AVP = AVP or {}

	local math_round = math.Round
	function AVP.Dist(dist) -- AVP source code uses the metric system, im lazy as shit so we'll do this on the go
		return math_round((dist *16) *3.281)
	end

    AVP_ALLEGIANCE_ENEMY = 1
    AVP_ALLEGIANCE_FRIEND = 3
    AVP_ALLEGIANCE_NEUTRAL = 4

	AVP_ENTITYCLASS_ALIEN = 0
	AVP_ENTITYCLASS_ALIENCHESTBURSTER = 1
	AVP_ENTITYCLASS_ALIENFACEHUGGER = 2
	AVP_ENTITYCLASS_ALIENQUEEN = 4
	AVP_ENTITYCLASS_HUMAN = 8
	AVP_ENTITYCLASS_PREDATOR = 16
	AVP_ENTITYCLASS_PREDALIEN = 32
	AVP_ENTITYCLASS_DROPSHIP = 64
	AVP_ENTITYCLASS_ANDROID = 128
	AVP_ENTITYCLASS_CIVILIAN = 256
	AVP_ENTITYCLASS_MARINE = 512
	AVP_ENTITYCLASS_SENTRYGUN = 1024

	AVP.fDefaultDamageRadius = AVP.Dist(2.0)
	AVP.fDefaultDamageAIBackAttackFactor = 0.5
	AVP.fDefaultAttackDetectionRadius = AVP.Dist(4.0)
	AVP.fDefaultTargetDetectionRadius = AVP.Dist(12.0)
	AVP.fDefaultTargetDetectionCosAngle = 0.866
	AVP.fDefaultTargetDetectionOriginBackwardsOffset = 0.5
	AVP.fDefaultBlockDetectionCosAngle = 0.707
	AVP.fDefaultBlockDamageProportion = 0.5
	
	AVP.fDefaultMinorMeleeDamageAmount = 30.0
	AVP.fDefaultModerateMeleeDamageAmount = 60.0
	AVP.fDefaultMajorMeleeDamageAmount = 120.0
	
	AVP.fDefaultMaxSuckDistance = AVP.Dist(4.0)
	
	AVP.fMeleeDamageImpulseStrength = 10.0
	AVP.fFatalDamageAmount = 1000000.0
	
	cvars.AddChangeCallback("vj_avp_xenostealth", function(convar_name, oldValue, newValue)
		VJ_AVP_CVAR_XENOSTEALTH = tonumber(newValue) == 1
	end)
	
	cvars.AddChangeCallback("vj_avp_flashlight", function(convar_name, oldValue, newValue)
		VJ_AVP_CVAR_FLASHLIGHT = tonumber(newValue) == 1
	end)

	local function AddPM(name, mdl, hands, skin)
		player_manager.AddValidModel(name, mdl)
		if hands then
			player_manager.AddValidHands(name, hands, 0, skin or "00000000")
		end
	end

	-- AddPM("Alex", "models/cpthazama/avp/marines/alex.mdl", "models/weapons/c_arms_cstrike.mdl")
	-- AddPM("Combat Android", "models/cpthazama/avp/marines/android.mdl", "models/weapons/c_arms_cstrike.mdl")
	-- AddPM("Cannor", "models/cpthazama/avp/marines/connor.mdl", "models/weapons/c_arms_cstrike.mdl")
	-- AddPM("Charity", "models/cpthazama/avp/marines/female_black1.mdl", "models/weapons/c_arms_cstrike.mdl")
	-- AddPM("Monica", "models/cpthazama/avp/marines/female_black2.mdl", "models/weapons/c_arms_cstrike.mdl")
	-- AddPM("Elaine", "models/cpthazama/avp/marines/female_blonde.mdl", "models/weapons/c_arms_cstrike.mdl")
	-- AddPM("Butch", "models/cpthazama/avp/marines/female_butch.mdl", "models/weapons/c_arms_cstrike.mdl")
	-- AddPM("Gibson", "models/cpthazama/avp/marines/gibson.mdl", "models/weapons/c_arms_cstrike.mdl")
	-- AddPM("Martinez", "models/cpthazama/avp/marines/hispanic.mdl", "models/weapons/c_arms_cstrike.mdl")
	-- AddPM("Johnson", "models/cpthazama/avp/marines/johnson.mdl", "models/weapons/c_arms_cstrike.mdl")
	-- AddPM("Moss", "models/cpthazama/avp/marines/moss.mdl", "models/weapons/c_arms_cstrike.mdl")
	-- AddPM("Rookie", "models/cpthazama/avp/marines/rookie.mdl", "models/weapons/c_arms_cstrike.mdl")
	-- AddPM("Security Guard", "models/cpthazama/avp/marines/security.mdl", "models/weapons/c_arms_cstrike.mdl")
	-- AddPM("Tequila", "models/cpthazama/avp/marines/tequila.mdl", "models/weapons/c_arms_cstrike.mdl")
	-- AddPM("Van Zandt", "models/cpthazama/avp/marines/vandieter.mdl", "models/weapons/c_arms_cstrike.mdl")
	-- AddPM("Thomas", "models/cpthazama/avp/marines/youngwhite.mdl", "models/weapons/c_arms_cstrike.mdl")

	VJ_AVP_PREDINFO_ENABLED = GetConVar("vj_avp_pred_info"):GetBool()
	cvars.AddChangeCallback("vj_avp_pred_info", function(convar_name, oldValue, newValue)
		VJ_AVP_PREDINFO_ENABLED = tonumber(newValue) == 1
	end)

	if SERVER then
		util.AddNetworkString("VJ_AVP_Marine_Client")
		util.AddNetworkString("VJ_AVP_Marine_Darkness")
		util.AddNetworkString("VJ_AVP_Predator_Client")
		util.AddNetworkString("VJ_AVP_Xeno_Client")
		util.AddNetworkString("VJ_AVP_Xeno_Darkness")
		util.AddNetworkString("VJ_AVP_CSound")
		util.AddNetworkString("VJ_AVP_PingTable")

		net.Receive("VJ_AVP_Marine_Darkness",function(len,pl)
			local ent = net.ReadEntity()
			local light = net.ReadFloat()
			if IsValid(ent) then
				ent.DarknessLevel = light
				ent.LastNetworkT = CurTime()
			end
		end)

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
			if !IsValid(ent) then return end
			net.Start("VJ_AVP_CSound")
				net.WriteString(snd)
				net.WriteEntity(ent)
			net.Send(ent)
		end

		function VJ_AVP_PatchRound(ply)
			if !ply:IsAdmin() then return end
			local spawner
			for _,v in pairs(ents.GetAll()) do
				if v.VJ_AVP_SurvivalSpawner then
					spawner = v
					break
				end
			end
			if IsValid(spawner) && !spawner:GetWaveSwitching() then
				spawner:ClearCurrentWave()
			end
		end
		concommand.Add("vj_avp_patchround",VJ_AVP_PatchRound)

		VJ_AVP_MAX_EGGS = 50

		local table_insert = table.insert
		local math_abs = math.abs
		local math_cos = math.cos
		local math_rad = math.rad
		local VJ_IsProp = VJ.IsProp

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
			local VJ_IsProp = VJ.IsProp

			for _, ent in pairs(entities) do
				if ent == self then continue end
				if !(ent:IsNPC() or ent:IsPlayer() or VJ_IsProp(ent) or moveEnts[ent:GetClass()]) then continue end
				if (ent:IsNPC() or ent:IsPlayer()) && (self:IsNPC() && self:CheckRelationship(ent) == D_LI or self:IsPlayer() && ent:IsNPC() && ent:Disposition(self) == D_LI) then continue end
				if self:IsNPC() && ent:IsPlayer() && VJ_CVAR_IGNOREPLAYERS then continue end
				if (ent:IsNPC() && (ent:GetMoveVelocity():Length() > 2 && ent:GetMoveVelocity():Length() or ent:GetVelocity():Length()) or ent:GetVelocity():Length()) <= 2 then continue end
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
			if self:IsNPC() && !VJ_CVAR_AI_ENABLED then return end
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
						sndPitch = 160
					else
						sndPitch = 100 +((1 -perDist) *60)
					end
					VJ.EmitSound(self,"cpthazama/avp/shared/motion_tracker_bleep_stevie.ogg",55,sndPitch)
					if self.IsVJBaseSNPC && self.CanInvestigate && self.NextInvestigationMove < CurTime() then
						if closestEnt:IsNPC() or closestEnt:IsPlayer() or closestEnt:IsNextBot() then
							if self:Visible(closestEnt) && math.random(1,3) == 1 && perDist <= 0.2 then
								self:StopMoving()
								self:SetTarget(closestEnt)
								self:SCHEDULE_FACE("TASK_FACE_TARGET")
								self.NextInvestigationMove = CurTime() +0.3
							elseif self.IsFollowing == false && math.random(1,15) == 1 && perDist <= 0.35 then
								self:SetLastPosition(closestEnt:GetPos())
								self:SCHEDULE_GOTO_POSITION("TASK_WALK_PATH")
								self.NextInvestigationMove = CurTime() +10
							end
							self:OnInvestigate(v)
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
			for _,ply in player.Iterator() do
				if ply:GetInfoNum("vj_avp_hud",0) == 1 && !ply.VJ_IsControllingNPC && ply:Alive() && !GetConVar("ai_ignoreplayers"):GetBool() && ply:GetInfoNum("vj_avp_hud_ping",1) == 1 then
					VJ_AVP_MotionTracker(ply)
				end
			end
		end)

		util.AddNetworkString("VJ.AVP.PredatorHUD.Info")

		function VJ_AVP_PredatorHUD_Transmit(target,ply)
			local data = {}
			if target.IsVJBaseSNPC_Tank then
				data.HasMelee = true
				data.MeleeDistance = 50
				data.HasRange = true
				data.RangeDistance = 4000
			elseif target.IsVJBaseSNPC_Creature then
				data.HasMelee = (target.HasMeleeAttack or target.HasLeapAttack)
				data.MeleeDistance = target.AttackDistance or target.MeleeAttackDistance
				data.HasRange = (target.CanSpit or target.HasRangeAttack)
				data.RangeDistance = target.SpitAttackDistance or (target.RangeDistance or target.RangeAttackDistance)
				if target.AttackDistance then
					data.HasMelee = true
				end
				if target.SpitAttackDistance then
					data.HasRange = true
				end
				if target.HasLeapAttack then
					data.MeleeDistance = target.LeapDistance
				end
			elseif target.IsVJBaseSNPC_Human then
				local wep = target:GetActiveWeapon()
				data.HasMelee = target.HasMeleeAttack
				data.MeleeDistance = target.MeleeAttackDistance
				data.HasRange = IsValid(wep)
				if IsValid(wep) && wep.IsVJBaseWeapon then
					data.RangeDistance = target.Weapon_FiringDistanceFar *wep.NPC_FiringDistanceScale
				else
					data.RangeDistance = target.Weapon_FiringDistanceFar
				end
			elseif target:IsPlayer() then
				local wep = target:GetActiveWeapon()
				data.HasMelee = true
				data.MeleeDistance = 50
				data.HasRange = IsValid(wep)
				data.RangeDistance = IsValid(wep) && (wep:GetHoldType() == "shotgun" && 200 or 1000) or 0
			elseif target:IsNPC() then
				local wep = target:GetActiveWeapon()
				data.HasMelee = VJ.AnimExists(target,ACT_MELEE_ATTACK1)
				data.MeleeDistance = 50
				data.HasRange = IsValid(target:GetActiveWeapon()) or VJ.AnimExists(target,ACT_RANGE_ATTACK1)
				data.RangeDistance = IsValid(wep) && 1536 or 1024
			end

			net.Start("VJ.AVP.PredatorHUD.Info")
				net.WriteEntity(target)
				net.WriteEntity(ply)
				net.WriteTable(data)
			net.Send(ply)
		end

		-- hook.Add("Think","TestHook",function()
			-- local eyeEnt = Entity(1):GetEyeTrace().Entity
			-- if IsValid(eyeEnt) && (eyeEnt:IsNPC() or eyeEnt:IsPlayer() or eyeEnt:IsNextBot()) then
			-- 	VJ_AVP_PredatorHUD_Transmit(eyeEnt,Entity(1))
			-- end
		-- end)
	else
		net.Receive("VJ.AVP.PredatorHUD.Info", function(len, ply)
			local target = net.ReadEntity()
			local ply = net.ReadEntity()
			local targetData = net.ReadTable()
			if IsValid(ply) then
				ply.VJ_AVP_PredatorHUD_TargetData = targetData
			end
		end)

		/*
			▒█▀▀█ █▀▀█ █▀▀ █▀▀▄ █▀▀█ ▀▀█▀▀ █▀▀█ █▀▀█ 　 ▒█░▒█ █░░█ █▀▀▄ 　 ▀▀█▀▀ █▀▀ █▀▀ ▀▀█▀▀ ░▀░ █▀▀▄ █▀▀▀ 
			▒█▄▄█ █▄▄▀ █▀▀ █░░█ █▄▄█ ░░█░░ █░░█ █▄▄▀ 　 ▒█▀▀█ █░░█ █░░█ 　 ░▒█░░ █▀▀ ▀▀█ ░░█░░ ▀█▀ █░░█ █░▀█ 
			▒█░░░ ▀░▀▀ ▀▀▀ ▀▀▀░ ▀░░▀ ░░▀░░ ▀▀▀▀ ▀░▀▀ 　 ▒█░▒█ ░▀▀▀ ▀▀▀░ 　 ░▒█░░ ▀▀▀ ▀▀▀ ░░▀░░ ▀▀▀ ▀░░▀ ▀▀▀▀
		*/
		/*
		local matTT_Thermal = Material("hud/cpthazama/avp/tt_thermal")
		local matTT_Thermal_Overlay = Material("hud/cpthazama/avp/tt_thermal_overlay")
		local matXenoOverlay = Material("models/cpthazama/avp/xenovision")
		local matColdOverlay = Material("hud/cpthazama/avp/tt_tech_overlay")
		local matNil = Material(" ")
		local matGradientThermal = Material("hud/cpthazama/avp/thermal_gradient.png")
		local matGradientThermal2 = Material("hud/cpthazama/avp/thermal_gradient_cold_b.png")
		local matGradientXeno = Material("hud/cpthazama/avp/grey_gradient.png")
		local matGradientTech = Material("hud/cpthazama/avp/tech_gradient.png")
		local matGradientNoMask = Material("hud/cpthazama/avp/tech_world_gradient_darker.png")
		local render_GetLightColor = render.GetLightColor
		local math_Clamp = math.Clamp

		local gDefault = {
			["$pp_colour_addr"] = 0,
			["$pp_colour_addg"] = 0,
			["$pp_colour_addb"] = 0,
			["$pp_colour_brightness"] = 0,
			["$pp_colour_contrast"] = 1,
			["$pp_colour_colour"] = 1,
			["$pp_colour_mulr"] = 0,
			["$pp_colour_mulg"] = 0,
			["$pp_colour_mulb"] = 0,
			["$pp_colour_inv"] = 0,
		}
		local tab_nomask = {
			["$pp_colour_addr"] 		= -0.5,
			["$pp_colour_addg"] 		= -0.5,
			["$pp_colour_addb"] 		= -0.5,
			["$pp_colour_brightness"] 	= .25,
			["$pp_colour_contrast"] 	= 0.2,
			["$pp_colour_colour"] 		= 2,
			["$pp_colour_mulr"] 		= 1,
			["$pp_colour_mulg"] 		= 1,
			["$pp_colour_mulb"] 		= 2,
			["$pp_colour_inv"] = 0,
		}
		local tab_thermal = {
			["$pp_colour_addr"] 		= -.5,
			["$pp_colour_addg"] 		= -.5,
			["$pp_colour_addb"] 		= -.8,
			["$pp_colour_brightness"] 	= 0.6,
			["$pp_colour_contrast"] 	= 0.12,
			["$pp_colour_colour"] 		= 1,
			["$pp_colour_mulr"] 		= 10,
			["$pp_colour_mulg"] 		= 0,
			["$pp_colour_mulb"] 		= 0,
			["$pp_colour_inv"] = 0,
		}
		local tab_thermal_new = {
			["$pp_colour_addr"] 		= -.5,
			["$pp_colour_addg"] 		= -.5,
			["$pp_colour_addb"] 		= -.8,
			["$pp_colour_brightness"] 	= 0.6,
			["$pp_colour_contrast"] 	= 0.12,
			["$pp_colour_colour"] 		= 1,
			["$pp_colour_mulr"] 		= 10,
			["$pp_colour_mulg"] 		= 0,
			["$pp_colour_mulb"] 		= 0,
			["$pp_colour_inv"] = 0,
		}
		local tab_xeno = {
			["$pp_colour_addr"] 		= .5,
			["$pp_colour_addg"] 		= .5,
			["$pp_colour_addb"] 		= .5,
			["$pp_colour_brightness"] 	= -0.9,
			["$pp_colour_contrast"] 	= -0.25,
			["$pp_colour_colour"] 		= 1,
			["$pp_colour_mulr"] 		= 0,
			["$pp_colour_mulg"] 		= 10,
			["$pp_colour_mulb"] 		= 0,
			["$pp_colour_inv"] = 0,
		}
		local tab_tech = {
			["$pp_colour_addr"] 		= -.5,
			["$pp_colour_addg"] 		= -.5,
			["$pp_colour_addb"] 		= -.5,
			["$pp_colour_brightness"] 	= 0.6,
			["$pp_colour_contrast"] 	= 0.12,
			["$pp_colour_colour"] 		= 1,
			["$pp_colour_mulr"] 		= 10,
			["$pp_colour_mulg"] 		= 0,
			["$pp_colour_mulb"] 		= 0,
			["$pp_colour_inv"] = 0,
		}

		local visionMode = 0
		hook.Add("RenderScreenspaceEffects","VJ_AVP_Predator_Vision",function()
			local mode = visionMode
			local ent = Entity(1)
			local ply = ent
			local cont = ent

			if mode != ent.PreviousVisionMode then
				DrawColorModify(gDefault)
				DrawBloom(0.65,1,4,4,4,2,255,255,255)
				DrawTexturize(0,matNil)
				ent.PreviousVisionMode = mode
				ply:ScreenFade(SCREENFADE.IN,mode == 1 && Color(255,255,0,128) or mode == 2 && Color(0,52,53) or mode == 3 && Color(8,86,41) or Color(124,0,0),0.3,0)
			end

			local lightLevel = math_Clamp(render_GetLightColor(ent:GetPos() +ent:OBBCenter()):Length(),0,1)
			local isDark = lightLevel <= 0.1
			ent.AVP_LastDark = ent.AVP_LastDark or isDark
			ent.AVP_LastDarkT = ent.AVP_LastDarkT or 0
			if mode > 0 && isDark != ent.AVP_LastDark && CurTime() > ent.AVP_LastDarkT then
				ply:EmitSound("cpthazama/avp/predator/vision/prd_vision_adjust" .. math.random(1,4) .. ".ogg",0,mode == 1 && math.random(95,110) or mode == 2 && math.random(115,125) or mode == 3 && math.random(75,90))
				ply:ScreenFade(SCREENFADE.IN,mode == 1 && Color(106,0,91,128) or mode == 2 && Color(0,0,0) or mode == 3 && Color(64,117,126) or Color(124,0,0),0.3,0)
				ent.AVP_LastDark = isDark
				ent.AVP_LastDarkT = CurTime() +1.5
			end

			tab_thermal["$pp_colour_brightness"] = Lerp(FrameTime() *2,tab_thermal["$pp_colour_brightness"],(1 -lightLevel) *0.72)
			tab_thermal["$pp_colour_contrast"] = Lerp(FrameTime() *2,tab_thermal["$pp_colour_contrast"],math_Clamp((1 -lightLevel) *0.14,0.07,0.15))

			tab_xeno["$pp_colour_brightness"] = Lerp(FrameTime() *2,tab_xeno["$pp_colour_brightness"],math_Clamp(lightLevel *-1.3,-1.2,-0.8))
			tab_xeno["$pp_colour_contrast"] = Lerp(FrameTime() *2,tab_xeno["$pp_colour_contrast"],math_Clamp((1 -lightLevel) *-0.2,-0.35,-0.2))

			tab_tech["$pp_colour_brightness"] = Lerp(FrameTime() *2,tab_tech["$pp_colour_brightness"],math_Clamp((1 -lightLevel) *0.9,0.85,1.3))
			tab_tech["$pp_colour_contrast"] = Lerp(FrameTime() *2,tab_tech["$pp_colour_contrast"],math_Clamp((1 -lightLevel) *0.2,0.025,0.15))

			tab_nomask["$pp_colour_brightness"] = Lerp(FrameTime() *2,tab_nomask["$pp_colour_brightness"],math_Clamp((1 -lightLevel) *0.9,0.6,1))

			if mode > 0 then
				local dLight = DynamicLight(ent:EntIndex())
				if dLight then
					dLight.Pos = ent:GetPos() +ent:OBBCenter()
					dLight.r = 5
					dLight.g = 5
					dLight.b = 5
					dLight.Brightness = 1
					dLight.Size = 4000
					dLight.Decay = 0
					dLight.DieTime = CurTime() +0.2
					dLight.Style = 0
				end
				DrawMotionBlur(0.4,0.8,0.015)
				if mode == 1 then
					-- DrawColorModify(tab_thermal)
					DrawBloom(0,1,1,1,0,-10,0.6,0.6,0.6)
					DrawTexturize(10,matGradientThermal2)
				elseif mode == 2 then
					DrawColorModify(tab_xeno)
					DrawBloom(0,0.5,1,1,0,0,10,10,10)
					DrawTexturize(10,matGradientXeno)
				elseif mode == 3 then
					DrawColorModify(tab_tech)
					DrawBloom(0,0.5,1,1,0,0,10,10,10)
					DrawTexturize(10,matGradientTech)
				end
				for _,v in ents.Iterator() do
					if mode == 1 then
						if v:IsNPC() or v:IsPlayer() or v:IsNextBot() then
							if v:GetNoDraw() == true or v:IsFlagSet(FL_NOTARGET) == true or v.IsVJBaseBullseye or (v:GetNW2Bool("AVP.IsTech",false) or v.VJ_AVP_IsTech) or (v.VJ_AVP_Xenomorph or v:GetNW2Bool("AVP.Xenomorph",false)) then continue end
							cam.Start3D(EyePos(),EyeAngles())
								if util.IsValidModel(v:GetModel()) then
									render.ClearStencil()
									render.SetStencilEnable(true)
									render.SetStencilWriteMask(255)
									render.SetStencilTestMask(255)
									render.SetStencilReferenceValue(1)
									render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_ALWAYS)
									render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
									render.SetStencilFailOperation(STENCILOPERATION_KEEP)
									render.SetStencilZFailOperation(STENCILOPERATION_KEEP)
									v:DrawModel()
									render.SuppressEngineLighting(true)
									if v.VJ_AVP_Predator && v:GetCloaked() then
										render.MaterialOverride(matTT_Thermal)
									end
									render.SetColorModulation(1.65,1.65,1.65)
									render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)
									render.SetStencilPassOperation(STENCILOPERATION_KEEP)
									v:DrawModel()
									if !(v.VJ_AVP_Predator && v:GetCloaked()) then
										DrawMotionBlur(1,0.15,1)
										DrawBloom(0,1,1,1,1,2,1,0.8,0.8)
										DrawTexturize(0,matGradientThermal)
									end
									render.SetColorModulation(1,1,1)
									render.MaterialOverride(0)
									render.SuppressEngineLighting(false)
									render.SetStencilEnable(false)

									-- render.OverrideDepthEnable(true,false)
									-- render.SetLightingMode(2)
									-- render.SetColorModulation(2,0,0)
									-- if v.VJ_AVP_Predator && v:GetCloaked() then
									-- 	render.MaterialOverride(matTT_Thermal)
									-- end
									-- v:DrawModel()
									-- render.SetColorModulation(1,1,1)
									-- render.MaterialOverride(0)
									-- render.SetLightingMode(0)
									-- render.OverrideDepthEnable(false,false)
									-- for _,x in pairs(v:GetChildren()) do
									-- 	if IsValid(x) then
									-- 		local mdl = x:GetModel()
									-- 		if mdl && util.IsValidModel(mdl) then
									-- 			render.OverrideDepthEnable(true,false)
									-- 			render.SetLightingMode(2)
									-- 			render.SetColorModulation(2,0,0)
									-- 			if v.VJ_AVP_Predator && v:GetCloaked() then
									-- 				render.MaterialOverride(matTT_Thermal)
									-- 			end
									-- 			x:DrawModel()
									-- 			render.SetColorModulation(1,1,1)
									-- 			render.MaterialOverride(0)
									-- 			render.SetLightingMode(0)
									-- 			render.OverrideDepthEnable(false,false)
									-- 		end
									-- 	end
									-- end
								end
							cam.End3D()
						end

					elseif mode == 2 && (v.VJ_AVP_Xenomorph or v:GetNW2Bool("AVP.Xenomorph",false)) && v:IsNPC() then
						cam.Start3D(EyePos(),EyeAngles())
							if util.IsValidModel(v:GetModel()) then
								render.OverrideDepthEnable(true,false)
								render.SetLightingMode(2)
								-- render.MaterialOverride(matXenoOverlay)
								v:DrawModel()
								-- render.MaterialOverride(0)
								render.SetLightingMode(0)
								render.OverrideDepthEnable(false,false)
							end
						cam.End3D()
					elseif mode == 3 && (v:GetNW2Bool("AVP.IsTech",false) or v.VJ_AVP_IsTech) then
						cam.Start3D(EyePos(),EyeAngles())
							if util.IsValidModel(v:GetModel()) then
								render.OverrideDepthEnable(true,false)
								render.SetLightingMode(2)
								render.SetBlend(1)
								render.MaterialOverride(matColdOverlay)
								v:DrawModel()
								render.OverrideDepthEnable(false,false)
								render.SetLightingMode(0)
								render.MaterialOverride(0)
								render.SetBlend(1)
							end
						cam.End3D()
					end
				end
				if IsValid(cont) then
					cont:SetDSP(31)
				end
			end
			if mode == 0 then
				if IsValid(cont) then
					cont:SetDSP(1)
				end
			end
		end)
		*/

		/*
			▒█▀▀▀ █▀▀▄ █▀▀▄ 
			▒█▀▀▀ █░░█ █░░█ 
			▒█▄▄▄ ▀░░▀ ▀▀▀░
		*/

		net.Receive("VJ_AVP_CSound",function(len,pl)
			local sound = net.ReadString()
			local ent = net.ReadEntity()

			ent:EmitSound(sound,0)
			-- print("Playing sound " .. sound .. " on " .. ent:Nick())
		end)

		hook.Add("PlayerBindPress","VJ.AVP.BindPressFix",function(ply,bind,pressed)
			if ply.VJ_IsControllingNPC == true && IsValid(ply.VJCE_NPC) && ply.VJCE_NPC.VJ_AVP_NPC then
				if bind == "invprev" or bind == "invnext" then
					return true
				end
			end
		end)

		hook.Add("CalcViewModelView","VJ_AVP_ViewModel",function(wep,vm,opos,oang,pos,ang)
			local ply = LocalPlayer()
			if IsValid(ply) then
				local possessing = ply.VJCE_NPC
				if ply.VJ_IsControllingNPC && IsValid(possessing) && (possessing.VJ_AVP_Predator or possessing.VJ_AVP_Xenomorph) && possessing.VJ_AVP_ViewModelData then
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

					if possessing.VJ_AVP_Xenomorph then
						origin = origin +angles:Forward() *-25
					end

					ply.VJ_AVP_ViewModelCalcData = {origin,angles}
		
					return origin, angles
				end
			end
		end)
		
		hook.Add("PreDrawViewModel","VJ_AVP_ViewModel",function(vm,ply)
			local possessing = ply.VJCE_NPC
			if ply.VJ_IsControllingNPC && IsValid(possessing) && (possessing.VJ_AVP_Predator or possessing.VJ_AVP_Xenomorph) then
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

		surface.CreateFont("VJFont_AVP_MarinePing", {
			font = "Orbitron Regular",
			size = 23,
			weight = 600,
			blursize = 1,
			antialias = true,
			italic = false,
		})
	end

	VJ.AddParticle("particles/vj_avp_blood.pcf",{
		"vj_avp_blood_predator",
		"vj_avp_blood_xeno",
		"vj_avp_blood_xeno_damage",
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
	-- VJ.AddParticle("particles/vj_avp_ins_muzzle.pcf",{
	-- 	"vj_avp_wep_rifle_muzzle",
	-- })
	VJ.AddParticle("particles/vj_avp_muzzle.pcf",{
		"vj_avp_muzzle_main",
		"vj_avp_muzzle_big_main",
		"vj_avp_muzzle_big_main_2",
		"vj_avp_muzzle_sg_main",
		"vj_avp_muzzle_lmg_main",
		"vj_avp_muzzle_ft",
	})
	VJ.AddParticle("particles/vj_avp_bloodpool.pcf",{
		"vj_avp_bloodpool_predator",
		"vj_avp_bloodpool_xeno",
		"vj_avp_bloodpool_xeno_small",
	})
	VJ.AddParticle("particles/vj_avp_xenomorph_spill.pcf",{
		"vj_avp_xenomorph_spill",
	})
	VJ.AddParticle("particles/vj_avp_flamethrower.pcf",{
		"vj_avp_flamethrower",
	})
	VJ.AddParticle("particles/vj_avp_flare.pcf",{
		"vj_avp_flare",
	})
	VJ.AddParticle("particles/vj_avp_speargun.pcf",{
		"vj_avp_pred_speargun_tracer",
	})
	VJ.AddParticle("particles/vj_avp_tracer.pcf",{
		"vj_avp_tracer",
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
	AddWep("M41A Pulse Rifle","weapon_vj_avp_pulserifle")
	AddWep("M42C Scoped Rifle","weapon_vj_avp_scopedrifle")
	AddWep("M56 Smartgun","weapon_vj_avp_smartgun")
	AddWep("M260B Flamethrower","weapon_vj_avp_flamethrower")
	AddWep("ZX-76 Shotgun","weapon_vj_avp_shotgun")

	if CLIENT then
		hook.Add("PopulateToolMenu", "VJ_ADDTOMENU_AVP", function()
			spawnmenu.AddToolMenuOption("DrVrej", "SNPC Configures", "Aliens vs Predator", "Aliens vs Predator", "", "", function(Panel)
				-- local vj_icon = vgui.Create("DImage")
				-- vj_icon:SetSize(512,60)
				-- vj_icon:SetImage("vgui/avp/spacer.png")
				-- Panel:AddPanel(vj_icon)

				-- local vj_button = vgui.Create("DButton")
				-- vj_button:SetSize(512,30)
				-- vj_button:SetText("Open Aliens vs Predator Configurations")
				-- vj_button.DoClick = function(vj_button)
				-- 	RunConsoleCommand("vj.avp.menu")
				-- end
				-- Panel:AddPanel(vj_button)
				local vj_icon = vgui.Create("DImage")
				vj_icon:SetSize(512,60)
				vj_icon:SetImage("vgui/avp/spacer.png")
				Panel:AddPanel(vj_icon)
				Panel:AddControl("Label", {Text = "General Settings"})
				Panel:AddControl("Checkbox", {Label = "Enable Fatalities", Command = "vj_avp_fatalities"})
				Panel:AddControl("Checkbox", {Label = "Enable Ambience Music [Survival]", Command = "vj_avp_survival_music"})
				Panel:AddControl("Checkbox", {Label = "Enable Bots [Survival]", Command = "vj_avp_survival_bots"})
				Panel:AddControl("Slider", {Label = "Bot Count (0 = Auto) [Survival]", min = 0, max = 8, Command = "vj_avp_survival_maxbots"})
				Panel:AddControl("Checkbox", {Label = "Use VJ Players As Bots", Command = "vj_avp_survival_plybots"})
				-- Panel:AddControl("Checkbox", {Label = "Respawn as Xenomorphs [Survival]", Command = "vj_avp_survival_respawn"})
				Panel:AddControl("Checkbox", {Label = "Enable Marine HUD", Command = "vj_avp_hud"})
				Panel:AddControl("Checkbox", {Label = "Enable Marine HUD Pinging", Command = "vj_avp_hud_ping"})

				local vj_icon = vgui.Create("DImage")
				vj_icon:SetSize(512,130)
				vj_icon:SetImage("vgui/avp/faction_alien.png")
				Panel:AddPanel(vj_icon)
				Panel:AddControl("Label", {Text = "Xenomorph Settings"})
				Panel:AddControl("Checkbox", {Label = "Enable Boss Themes", Command = "vj_avp_bosstheme_a"})
				Panel:AddControl("Checkbox", {Label = "Enable Xenomorph Stealth", Command = "vj_avp_xenostealth"})
				Panel:AddControl("Label", {Text = "Note: Due to the way this code is handled, it is quite taxing on the game. Disable if you experience performance issues."})
				Panel:AddControl("Checkbox", {Label = "Successful K-Series Experiment", Command = "vj_avp_kseries_ally"})
				Panel:AddControl("Label", {Text = "Note: This will make K-Series Xenomorphs friendly to Weyland-Yutani forces."})

				local vj_icon = vgui.Create("DImage")
				vj_icon:SetSize(512,130)
				vj_icon:SetImage("vgui/avp/faction_predator.png")
				Panel:AddPanel(vj_icon)
				Panel:AddControl("Label", {Text = "Predator Settings"})
				Panel:AddControl("Checkbox", {Label = "Enable Boss Themes", Command = "vj_avp_bosstheme_p"})
				Panel:AddControl("Checkbox", {Label = "Enable Unique Spawns", Command = "vj_avp_predmobile"})
				Panel:AddControl("Checkbox", {Label = "Enable Predator HUD Info Display", Command = "vj_avp_hud_predinfo"})
				if LocalPlayer():IsAdmin() then
					Panel:AddControl("Checkbox", {Label = "Toggle Predator HUD Info Code", Command = "vj_avp_pred_info"})
					Panel:AddControl("Label", {Text = "Admin Only - Disables the background code for the info display. WILL BREAK THE HUD IN MOST INSTANCES!"})
				end

				local vj_icon = vgui.Create("DImage")
				vj_icon:SetSize(512,130)
				vj_icon:SetImage("vgui/avp/faction_marine.png")
				Panel:AddPanel(vj_icon)
				Panel:AddControl("Label", {Text = "Human Settings"})
				Panel:AddControl("Checkbox", {Label = "Enable Boss Themes", Command = "vj_avp_bosstheme_m"})
				Panel:AddControl("Checkbox", {Label = "Enable Dynamic Flashlights", Command = "vj_avp_flashlight"})
				Panel:AddControl("Label", {Text = "Note: Due to the way this code is handled, it is quite taxing on the game. Disable if you experience performance issues."})
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
	VJ_AVP_HALOS.Equipment = {}
	VJ_AVP_HALOS.Links = {}
	VJ_AVP_HALOS.Other = {}
	VJ_AVP_HALOS.Survival = {}
	VJ_AVP_HALOS.Hunt = {}
	VJ_AVP_FATALITIES = GetConVar("vj_avp_fatalities"):GetBool()

	VJ_AVP_XENOS = {}

	VJ_AVP_HuntData = {}
	VJ_AVP_HuntData["rp_lepointe"] = {}
	VJ_AVP_HuntData["rp_lepointe"].InsurgentPoints = {
		Vector(-5683.274902,3742.371094,-910.522156),
		Vector(-2608.353516,1084.985352,-911.968750),
		Vector(-5116.766602,9245.182617,-911.968750),
		Vector(-13327.970703,13104.601563,-919.058838),
	}
	VJ_AVP_HuntData["rp_lepointe"].PlayerSpawn = {
		Vector(10494.035156,-9662.649414,-905.983398),
		Vector(10602.247070,-9027.605469,-918.429871),
		Vector(11100.815430,-9248.292969,-917.242249),
		Vector(9656.352539 -9142.073242 -918.925842),
	}
	VJ_AVP_HuntData["rp_lepointe"].PredatorSpawn = {
		{Pos=Vector(12768.645508,3885.821045,-911.361511),Ang=Angle(0,180,0)},
	}
	VJ_AVP_HuntData["rp_lepointe"].DataSpawn = {
		Vector(-8980.079102,-733.879395,-911.968750),
		Vector(-6135.881348,9411.145508,-911.968750),
		Vector(-5422.528320,2866.659668,-887.968750),
		Vector(-14322.620117,11262.540039,-903.968750),
	}
	VJ_AVP_HuntData["rp_lepointe"].Extract = Vector(-9588.245117,10821.127930,-903.968750)

	VJ_AVP_HuntData["rp_junglestorm"] = {}
	VJ_AVP_HuntData["rp_junglestorm"].InsurgentPoints = {
		Vector(487.13714599609,2074.6950683594,-2314.837890625),
		Vector(8884.072265625,-11332.016601563,-2188.2509765625),
		Vector(10849.030273438,8609.111328125,-1882.3703613281),
		Vector(-12244.125976563,-7391.2963867188,-2143.96875),
	}
	VJ_AVP_HuntData["rp_junglestorm"].PlayerSpawn = {
		Vector(-9808.32421875,6838.4819335938,-2192.0302734375),
		Vector(-9446.3408203125,7008.17578125,-2192.0290527344),
		Vector(-9192.1904296875,7194.3564453125,-2192.2392578125),
		Vector(-8807.248046875,6954.3217773438,-2193.3195800781),
		Vector(-9176.6474609375,6614.1264648438,-2192.0163574219),
		Vector(-9477.8896484375,6568.7114257813,-2192.0378417969),
	}
	VJ_AVP_HuntData["rp_junglestorm"].PredatorSpawn = {
		{Pos=Vector(-639.00665283203,-4364.73828125,-1446.9732666016),Ang=Angle(0,-121.27067565918,0)},
	}
	VJ_AVP_HuntData["rp_junglestorm"].DataSpawn = {
		Vector(135.97930908203,2385.345703125,-2314.150390625),
		Vector(10942.595703125,8868.599609375,-1887.6782226563),
		Vector(7407.7729492188,-11982.147460938,-2192),
		Vector(-12125.806640625,-7562.3076171875,-1967.96875),
	}
	VJ_AVP_HuntData["rp_junglestorm"].Extract = Vector(-10872.010742188,-9664.9306640625,-2191.8171386719)

	function VJ_AVP_GrabHuntData(dataType) // 1 = Insurgent Points, 2 = Player Spawn, 3 = Predator Spawn, 4 = Data Spawn, 5 = Extract
		local map = game.GetMap()
		local ply = Entity(1)
		local tr = ply:GetEyeTrace()
		local dataType = dataType or 0

		if dataType == 1 then
			print('VJ_AVP_HuntData["' .. map .. '"].InsurgentPoints = {')
			print("	Vector(" .. tr.HitPos.x .. "," .. tr.HitPos.y .. "," .. tr.HitPos.z .. "),")
			print("}")
		elseif dataType == 2 then
			print('VJ_AVP_HuntData["' .. map .. '"].PlayerSpawn = {')
			print("	Vector(" .. tr.HitPos.x .. "," .. tr.HitPos.y .. "," .. tr.HitPos.z .. "),")
			print("}")
		elseif dataType == 3 then
			local ang = ply:GetAngles()
			print('VJ_AVP_HuntData["' .. map .. '"].PredatorSpawn = {')
			print("	{Pos=Vector(" .. tr.HitPos.x .. "," .. tr.HitPos.y .. "," .. tr.HitPos.z .. "),Ang=Angle(0," .. -ang.y .. ",0)},")
			print("}")
		elseif dataType == 4 then
			print('VJ_AVP_HuntData["' .. map .. '"].DataSpawn = {')
			print("	Vector(" .. tr.HitPos.x .. "," .. tr.HitPos.y .. "," .. tr.HitPos.z .. "),")
			print("}")
		elseif dataType == 5 then
			print('VJ_AVP_HuntData["' .. map .. '"].Extract = Vector(' .. tr.HitPos.x .. "," .. tr.HitPos.y .. "," .. tr.HitPos.z .. ")")
		else
			print("Vector(" .. tr.HitPos.x .. "," .. tr.HitPos.y .. "," .. tr.HitPos.z .. "),")
		end
	end

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
		local vecZ30 = Vector(0, 0, 100)
		local vecZ1 = Vector(0, 0, 1)
		local math_abs = math.abs
		--
		function VJ_AVP_XenoBloodSpill(self,corpse,force,forceData)
			if !IsValid(corpse) && !force then return end
			local faction = forceData && forceData.Class or self.VJ_NPC_Class

			local function CheckFaction(v)
				local vFaction = v.VJ_NPC_Class
				if !vFaction then return false end

				for _,myFac in ipairs(faction) do
					if VJ.HasValue(vFaction,myFac) then
						return true
					end
				end
				return false
			end

			if force then
				local pos = forceData.Pos
				local tr = util.TraceLine({
					start = pos,
					endpos = pos -vecZ30,
					filter = self,
					mask = CONTENTS_SOLID
				})
				if tr.HitWorld then
					local dmgPos = tr.HitPos +tr.HitNormal *4
					if forceData.Pos then
						sound.Play("cpthazama/avp/xeno/alien/blood/alien_blood_10s_0" .. math.random(1,4) .. ".ogg",forceData.Pos,70)
					else
						VJ.EmitSound(self,"cpthazama/avp/xeno/alien/blood/alien_blood_10s_0" .. math.random(1,4) .. ".ogg",70)
					end
					ParticleEffect("vj_avp_xenomorph_spill",tr.HitPos +tr.HitNormal *2,Angle())
					for i = 1,20 do
						timer.Simple(i *0.25,function()
							sound.EmitHint(SOUND_DANGER, dmgPos, 200, 0.24)

							for _,v in pairs(ents.FindInSphere(dmgPos,100)) do
								if ((v:IsPlayer() && !VJ_CVAR_IGNOREPLAYERS && v:Alive()) or (v:IsNPC() && !v.VJ_AVP_Xenomorph && v:Health() > 0 && CheckFaction(v) == false) or v:IsNextBot()) && !v:IsFlagSet(FL_NOTARGET) && math_abs(v:GetPos().z -dmgPos.z) <= 40 then
									local dmg = DamageInfo()
									dmg:SetDamage(2)
									dmg:SetDamageType(DMG_ACID)
									dmg:SetAttacker(v)
									dmg:SetInflictor(v)
									dmg:SetDamagePosition(v:NearestPoint(dmgPos))
									v:TakeDamageInfo(dmg)
								end
							end
						end)
					end
				end
				return
			end
			timer.Simple(2.75, function()
				if IsValid(corpse) then
					local pos = corpse:GetPos() +corpse:OBBCenter()
					local tr = util.TraceLine({
						start = pos,
						endpos = pos -vecZ30,
						filter = corpse,
						mask = CONTENTS_SOLID
					})
					if tr.HitWorld then
						local dmgPos = tr.HitPos +tr.HitNormal *4
						VJ.EmitSound(corpse,"cpthazama/avp/xeno/alien/blood/alien_blood_10s_0" .. math.random(1,4) .. ".ogg",70)
						ParticleEffect("vj_avp_xenomorph_spill",tr.HitPos +tr.HitNormal *2,Angle())
						for i = 1,20 do
							timer.Simple(i *0.25,function()
								if !IsValid(corpse) then return end

								sound.EmitHint(SOUND_DANGER, dmgPos, 200, 0.24, corpse)

								for _,v in pairs(ents.FindInSphere(dmgPos,100)) do
									if ((v:IsPlayer() && !VJ_CVAR_IGNOREPLAYERS && v:Alive()) or (v:IsNPC() && !v.VJ_AVP_Xenomorph && v:Health() > 0 && CheckFaction(v) == false) or v:IsNextBot()) && !v:IsFlagSet(FL_NOTARGET) then
										local dmg = DamageInfo()
										dmg:SetDamage(2)
										dmg:SetDamageType(DMG_ACID)
										dmg:SetAttacker(v)
										dmg:SetInflictor(v)
										dmg:SetDamagePosition(v:NearestPoint(dmgPos))
										v:TakeDamageInfo(dmg)
									end
								end
							end)
						end
					end
				end
			end)
		end

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

		function VJ_AVP_GetPraetorianCount()
			local count = 0
			for _,v in ipairs(VJ_AVP_XENOS) do
				if v.VJ_AVP_XenomorphPraetorian then
					count = count +1
				end
			end
			return count
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
				if (v.IsVJBaseBullseye && v.VJ_IsBeingControlled) or v.VJ_IsControllingNPC then continue end -- Don't damage bulleyes used by the NPC controller OR entities that are controlling others (Usually players)
				local nearestPos = startPos == attacker:GetPos() && attacker:GetNearestPositions(v) or v:NearestPoint(startPos) -- From the enemy position to the given position
				-- local nearestPos = v:NearestPoint(startPos) -- From the enemy position to the given position
				if realisticRadius != false then -- Decrease damage from the nearest point all the way to the enemy point then clamp it!
					dmgFinal = math_clamp(dmgFinal * ((dmgRadius - startPos:Distance(nearestPos)) + 150) / dmgRadius, dmgMax / 2, dmgFinal)
				end
				
				if (disableVisibilityCheck == false && (v:VisibleVec(startPos) or v:Visible(attacker))) or (disableVisibilityCheck == true) then
					local function DealDamage()
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
							local force = baseForce or math_clamp(dmgFinal, 5, 35)
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
								if baseForce != false then
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
						if extraOptions.DamageAttacker then DealDamage() end -- If it can't self hit, then skip
					-- Other entities
					elseif (ignoreInnocents == false) or (!v:IsNPC() && !v:IsPlayer()) or (v:IsNPC() && v:GetClass() != attacker:GetClass() && v:Health() > 0 && (attacker:IsPlayer() or (attacker:IsNPC() && attacker:Disposition(v) != D_LI))) or (v:IsPlayer() && v:Alive() && (attacker:IsPlayer() or (!VJ_CVAR_IGNOREPLAYERS && !v:IsFlagSet(FL_NOTARGET)))) then
						DealDamage()
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
							if (isCombine && ent.IsVJBaseSNPC_Human && ent.VJ_ID_Police != true) or (isCombine && !ent.IsVJBaseSNPC_Human) or ent.VJ_ID_Vehicle == true or (mat == MAT_METAL or mat == MAT_GLASS) then
								ent:SetNW2Bool("AVP.IsTech",true)
								ent.VJ_AVP_IsTech = true
							end
						end
					end
				end)
			end
		end)

		util.AddNetworkString("VJ.AVP.PlayerHUDDamage")
		util.AddNetworkString("VJ.AVP.XenoEat")
		hook.Add("EntityTakeDamage","VJ_AVP_MarinePlayer_HUD",function(ent,dmginfo)
			if (ent:IsPlayer() or (ent:IsNPC() && ent.VJ_AVP_NPC && ent.VJ_IsBeingControlled)) && math.random(1,dmginfo:IsBulletDamage() && 5 or 2) == 1 then
				local dmg = tonumber(dmginfo:GetDamage())
				net.Start("VJ.AVP.PlayerHUDDamage")
					net.WriteInt(dmg,16)
				net.Send(ent:IsNPC() && ent.VJ_TheController or ent)
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
					if VJ.HasValue(VJ_AVP_PMV["Tech"],ent:GetModel()) then
						ent:SetNW2Bool("AVP.IsTech",true)
						ent.VJ_AVP_IsTech = true
					-- elseif VJ_AVP_PMV["Xeno"][ent:GetModel()] then
						-- ent:SetNW2Bool("AVP.Xenomorph",true)
						-- ent.VJ_AVP_Xenomorph = true
					else
						ent:SetNW2Bool("AVP.IsTech",false)
						ent.VJ_AVP_IsTech = false
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