AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/avp/xeno/praetorian.mdl"}
ENT.StartHealth = 1000
ENT.VJ_ID_Boss = true
ENT.HullType = HULL_LARGE

ENT.ControllerParams = {
    CameraMode = 2,
    ThirdP_Offset = Vector(0, 0, -35),
    FirstP_Bone = "Bip01 Head",
    FirstP_Offset = Vector(20, 0, 0),
    FirstP_ShrinkBone = false
}

ENT.RangeAttackAnimationStopMovement = false

ENT.HasBreath = true
ENT.FootstepSoundLevel = 82

ENT.CanScreamForHelp = false
ENT.SummonClasses = {
	"npc_vj_avp_xeno_warrior",
	"npc_vj_avp_xeno_warrior",
	"npc_vj_avp_xeno_warrior",
	"npc_vj_avp_xeno_warrior",
	"npc_vj_avp_xeno_ridged",
}
ENT.AttackDamageMultiplier = 2
ENT.RangeAttackDamageMultiplier = 1.25
ENT.CanSpit = true
ENT.AlwaysStand = true
ENT.AnimTranslations = {
	[ACT_IDLE] = ACT_HL2MP_IDLE_SMG1,
	[ACT_WALK] = ACT_HL2MP_WALK_SMG1,
	[ACT_RUN] = ACT_HL2MP_WALK_CROUCH_SMG1,
	[ACT_MP_SPRINT] = ACT_HL2MP_RUN_SMG1,
	[ACT_TURN_LEFT] = ACT_ROLL_LEFT,
	[ACT_TURN_RIGHT] = ACT_ROLL_RIGHT,
}
ENT.FaceEnemyMovements = {ACT_HL2MP_WALK_SMG1,ACT_HL2MP_WALK_CROUCH_SMG1,ACT_HL2MP_RUN_SMG1}

ENT.StandingBounds = Vector(16,16,84)
ENT.CrawlingBounds = Vector(16,16,84)

ENT.DistractionSound = "cpthazama/avp/xeno/praetorian/vocal/praetorian_trophy_struggle_01.ogg"
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRangeAttack_BeforeStartTimer()
	if self:IsMoving() then
		self.AnimTbl_RangeAttack = "vjges_Praetorian_Spit_layer"
	else
		self.AnimTbl_RangeAttack = "Praetorian_Spit"
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnInit()
	-- self.CurrentSet = 2
	if GetConVar("vj_avp_bosstheme_a"):GetBool() then
		self.HasSoundTrack = true
		self.SoundTbl_SoundTrack = {"cpthazama/avp/music/boss/Full Tilt Rampage.mp3"}
	end
	self.Summons = {}
	self.AnimTbl_RangeAttack = {"Praetorian_Spit"}
	self.SoundTbl_Alert = {
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_taunt_01.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_taunt_02.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_taunt_03.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_taunt_04.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_taunt_05.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_taunt_06.ogg",
	}
	self.SoundTbl_Attack = {
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_trophy_struggle_01.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_trophy_struggle_02.ogg",
	}
	self.SoundTbl_CombatIdle = {
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_taunt_01.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_taunt_02.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_taunt_03.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_taunt_04.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_taunt_05.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_taunt_06.ogg",
	}
	self.SoundTbl_BeforeRangeAttack = {
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_trophy_struggle_01.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_trophy_struggle_02.ogg",
	}
	self.SoundTbl_RangeAttack = {}
	self.SoundTbl_Jump = {
		"cpthazama/avp/xeno/alien/vocals/alien_jump_grunt_01.ogg",
		"cpthazama/avp/xeno/alien/vocals/alien_jump_grunt_02.ogg",
		"cpthazama/avp/xeno/alien/vocals/alien_jump_grunt_03.ogg",
		"cpthazama/avp/xeno/alien/vocals/alien_jump_grunt_04.ogg",
	}
	self.SoundTbl_Pain = {
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_pain_01.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_pain_02.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_pain_04.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_pain_05.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_pain_06.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_pain_07.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_pain_08.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_pain_09.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_pain_10.ogg",
	}
	self.SoundTbl_Death = {
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_death_scream_01.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_death_scream_03.ogg",
	}
	self.FootData = {
		["lfoot"] = {Range=15.5,OnGround=true},
		["rfoot"] = {Range=15,OnGround=true},
		["lhand"] = {Range=8.5,OnGround=true},
		["rhand"] = {Range=8.5,OnGround=true}
	}
	self.FootstepSoundPitch = VJ.SET(60, 70)
	self.NextSummonT = CurTime() +3
	-- self.NextSummonT = CurTime() +60
	-- timer.Simple(0,function()
	-- 	if IsValid(self) then
	-- 		self:DoSummon()
	-- 	end
	-- end)

	self.HitGroups = {
		[HITGROUP_HEAD] = {
			HP = 800,
			Dead = false,
			OnDecap = function(self,dmginfo,hitgroup)
				self:SetBodygroup(self:FindBodygroupByName("head"),1)
				self:SetBodygroup(self:FindBodygroupByName("face"),2)
				self:SetHealth(0)
				self:TakeDamage(100,dmginfo:GetAttacker(),dmginfo:GetInflictor())
			end,
		},
		[HITGROUP_LEFTARM] = {
			HP = 500,
			Dead = false,
			OnDecap = function(self,dmginfo,hitgroup)
				self:SetBodygroup(self:FindBodygroupByName("larm"),1)
				self.Gibbed = self.Gibbed or {}
				self.Gibbed.LeftArm = true
				if self.Gibbed.RightArm then
					self:SetHealth(0)
					self:TakeDamage(100,dmginfo:GetAttacker(),dmginfo:GetInflictor())
					self:StopAttacks(true)
					self.AttackAnimTime = 0	
					self:StopMoving()
					self:CapabilitiesRemove(CAP_MOVE_JUMP)
				end
			end,
		},
		[HITGROUP_RIGHTARM] = {
			HP = 500,
			Dead = false,
			OnDecap = function(self,dmginfo,hitgroup)
				self:SetBodygroup(self:FindBodygroupByName("rarm"),1)
				self.Gibbed = self.Gibbed or {}
				self.Gibbed.RightArm = true
				if self.Gibbed.LeftArm then
					self:SetHealth(0)
					self:TakeDamage(100,dmginfo:GetAttacker(),dmginfo:GetInflictor())
					self:StopAttacks(true)
					self.AttackAnimTime = 0	
					self:StopMoving()
					self:CapabilitiesRemove(CAP_MOVE_JUMP)
				end
			end,
		},
		[HITGROUP_LEFTLEG] = {
			HP = 500,
			Dead = false,
			OnDecap = function(self,dmginfo,hitgroup)
				self:SetBodygroup(self:FindBodygroupByName("lleg"),1)
				self.Gibbed = self.Gibbed or {}
				self.Gibbed.LeftLeg = true
				self:StopAttacks(true)
				self.AttackAnimTime = 0	
				self:StopMoving()
				self:CapabilitiesRemove(CAP_MOVE_JUMP)
			end,
		},
		[HITGROUP_RIGHTLEG] = {
			HP = 500,
			Dead = false,
			OnDecap = function(self,dmginfo,hitgroup)
				self:SetBodygroup(self:FindBodygroupByName("rleg"),1)
				self.Gibbed = self.Gibbed or {}
				self.Gibbed.RightLeg = true
				self:StopAttacks(true)
				self.AttackAnimTime = 0	
				self:StopMoving()
				self:CapabilitiesRemove(CAP_MOVE_JUMP)
			end,
		},
		[111] = {
			HP = 500,
			Dead = false,
			OnDecap = function(self,dmginfo,hitgroup)
				self:SetBodygroup(self:FindBodygroupByName("tail_end"),1)
				self.Gibbed = self.Gibbed or {}
				self.Gibbed.Tail = true
			end,
		},
		[110] = {
			HP = 500,
			Dead = false,
			OnDecap = function(self,dmginfo,hitgroup)
				self:SetBodygroup(self:FindBodygroupByName("tail"),1)
				self:SetBodygroup(self:FindBodygroupByName("tail_end"),2)
				self.Gibbed = self.Gibbed or {}
				self.Gibbed.Tail = true
			end,
		},
	}

	self:SetStepHeight(36)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnStep(pos,name)
	util.ScreenShake(pos,5,100,0.35,500)
end
---------------------------------------------------------------------------------------------------------------------------------------------
local math_abs = math.abs
--
function ENT:DoSummon()
	self:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK)
	VJ.STOPSOUND(self.CurrentSpeechSound)
	VJ.STOPSOUND(self.CurrentIdleSound)
	self:PlayAnim("Praetorian_Stand_Summon_Into",true,false,false,0,{OnFinish=function(interrupted)
		if interrupted then self:SetState() return end
		VJ.STOPSOUND(self.CurrentSpeechSound)
		VJ.STOPSOUND(self.CurrentIdleSound)
		VJ.CreateSound(self,"cpthazama/avp/xeno/praetorian/vocal/praetorian_summon_long_01.ogg",110)

		self:Allies_CallHelp(8000)
		self:PlayAnim("Praetorian_Stand_Summon",true,false,false,0,{OnFinish=function(interrupted)
			local enemyEnts = {}
			for _,v in pairs(ents.GetAll()) do
				if (v:IsNPC() && (v.VJ_NPC_Class != nil && !VJ.HasValue(v.VJ_NPC_Class,self.VJ_NPC_Class[1] or "CLASS_XENOMORPH") or v.VJ_NPC_Class == nil)) or (v:IsPlayer() && !VJ_CVAR_IGNOREPLAYERS && v:Alive()) then
					table.insert(enemyEnts,v)
				end
			end
			local totalSpawns = 0
			local nodegraph = table.Copy(VJ_Nodegraph.Data.Nodes)
			local closestNodes = {}
			local maxDist = 8000
			local minDist = 1500
			for _,node in ipairs(nodegraph) do
				if totalSpawns >= 5 then break end
				local dist = node.pos:Distance(self:GetPos())
				local badNode = false
				if dist < maxDist && dist > minDist then
					for _,v in pairs(enemyEnts) do
						local heightDif = math_abs(v:GetPos().z -node.pos.z)
						local dist = v:GetPos():Distance(node.pos)
						if heightDif <= 500 then
							minDist = 750
						end
						if dist < minDist or v:VisibleVec(node.pos) then badNode = true continue end
					end
					if badNode then continue end
				end
				table.insert(closestNodes,node.pos)
				totalSpawns = totalSpawns +1
			end
			for _ = 1,5 do
				local pos = VJ.PICK(closestNodes)
				if pos then
					local xeno = ents.Create(VJ.PICK(self.SummonClasses))
					xeno:SetPos(pos)
					xeno:SetAngles(Angle(0,(self:GetPos() -pos):Angle().y,0))
					xeno:Spawn()
					xeno:Activate()
					xeno.VJ_NPC_Class = self.VJ_NPC_Class
					if !self.VJ_IsBeingControlled then xeno:ForceSetEnemy(self:GetEnemy(),true) end
					table.insert(self.Summons,xeno)
				end
			end

			if interrupted then self:SetState() return end
			self:SetState()
		end})
	end})
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnKey(ply,key)
	if key == KEY_B && CurTime() > self.NextSummonT && !self:IsBusy() then
		self:DoSummon()
		self.NextSummonT = CurTime() +60
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnCustomAttack(ply,ent,vis,dist)
	if !IsValid(ply) && !self.SpawnedUsingMutator && CurTime() > self.NextSummonT && math.random(1,50) == 1 && !self:IsBusy() then
		self:DoSummon()
		self.NextSummonT = CurTime() +math.random(60,120)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local subSpecies = {
	"npc_vj_avp_xeno_carrier",
	"npc_vj_avp_xeno_venator",
	"npc_vj_avp_xeno_ravager",
}
local subKSpecies = {
	"npc_vj_avp_kxeno_carrier",
	"npc_vj_avp_kxeno_venator",
	"npc_vj_avp_kxeno_ravager",
}
--
function ENT:DoRoyalTransformation(subClass)
	if subClass then -- Not a Queen, rather a Carrier, Venator or Ravager
		local xeno = ents.Create(VJ.PICK(self.VJ_AVP_K_Xenomorph && subKSpecies or subSpecies))
		xeno:SetPos(self:GetPos())
		xeno:SetAngles(self:GetAngles())
		xeno.VJ_NPC_Class = self.VJ_NPC_Class
		xeno:Spawn()
		xeno:Activate()
		xeno:ForceSetEnemy(self:GetEnemy(),true)
		xeno:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK)
		xeno:PlayAnim("Praetorian_Stand_Summon_Into",true,false,false,0,{OnFinish=function(interrupted)
			if interrupted then xeno:SetState() return end
			VJ.STOPSOUND(xeno.CurrentSpeechSound)
			VJ.STOPSOUND(xeno.CurrentIdleSound)
			VJ.CreateSound(xeno,"cpthazama/avp/xeno/praetorian/vocal/praetorian_summon_long_01.ogg",110,125)
			xeno:PlayAnim("Praetorian_Stand_Summon",true,false,false,0,{OnFinish=function(interrupted)
				if interrupted then xeno:SetState() return end
				xeno:SetState()
			end})
		end})
		undo.ReplaceEntity(self,xeno)
		local cont = self.VJ_TheController
		timer.Simple(0.12,function()
			if IsValid(cont) && IsValid(xeno) then
				local SpawnControllerObject = ents.Create("obj_vj_controller")
				SpawnControllerObject.VJCE_Player = cont
				SpawnControllerObject:SetControlledNPC(xeno)
				SpawnControllerObject:Spawn()
				SpawnControllerObject:StartControlling()
				print(cont,"evolved into",xeno)
			end
		end)
		self:Remove()
		return
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Breathe()
	if CurTime() > (self.NextBreathT or 0) then
		local snd = "cpthazama/avp/xeno/alien queen/alien_queen_breathe_in_0" .. math.random(1,3) .. ".ogg"
		local sndB = "cpthazama/avp/xeno/alien queen/alien_queen_breathe_out_0" .. math.random(1,3) .. ".ogg"
		VJ.CreateSound(self,snd,65,112)
		timer.Simple(1,function()
			if IsValid(self) then
				VJ.CreateSound(self,sndB,65,112)
			end
		end)
		self.NextBreathT = CurTime() +2.3
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SelectIdleActivity(act)
	local gib = self.Gibbed
	if gib && (gib.LeftLeg or gib.RightLeg or gib.LeftArm or gib.RightArm) then
		return (gib.LeftArm && ACT_WALK_CROUCH or gib.RightArm && ACT_WALK_CROUCH_AIM) or ACT_RUN_CROUCH
	end
	return ACT_IDLE
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:WhenRemoved()
	if !self.Dead then
		for _, v in ipairs(self.Summons) do
			if IsValid(v) then
				v:Remove()
			end
		end
	end
end