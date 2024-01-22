AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.StartHealth = 100

ENT.VJC_Data = {
    CameraMode = 2,
    ThirdP_Offset = Vector(0, 0, -35),
    FirstP_Bone = "Bip01 Head",
    FirstP_Offset = Vector(4, 0, 1.5),
}

ENT.BloodColor = "Red"

ENT.VJ_NPC_Class = {"CLASS_PLAYER_ALLY"}
ENT.FriendsWithAllPlayerAllies = true

ENT.HasMeleeAttack = true

ENT.HasFlashlight = true
ENT.HasMotionTracker = true
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GenderInit(gender)
	return "models/cpthazama/avp/marines/alex.mdl"
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPreInitialize()
	-- self.Gender = self.Gender or 1 // math.random(1,2)
	self.Model = self:GenderInit(self.Gender)

	if self.VJ_AVP_IsTech then
		self:SynthInitialize()
	elseif self.VJ_AVP_Colonist then
		self:ColonistInitialize()
	else
		self:MarineInitialize(self.Gender)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MarineInitialize(gender)
	local VO = self.VO or 1
	if gender == 1 then
		if VO == 1 then
			self.SoundTbl_LostEnemy = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/AGGRESSIVE_TO_ALERT_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/AGGRESSIVE_TO_ALERT_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/AGGRESSIVE_TO_ALERT_MAR01_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/AGGRESSIVE_TO_ALERT_MAR01_04.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/AGGRESSIVE_TO_ALERT_MAR01_05.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/AGGRESSIVE_TO_ALERT_MAR01_08.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/AGGRESSIVE_TO_ALERT_MAR01_10.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/ALERT_TO_PASSIVE_MAR01_04.ogg",
			}
			self.SoundTbl_Alert = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/ATTACKING_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/ATTACKING_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/ATTACKING_MAR01_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/ATTACKING_MAR01_04.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/ATTACKING_MAR01_05.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/ATTACKING_MAR01_06.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/ATTACKING_MAR01_08.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/ATTACKING_MAR01_09.ogg",
			}
			self.SoundTbl_Death = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/DEATH_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/DEATH_MAR01_02.ogg",
			}
			self.SoundTbl_SeeBody = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/DISCOVER_BODY_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/DISCOVER_BODY_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/DISCOVER_BODY_MAR01_03.ogg",
			}
			self.SoundTbl_DistractionSuccess = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/DISTRACTION_SUCCESS_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/DISTRACTION_SUCCESS_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/DISTRACTION_SUCCESS_MAR01_03.ogg",
			}
			self.SoundTbl_Suppressing = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/ENTERING_COVER_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/ENTERING_COVER_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/ENTERING_COVER_MAR01_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/ENTERING_COVER_MAR01_04.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/ENTERING_COVER_MAR01_05.ogg",
			}
			self.SoundTbl_OnReceiveOrder = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/FLANKING_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/FLANKING_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/FLANKING_MAR01_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/FLANKING_MAR01_04.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/FLANKING_MAR01_05.ogg",
			}
			self.SoundTbl_DamageByPlayer = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/FRIENDLY_FIRE_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/FRIENDLY_FIRE_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/FRIENDLY_FIRE_MAR01_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/FRIENDLY_FIRE_MAR01_04.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/FRIENDLY_FIRE_MAR01_05.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/FRIENDLY_FIRE_MAR01_06.ogg",
			}
			self.SoundTbl_InvestigateComplete = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/INVESTIGATE_ARRIVAL_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/INVESTIGATE_ARRIVAL_MAR01_04.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/INVESTIGATE_END_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/INVESTIGATE_END_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/INVESTIGATE_END_MAR01_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/INVESTIGATE_END_MAR01_04.ogg",
			}
			self.SoundTbl_OnKilledEnemy = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/KILLED_THREAT_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/KILLED_THREAT_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/KILLED_THREAT_MAR01_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/KILLED_THREAT_MAR01_04.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/KILLED_THREAT_MAR01_05.ogg",
			}
			self.SoundTbl_MotionTracker_Far = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/MOTION_TRACK_FAR_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/MOTION_TRACK_FAR_MAR01_02.ogg",
			}
			self.SoundTbl_MotionTracker_Mid = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/MOTION_TRACK_MID_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/MOTION_TRACK_MID_MAR01_02.ogg",
			}
			self.SoundTbl_MotionTracker_Close = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/MOTION_TRACK_NEAR_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/MOTION_TRACK_NEAR_MAR01_02.ogg",
			}
			self.SoundTbl_Pain = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/PAIN_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/PAIN_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/pain_mm01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/pain_mm01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/pain_mm01_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/pain_mm01_04.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/pain_mm01_05.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/pain_mar01_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/pain_mar01_04.ogg",
			}
			self.SoundTbl_Investigate = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/PASSIVE_TO_ALERT_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/PASSIVE_TO_ALERT_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/PASSIVE_TO_ALERT_MAR01_03.ogg",
			}
			self.SoundTbl_WeaponReload = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/RELOADING_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/RELOADING_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/RELOADING_MAR01_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/RELOADING_MAR01_05.ogg",
			}
			self.SoundTbl_Spot_XenoLarge = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_ALIEN_LARGE_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_ALIEN_LARGE_MAR01_02.ogg",
			}
			self.SoundTbl_Spot_Xeno = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_ALIEN_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_ALIEN_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_ALIEN_MAR01_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_ALIEN_MAR01_04.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_ALIEN_MAR01_05.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_ALIEN_MAR01_06.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_ALIEN_MAR01_07.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_ALIEN_MAR01_08.ogg",
			}
			self.SoundTbl_Spot_Android = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_ANDROID_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_ANDROID_MAR01_02.ogg",
			}
			self.SoundTbl_Spot_PredatorCloaked = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_CLOAKED_PREDATOR_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_CLOAKED_PREDATOR_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_CLOAKED_PREDATOR_MAR01_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_CLOAKED_PREDATOR_MAR01_04.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_CLOAKED_PREDATOR_MAR01_05.ogg",
			}
			self.SoundTbl_Spot_Predator = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_PREDATOR_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_PREDATOR_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_PREDATOR_MAR01_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_PREDATOR_MAR01_04.ogg",
			}
			self.SoundTbl_AllyDeath_Xeno = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/SQUAD_DEATH_BY_ALIEN_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SQUAD_DEATH_BY_ALIEN_MAR01_02.ogg",
			}
			self.SoundTbl_AllyDeath_Android = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/SQUAD_DEATH_BY_ANDROID_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SQUAD_DEATH_BY_ANDROID_MAR01_02.ogg",
			}
			self.SoundTbl_AllyDeath_Predator = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/SQUAD_DEATH_BY_PREDATOR_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SQUAD_DEATH_BY_PREDATOR_MAR01_02.ogg",
			}
			self.SoundTbl_AllyDeath = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/SQUAD_DEATH_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SQUAD_DEATH_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SQUAD_DEATH_MAR01_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SQUAD_DEATH_MAR01_04.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SQUAD_DEATH_MAR01_05.ogg",
			}
			self.SoundTbl_Surprised = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/SURPRISE_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SURPRISE_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SURPRISE_MAR01_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SURPRISE_MAR01_04.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SURPRISE_MAR01_05.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SURPRISE_MAR01_06.ogg",
			}
			self.SoundTbl_Alert_Horde = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/TARGETS_MANY_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/TARGETS_MANY_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/TARGETS_MANY_MAR01_03.ogg",
			}
			self.SoundTbl_Death = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/death_mar01_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/death_mar01_04.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/death_mm01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/death_mm01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/death_mm01_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/death_mm01_04.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/death_mm01_05.ogg",
			}
		end
	else

	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAlert(ent)
	self:VJ_ACT_PLAYACTIVITY("ohwn_oh_shit",true,false,true)
	if ent:IsNPC() then
		if ent.VJ_AVP_Xenomorph then
			self:PlaySoundSystem("Alert", ent.VJ_AVP_XenomorphLarge && self.SoundTbl_Spot_XenoLarge or self.SoundTbl_Spot_Xeno)
			return
		elseif ent.VJ_AVP_IsTech then
			self:PlaySoundSystem("Alert", self.SoundTbl_Spot_Android)
			return
		elseif ent.VJ_AVP_Predator then
			self:PlaySoundSystem("Alert", ent:GetCloaked() && self.SoundTbl_Spot_PredatorCloaked or self.SoundTbl_Spot_Predator)
			return
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local toAct = VJ.SequenceToActivity
--
function ENT:CustomOnInitialize()
	if self.OnInit then
		self:OnInit()
	end

	self.SprintT = 0
	self.NextSprintT = 0
	self.Moveset = 0
	self.Ping_ClosestDist = 0
	self.Ping_NextPingT = CurTime() +1
	self.NextHealT = CurTime() +1

	self.AnimTbl_ScaredBehaviorMovement = {toAct(self,"nwn_Panic_run_fwd_look_fwd")}

	local att = self:LookupAttachment("flashlight")
	if att > 0 && self.HasFlashlight then
		local envLight = ents.Create("env_projectedtexture")
		envLight:SetLocalPos(self:GetPos())
		envLight:SetLocalAngles(self:GetAngles())
		envLight:SetKeyValue("lightcolor","255 247 206")
		envLight:SetKeyValue("lightfov","40")
		envLight:SetKeyValue("farz","1000")
		envLight:SetKeyValue("nearz","10")
		envLight:SetKeyValue("shadowquality","1")
		envLight:Input("SpotlightTexture",NULL,NULL,"effects/flashlight001")
		envLight:SetOwner(self)
		envLight:SetParent(self)
		envLight:Spawn()
		envLight:Fire("setparentattachment","flashlight")
		self:DeleteOnRemove(envLight)

        local spotlight = ents.Create("beam_spotlight")
        spotlight:SetPos(self:GetPos())
        spotlight:SetAngles(self:GetAngles())
        spotlight:SetKeyValue("spotlightlength",700)
        spotlight:SetKeyValue("spotlightwidth",30)
		spotlight:SetKeyValue("spawnflags","2")
        spotlight:Fire("Color","255 247 206")
        spotlight:SetParent(self)
        spotlight:Spawn()
        spotlight:Activate()
		spotlight:Fire("setparentattachment","flashlight")
        spotlight:Fire("lighton")
		spotlight:AddEffects(EF_PARENT_ANIMATES)
        self:DeleteOnRemove(spotlight)

		local glow1 = ents.Create("env_sprite")
		glow1:SetKeyValue("model","sprites/light_ignorez.vmt")
		glow1:SetKeyValue("scale","0.2")
		glow1:SetKeyValue("rendermode","9")
		glow1:SetKeyValue("rendercolor","255 247 206")
		glow1:SetKeyValue("spawnflags","0.1")
		glow1:SetParent(self)
		glow1:SetOwner(self)
		glow1:Fire("SetParentAttachment","flashlight",0)
		glow1:Spawn()
		self:DeleteOnRemove(glow1)

		-- local glowLight = ents.Create("light_dynamic")
		-- glowLight:SetKeyValue("brightness","1.4")
		-- glowLight:SetKeyValue("distance","70")
		-- glowLight:SetLocalPos(self:GetPos() +self:OBBCenter())
		-- glowLight:SetLocalAngles(self:GetAngles())
		-- glowLight:Fire("Color", "255 247 206")
		-- glowLight:SetParent(self)
		-- glowLight:SetOwner(self)
		-- glowLight:Spawn()
		-- glowLight:Fire("TurnOn","",0)
		-- glowLight:Fire("SetParentAttachment","flashlight",0)
		-- self:DeleteOnRemove(glowLight)

		-- self.Light = envLight
		-- self.LightGlow = glow1
		-- self.LightGlowDynamic = glowLight
	end

	hook.Add("PlayerButtonDown", self, function(self, ply, button)
		if ply.VJTag_IsControllingNPC == true && IsValid(ply.VJ_TheControllerEntity) then
			local cent = ply.VJ_TheControllerEntity
            if cent.VJCE_NPC == self then
                cent.VJCE_NPC:OnKeyPressed(ply,button)
            end
        end
    end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Controller_Initialize(ply,controlEnt)
	controlEnt.VJC_Player_DrawHUD = false

	function controlEnt:CustomOnThink()
		self.VJC_NPC_CanTurn = self.VJC_Camera_Mode == 2
		self.VJC_BullseyeTracking = self.VJC_Camera_Mode == 2
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnKeyPressed(ply,key)
    if key == KEY_E then
		local tr = util.TraceLine({
			start = self:EyePos(),
			endpos = self:EyePos() +ply:GetAimVector() *125,
			filter = {self,ply}
		})
		local ent = tr.Entity
		if tr.Hit && IsValid(ent) then
			ent:Fire("Use",nil,0,ply,self)
		end
    elseif key == KEY_G then
		if self:Health() < self:GetMaxHealth() && CurTime() > self.NextHealT then
			self:UseStimpack()
			self.NextHealT = CurTime() +3
		end
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:UseStimpack()
	if self.InFatality or self.DoingFatality then return end
	if self:IsBusy() then return end
	self:VJ_ACT_PLAYACTIVITY("vjges_ohwa_pistol_stim",true,false,false,0,{OnFinish=function(i)
		if i then return end
		self:SetHealth(self:GetMaxHealth())
	end})
	self.NextChaseTime = 0
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:TranslateActivity(act)
	if self.Moveset == 1 then
		if act == ACT_RUN then
			act = ACT_WALK
		end
	elseif self.Moveset == 2 then
		if act == ACT_RUN then
			return ACT_SPRINT
		end
		if act == ACT_WALK then
			act = ACT_RUN
		end
	elseif self.Moveset == 3 && CurTime() < self.NextSprintT then
		if act == ACT_WALK then
			act = ACT_RUN
		end
	end

	if act == ACT_IDLE then
		if self.NoWeapon_UseScaredBehavior_Active == true then
			return ACT_COWER
		elseif self.Alerted && self:GetWeaponState() != VJ.NPC_WEP_STATE_HOLSTERED && IsValid(self:GetActiveWeapon()) then
			return ACT_IDLE_ANGRY
		end
	elseif act == ACT_RUN && self.NoWeapon_UseScaredBehavior_Active == true && !self.VJ_IsBeingControlled then
		return ACT_RUN_PROTECTED
	elseif (act == ACT_RUN or act == ACT_WALK) && self.HasShootWhileMoving == true && IsValid(self:GetEnemy()) then
		if (self.EnemyData.IsVisible or (self.EnemyData.LastVisibleTime + 5) > CurTime()) && self.CurrentSchedule != nil && self.CurrentSchedule.CanShootWhenMoving == true && self:IsAbleToShootWeapon(true, false) == true then
			local anim = self:TranslateToWeaponAnim(act == ACT_RUN and ACT_RUN_AIM or ACT_WALK_AIM)
			if VJ.AnimExists(self, anim) == true then
				self.DoingWeaponAttack = true
				self.DoingWeaponAttack_Standing = false
				return anim
			end
		end
	end

	return act
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetAnimationTranslations(hType)
	//toAct(self, "walkaimall1_ar2")
	self.AnimationTranslations[ACT_COWER] 								= {toAct(self, "nwa_Cower1"),toAct(self, "nwa_stand_alert_PanicA"),toAct(self, "nwa_panic_idle")}
	if hType == "pistol" then
		self.AnimationTranslations[ACT_RANGE_ATTACK1] 					= toAct(self, "ohwa_pistol_idle")
		self.AnimationTranslations[ACT_GESTURE_RANGE_ATTACK1] 			= "vjges_ohwa_pistol_shoot"
		self.AnimationTranslations[ACT_RANGE_ATTACK1_LOW] 				= toAct(self, "OHWA_crouch_idle")
		self.AnimationTranslations[ACT_RELOAD] 							= "vjges_ohwa_pistol_reload"
		self.AnimationTranslations[ACT_RELOAD_LOW] 						= "vjges_ohwa_pistol_reload"
		self.AnimationTranslations[ACT_COVER_LOW] 						= toAct(self, "OHWA_crouch_idle")
		
		self.AnimationTranslations[ACT_IDLE] 							= toAct(self, "ohwn_pistol_idle")
		self.AnimationTranslations[ACT_IDLE_ANGRY] 						= {toAct(self, "ohwa_alert_idle_1"),toAct(self, "ohwa_alert_panic"),toAct(self, "ohwa_alert_watchfulA")}
		-- self.AnimationTranslations[ACT_JUMP] 							= ACT_HL2MP_JUMP_PISTOL
		-- self.AnimationTranslations[ACT_GLIDE] 							= ACT_HL2MP_JUMP_PISTOL
		-- self.AnimationTranslations[ACT_LAND] 							= ACT_HL2MP_IDLE_PISTOL
		
		self.AnimationTranslations[ACT_WALK] 							= toAct(self, "ohwn_Walk")
		self.AnimationTranslations[ACT_WALK_AIM] 						= toAct(self, "OHWA_Walk")
		
		self.AnimationTranslations[ACT_RUN] 							= toAct(self, "ohwn_Run")
		self.AnimationTranslations[ACT_RUN_AIM] 						= toAct(self, "ohwa_Run_fwd_Look_fwd")
		self.AnimationTranslations[ACT_SPRINT] 							= toAct(self, "ohwn_sprint")
	end
	return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
local table_insert = table.insert
local math_abs = math.abs
local math_cos = math.cos
local math_rad = math.rad
--
function ENT:CustomOnThink()
	local curTime = CurTime()

	local cont = self.VJ_TheController
	if IsValid(cont) then
		local walk = cont:KeyDown(IN_WALK)
		local sprint = cont:KeyDown(IN_SPEED)
		if walk && self.Moveset != 1 then
			self.Moveset = 1
		-- 	self.AnimTbl_Walk = {ACT_WALK}
		-- 	self.AnimTbl_Run = {ACT_WALK}
		-- 	self.AnimTbl_ShootWhileMovingWalk = {ACT_WALK_AIM}
		-- 	self.AnimTbl_ShootWhileMovingRun = {ACT_WALK_AIM}
		elseif !walk && self.Moveset != 2 then
			self.Moveset = 2
		-- 	self.AnimTbl_Walk = {ACT_RUN}
		-- 	self.AnimTbl_Run = {ACT_SPRINT}
		-- 	self.AnimTbl_ShootWhileMovingWalk = {ACT_RUN_AIM}
		-- 	self.AnimTbl_ShootWhileMovingRun = {ACT_RUN_AIM}
		elseif !walk && self.Moveset != 3 && curTime < self.NextSprintT then
			self.Moveset = 3
		-- 	self.AnimTbl_Walk = {ACT_RUN}
		-- 	self.AnimTbl_Run = {ACT_RUN}
		-- 	self.AnimTbl_ShootWhileMovingWalk = {ACT_RUN_AIM}
		-- 	self.AnimTbl_ShootWhileMovingRun = {ACT_RUN_AIM}
			sprint = false
		end
		self:SetSprinting(sprint)
	else
		-- if self.Moveset != 0 then
		-- 	self.Moveset = 0
		-- 	self.AnimTbl_Walk = {ACT_WALK}
		-- 	self.AnimTbl_Run = {ACT_RUN}
		-- 	self.AnimTbl_ShootWhileMovingWalk = {ACT_WALK_AIM}
		-- 	self.AnimTbl_ShootWhileMovingRun = {ACT_RUN_AIM}
		-- 	self:SetSprinting(false)
		-- end

		if self:Health() < self:GetMaxHealth() && CurTime() > self.NextHealT && math.random(1,30) == 1 && !self:IsBusy() then
			self:UseStimpack()
			self.NextHealT = CurTime() +math.Rand(45,60)
		end
	end
	if self:GetSprinting() then
		self.SprintT = self.SprintT +0.1
		if self.SprintT >= 4 then
			self.NextSprintT = curTime +3
		end
	else
		if self.SprintT > 0 then
			self.SprintT = self.SprintT -0.2
		end
	end

	if self.HasMotionTracker then
		VJ_AVP_MotionTracker(self)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnKilled()
	if self:GetState() == VJ_STATE_NONE then
		for i = 1,self:GetBoneCount() -1 do
			if math.random(1,4) <= 3 then continue end
			local bone = self:GetBonePosition(i)
			if bone then
				local particle = ents.Create("info_particle_system")
				particle:SetKeyValue("effect_name", VJ.PICK(self.CustomBlood_Particle))
				particle:SetPos(bone +VectorRand() *15)
				particle:Spawn()
				particle:Activate()
				particle:Fire("Start")
				particle:Fire("Kill", "", 0.1)
			end
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
	if self.WhenRemoved then
		self:WhenRemoved()
	end

	-- if IsValid(self.Flashlight) then
	-- 	self.Flashlight:Fire("TurnOff","",0)
	-- 	self.Flashlight:Fire("Kill","",0)
	-- 	SafeRemoveEntity(self.Flashlight)
	-- end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnChangeActivity(newAct)
	//print(newAct)
	local funcCustom = self.CustomOnChangeActivity; if funcCustom then funcCustom(self, newAct) end
	if newAct == ACT_TURN_LEFT or newAct == ACT_TURN_RIGHT then
		self.NextIdleStandTime = CurTime() + VJ.AnimDuration(self, self:GetSequenceName(self:GetSequence()))
		//self.NextIdleStandTime = CurTime() + 1.2
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local angY45 = Angle(0, 45, 0)
local angYN45 = Angle(0, -45, 0)
local angY90 = Angle(0, 90, 0)
local angYN90 = Angle(0, -90, 0)
local angY135 = Angle(0, 135, 0)
local angYN135 = Angle(0, -135, 0)
local angY180 = Angle(0, 180, 0)
local defAng = Angle(0, 0, 0)
--
function ENT:Controller_Movement(cont, ply, bullseyePos)
	if self.MovementType != VJ_MOVETYPE_STATIONARY then
		local gerta_lef = ply:KeyDown(IN_MOVELEFT)
		local gerta_rig = ply:KeyDown(IN_MOVERIGHT)
		local gerta_arak = ply:KeyDown(IN_SPEED)
		local aimVector = ply:GetAimVector()
		local FT = FrameTime() *(self.TurningSpeed *2.25)

		self.VJC_Data.TurnAngle = self.VJC_Data.TurnAngle or defAng
		
		if ply:KeyDown(IN_FORWARD) then
			if self.MovementType == VJ_MOVETYPE_AERIAL or self.MovementType == VJ_MOVETYPE_AQUATIC then
				self:AA_MoveTo(cont.VJCE_Bullseye, true, gerta_arak and "Alert" or "Calm", {IgnoreGround=true})
			else
				self.VJC_Data.TurnAngle = LerpAngle(FT, self.VJC_Data.TurnAngle, gerta_lef && angY45 or gerta_rig && angYN45 or defAng)
				cont:StartMovement(aimVector, self.VJC_Data.TurnAngle)
			end
		elseif ply:KeyDown(IN_BACK) then
			self.VJC_Data.TurnAngle = LerpAngle(FT, self.VJC_Data.TurnAngle, gerta_lef && angY135 or gerta_rig && angYN135 or angY180)
			cont:StartMovement(aimVector, self.VJC_Data.TurnAngle)
		elseif gerta_lef then
			self.VJC_Data.TurnAngle = LerpAngle(FT, self.VJC_Data.TurnAngle, angY90)
			cont:StartMovement(aimVector, self.VJC_Data.TurnAngle)
		elseif gerta_rig then
			self.VJC_Data.TurnAngle = LerpAngle(FT, self.VJC_Data.TurnAngle, angYN90)
			cont:StartMovement(aimVector, self.VJC_Data.TurnAngle)
		else
			self:StopMoving()
			if self.MovementType == VJ_MOVETYPE_AERIAL or self.MovementType == VJ_MOVETYPE_AQUATIC then
				self:AA_StopMoving()
			end
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:StartMovement(cont, Dir, Rot)
	local self = cont.VJCE_NPC
	local ply = cont.VJCE_Player
	if self:GetState() != VJ_STATE_NONE then return end

	local DEBUG = ply:GetInfoNum("vj_npc_cont_devents", 0) == 1
	local plyAimVec = Dir
	plyAimVec.z = 0
	plyAimVec:Rotate(Rot)
	local selfPos = self:GetPos()
	local centerToPos = self:OBBCenter():Distance(self:OBBMins()) + 20 // self:OBBMaxs().z
	local NPCPos = selfPos + self:GetUp()*centerToPos
	local groundSpeed = math.Clamp(self:GetSequenceGroundSpeed(self:GetSequence()), 300, 9999)
	local defaultFilter = {cont, self, ply}
	local forwardTr = util.TraceHull({start = NPCPos, endpos = NPCPos + plyAimVec * groundSpeed, filter = defaultFilter, mins = Vector(-4,-4,-4), maxs = Vector(4,4,4)})
	local forwardDist = NPCPos:Distance(forwardTr.HitPos)
	local wallToSelf = forwardDist - (self:OBBMaxs().y *2.5) -- Use Y instead of X because X is left/right whereas Y is forward/backward
	if DEBUG then
		VJ.DEBUG_TempEnt(NPCPos, cont:GetAngles(), Color(0, 255, 255)) -- NPC's calculated position
		VJ.DEBUG_TempEnt(forwardTr.HitPos, cont:GetAngles(), Color(255, 255, 0)) -- forward trace position
	end
	if forwardDist >= 25 then
		local finalPos = Vector((selfPos + plyAimVec * wallToSelf).x, (selfPos + plyAimVec * wallToSelf).y, forwardTr.HitPos.z)
		local downTr = util.TraceLine({start = finalPos, endpos = finalPos + cont:GetUp()*-(200 + centerToPos), filter = defaultFilter})
		local downDist = (finalPos.z - centerToPos) - downTr.HitPos.z
		if downDist >= 150 then -- If the drop is this big, then don't move!
			//wallToSelf = wallToSelf - downDist -- No need, we are returning anyway
			return
		end
		if forwardDist <= 225 && !forwardTr.Hit then
			finalPos = Vector((selfPos + plyAimVec * groundSpeed).x, (selfPos + plyAimVec * groundSpeed).y, forwardTr.HitPos.z)
		else
			finalPos = Vector((selfPos + plyAimVec * wallToSelf).x, (selfPos + plyAimVec * wallToSelf).y, forwardTr.HitPos.z)
		end
		if DEBUG then
			VJ.DEBUG_TempEnt(downTr.HitPos, cont:GetAngles(), Color(255, 0, 255)) -- Down trace position
			VJ.DEBUG_TempEnt(finalPos, cont:GetAngles(), Color(0, 255, 0)) -- Final move position
		end
		self:SetLastPosition(finalPos)
		self:VJ_TASK_GOTO_LASTPOS(ply:KeyDown(IN_SPEED) and "TASK_RUN_PATH" or "TASK_WALK_PATH", function(x)
			if ply:KeyDown(IN_ATTACK2) && self.IsVJBaseSNPC_Human then
				x.FaceData = {Type = VJ.NPC_FACE_ENEMY}
				x.CanShootWhenMoving = true
			else
				if cont.VJC_BullseyeTracking then
					x.FaceData = {Type = VJ.NPC_FACE_ENEMY}
				else
					x:EngTask("TASK_FACE_LASTPOSITION", 0)
				end
			end
		end)
	end
end