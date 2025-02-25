AddCSLuaFile("shared.lua")
include("shared.lua")
include("vj_base/extensions/avp_fatality_module.lua")
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/avp/xeno/warrior.mdl"}
ENT.StartHealth = 140
ENT.HealthRegenParams = {
	Enabled = true,
	Amount = 1,
	Delay = VJ.SET(0.5, 0.5),
}
ENT.HullType = HULL_HUMAN
ENT.PoseParameterLooking_InvertPitch = true
ENT.PoseParameterLooking_InvertYaw = true
ENT.EnemyXRayDetection = true
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.BloodColor = VJ.BLOOD_COLOR_YELLOW
ENT.BloodParticle = {"vj_avp_blood_xeno"}
ENT.BloodDecal = {"VJ_AVP_BloodXenomorph"}
ENT.BloodPool = {"vj_avp_bloodpool_xeno"}
ENT.VJ_NPC_Class = {"CLASS_XENOMORPH"}

ENT.HasMeleeAttack = false

ENT.JumpParams = {
	MaxRise = 375,
	MaxDrop = 700,
	MaxDistance = 1000,
}

ENT.ControllerParams = {
    CameraMode = 2,
    ThirdP_Offset = Vector(0, 0, -35),
    FirstP_Bone = "Bip01 Head",
    FirstP_Offset = Vector(15, 0, 0),
    FirstP_ShrinkBone = true
}

ENT.FootData = {
	["lfoot"] = {Range=12,OnGround=true},
	["rfoot"] = {Range=12,OnGround=true},
	["lhand"] = {Range=8.5,OnGround=true},
	["rhand"] = {Range=8.5,OnGround=true}
}

ENT.AnimTbl_RangeAttack = {"all4s_spit_left","all4s_spit_right"}
ENT.RangeAttackAnimationFaceEnemy = false
ENT.RangeAttackAnimationStopMovement = true
ENT.RangeAttackMaxDistance = 2300
ENT.RangeAttackMinDistance = 400
ENT.TimeUntilRangeAttackProjectileRelease = false
ENT.NextRangeAttackTime = VJ.SET(6, 12)
ENT.DisableDefaultRangeAttackCode = true

ENT.CanFlinch = true
ENT.FlinchChance = 12
ENT.FlinchCooldown = 1.75
ENT.AnimTbl_FlinchCrouch = {"flinch_fwd_left","flinch_fwd_right","flinch_back_left","flinch_back_right"}
ENT.AnimTbl_FlinchStand = {"standing_flinch_back_left","standing_flinch_back_right","standing_flinch_fwd_left","standing_flinch_fwd_right"}

ENT.DisableFootStepSoundTimer = true
ENT.HasExtraMeleeAttackSounds = true
ENT.MainSoundPitch = 100

ENT.AnimTbl_Fatalities = {
	Alien = {
		Trophy = {
			Grab = "v_alien_headbite_grab",
			Lift = "v_alien_headbite_grapple",
			Counter = "v_alien_headbite_countered",
			Kill = "v_alien_headbite_kill"
		},
		Stealth = {
			Grab = "v_alien_headbitebehind_grapple",
			Counter = "v_alien_headbitebehind_countered",
			Kill = "v_alien_headbitebehind_kill"
		}
	},
	Human = {
		Trophy = {
			Grab = "neckbite_marine_ohwa_grab",
			Counter = "neckbite_marine_ohwa_counter",
			Kill = "neckbite_marine_ohwa_death"
		},
		Stealth = {
			Grab = "stealth_kill_marine_tailstab_head_hold",
			Kill = "stealth_kill_marine_tailstab_head_kill"
		}
	},
	Predator = {
		Trophy = {
			Grab = "headbite_pred",
			Counter = "headbite_pred_countered",
			Kill = "headbite_pred_kill"
		},
		Stealth = {
			Grab = "stealth_kill_pred",
			Counter = "stealth_kill_pred_countered",
			Kill = "stealth_kill_pred_finished"
		}
	}
}

ENT.AnimTbl_FatalitiesResponse = {
	["predator_claws_trophy_alien_grab"] = "standing_guard_broken",
	["predator_claws_trophy_alien_lift"] = "pred_trophy_standing_lift",
	["predator_claws_trophy_alien_countered"] = "pred_trophy_countered",
	["predator_claws_trophy_alien_impale"] = "pred_trophy_death_impaled",
	["predator_claws_trophy_alien_kill"] = "pred_trophy_death",
	["predator_claws_trophy_alien_kill_headplant"] = "pred_trophy_death_headplant",
	["predator_claws_trophy_alien_kill_kneeplant"] = "pred_trophy_death_kneeplant",
	["predator_claws_trophy_alien_kill_slow"] = "pred_trophy_death_slow",
	["predator_claws_stealthkill_alien_kill"] = "stealthkill_pred_death",
	["predator_claws_stealthkill_alien_standing_kill"] = "stealthkill_standing_pred_death",
	["v_alien_headbite_countered"] = "v_alien_headbite_counter",
	["v_alien_headbite_kill"] = "v_alien_headbite_death",
	["v_alien_headbite_grab"] = "standing_guard_broken",
	["v_alien_headbite_grapple"] = "v_alien_headbite_grapple_victim",
	["v_alien_headbitebehind_countered"] = "v_alien_headbitebehind_counter",
	["v_alien_headbitebehind_kill"] = "v_alien_headbitebehind_death",
	["v_alien_headbitebehind_grapple"] = "v_alien_headbitebehind_grapple_victim",
	["v_alien_stealthkill_countered"] = "v_alien_stealthkill_counter",
	["v_alien_stealthkill_kill"] = "v_alien_stealthkill_death",
	["v_alien_stealthkill_grapple"] = "v_alien_stealthkill_grapple_victim",
	["v_alien_stealthkill_take_off_face"] = "v_alien_stealthkill_take_off_face_victim",
	["v_alien_tailstab_head_front_countered"] = "v_alien_tailstab_head_front_counter",
	["v_alien_tailstab_head_front_kill"] = "v_alien_tailstab_head_front_death",
	["v_alien_tailstab_head_front_grapple"] = "v_alien_tailstab_head_front_grapple_victim",
}

ENT.FootstepSoundLevel = 60
ENT.SoundTbl_FootSteps = {
	[MAT_CONCRETE] = {
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_stone_walk_01.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_stone_walk_02.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_stone_walk_03.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_stone_walk_04.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_stone_walk_05.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_stone_walk_06.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_stone_walk_07.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_stone_walk_08.ogg"
	},
	[MAT_DIRT] = {
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_dirt_walk_01.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_dirt_walk_02.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_dirt_walk_03.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_dirt_walk_04.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_dirt_walk_05.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_dirt_walk_06.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_dirt_walk_07.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_dirt_walk_08.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_dirt_walk_09.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_dirt_walk_10.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_dirt_walk_11.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_dirt_walk_12.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_dirt_walk_13.ogg"
	},
	[MAT_GRATE] = {
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_metal_walk_01.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_metal_walk_02.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_metal_walk_03.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_metal_walk_04.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_metal_walk_05.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_metal_walk_06.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_metal_walk_07.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_metal_walk_08.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_metal_walk_09.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_metal_walk_10.ogg"
	},
	[MAT_METAL] = {
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_metal_walk_01.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_metal_walk_02.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_metal_walk_03.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_metal_walk_04.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_metal_walk_05.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_metal_walk_06.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_metal_walk_07.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_metal_walk_08.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_metal_walk_09.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_metal_walk_10.ogg"
	},
	[MAT_FOLIAGE] = {
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_forest_run_01.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_forest_run_02.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_forest_run_03.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_forest_run_04.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_forest_run_05.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_forest_run_06.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_forest_run_07.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_forest_run_08.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_forest_run_09.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_forest_run_10.ogg"
	},
	[MAT_SLOSH] = {
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_dirt_walk_01.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_dirt_walk_02.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_dirt_walk_03.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_dirt_walk_04.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_dirt_walk_05.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_dirt_walk_06.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_dirt_walk_07.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_dirt_walk_08.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_dirt_walk_09.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_dirt_walk_10.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_dirt_walk_11.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_dirt_walk_12.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_dirt_walk_13.ogg"
	},
	[MAT_TILE] = {
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_stone_walk_01.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_stone_walk_02.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_stone_walk_03.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_stone_walk_04.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_stone_walk_05.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_stone_walk_06.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_stone_walk_07.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_stone_walk_08.ogg"
	},
	[85] = { -- Grass
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_forest_run_01.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_forest_run_02.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_forest_run_03.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_forest_run_04.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_forest_run_05.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_forest_run_06.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_forest_run_07.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_forest_run_08.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_forest_run_09.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_forest_run_10.ogg"
	},
	[MAT_VENT] = {
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_metal_walk_01.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_metal_walk_02.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_metal_walk_03.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_metal_walk_04.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_metal_walk_05.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_metal_walk_06.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_metal_walk_07.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_metal_walk_08.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_metal_walk_09.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_metal_walk_10.ogg"
	},
	[MAT_GLASS] = {
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_metal_walk_01.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_metal_walk_02.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_metal_walk_03.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_metal_walk_04.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_metal_walk_05.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_metal_walk_06.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_metal_walk_07.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_metal_walk_08.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_metal_walk_09.ogg",
		"cpthazama/avp/xeno/alien/footsteps/new_oct_09/fs_alien_metal_walk_10.ogg"
	}
}
ENT.SoundTbl_Alert = {
	"cpthazama/avp/xeno/alien/vocals/alien_hiss_long_01.ogg",
	"cpthazama/avp/xeno/alien/vocals/alien_hiss_long_02.ogg",
	"cpthazama/avp/xeno/alien/vocals/alien_hiss_scream_long_01.ogg",
	"cpthazama/avp/xeno/alien/vocals/alien_hiss_scream_long_02.ogg",
	"cpthazama/avp/xeno/alien/vocals/alien_hiss_short_01.ogg",
	"cpthazama/avp/xeno/alien/vocals/alien_hiss_short_02.ogg",
}
ENT.SoundTbl_Attack = {
	"cpthazama/avp/xeno/alien/vocals/alien_jump_grunt_01.ogg",
	"cpthazama/avp/xeno/alien/vocals/alien_jump_grunt_03.ogg",
	"cpthazama/avp/xeno/alien/vocals/alien_jump_grunt_05.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_taunt_02.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_taunt_04.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_taunt_06.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_taunt_08.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_taunt_10.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_taunt_12.ogg",
}
ENT.SoundTbl_CombatIdle = {
	"cpthazama/avp/xeno/alien/vocals/alien_growl_short_01.ogg",
	"cpthazama/avp/xeno/alien/vocals/alien_growl_short_02.ogg",
	"cpthazama/avp/xeno/alien/vocals/alien_growl_short_03.ogg",
	"cpthazama/avp/xeno/alien/vocals/alien_growl_short_04.ogg",
	"cpthazama/avp/xeno/alien/vocals/alien_growl_short_05.ogg",
}
-- ENT.SoundTbl_BeforeRangeAttack = {
	-- "cpthazama/avp/weapons/alien/spit/aln_pre_spit_attack_01.ogg",
	-- "cpthazama/avp/weapons/alien/spit/aln_pre_spit_attack_02.ogg",
	-- "cpthazama/avp/weapons/alien/spit/aln_pre_spit_attack_03.ogg",
	-- "cpthazama/avp/weapons/alien/spit/aln_pre_spit_attack_04.ogg",
-- }
ENT.SoundTbl_RangeAttack = {
	"cpthazama/avp/weapons/alien/spit/aln_spit_attack_01.ogg",
	"cpthazama/avp/weapons/alien/spit/aln_spit_attack_01a.ogg",
	"cpthazama/avp/weapons/alien/spit/aln_spit_attack_01b.ogg",
	"cpthazama/avp/weapons/alien/spit/aln_spit_attack_02.ogg",
	"cpthazama/avp/weapons/alien/spit/aln_spit_attack_02a.ogg",
	"cpthazama/avp/weapons/alien/spit/aln_spit_attack_02b.ogg",
	"cpthazama/avp/weapons/alien/spit/aln_spit_attack_03.ogg",
	"cpthazama/avp/weapons/alien/spit/aln_spit_attack_03a.ogg",
	"cpthazama/avp/weapons/alien/spit/aln_spit_attack_03b.ogg",
	"cpthazama/avp/weapons/alien/spit/aln_spit_attack_04.ogg",
	"cpthazama/avp/weapons/alien/spit/aln_spit_attack_04a.ogg",
	"cpthazama/avp/weapons/alien/spit/aln_spit_attack_04b.ogg",
	"cpthazama/avp/weapons/alien/spit/aln_spit_attack_05.ogg",
	"cpthazama/avp/weapons/alien/spit/aln_spit_attack_05a.ogg",
	"cpthazama/avp/weapons/alien/spit/aln_spit_attack_05b.ogg",
}
ENT.SoundTbl_Jump = {
	"cpthazama/avp/xeno/alien/vocals/alien_jump_grunt_01.ogg",
	"cpthazama/avp/xeno/alien/vocals/alien_jump_grunt_02.ogg",
	"cpthazama/avp/xeno/alien/vocals/alien_jump_grunt_03.ogg",
	"cpthazama/avp/xeno/alien/vocals/alien_jump_grunt_04.ogg",
}
ENT.SoundTbl_Pain = {
	"cpthazama/avp/xeno/alien/vocals/aln_pain_small_01.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_pain_small_02.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_pain_small_03.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_pain_small_04.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_pain_small_05.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_pain_small_06.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_pain_small_07.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_pain_small_08.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_pain_small_09.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_pain_small_10.ogg",
}
ENT.SoundTbl_Death = {
	"cpthazama/avp/xeno/alien/vocals/alien_death_scream_iconic_elephant.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_death_scream_20.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_death_scream_21.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_death_scream_22.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_death_scream_23.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_death_scream_24.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_death_scream_25.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_death_scream_26.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_death_scream_27.ogg",
}

ENT.AttackDistance = 130
ENT.AttackDamageDistance = 140
ENT.AttackDamage = 18

ENT.CanSpit = false
ENT.CanStand = true
ENT.CanLeap = true
ENT.CanLeapAttack = true
ENT.CanAttack = true
ENT.CanSprint = true
ENT.CanScreamForHelp = true
ENT.CanSetGroundAngle = true
ENT.CanBlock = true
ENT.AlwaysStand = false
ENT.ReactsToFire = true
ENT.CanBeKnockedDown = true
ENT.DisableFatalities = false
ENT.BulletDamageReductionRequirement = 20
ENT.BulletDamageReduction = 0.2
ENT.FaceEnemyMovements = {ACT_RUN_RELAXED,ACT_RUN,ACT_WALK_STIMULATED,ACT_WALK_RELAXED}
ENT.HitGroups = {
	[HITGROUP_HEAD] = {
		HP = 100,
		Dead = false,
		OnDecap = function(self,dmginfo,hitgroup)
			self:SetBodygroup(self:FindBodygroupByName("m_head"),1)
			self:SetBodygroup(self:FindBodygroupByName("m_mouth"),1)
			self:SetBodygroup(self:FindBodygroupByName("m_mouth_mini"),1)
			self:SetBodygroup(self:FindBodygroupByName("m_face"),2)
			self:SetBodygroup(self:FindBodygroupByName("head"),1)
			self:SetBodygroup(self:FindBodygroupByName("mouth"),1)
			self:SetBodygroup(self:FindBodygroupByName("mouth_mini"),1)
			self:SetBodygroup(self:FindBodygroupByName("face"),2)
			self:SetHealth(0)
			self:TakeDamage(100,dmginfo:GetAttacker(),dmginfo:GetInflictor())
		end,
	},
	[HITGROUP_LEFTARM] = {
		HP = 75,
		Dead = false,
		OnDecap = function(self,dmginfo,hitgroup)
			self:SetBodygroup(self:FindBodygroupByName("m_larm"),1)
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
		HP = 75,
		Dead = false,
		OnDecap = function(self,dmginfo,hitgroup)
			self:SetBodygroup(self:FindBodygroupByName("m_rarm"),1)
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
		HP = 75,
		Dead = false,
		OnDecap = function(self,dmginfo,hitgroup)
			self:SetBodygroup(self:FindBodygroupByName("m_lleg"),1)
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
		HP = 75,
		Dead = false,
		OnDecap = function(self,dmginfo,hitgroup)
			self:SetBodygroup(self:FindBodygroupByName("m_rleg"),1)
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
		HP = 50,
		Dead = false,
		OnDecap = function(self,dmginfo,hitgroup)
			self:SetBodygroup(self:FindBodygroupByName("m_tail_end"),1)
			self:SetBodygroup(self:FindBodygroupByName("tail_end"),1)
			self.Gibbed = self.Gibbed or {}
			self.Gibbed.Tail = true
		end,
	},
	[110] = {
		HP = 50,
		Dead = false,
		OnDecap = function(self,dmginfo,hitgroup)
			self:SetBodygroup(self:FindBodygroupByName("m_tail_main"),1)
			self:SetBodygroup(self:FindBodygroupByName("tail_main"),1)
			self:SetBodygroup(self:FindBodygroupByName("m_tail_end"),2)
			self:SetBodygroup(self:FindBodygroupByName("tail_end"),2)
			self.Gibbed = self.Gibbed or {}
			self.Gibbed.Tail = true
		end,
	},
	[100] = {
		HP = 50,
		Dead = false,
		OnDecap = function(self,dmginfo,hitgroup)
			self:SetBodygroup(self:FindBodygroupByName("m_ltubes"),1)
			self:SetBodygroup(self:FindBodygroupByName("ltubes"),1)
		end,
	},
	[102] = {
		HP = 50,
		Dead = false,
		OnDecap = function(self,dmginfo,hitgroup)
			self:SetBodygroup(self:FindBodygroupByName("m_ltubes"),1)
			self:SetBodygroup(self:FindBodygroupByName("ltubes"),1)
		end,
	},
	[101] = {
		HP = 50,
		Dead = false,
		OnDecap = function(self,dmginfo,hitgroup)
			self:SetBodygroup(self:FindBodygroupByName("m_rtubes"),1)
			self:SetBodygroup(self:FindBodygroupByName("rtubes"),1)
		end,
	},
	[103] = {
		HP = 50,
		Dead = false,
		OnDecap = function(self,dmginfo,hitgroup)
			self:SetBodygroup(self:FindBodygroupByName("m_rtubes"),1)
			self:SetBodygroup(self:FindBodygroupByName("rtubes"),1)
		end,
	},
}
---------------------------------------------------------------------------------------------------------------------------------------------
local defStandingBounds = Vector(13,13,72)
local defCrawlingBounds = Vector(13,13,34)
local table_insert = table.insert
--
function ENT:Init()
	self.CurrentSet = 1 -- Crawl | 2 = Stand
	self.AnimTbl_Flinch = self.AnimTbl_FlinchCrouch
	self.LastSet = 0
	self.LastIdleActivity = ACT_IDLE
	self.LastMovementActivity = ACT_RUN
	self.ChangeSetT = CurTime() +1
	self.IsUsingFaceAnimation = false
	self.StalkingAITime = 0
	self.SprintT = 0
	self.NextSprintT = 0
	self.WasSprinting = false
	self.AI_IsSprinting = false
	self.LastEnemyDistance = 999999
	self.NextMoveRandomlyT = 0
	self.MoveAroundRandomlyT = 0
	self.NextGibbedFXTime = 0
	self.DarknessLevel = false
	self.LastNetworkT = 0
	self.RoyalMorphT = CurTime() +600
	self.CurrentVoiceLineTime = 0
	self.AI_IsBlocking = false
	self.IsBlocking = false
	self.BlockAnimTime = 0
	self.AI_BlockTime = 0
	self.SpecialBlockAnimTime = 0
	self.NextKnockdownT = 0
	self.IsCrawler = false
	self.CanDodge = VJ.AnimExists(self,"dodge_left")
	self.RestraintIdle = VJ.PICK({VJ.SequenceToActivity(self,"Constraints_idle"),VJ.SequenceToActivity(self,"Constraints_idle_02"),VJ.SequenceToActivity(self,"Constraints_idle_03")})
	self.RestraintAlert = VJ.PICK({VJ.SequenceToActivity(self,"Constraints_roar1"),VJ.SequenceToActivity(self,"Constraints_roar2"),VJ.SequenceToActivity(self,"Constraints_roar3")})

	if !self.VJ_AVP_XenomorphLarge then
		self.BreathLoop = CreateSound(self,"cpthazama/avp/xeno/alien/vocals/alien_breathing_steady_01.ogg")
		self.BreathLoop:SetSoundLevel(50)
		self.BreathLoop:Play()

		self.CanEat = true
	end

	if self.OnInit then
		self:OnInit()
	end

	if self.VJ_AVP_K_Xenomorph && GetConVar("vj_avp_kseries_ally"):GetBool() then
		table_insert(self.VJ_NPC_Class,"CLASS_WEYLAND_YUTANI")
	end

    for attName, var in pairs(self.FootData) do
        var.AttID = self:LookupAttachment(attName)
    end

	if self.CanBlock && !VJ.AnimExists(self,ACT_IDLE_STEALTH) then
		self.CanBlock = false
	end

	self:SetJumpAbility(self.CanLeap)
	self:CapabilitiesAdd(bit.bor(CAP_USE))

	if self.CanSpit then
		self.HasRangeAttack = true
	end

	self.CanInteract = VJ.AnimExists(self,"interaction")

	if self.CurrentSet == 2 then
		local bounds = self.StandingBounds or defStandingBounds
		self:SetCollisionBounds(bounds,Vector(-bounds.x, -bounds.y, 0))
	elseif self.CurrentSet == 1 then
		local bounds = self.CrawlingBounds or defCrawlingBounds
		self:SetCollisionBounds(bounds,Vector(-bounds.x, -bounds.y, 0))
	end

	local bounds = self.StandingBounds or defStandingBounds
	local collisionMin, collisionMax = -bounds, bounds
	self:SetSurroundingBounds(Vector(collisionMin.x * 1.8, collisionMin.y * 1.8, collisionMin.z * 1.2), Vector(collisionMax.x * 1.8, collisionMax.y * 1.8, collisionMax.z * 1.2))

	hook.Add("PlayerButtonDown", self, function(self, ply, button)
		if ply.VJ_IsControllingNPC == true && IsValid(ply.VJ_TheControllerEntity) then
			local cent = ply.VJ_TheControllerEntity
            if cent.VJCE_NPC == self then
                cent.VJCE_NPC:OnKeyPressed(ply,button)
            end
        end
    end)

	if self.AlwaysStand then
		self:SetStepHeight(self.StepHeight_Standing or 22)
	else
		self:SetStepHeight(self.StepHeight_Crawling or 100)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnEat(status, statusData)
	if status == "CheckFood" then
		local ent = statusData.owner
		return self:Health() <= self:GetMaxHealth() *0.6 && ent:GetClass() == "prop_ragdoll" && ent.IsVJBaseCorpse && !ent.VJ_AVP_Xenomorph && !ent.VJ_AVP_CorpseHasBeenEaten
	elseif status == "BeginEating" then
		return 0
	elseif status == "Eat" then
		self:HeadbiteCorpse(self.EatingData.Target)
		return 999
	elseif status == "StopEating" then
		if statusData != "Dead" && self.EatingData.AnimStatus != "None" then
			return 0
		end
	end
	return 0
end
-----------------------------------------------------------------------------------------------------------------------------------------------
local math_acos = math.acos
local math_deg = math.deg
local math_abs = math.abs
--
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DoTranslations(act)
	if act == ACT_IDLE then
		if self.IsOnSurface && self.Surface_IsMoving then
			return ACT_RUN
		end
		if self.IsBlocking or self.AI_IsBlocking then
			return ACT_IDLE_STEALTH
		end
		return self:SelectIdleActivity(act)
	elseif act == ACT_WALK or act == ACT_RUN then
		return self:SelectMovementActivity(act)
	end
	return false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:TranslateActivity(act)
	if IsValid(self.Restraint) then
		if self.Alerted && !self.VJ_IsBeingControlled then
			return self.RestraintAlert
		end
		return self.RestraintIdle
	end
	local avp = self:DoTranslations(act)
	if avp then
		-- print(act,avp,self.AnimTranslations[avp])
		local trans = self.AnimTranslations && self.AnimTranslations[avp]
		if trans then
			return trans
		end
		return avp
	end

	local translation = self.AnimationTranslations[act]
	if translation then
		if istable(translation) then
			if act == ACT_IDLE then
				self:ResolveAnimation(translation)
			end
			return translation[math.random(1, #translation)] or act -- "or act" = To make sure it doesn't return nil when the table is empty!
		else
			return translation
		end
	end
	return avp or act
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnChangeActivity(act)
	-- if self.AnimationBehaviors[act] then
	-- 	self.AnimationBehaviors[act](self)
	-- end
	if act == ACT_JUMP then
		VJ.CreateSound(self,self.SoundTbl_Jump,76)
	elseif act == ACT_SPRINT then
		VJ.EmitSound(self,"cpthazama/avp/xeno/alien/footsteps/sprint/alien_sprint_burst_0" .. math.random(1,3) .. ".ogg",70)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local vecZ20 = Vector(0, 0, 20)
--
function ENT:Controller_Initialize(ply,controlEnt)
    net.Start("VJ_AVP_Xeno_Client")
		net.WriteBool(false)
		net.WriteEntity(self)
		net.WriteEntity(ply)
    net.Send(ply)

	controlEnt.VJC_Player_DrawHUD = false

	function controlEnt:OnThink()
		self.VJCE_NPC:SetMoveVelocity(self.VJCE_NPC:GetMoveVelocity() *2)
		self.VJCE_NPC:SetArrivalSpeed(9999)
		self.VJC_NPC_CanTurn = self.VJC_Camera_Mode == 2
		self.VJC_BullseyeTracking = (self.VJCE_NPC:IsMoving() && !self.VJCE_NPC:GetSprinting()) or self.VJC_Camera_Mode == 2
	end

	function controlEnt:OnStopControlling()
		net.Start("VJ_AVP_Xeno_Client")
			net.WriteBool(true)
			net.WriteEntity(self)
			net.WriteEntity(ply)
		net.Send(ply)
	end

	function controlEnt:Think()
		local ply = self.VJCE_Player
		local npc = self.VJCE_NPC
		local camera = self.VJCE_Camera
		if (!camera:IsValid()) then self:StopControlling() return end
		if !IsValid(ply) /*or ply:KeyDown(IN_USE)*/ or ply:Health() <= 0 or (!ply.VJ_IsControllingNPC) or !IsValid(npc) or (npc:Health() <= 0) then self:StopControlling() return end
		if ply.VJ_IsControllingNPC != true then return end
		local curTime = CurTime()
		if ply.VJ_IsControllingNPC && IsValid(npc) then
			local npcWeapon = npc:GetActiveWeapon()
			self.VJC_NPC_LastPos = npc:GetPos()
			ply:SetPos(self.VJC_NPC_LastPos + vecZ20) -- Set the player's location
			self:SendDataToClient()
			
			-- HUD
			if self.VJC_Player_DrawHUD then
				net.Start("vj_controller_hud")
					net.WriteBool(ply:GetInfoNum("vj_npc_cont_hud", 1) == 1)
					net.WriteFloat(npc:GetMaxHealth())
					net.WriteFloat(npc:Health())
					net.WriteString(npc:GetName())
					net.WriteInt(npc.HasMeleeAttack == true && (((npc.IsAbleToMeleeAttack != true or npc.AttackType == VJ.ATTACK_TYPE_MELEE) and 2) or 1) or 0, 3)
					net.WriteInt(npc.HasRangeAttack == true && (((npc.IsAbleToRangeAttack != true or npc.AttackType == VJ.ATTACK_TYPE_RANGE) and 2) or 1) or 0, 3)
					net.WriteInt(npc.HasLeapAttack == true && (((npc.IsAbleToLeapAttack != true or npc.AttackType == VJ.ATTACK_TYPE_LEAP) and 2) or 1) or 0, 3)
					net.WriteBool(IsValid(npcWeapon))
					net.WriteInt(IsValid(npcWeapon) && npcWeapon:Clip1() or 0, 32)
					net.WriteInt(npc.HasGrenadeAttack == true && ((curTime <= npc.NextThrowGrenadeT and 2) or 1) or 0, 3)
				net.Send(ply)
			end
			
			local wepList = ply:GetWeapons()
			if #wepList > 0 then
				for _, v in ipairs(wepList) do
					if !v.VJBase_IsControllerWeapon then
						ply:StripWeapon(v:GetClass())
					end
				end
			end
	
			local bullseyePos = self.VJCE_Bullseye:GetPos()
			if ply:GetInfoNum("vj_npc_cont_debug", 0) == 1 then
				VJ.DEBUG_TempEnt(ply:GetPos(), self:GetAngles(), Color(0,109,160)) -- Player's position
				VJ.DEBUG_TempEnt(camera:GetPos(), self:GetAngles(), Color(255,200,260)) -- Camera's position
				VJ.DEBUG_TempEnt(bullseyePos, self:GetAngles(), Color(255,0,0)) -- Bullseye's position
			end
			
			self:OnThink()
	
			local canTurn = true
			if npc.Flinching == true or (((npc.CurrentSchedule && !npc.CurrentSchedule.IsPlayActivity) or npc.CurrentSchedule == nil) && npc:GetNavType() == NAV_JUMP) then return end
	
			-- Weapon attack
			if npc.IsVJBaseSNPC_Human == true then
				if IsValid(npcWeapon) && !npc:IsMoving() && npcWeapon.IsVJBaseWeapon == true && ply:KeyDown(IN_ATTACK2) && npc.AttackType == VJ.ATTACK_TYPE_NONE && npc.PauseAttacks == false && npc:GetWeaponState() == VJ.WEP_STATE_READY then
					//npc:SetAngles(Angle(0,math.ApproachAngle(npc:GetAngles().y,ply:GetAimVector():Angle().y,100),0))
					npc:SetTurnTarget(bullseyePos, 0.2)
					canTurn = false
					if VJ.IsCurrentAnim(npc, npc:TranslateActivity(npc.WeaponAttackAnim)) == false && VJ.IsCurrentAnim(npc, npc.AnimTbl_WeaponAttack) == false then
						npc:OnWeaponAttack()
						npc.WeaponAttackAnim = VJ.PICK(npc.AnimTbl_WeaponAttack)
						npc:PlayAnim(npc.WeaponAttackAnim, false, 2, false)
						npc.WeaponAttackState = VJ.WEP_ATTACK_STATE_FIRE_STAND
					end
				end
				if !ply:KeyDown(IN_ATTACK2) then
					npc.WeaponAttackState = VJ.WEP_ATTACK_STATE_NONE
				end
			end
			
			if npc.AttackAnimTime < CurTime() && curTime > npc.NextChaseTime && npc.IsVJBaseSNPC_Tank != true then
				-- Turning
				if !npc:IsMoving() && canTurn && npc.MovementType != VJ_MOVETYPE_PHYSICS && ((npc.IsVJBaseSNPC_Human && npc:GetWeaponState() != VJ.WEP_STATE_RELOADING) or (!npc.IsVJBaseSNPC_Human)) then
					npc:SCHEDULE_IDLE_STAND()
					if self.VJC_NPC_CanTurn == true then
						local turnData = npc.TurnData
						if turnData.Target != self.VJCE_Bullseye then
							npc:SetTurnTarget(self.VJCE_Bullseye, 1)
						elseif npc:GetActivity() == ACT_IDLE && npc:GetIdealActivity() == ACT_IDLE then -- Check both current act AND ideal act because certain activities only change the current act (Ex: UpdateTurnActivity function)
							npc:UpdateTurnActivity()
							if npc:GetIdealActivity() != ACT_IDLE then -- If ideal act is no longer idle, then we have selected a turn activity!
								npc.NextIdleTime = CurTime() + npc:DecideAnimationLength(npc:GetIdealActivity())
							end
						end
					end
					//self.TestLerp = npc:GetAngles().y
					//npc:SetAngles(Angle(0,Lerp(100*FrameTime(),self.TestLerp,ply:GetAimVector():Angle().y),0))
				end
				
				-- Movement
				npc:Controller_Movement(self, ply, bullseyePos)
				
				//if (ply:KeyDown(IN_USE)) then
					//npc:StopMoving()
					//self:StopControlling()
				//end
			end
		end
		self:NextThink(curTime)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnAlert(ent)
	if self.VJ_AVP_XenomorphLarge then return end
	if !self.CanScreamForHelp then return end
	if math.random(1,10) == 1 && !self:IsBusy() && ent:Visible(self) && self.EnemyData.DistanceNearest > 1000 then
		VJ.STOPSOUND(self.CurrentSpeechSound)
		VJ.STOPSOUND(self.CurrentIdleSound)
		self:PlayAnim("hiss_reaction",true,false,false)
		self:PlaySound({"cpthazama/avp/xeno/alien/vocals/alien_hiss_scream_long_01.ogg","cpthazama/avp/xeno/alien/vocals/alien_hiss_scream_long_02.ogg"},80)
		VJ.EmitSound(self,"cpthazama/avp/xeno/alien/vocals/alien_call_scream_01.ogg",90)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnCallForHelp(ally)
	if self.VJ_AVP_XenomorphLarge or !self.CanScreamForHelp or self:IsBusy() then return end
	if math.random(1,10) != 1 then return end
	VJ.STOPSOUND(self.CurrentSpeechSound)
	VJ.STOPSOUND(self.CurrentIdleSound)
	self:PlayAnim("hiss_reaction",true,false,false)
	self:PlaySound({"cpthazama/avp/xeno/alien/vocals/alien_hiss_scream_long_01.ogg","cpthazama/avp/xeno/alien/vocals/alien_hiss_scream_long_02.ogg"},80)
	VJ.EmitSound(self,"cpthazama/avp/xeno/alien/vocals/alien_call_scream_01.ogg",90)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnMeleeAttack_AfterChecks(v,isProp)
	if self.OnHitEntity then
		self:OnHitEntity(v,isProp)
	end
	if self.VJ_AVP_XenomorphRunner && !v.VJ_AVP_Xenomorph && !v.VJ_AVP_IsTech && math.random(1,4) == 1 then
		if v:IsPlayer() && v:HasGodMode() then return end
		local tName = "VJ.AVP.Timer.BlackGoo." .. v:EntIndex()
		if v:IsPlayer() && !timer.Exists(tName) then
			VJ_AVP_CSound(v,"cpthazama/avp/shared/grapple/grapple_sting_01.ogg")
			v:ScreenFade(SCREENFADE.IN,Color(0,0,0),0.35,0.1)
		end
		if !timer.Exists(tName) then
			v.VJ_AVP_XenomorphRunnerDMG = 1
			v.VJ_AVP_XenomorphRunnerDMGFrags = v:IsPlayer() && v:Deaths() or 0
		end
		timer.Create(tName,10,6,function()
			if IsValid(v) && v:Health() > 0 then
				if v:IsPlayer() && v:Deaths() > v.VJ_AVP_XenomorphRunnerDMGFrags then
					timer.Remove(tName)
					return
				end
				local pos = v:EyePos() +v:GetForward() *5
				local att = v:LookupAttachment("mouth")
				if att > 0 then
					pos = v:GetAttachment(att).Pos
				end
				local particle = ents.Create("info_particle_system")
				particle:SetKeyValue("effect_name","vj_avp_xeno_blackgoo")
				particle:SetPos(pos)
				particle:Spawn()
				particle:Activate()
				particle:SetParent(v)
				particle:Fire("Start")
				particle:Fire("Kill","",1.25)
				if att > 0 then
					particle:Fire("SetParentAttachment","mouth",0)
				end
				if v:IsPlayer() then
					v:ScreenFade(SCREENFADE.IN,Color(0,0,0,245),0.35,0.8)
				end
				for i = 1,15 do
					timer.Simple(i *0.05,function()
						if IsValid(v) && v:Health() > 0 then
							local oldBleeds = v.Bleeds
							local oldDamageAllyResponse = v.DamageAllyResponse
							local oldIdleDamageResponse = v.DamageResponse
							if v.IsVJBaseSNPC then
								v.Bleeds = false
								v.DamageAllyResponse = false
								v.DamageResponse = "OnlySearch"
							end
							local dmgEnt = IsValid(self) && self or v
							local dmginfo = DamageInfo()
							dmginfo:SetDamage(v.VJ_AVP_XenomorphRunnerDMG or 1)
							dmginfo:SetDamageType(i == 1 && bit.bor(DMG_ACID,DMG_DIRECT,DMG_DROWN) or bit.bor(DMG_ACID,DMG_DIRECT))
							dmginfo:SetAttacker(dmgEnt)
							dmginfo:SetInflictor(dmgEnt)
							dmginfo:SetDamagePosition(pos)
							v:TakeDamageInfo(dmginfo)
							if v:IsPlayer() then
								v:ViewPunch(Angle(10,0,0))
								v:SetVelocity(v:GetVelocity() *-1.3)
							end
							if v.IsVJBaseSNPC then
								v.Bleeds = oldBleeds
								v.DamageAllyResponse = oldDamageAllyResponse
								v.DamageResponse = oldIdleDamageResponse
							end
						else
							timer.Remove(tName)
						end
					end)
				end
				v.VJ_AVP_XenomorphRunnerDMG = (v.VJ_AVP_XenomorphRunnerDMG or 1) +1
			else
				timer.Remove(tName)
			end
		end)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:HandlePerceivedRelationship(v)
	local darkness = self.DarknessLevel
	if darkness && darkness <= 0.065 && !self:IsMoving() then
		if v.VJ_AVP_Xenomorph or v.VJ_AVP_Predator && v:GetVisionMode() == 2 then
			return
		end
		if v:GetPos():Distance(self:GetPos()) > (650 *(darkness *10)) then
			if v:HasEnemyMemory(self) then
				v:ClearEnemyMemory(self)
			end
			if v:GetEnemy() == self then
				v:SetEnemy(nil)
			end
			return D_NU
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:FootStep(pos,name)
	if !self:IsOnGround() then return end
	if self.CurrentSet == 2 && (name == "lhand" or name == "rhand") then return end
	local tbl = self.SoundTbl_FootSteps
	if !tbl then
		return
	end
	local tr = util.TraceLine({
		start = self:GetPos(),
		endpos = self:GetPos() +Vector(0,0,-150),
		filter = {self}
	})
	local matType = tr.MatType
	if matType && tbl[matType] == nil then
		matType = MAT_CONCRETE
	end
	if tr.Hit && tbl[matType] then
		local snd = VJ.PICK(tbl[matType])
		sound.Play(snd,pos,self.FootstepSoundLevel,self:GetSoundPitch(self.FootstepSoundPitch))
		VJ.EmitSound(self,snd,10)
	end
	if self:WaterLevel() > 0 && self:WaterLevel() < 3 then
		VJ.EmitSound(self,"player/footsteps/wade" .. math.random(1,8) .. ".wav",self.FootstepSoundLevel,self:GetSoundPitch(self.FootstepSoundPitch))
	end
	if self.OnStep then
		self:OnStep(pos,name)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local NPCTbl_Animals = {npc_barnacle=true,npc_crow=true,npc_pigeon=true,npc_seagull=true,monster_cockroach=true}
--
function ENT:CheckRelationship(ent)
	if ent.ForceEntAsEnemy then
		if ent.ForceEntAsEnemy == self then
			return D_HT
		else
			return D_NU
		end
	end
	-- if ent.ForceEntAsEnemy == self then return D_HT end -- Always enemy to me (Used by the bullseye under certain circumstances)
	if ent:IsFlagSet(FL_NOTARGET) or NPCTbl_Animals[ent:GetClass()] then return D_NU end
	if self:GetClass() == ent:GetClass() then return D_LI end
	if ent:Health() > 0 && self:Disposition(ent) != D_LI then
		local isPly = ent:IsPlayer()
		if isPly && VJ_CVAR_IGNOREPLAYERS then return D_NU end
		local entDisp = ent.Disposition and ent:Disposition(self)
		if !self.SpawnedUsingMutator && !ent:Visible(self) && ent:GetPos():Distance(self:GetPos()) > self:GetMaxLookDistance() *0.075 then
			return D_NU
		end
		if (ent:IsNPC() && ((entDisp == D_HT) or (entDisp == D_NU && ent.VJ_IsBeingControlled))) or (isPly && ent:Alive()) then
			return D_HT
		else
			return D_NU
		end
	end
	return D_LI
end
---------------------------------------------------------------------------------------------------------------------------------------------
local colFade = {
	["Red"] = Color(128,0,0),
	["Yellow"] = Color(208,208,28),
	["Green"] = Color(13,212,13),
	["Orange"] = Color(244,135,33),
	["Blue"] = Color(0,68,128),
	["Purple"] = Color(128,0,128),
	["White"] = Color(220,220,220),
	["Oil"] = Color(52,52,52),
}

-- local vecZ30 = Vector(0,0,30)
-- local vecZ1 = Vector(0,0,1)
local vec256 = Vector(0,0,-256)
local math_Clamp = math.Clamp
--
function ENT:HeadbiteCorpse(ent)
	local ply = self.VJ_TheController
	VJ.CreateSound(self,"cpthazama/avp/xeno/alien/special/alien_brainbite_out_direct.ogg",75)
	self:PlayAnim("headbite_2ndry",true,false,false,0,{AlwaysUseGesture=true,GesturePlayBackRate=1})
	ent.VJ_AVP_CorpseHasBeenEaten = true
	if !ent.VJ_AVP_IsTech then
	-- if ent.BloodData.Color != "White" then
		self:SetHealth(self:Health() +math_Clamp(self:GetMaxHealth() *0.5,0,250))
	end
	if ent.OnHeadAte then
		ent:OnHeadAte(self)
	end
	local att1 = ent:LookupAttachment("eyes")
	local att2 = ent:LookupAttachment("forward")
	local att = (att1 > 0 && att1 or att2 > 0 && att2) or false
	if IsValid(ply) then
		net.Start("VJ.AVP.XenoEat")
			net.WriteEntity(ent)
			net.WriteTable(ent.BloodData)
		net.Send(ply)
		ply:ScreenFade(SCREENFADE.IN,colFade[ent.BloodData.Color] or Color(128,0,0),2,0.5)
	end
	if att then
		local pos = ent:GetAttachment(att).Pos
		local effect = VJ.PICK(ent.BloodData.Particle)
		ParticleEffect(effect,pos,Angle())
		local randVec = VectorRand() *48
		randVec.z = 0
		local tr = util.TraceLine({start = pos,endpos = pos +vec256 +randVec,filter = ent})
		local trNormalP = tr.HitPos +tr.HitNormal
		local trNormalN = tr.HitPos -tr.HitNormal
		util.Decal(VJ.PICK(ent.BloodData.Decal),trNormalP,trNormalN,ent)
		for _ = 1, 2 do
			if math.random(1, 2) == 1 then
				util.Decal(VJ.PICK(ent.BloodData.Decal), trNormalP +Vector(math.random(-70,70),math.random(-70,70),0),trNormalN,ent)
			end
		end
		-- local tr = util.TraceLine({
		-- 	start = pos,
		-- 	endpos = pos -vecZ30,
		-- 	filter = ent,
		-- 	mask = CONTENTS_SOLID
		-- })
		-- if tr.HitWorld && (tr.HitNormal == vecZ1) then
		-- 	ParticleEffect(getBloodPool,tr.HitPos,Angle())
		-- end
		for i = 1,math.random(6,12) do
			timer.Simple(i *0.25,function()
				if IsValid(ent) then
					pos = ent:GetAttachment(att).Pos
					ParticleEffect(effect,pos,Angle())
					local randVec = VectorRand() *48
					randVec.z = 0
					local tr = util.TraceLine({start = pos,endpos = pos +vec256 +randVec,filter = ent})
					local trNormalP = tr.HitPos +tr.HitNormal
					local trNormalN = tr.HitPos -tr.HitNormal
					util.Decal(VJ.PICK(ent.BloodData.Decal),trNormalP,trNormalN,ent)
				end
			end)
		end
		sound.Play("cpthazama/avp/weapons/alien/jaw/alien_jaw_impale_0" .. math.random(1,5) .. ".ogg",pos,72)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SapBattery(ent)
	local _,animDur = self:VJ_ACT_PLAYACTIVITY("interaction",true,false,false,0,{OnFinish=function()
		self.BatteryEnt = nil
	end})
	self:SetTurnTarget(ent,1,true)
	self.BatteryEnt = ent
	self:SetPos(ent:GetPos() +ent:GetForward() *35 +ent:GetUp() *6)
	self:SetAngles(Angle(0,(ent:GetPos() -self:GetPos()):Angle().y,0))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DestroyConsole(ent)
	local _,animDur = self:VJ_ACT_PLAYACTIVITY("interaction",true,false,false,0,{OnFinish=function()
		self.ConsoleEnt = nil
	end})
	self:SetTurnTarget(ent,1,true)
	self.ConsoleEnt = ent
	self:SetPos(ent:GetPos() +ent:GetForward() *43 +ent:GetUp() *6)
	self:SetAngles(Angle(0,(ent:GetPos() -self:GetPos()):Angle().y,0))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:TranslateNavGoal(ent,goal)
	if ent.EntityClass == AVP_ENTITYCLASS_SENTRYGUN && self.CanInteract then
		local RC = ent.RC
		if IsValid(RC) then
			if self:GetPos():Distance(RC:GetPos()) <= 80 && !self:IsBusy() then
				self:DestroyConsole(RC)
				return
			end
			return RC:GetPos() +RC:GetForward() *50
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnKeyPressed(ply,key)
	if self.OnKey then
		self:OnKey(ply,key)
	end
    if key == KEY_E then
		local tr = util.TraceLine({
			start = self:EyePos(),
			endpos = self:EyePos() +ply:GetAimVector() *128,
			filter = {self,ply}
		})
		local ent = tr.Entity
		if ent == Entity(0) then
			for _,v in pairs(ents.FindInSphere(tr.HitPos,128)) do
				if v:GetClass() == "prop_ragdoll" && v:GetCollisionGroup() == COLLISION_GROUP_DEBRIS then
					ent = v
					break
				end
			end
		end
		if tr.Hit && IsValid(ent) then
			if !ent:IsNPC() && !ent:IsPlayer() then
				if self.CanInteract && ent:GetClass() == "sent_vj_avp_battery" && ent.BatteryLife > 0 && !self:IsBusy() then
					self:SapBattery(ent)
					return
				elseif self.CanInteract && ent:GetClass() == "sent_vj_avp_controller" && !self:IsBusy() then
					self:DestroyConsole(ent)
					return
				end
				ent:Fire("Use",nil,0,ply,self)
				return
			end
			-- print(ent,ent.IsVJBaseCorpse,!ent.VJ_AVP_Xenomorph,!ent.VJ_AVP_CorpseHasBeenEaten,!self:IsBusy())
			-- print(ent,"Has been eaten?",ent.VJ_AVP_CorpseHasBeenEaten)
			if ent:GetClass() == "prop_ragdoll" && ent.IsVJBaseCorpse && !ent.VJ_AVP_Xenomorph && !ent.VJ_AVP_CorpseHasBeenEaten && !self:IsBusy() then
				self:HeadbiteCorpse(ent)
			elseif ent:IsNPC() && self.EnemyData.DistanceNearest <= self.AttackDistance && self.CanAttack && !self:IsBusy() then
				local canUse, inFront = self:CanUseFatality(ent)
				if canUse then
					self:DoFatality(ent,inFront)
					return
				end
			end
		end
	elseif key == KEY_LCONTROL then
		if CurTime() > self.ChangeSetT then
			self.CurrentSet = (self.CurrentSet == 1 && self.CanStand) && 2 or 1
			self.ChangeSetT = CurTime() +0.5
			self.NextIdleTime = 0
			self.NextIdleStandTime = 0
			if self.CurrentSet == 1 then
				self.AnimTbl_Flinch = self.AnimTbl_FlinchCrouch
			else
				self.AnimTbl_Flinch = self.AnimTbl_FlinchStand
			end
		end
	elseif key == KEY_R then
		self.DistractT = self.DistractT or 0
		if CurTime() < self.DistractT or self:IsBusy() then return end

		VJ.STOPSOUND(self.CurrentSpeechSound)
		VJ.STOPSOUND(self.CurrentIdleSound)
		self.DistractT = CurTime() +SoundDuration("cpthazama/avp/xeno/alien/vocals/alien_distract_01.ogg") +5
		VJ.CreateSound(self,self.DistractionSound or "cpthazama/avp/xeno/alien/vocals/alien_distract_01.ogg",65)

		for _,ent in pairs(ents.FindInSphere(self:GetPos(),1200)) do
			if ent:IsNPC() && self:CheckRelationship(ent) == D_HT then
				self:DistractionCode(ent)
			end
		end
		-- local tr = util.TraceHull({
		-- 	start = self:EyePos(),
		-- 	endpos = self:EyePos() +ply:GetAimVector() *1200,
		-- 	filter = {self,ply,self.VJ_TheControllerBullseye,ply:GetViewModel(),ply:GetActiveWeapon()},
		-- 	mins = Vector(-10,-10,-10),
		-- 	maxs = Vector(10,10,10)
		-- })
		-- if tr.Hit && IsValid(tr.Entity) then
		-- 	local ent = tr.Entity
		-- 	if (ent:IsNPC() or ent:IsPlayer()) && self:CheckRelationship(ent) == D_HT then
		-- 		self:DistractionCode(ent)
		-- 	end
		-- end
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DistractionCode(ent)
	local soundPos = self:GetPos() +VectorRand() *300
	local nodegraph = table.Copy(VJ_Nodegraph.Data.Nodes)
	local possibleNodes = {}
	for _,node in pairs(nodegraph) do
		if node.type == 2 && self:GetPos():Distance(node.pos) < 400 then
			table_insert(possibleNodes,node.pos)
		end
	end
	if #possibleNodes > 0 then
		soundPos = VJ.PICK(possibleNodes)
	end
	if ent:IsNPC() then
		if ent.IsVJBaseSNPC && !ent:IsBusy() && !ent.Alerted then
			ent:SetLastPosition(soundPos)
			ent:SCHEDULE_GOTO_POSITION("TASK_WALK_PATH",function(x)
				x.CanShootWhenMoving = true
				if ent.OnDistracted then
					x.RunCode_OnFinish = function()
						timer.Simple(0.01, function()
							if IsValid(ent) && !ent:IsBusy() then
								ent:OnDistracted(2)
							end
						end)
					end
				end
			end)

			if ent.OnDistracted then
				ent:OnDistracted(1)
			else
				ent:OnInvestigate(ent)
				ent:PlaySoundSystem(#ent.SoundTbl_Investigate > 0 && "Investigate" or "Alert")
			end
		elseif !ent.IsVJBaseSNPC then
			ent:SetLastPosition(soundPos)
			ent:SetSchedule(SCHED_FORCED_GO)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
-- local vecZ50 = Vector(0, 0, -50)
--
-- function ENT:OnEat(status, statusData)
-- 	if status == "CheckFood" then
-- 		if statusData.owner.VJ_AVP_Xenomorph or statusData.owner.VJ_AVP_IsTech then
-- 			return false
-- 		end
-- 		return true
-- 	elseif status == "BeginEating" then
-- 		self.Cur_Idle = VJ.SequenceToActivity(self, "ai_eat_corpse")
-- 		return select(2, self:PlayAnim("ai_eat_corpse_start", true, false))
-- 	elseif status == "Eat" then
-- 		VJ.EmitSound(self, "cpthazama/avp/xeno/alien/special/flesh eat/flesh_eat_0"..math.random(1, 7)..".ogg", 65)
-- 		-- Health changes
-- 		local food = self.EatingData.Target
-- 		local damage = 1 -- How much damage food will receive
-- 		local foodHP = food:Health() -- Food's health
-- 		local myHP = self:Health() -- NPC's current health
-- 		self:SetHealth(math.Clamp(myHP + ((damage > foodHP and foodHP) or damage), myHP, self:GetMaxHealth() < myHP and myHP or self:GetMaxHealth())) -- Give health to the NPC
-- 		food:SetHealth(foodHP - damage) -- Decrease corpse health
-- 		local bloodData = food.BloodData
-- 		if bloodData then
-- 			local bloodPos = food:GetPos() + food:OBBCenter()
-- 			local bloodParticle = VJ.PICK(bloodData.Particle)
-- 			if bloodParticle then
-- 				ParticleEffect(bloodParticle, bloodPos, self:GetAngles())
-- 			end
-- 			local bloodDecal = VJ.PICK(bloodData.Decal)
-- 			if bloodDecal then
-- 				local tr = util.TraceLine({start = bloodPos, endpos = bloodPos + vecZ50, filter = {food, self}})
-- 				util.Decal(bloodDecal, tr.HitPos + tr.HitNormal + Vector(math.random(-45, 45), math.random(-45, 45), 0), tr.HitPos - tr.HitNormal, food)
-- 			end
-- 		end
-- 		local phys = food:GetPhysicsObject()
-- 		if IsValid(phys) then
-- 			for i = 0, food:GetPhysicsObjectCount() - 1 do
-- 				local bone = food:GetPhysicsObjectNum(i)
-- 				if IsValid(bone) then
-- 					bone:ApplyForceCenter(VectorRand() *bone:GetMass() *(self.IsQueen && 128 or 64))
-- 				end
-- 			end
-- 		end
-- 		return 1
-- 	elseif status == "StopEating" then
-- 		self.Cur_Idle = nil
-- 		if statusData != "Dead" && self.EatingData.AnimStatus != "None" then
-- 			return 0.2
-- 		end
-- 	end
-- 	return 0
-- end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnAttackBlocked(ent)
	sound.Play("cpthazama/avp/weapons/predator/wrist_blades/prd_wrist_blades_block_0" .. math.random(1,5) .. ".ogg",ent:GetPos() +ent:OBBCenter(),70)
	local _,dir = self:PlayAnim("crawl_stand_attack_" .. self.AttackSide .. "_countered",true,false,false)
	self.BlockAttackT = CurTime() +(dir *1.4)
end
---------------------------------------------------------------------------------------------------------------------------------------------
local tblA = {
	Trophy = {
		Grab = "v_alien_headbite_grab",
		Lift = "v_alien_headbite_grapple",
		Counter = "v_alien_headbite_countered",
		Kill = "v_alien_headbite_kill"
	},
	Stealth = {
		Grab = "v_alien_headbitebehind_grapple",
		Counter = "v_alien_headbitebehind_countered",
		Kill = "v_alien_headbitebehind_kill"
	}
}
local tblB = {
	Trophy = {
		Grab = "v_alien_tailstab_head_front_grapple",
		Counter = "v_alien_tailstab_head_front_countered",
		Kill = "v_alien_tailstab_head_front_kill"
	},
	Stealth = {
		Grab = "v_alien_stealthkill_grapple",
		Counter = "v_alien_stealthkill_countered",
		Kill = "v_alien_stealthkill_kill"
	}
}
local tblC = {
	Trophy = {
		Grab = "v_alien_tailstab_head_front_grapple",
		Counter = "v_alien_tailstab_head_front_countered",
		Kill = "v_alien_tailstab_head_front_kill"
	},
	Stealth = {
		Kill = "v_alien_stealthkill_take_off_face",
		OnlyKill = true
	}
}
--
function ENT:OnBeforeDoFatality(ent,fType)
	if fType == "Alien" then
		local group = math.random(1,3)
		if group == 1 then
			return tblA
		elseif group == 2 then
			return tblB
		else
			return tblC
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:LongJumpCode(gotoPos,atk)
	if self.InFatality or self.DoingFatality then return end
	if !self.CanLeap then return end
	self.CurrentSet = 1
	self.AnimTbl_Flinch = self.AnimTbl_FlinchCrouch
	self.ChangeSetT = CurTime() +0.5
	local ply = self.VJ_TheController
	local bullseye = self.VJ_TheControllerBullseye
	local aimVec = IsValid(ply) && ply:GetAimVector()
	local tr1
	local canJump = true
	self:SetMoveType(MOVETYPE_STEP)
	self:CapabilitiesAdd(bit.bor(CAP_MOVE_GROUND))
	if gotoPos then
		tr1 = util.TraceLine({
			start = self:EyePos(),
			endpos = gotoPos +Vector(0,0,self:OBBMaxs().z),
			filter = {self,ply,bullseye}
		})
		canJump = self:VisibleVec(gotoPos)
	else
		tr1 = util.TraceLine({
			start = self:EyePos(),
			endpos = self:EyePos() +(IsValid(ply) && aimVec *(atk && 600 or 1000) or self:GetForward() *600),
			filter = {self,ply,bullseye}
		})
	end
	if !canJump then return end
	local firstHit = tr1.HitPos
	local hitNormal = tr1.HitNormal
	local trSt
	if math_abs(hitNormal.x) >= 0.9 or math_abs(hitNormal.y) >= 0.9 then
		// Normal ground stuff
		-- Entity(1):ChatPrint('Wall')
		trSt = tr1
		self.LongJumpType = 2
	-- elseif hitNormal.z == -1 then
		// Ceiling
		-- Entity(1):ChatPrint('Ceiling')
		-- trSt = tr1
		-- self.LongJumpType = 1
	else
		-- Entity(1):ChatPrint('Ground')
		local upCheck1 = util.TraceLine({
			start = firstHit,
			endpos = firstHit +self:GetUp() *200,
			filter = {self,ply,bullseye}
		})
		if upCheck1 then
			local pos = upCheck1.HitPos +(upCheck1.HitPos -self:GetPos()):GetNormalized() *64
			-- VJ.DEBUG_TempEnt(pos, self:GetAngles(), Color(255,242,0), 5)
			trSt = util.TraceLine({
				start = pos,
				endpos = pos +self:GetUp() *-2000,
				filter = {self,ply,bullseye}
			})
			-- VJ.DEBUG_TempEnt(trSt.HitPos, self:GetAngles(), Color(255,0,212), 5)
		else
			trSt = util.TraceLine({
				start = firstHit,
				endpos = firstHit +self:GetUp() *-2000,
				filter = {self,ply,bullseye}
			})
			-- VJ.DEBUG_TempEnt(trSt.HitPos, self:GetAngles(), Color(17,255,0), 5)
		end
		self.LongJumpType = 0
	end
	-- Entity(1):ChatPrint(tostring(hitNormal))
	-- VJ.DEBUG_TempEnt(firstHit, self:GetAngles(), Color(255,0,0), 5)

	-- VJ.DEBUG_TempEnt(trSt.HitPos +trSt.HitNormal *4, self:GetAngles(), Color(13,0,255), 5)
	self.LongJumpPos = trSt.HitPos
	self.LongJumpAttacking = atk
	self.JumpT = 0
	local anim = "jump_fwd"
	self:SetTurnTarget(self.LongJumpPos, 1)
	self:PlayAnim(anim,true,false,false)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CalculateTrajectory(start, goal, pitch)
	local g = physenv.GetGravity():Length()
	local vec = Vector(goal.x - start.x, goal.y - start.y, 0)
	local x = vec:Length()
	local y = goal.z - start.z
	if pitch > 90 then pitch = 90 end
	if pitch < -90 then pitch = -90 end
	pitch = math.rad(pitch)
	if y < math.tan(pitch)*x then
		magnitude = math.sqrt((-g*x^2)/(2*math.pow(math.cos(pitch), 2)*(y - x*math.tan(pitch))))
		vec.z = math.tan(pitch)*x
		return vec:GetNormalized()*magnitude
	end
	return self:CalculateProjectile("Curve",start,goal,1200)
end
---------------------------------------------------------------------------------------------------------------------------------------------
local sdClawFlesh = {
	"cpthazama/avp/weapons/alien/claws/alien_claw_impact_flesh_01.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_impact_flesh_02.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_impact_flesh_03.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_impact_flesh_04.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_impact_flesh_05.ogg",
}
local sdClawMiss = {
	"cpthazama/avp/weapons/alien/claws/alien_claw_swipe_01.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_swipe_02.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_swipe_03.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_swipe_04.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_swipe_05.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_swipe_06.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_swipe_07.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_swipe_08.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_swipe_09.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_swipe_10.ogg",
}
local sdMM = {
	"cpthazama/avp/weapons/alien/claws/alien_claw_impact_mn_01.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_impact_mn_02.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_impact_mn_03.ogg",
}
local sdTail = {
	"cpthazama/avp/weapons/alien/tail/alien_heavyattack_tailstab_mn_01.ogg",
	"cpthazama/avp/weapons/alien/tail/alien_heavyattack_tailstab_mn_02.ogg",
	"cpthazama/avp/weapons/alien/tail/alien_heavyattack_tailstab_mn_03.ogg",
	"cpthazama/avp/weapons/alien/tail/alien_tail_impact_flesh_01.ogg",
	"cpthazama/avp/weapons/alien/tail/alien_tail_impact_flesh_02.ogg",
	"cpthazama/avp/weapons/alien/tail/alien_tail_impact_flesh_03.ogg",
	"cpthazama/avp/weapons/alien/tail/alien_tail_impact_flesh_04.ogg",
	"cpthazama/avp/weapons/alien/tail/alien_tail_impact_flesh_05.ogg",
}
local sdTailMiss = {
	"cpthazama/avp/weapons/alien/tail/alien_tailswipe_tp_1.ogg",
	"cpthazama/avp/weapons/alien/tail/alien_tailswipe_tp_2.ogg",
	"cpthazama/avp/weapons/alien/tail/alien_tailswipe_tp_3.ogg",
	"cpthazama/avp/weapons/alien/tail/alien_tailswipe_tp_4.ogg",
	"cpthazama/avp/weapons/alien/tail/alien_tailswipe_tp_5.ogg",
	"cpthazama/avp/weapons/alien/tail/alien_tailswipe_tp_6.ogg",
}

local string_StartWith = string.StartWith
local string_Replace = string.Replace
--
function ENT:OnInput(key,activator,caller,data)
	if self.OnInput2 then
		self:OnInput2(key)
	end
	if key == "jump_start" then
		self:DoChangeMovementType(VJ_MOVETYPE_GROUND)
		self:SetLocalVelocity(Vector(0,0,0))
		self.IsOnSurface = false
		self:SetJumpPosition(self.LongJumpPos)
		self.LongJumping = true
		self.JumpStart = self:GetPos()
		self:PlaySound(self.SoundTbl_Jump,75)
	elseif key == "jump_end" then
		self.LongJumping = false
		self:SetJumpPosition(Vector(0,0,0))
		self:SetLocalVelocity(Vector(0,0,0))
		self:SetVelocity(self:GetForward() *150 +Vector(0,0,-100))
		VJ.EmitSound(self,"cpthazama/avp/xeno/alien/footsteps/land/alien_land_stone_1"  .. math.random(0,2) .. ".ogg",75)
		if self.VJ_AVP_XenomorphPredalien then
			self.AttackDamage = 30
			self.AttackDamageDistance = 140
			self.AttackDamageType = bit.bor(DMG_SLASH,DMG_CRUSH)
			local dmgcode = self:RunDamageCode()
			if #dmgcode > 0 then
				VJ.EmitSound(self,sdClawFlesh,75)
			end
			util.ScreenShake(self:GetPos(),8,200,2,500)
		end
		local tr = util.TraceLine({
			start = self:GetPos(),
			endpos = self:GetPos() +self:GetUp() *-100,
			filter = {self},
			mask = MASK_SOLID_BRUSHONLY
		})
		if tr.Hit then
			local fx = EffectData()
			fx:SetOrigin(tr.HitPos)
			fx:SetScale(2)
			fx:SetMagnitude(2)
			fx:SetNormal(self:GetUp())
			util.Effect("ElectricSpark",fx)
			for _ = 1,16 do
				util.Effect("GlassImpact",fx)
			end
		end
		if self.LongJumpType && self.LongJumpType > 0 && self:GetPos():Distance(self.LongJumpPos) <= 60 then
			self:SetMoveType(MOVETYPE_NONE)
			self:CapabilitiesRemove(CAP_MOVE_GROUND)
			-- local forwardTr = util.TraceHull({
			-- 	start = self:GetPos(),
			-- 	endpos = self:GetPos() + self:GetForward() * 50,
			-- 	filter = self,
			-- 	mins = self:OBBMins(),
			-- 	maxs = self:OBBMaxs()
			-- }) -- Use this to see if we bump into something

			-- if forwardTr.Hit && !self.IsOnSurface then
			-- 	self:DoChangeMovementType(VJ_MOVETYPE_AERIAL)
			-- 	self:SetGroundEntity(NULL)
			-- 	self:SetLocalVelocity(Vector(0,0,0))
			-- 	self.IsOnSurface = true
			-- 	self.CurrentSurfaceNormal = forwardTr.HitNormal
			-- 	print("Set to surface movement")
			-- end
		end
	elseif key == "interaction" then
		local ent = self.BatteryEnt or self.ConsoleEnt
		if !IsValid(ent) then return end
		if ent.VJ_AVP_Battery then
			ent:DrainBattery()
		elseif ent.VJ_AVP_Console then
			ent:DestroyObject()
		end
	elseif key == "step" then
		self:PlayFootstepSound()
	elseif key == "spit_vo" then
		VJ.STOPSOUND(self.CurrentSpeechSound)
		VJ.STOPSOUND(self.CurrentIdleSound)
		VJ.CreateSound(self,"cpthazama/avp/xeno/alien queen/vocal/alien_queen_scream_04.ogg",80)
	elseif key == "spit" then
		local ent = self:GetEnemy()
		VJ.STOPSOUND(self.CurrentSpeechSound)
		VJ.STOPSOUND(self.CurrentIdleSound)
		VJ.CreateSound(self,self.SoundTbl_RangeAttack,80,self:GetSoundPitch(false))
		if IsValid(ent) then
			local mClass = self.VJ_NPC_Class
			local mult = self.RangeAttackDamageMultiplier or 1
			local att = self:GetAttachment(self:LookupAttachment("spit") > 0 && self:LookupAttachment("spit") or self:LookupAttachment("eyes"))
			local targetPos = (self.EnemyData && !self:Visible(ent) && self.EnemyData.VisiblePos) or ent:GetPos() +ent:OBBCenter()
			local targetAng = (targetPos -att.Pos):Angle()
			local ang = self:GetAngles()
			targetAng.y = math.Clamp(targetAng.y, ang.y - 80, ang.y + 80)
			for i = 1,self.VJ_AVP_XenomorphLarge && 3 or 1 do
				local proj = ents.Create("obj_vj_avp_projectile")
				proj:SetPos(att.Pos)
				proj:SetAngles(targetAng)
				proj:SetOwner(self)
				proj:SetAttackType(2,20 *mult,DMG_ACID,150,10,true)
				proj:SetNoDraw(true)
				proj:Spawn()
				proj.CollisionDecal = {"VJ_AVP_BloodXenomorph"}
				proj.OnThink = function(projEnt)
					projEnt.LastHeight = projEnt.LastHeight or projEnt:GetPos().z
					if projEnt.LastHeight < projEnt:GetPos().z then
						projEnt.LastHeight = projEnt:GetPos().z
					end
					if projEnt.LastHeight > projEnt:GetPos().z && !projEnt.DidSlow then
						local phys = projEnt:GetPhysicsObject()
						if IsValid(phys) then
							phys:SetMass(0.005)
							phys:SetVelocity(phys:GetVelocity() *0.75)
						end
						projEnt.DidSlow = true
					end
				end
				proj.OnDeath = function(projEnt,data, defAng, HitPos)
					VJ_AVP_XenoBloodSpill(nil,nil,true,{Pos = HitPos, Class = mClass})
					ParticleEffect("vj_avp_xeno_spit_impact",HitPos,defAng)
					sound.Play("cpthazama/avp/xeno/alien/blood/alien_blood_10s_0" .. math.random(1,4) .. ".ogg",HitPos,70)
				end
				VJ.EmitSound(proj,"cpthazama/avp/weapons/alien/spit/alien_spitacid_tp_" .. math.random(1,3) .. ".ogg",75)
				proj:AddSound("cpthazama/avp/xeno/alien/blood/alien_blood_fizz_loop_01.wav",65)
				ParticleEffectAttach("vj_avp_xeno_spit",PATTACH_POINT_FOLLOW,proj,0)

				local phys = proj:GetPhysicsObject()
				if IsValid(phys) then
					phys:EnableGravity(true)
					-- phys:SetVelocity(self:CalculateTrajectory(proj:GetPos(),i > 1 && targetPos +VectorRand(-135,135) or targetPos +VectorRand(-25,25),25))
					
					local physVel = VJ.CalculateTrajectory(self,nil,"Curve",proj:GetPos(),i > 1 && targetPos +VectorRand(-135,135) or targetPos +VectorRand(-25,25),30)
					phys:SetVelocity(physVel)
				end
			end
		end
	elseif key == "attack" then
		self.AttackDamageDistance = 140
		self.AttackDamageType = DMG_SLASH
		VJ.EmitSound(self,#self:RunDamageCode() > 0 && sdClawFlesh or sdClawMiss,75)
	elseif key == "attack_heavy" then
		self.AttackDamageDistance = 140
		self.AttackDamageType = bit.bor(DMG_SLASH,DMG_VEHICLE)
		VJ.EmitSound(self,#self:RunDamageCode(1.5) > 0 && sdClawFlesh or sdClawMiss,75)
	elseif key == "attack_mouth" then
		self.AttackDamageDistance = 120
		self.AttackDamageType = DMG_SLASH
		local hitEnts = self:RunDamageCode(1.25)
		if #hitEnts > 0 then
			self:SetHealth(math_Clamp(self:Health() +(#hitEnts *5),0,self:GetMaxHealth()))
		end
		VJ.EmitSound(self,sdMM,75)
	elseif key == "attack_tail" then
		self.AttackDamageDistance = 200
		self.AttackDamageType = bit.bor(DMG_SLASH,DMG_VEHICLE)
		VJ.EmitSound(self,#self:RunDamageCode(2.25) > 0 && sdTail or sdTailMiss,75)
	elseif string_StartWith(key,"snd") then
		key = string_Replace(key,"snd ","")
		local snd,vol,sndEnt = false,70,self
		if key == "pierce_tail" then
			snd = "cpthazama/avp/weapons/alien/tail/alien_killmove_cheststabgore_in.ogg"
		elseif key == "remove_tail" then
			snd = "cpthazama/avp/weapons/alien/tail/alien_killmove_cheststabgore_out.ogg"
		elseif key == "short_hiss" then
			snd = VJ.PICK("cpthazama/avp/xeno/alien/vocals/alien_hiss_short_01.ogg","cpthazama/avp/xeno/alien/vocals/alien_hiss_short_02.ogg")
		end
		if snd then
			VJ.EmitSound(sndEnt or self,snd,vol or 70)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RunDamageCode(mult)
	mult = mult or 1
	mult = mult *(self.AttackDamageMultiplier or 1)
	if self.BeforeRunDamage then
		self:BeforeRunDamage(mult)
	end
	local hitEnts = VJ.AVP_ApplyRadiusDamage(self,self,self:GetPos() +self:OBBCenter(),self.AttackDamageDistance or 120,(self.AttackDamage or 10) *mult,self.AttackDamageType or DMG_SLASH,true,false,{UseConeDegree=self.MeleeAttackDamageAngleRadius},
	function(ent)
		self:CustomOnMeleeAttack_AfterChecks(ent, false)
		local isProp = VJ.IsProp(ent)
		if isProp && (self.PropInteraction == true or self.PropInteraction == "OnlyDamage") then
			local phys = ent:GetPhysicsObject()
			local selfPhys = self:GetPhysicsObject()
			if IsValid(phys) && IsValid(selfPhys) && (selfPhys:GetSurfaceArea() *self.PropInteraction_MaxScale) >= phys:GetSurfaceArea() then
				phys:EnableMotion(true)
				phys:Wake()
				phys:ApplyForceCenter(self:GetPos() +self:GetForward() *(phys:GetMass() *700) +self:GetUp() *(phys:GetMass() *200))
			end
		end
		return ent:IsNPC() or ent:IsPlayer() or ent:IsNextBot() or isProp or ent:GetClass() == "prop_ragdoll"
	end)
	return hitEnts
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GetFatalityOffset(ent)
	local offset = (self:OBBMaxs().y +ent:OBBMaxs().y) *2
	if ent.VJ_AVP_Xenomorph then
		offset = (self:OBBMaxs().y +ent:OBBMaxs().y) *1.02
	elseif ent.VJ_AVP_Predator then
		offset = (self:OBBMaxs().y +ent:OBBMaxs().y) *1.5
	elseif ent.VJ_AVP_Marine then
		offset = 0
	end
	return offset
end
---------------------------------------------------------------------------------------------------------------------------------------------
local string_find = string.find
--
function ENT:OnThinkAttack(isAttacking, enemy)
	if self.InFatality or self.DoingFatality then return end
	local cont = self.VJ_TheController
	local eneData = self.EnemyData
	local dist = eneData.DistanceNearest
	local isCrawling = self.CurrentSet == 1
	local curTime = CurTime()
	if self.IsCrawler then return end
	local doingBlock = IsValid(cont) && (cont:KeyDown(IN_ATTACK) && cont:KeyDown(IN_ATTACK2)) or !IsValid(cont) && self.AI_IsBlocking
	if !self.CanBlock then
		doingBlock = false
	end
	-- if self:IsBusy() then
	-- 	doingBlock = false
	-- 	print("busy")
	-- end
	if !doingBlock && self.IsBlocking then
		self.IsBlocking = false
		-- print("disable block")
	elseif doingBlock && !self.IsBlocking then
		self.IsBlocking = true
		if isCrawling then
			self.CurrentSet = (self.CurrentSet == 1 && self.CanStand) && 2 or 1
			self.ChangeSetT = CurTime() +0.5
			if self.CurrentSet == 1 then
				self.AnimTbl_Flinch = self.AnimTbl_FlinchCrouch
			else
				self.AnimTbl_Flinch = self.AnimTbl_FlinchStand
			end
			self:PlayAnim("crawl_to_block",true,false,true)
		end
		-- print("enable block")
	end

	if self.OnCustomAttack then
		self:OnCustomAttack(cont,enemy,eneData.Visible,dist)
	end

	if IsValid(cont) then
		if doingBlock then return end
		if cont:KeyDown(IN_ATTACK) && !cont:KeyDown(IN_ATTACK2) && !cont:KeyDown(IN_SPEED) && !self:IsBusy() then
			self:AttackCode(isCrawling)
		elseif cont:KeyDown(IN_ATTACK2) && !cont:KeyDown(IN_ATTACK) && !self:IsBusy() then
			if self.HasRangeAttack && self.IsAbleToRangeAttack then return end
			self:AttackCode(isCrawling,5)
		elseif cont:KeyDown(IN_ATTACK) && !cont:KeyDown(IN_ATTACK2) && cont:KeyDown(IN_SPEED) && !self:IsBusy() && self.CanLeapAttack then
			self:AttackCode(isCrawling,4)
		elseif !cont:KeyDown(IN_ATTACK) && !cont:KeyDown(IN_ATTACK2) && cont:KeyDown(IN_JUMP) && !self:IsBusy() then
			self:LongJumpCode()
		end
		return
	end

	if eneData.Visible then
		if self.AI_IsBlocking && CurTime() > self.AI_BlockTime then
			self.AI_IsBlocking = false
			self.IsBlocking = false
			return
		end
		if self.CanAttack && dist <= self.AttackDistance && !self:IsBusy() then
			local canUse, inFront = self:CanUseFatality(enemy)
			if canUse && (inFront && math.random(1,2) == 1 or !inFront) then
				if self:DoFatality(enemy,inFront) == false then
					self:AttackCode(isCrawling)
				end
			else
				if self.CanBlock && !self.AI_IsBlocking && (!enemy.IsVJBaseSNPC && (string_find(enemy:GetSequenceName(enemy:GetSequence()),"attack") or math.random(1,3) == 1) or enemy.IsVJBaseSNPC && enemy.AttackType == VJ.ATTACK_TYPE_MELEE && enemy.AttackState == VJ.ATTACK_STATE_STARTED) && math.random(1,2) == 1 then
					self.AI_IsBlocking = true
					self.AI_BlockTime = CurTime() +math.Rand(2,4)
					return
				else
					self:AttackCode(isCrawling,(isCrawling && self:IsMoving() && math.random(1,2) == 1) && 5 or nil)
				end
			end
		elseif self.CanAttack && dist <= 450 && dist >= 325 && math.random(1,120) == 1 && !self:IsBusy() then
			self:AttackCode(isCrawling,4)
		end

		if math.random(1,10) == 1 && isCrawling && !self:IsBusy() && dist <= 900 && dist > 225 && curTime > self.NextMoveRandomlyT then
			local moveCheck = VJ.PICK(self:VJ_CheckAllFourSides(300, true, "0011"))
			if moveCheck then
				self:SetLastPosition(moveCheck)
				self:SCHEDULE_GOTO_POSITION("TASK_WALK_PATH",function(x)
					x:EngTask("TASK_FACE_ENEMY",0)
					x.TurnData = {Type = VJ.FACE_ENEMY}
				end)
				self.MoveAroundRandomlyT = curTime +self:GetPathTimeToGoal() +math.Rand(1,2.5)
				self.NextMoveRandomlyT = self.MoveAroundRandomlyT +math.random(3,8)
				self.NextChaseTime = self.MoveAroundRandomlyT +math.Rand(0.5,1)
			end
		end

		if curTime < self.MoveAroundRandomlyT && dist <= 180 && !self:IsBusy() then
			self.NextChaseTime = 0
			self.MoveAroundRandomlyT = 0
			self:ClearGoal()
			self:StopMoving()
			self.NextMoveRandomlyT = curTime +math.random(3,8)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RangeAttackProjPos(projectile)
	return self:GetAttachment(self:LookupAttachment("eyes")).Pos
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRangeAttack_AfterStartTimer()
	if self.LastAnimType == VJ.ANIM_TYPE_GESTURE then
		self.NextChaseTime = 0
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DoLeapAttack()
	self:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK)
	VJ.STOPSOUND(self.CurrentSpeechSound)
	VJ.STOPSOUND(self.CurrentIdleSound)
	VJ.CreateSound(self,self.SoundTbl_Jump,80)

	local targetPos = IsValid(self:GetEnemy()) && self:GetEnemy():EyePos() or self:EyePos() +self:GetForward() *2000
	self:SetVelocity(self:CalculateProjectile("Line", self:GetPos(), targetPos, math_Clamp(self.EnemyData.DistanceNearest,700,2500)))
	self:PlayAnim("leap_long",true,false,false,0,{OnFinish=function(interrupted)
		if interrupted then return end
		self.AttackDamageDistance = 140
		self.AttackDamageType = bit.bor(DMG_SLASH,DMG_CRUSH,DMG_VEHICLE)
		local dmgcode = self:RunDamageCode(2)
		VJ.EmitSound(self,#dmgcode > 0 && sdClawFlesh or sdClawMiss,75)
		VJ.STOPSOUND(self.CurrentSpeechSound)
		VJ.STOPSOUND(self.CurrentIdleSound)
		VJ.CreateSound(self,self.SoundTbl_Attack,80)
		self:PlayAnim(#dmgcode <= 0 && "leap_attack_miss" or "leap_long_land",true,false,false,0,{OnFinish=function(interrupted)
			if interrupted then return end
			self:SetState()
		end})
	end})
	self:SetTurnTarget(targetPos,0.25,true)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:AttackCode(isCrawling,forceAttack)
	if self.InFatality or self.DoingFatality or !self.CanAttack or CurTime() < (self.BlockAttackT or 0) then return end
	local gib = self.Gibbed
	if gib && (gib.LeftLeg or gib.RightLeg or gib.LeftArm or gib.RightArm) then
		self.AttackType = 2
		self.AttackSide = self.AttackSide == "right" && "left" or "right"
		self:PlayAnim("claw_swipe_" .. self.AttackSide .. "_mid",true,false,true,0,{AlwaysUseGesture=true,OnFinish=function(interrupted,anim)
			if interrupted or self.InFatality then return end
			self:PlayAnim("claw_swipe_" .. self.AttackSide .. "_mid_return",true,false,false,0,{AlwaysUseGesture=true})
			self.NextChaseTime = 0
		end})
		self.NextChaseTime = 0
		return
	end
	if forceAttack == 4 then
		self:DoLeapAttack()
		return
	end
	if isCrawling then
		-- print(isCrawling,self:IsMoving(),forceAttack)
		if self:IsMoving() then
			if forceAttack == 5 or forceAttack == nil && math.random(1,4) == 1 then
				// Leap attack
				self.AttackType = 3
				self.AttackSide = self.AttackSide == "right" && "left" or "right"
				self:SetGroundEntity(NULL)
				-- self:SetVelocity(self:CalculateProjectile("Line", self:GetPos(), self:GetPos() +self:GetForward() *400 +self:GetUp() *50, 900))
				self:PlayAnim("crawl_claw_attack_" .. self.AttackSide,true,false,false,0,{OnFinish=function(interrupted,anim)
					if interrupted or self.InFatality then return end
					self:PlayAnim("crawl_claw_attack_" .. self.AttackSide .. "_land",true,false,false)
				end})
			else
				if IsValid(self.VJ_TheController) && self:IsMoving() or !IsValid(self.VJ_TheController) && math.random(1,3) == 1 then
					// Stand up attack
					self.AttackType = 1
					self.AttackSide = self.AttackSide == "right" && "left" or "right"
					self:PlaySound(self.SoundTbl_Attack,75)
					self:PlayAnim("crawl_stand_attack_" .. self.AttackSide,true,false,true,0,{OnFinish=function(interrupted)
						if interrupted or self.InFatality then return end -- Means we hit something
						if IsValid(self.VJ_TheController) && self.VJ_TheController:KeyDown(IN_ATTACK) or !IsValid(self.VJ_TheController) && IsValid(self:GetEnemy()) && self.LastEnemyDistance <= 130 then
							self.AttackSide = self.AttackSide == "right" && "left" or "right"
							local anim = "crawl_stand_attack_" .. self.AttackSide .. "_loop"
							self:PlaySound(self.SoundTbl_Attack,75)
							self:PlayAnim({anim,anim .. "_move",anim .. "_variant1",anim .. "_variant1_move"},true,false,false,0,{OnFinish=function(interrupted)
								if interrupted or self.InFatality then return end
								if IsValid(self.VJ_TheController) && self.VJ_TheController:KeyDown(IN_ATTACK) or !IsValid(self.VJ_TheController) && IsValid(self:GetEnemy()) && self.LastEnemyDistance <= 130 then
									self.AttackSide = self.AttackSide == "right" && "left" or "right"
									local anim = "crawl_stand_attack_" .. self.AttackSide .. "_loop"
									self:PlaySound(self.SoundTbl_Attack,75)
									self:PlayAnim({anim,anim .. "_move",anim .. "_variant1",anim .. "_variant1_move"},true,false,false,0,{OnFinish=function(interrupted)
										if interrupted or self.InFatality then return end
										-- self:PlayAnim("crawl_stand_attack_" .. self.AttackSide .. "_end",true,false,false,0,{OnFinish=function(interrupted,anim)
										-- 	if interrupted or self.InFatality or IsValid(self.VJ_TheController) then return end
										-- 	self.CurrentSet = 1
										-- 	self.AnimTbl_Flinch = self.AnimTbl_FlinchCrouch
										-- 	self.ChangeSetT = CurTime() +0.5
										-- end})
										if self.CurrentSet == 1 then
											self:PlayAnim("light_attack_" .. self.AttackSide .. "_to_crawl_fwd",true,false,false)
										else
											self:PlayAnim("light_attack_" .. self.AttackSide .. "_to_run_fwd",true,false,false)
										end
									end})
								else
									if self.CurrentSet == 1 then
										self:PlayAnim("light_attack_" .. self.AttackSide .. "_to_crawl_fwd",true,false,false)
									else
										self:PlayAnim("light_attack_" .. self.AttackSide .. "_to_run_fwd",true,false,false)
									end
									-- self:PlayAnim("crawl_stand_attack_" .. self.AttackSide .. "_end",true,false,false,0,{OnFinish=function(interrupted,anim)
									-- 	if interrupted or self.InFatality or IsValid(self.VJ_TheController) then return end
									-- 	self.CurrentSet = 1
									-- 	self.AnimTbl_Flinch = self.AnimTbl_FlinchCrouch
									-- 	self.ChangeSetT = CurTime() +0.5
									-- end})
								end
							end})
						else
							if self.CurrentSet == 1 then
								self:PlayAnim("light_attack_" .. self.AttackSide .. "_to_crawl_fwd",true,false,false)
							else
								self:PlayAnim("light_attack_" .. self.AttackSide .. "_to_run_fwd",true,false,false)
							end
							-- self:PlayAnim("crawl_stand_attack_" .. self.AttackSide .. "_end",true,false,false,0,{OnFinish=function(interrupted,anim)
							-- 	if interrupted or self.InFatality or IsValid(self.VJ_TheController) then return end
							-- 	self.CurrentSet = 1
							-- 	self.AnimTbl_Flinch = self.AnimTbl_FlinchCrouch
							-- 	self.ChangeSetT = CurTime() +0.5
							-- end})
						end
					end})
				else
					// Gesture claw attack
					self.AttackType = 2
					self.AttackSide = self.AttackSide == "right" && "left" or "right"
					self:PlayAnim("claw_swipe_" .. self.AttackSide .. "_mid",true,false,true,0,{AlwaysUseGesture=true,OnFinish=function(interrupted,anim)
						if interrupted or self.InFatality then return end
						self:PlayAnim("claw_swipe_" .. self.AttackSide .. "_mid_return",true,false,false,0,{AlwaysUseGesture=true})
						self.NextChaseTime = 0
					end})
					self.NextChaseTime = 0
				end
			end
		else
			if forceAttack == 5 or forceAttack == nil && !IsValid(self.VJ_TheController) && math.random(1,4) == 1 then
				// Heavy attack
				self.AttackType = 5
				self:PlayAnim("melee_heavy_attack_charge_up",true,false,true,0,{OnFinish=function(interrupted)
					if interrupted or self.InFatality then return end
					self:PlaySound(self.SoundTbl_Attack,75)
					self:PlayAnim({"melee_heavy_attack_medium","melee_heavy_attack_short"},true,false,true)
				end})
			elseif IsValid(self.VJ_TheController) && self:IsMoving() or !IsValid(self.VJ_TheController) && math.random(1,3) == 1 then
				// Stand up attack
				self.AttackType = 1
				self.AttackSide = self.AttackSide == "right" && "left" or "right"
				self:PlaySound(self.SoundTbl_Attack,75)
				self:PlayAnim("crawl_stand_attack_" .. self.AttackSide,true,false,true,0,{OnFinish=function(interrupted)
					if interrupted or self.InFatality then return end -- Means we hit something
					if IsValid(self.VJ_TheController) && self.VJ_TheController:KeyDown(IN_ATTACK) or !IsValid(self.VJ_TheController) && IsValid(self:GetEnemy()) && self.LastEnemyDistance <= 130 then
						self.AttackSide = self.AttackSide == "right" && "left" or "right"
						local anim = "crawl_stand_attack_" .. self.AttackSide .. "_loop"
						self:PlaySound(self.SoundTbl_Attack,75)
						self:PlayAnim({anim,anim .. "_move",anim .. "_variant1",anim .. "_variant1_move"},true,false,false,0,{OnFinish=function(interrupted)
							if interrupted or self.InFatality then return end
							if IsValid(self.VJ_TheController) && self.VJ_TheController:KeyDown(IN_ATTACK) or !IsValid(self.VJ_TheController) && IsValid(self:GetEnemy()) && self.LastEnemyDistance <= 130 then
								self.AttackSide = self.AttackSide == "right" && "left" or "right"
								local anim = "crawl_stand_attack_" .. self.AttackSide .. "_loop"
								self:PlaySound(self.SoundTbl_Attack,75)
								self:PlayAnim({anim,anim .. "_move",anim .. "_variant1",anim .. "_variant1_move"},true,false,false,0,{OnFinish=function(interrupted)
									if interrupted or self.InFatality then return end
									if self.CurrentSet == 1 then
										self:PlayAnim("light_attack_" .. self.AttackSide .. "_to_crawl_fwd",true,false,false)
									else
										self:PlayAnim("light_attack_" .. self.AttackSide .. "_to_run_fwd",true,false,false)
									end
								end})
							else
								if self.CurrentSet == 1 then
									self:PlayAnim("light_attack_" .. self.AttackSide .. "_to_crawl_fwd",true,false,false)
								else
									self:PlayAnim("light_attack_" .. self.AttackSide .. "_to_run_fwd",true,false,false)
								end
								-- self:PlayAnim("crawl_stand_attack_" .. self.AttackSide .. "_end",true,false,false,0,{OnFinish=function(interrupted,anim)
								-- 	if interrupted or self.InFatality or IsValid(self.VJ_TheController) then return end
								-- 	self.CurrentSet = 1
								-- 	self.AnimTbl_Flinch = self.AnimTbl_FlinchCrouch
								-- 	self.ChangeSetT = CurTime() +0.5
								-- end})
							end
						end})
					else
						if self.CurrentSet == 1 then
							self:PlayAnim("light_attack_" .. self.AttackSide .. "_to_crawl_fwd",true,false,false)
						else
							self:PlayAnim("light_attack_" .. self.AttackSide .. "_to_run_fwd",true,false,false)
						end
						-- self:PlayAnim("crawl_stand_attack_" .. self.AttackSide .. "_end",true,false,false,0,{OnFinish=function(interrupted,anim)
						-- 	if interrupted or self.InFatality or IsValid(self.VJ_TheController) then return end
						-- 	self.CurrentSet = 1
						-- 	self.AnimTbl_Flinch = self.AnimTbl_FlinchCrouch
						-- 	self.ChangeSetT = CurTime() +0.5
						-- end})
					end
				end})
			else
				// Claw attack
				self.AttackType = 0
				local side = math.random(1,2)
				self:PlayAnim("all4s_claw_swipe_" .. side,true,false,true,0,{OnFinish=function(interrupted,anim)
					if interrupted or self.InFatality then return end -- Means we hit something and started the return animation
					self:PlayAnim("all4s_claw_swipe_" .. side .. "_return",true,false,false)
				end})
			end
		end
	else
		if self:IsMoving() then
			// Heavy attack
			if forceAttack == 5 or forceAttack == nil && !IsValid(self.VJ_TheController) && math.random(1,4) == 1 then
				self.AttackType = 5
				self:PlayAnim("melee_heavy_attack_charge_up",true,false,true,0,{OnFinish=function(interrupted)
					if interrupted or self.InFatality then return end
					self:PlaySound(self.SoundTbl_Attack,75)
					self:PlayAnim("melee_heavy_attack_long",true,false,true)
				end})
			else
				// Gesture claw attack
				self.AttackType = 2
				self.AttackSide = self.AttackSide == "right" && "left" or "right"
				self:PlayAnim("light_attack_" .. self.AttackSide .. "_mid",true,false,true,0,{AlwaysUseGesture=true})
				self.NextChaseTime = 0
			end
		else
			if forceAttack == 5 or forceAttack == nil && !IsValid(self.VJ_TheController) && math.random(1,4) == 1 then
				// Heavy attack
				self.AttackType = 5
				self:PlayAnim("melee_heavy_attack_charge_up",true,false,true,0,{OnFinish=function(interrupted)
					if interrupted or self.InFatality then return end
					self:PlaySound(self.SoundTbl_Attack,75)
					self:PlayAnim({"melee_heavy_attack_medium","melee_heavy_attack_short"},true,false,true)
				end})
			else
				// Stand up attack
				self.AttackType = 1
				self.AttackSide = self.AttackSide == "right" && "left" or "right"
				self:PlaySound(self.SoundTbl_Attack,75)
				if IsValid(self.VJ_TheController) && self.VJ_TheController:KeyDown(IN_FORWARD) then
					self:PlayAnim("crawl_stand_attack_" .. self.AttackSide,true,false,true,0,{OnFinish=function(interrupted)
						if interrupted or self.InFatality then return end -- Means we hit something
						if IsValid(self.VJ_TheController) && self.VJ_TheController:KeyDown(IN_ATTACK) or !IsValid(self.VJ_TheController) && IsValid(self:GetEnemy()) && self.LastEnemyDistance <= 130 then
							self.AttackSide = self.AttackSide == "right" && "left" or "right"
							local anim = "crawl_stand_attack_" .. self.AttackSide .. "_loop"
							self:PlaySound(self.SoundTbl_Attack,75)
							self:PlayAnim({anim,anim .. "_move",anim .. "_variant1",anim .. "_variant1_move"},true,false,false,0,{OnFinish=function(interrupted)
								if interrupted or self.InFatality then return end
								if IsValid(self.VJ_TheController) && self.VJ_TheController:KeyDown(IN_ATTACK) or !IsValid(self.VJ_TheController) && IsValid(self:GetEnemy()) && self.LastEnemyDistance <= 130 then
									self.AttackSide = self.AttackSide == "right" && "left" or "right"
									local anim = "crawl_stand_attack_" .. self.AttackSide .. "_loop"
									self:PlaySound(self.SoundTbl_Attack,75)
									self:PlayAnim({anim,anim .. "_move",anim .. "_variant1",anim .. "_variant1_move"},true,false,false,0,{OnFinish=function(interrupted)
										if interrupted or self.InFatality then return end
										if self.CurrentSet == 1 then
											self:PlayAnim("light_attack_" .. self.AttackSide .. "_to_crawl_fwd",true,false,false)
										else
											self:PlayAnim("light_attack_" .. self.AttackSide .. "_to_run_fwd",true,false,false)
										end
									end})
								else
									self:PlayAnim("light_attack_" .. self.AttackSide .. "_to_run_fwd",true,false,false,0,{OnFinish=function(interrupted,anim)
										if interrupted or self.InFatality then return end
										self.CurrentSet = 2
										self.AnimTbl_Flinch = self.AnimTbl_FlinchStand
										self.ChangeSetT = CurTime() +0.5
									end})
									-- self:PlayAnim("crawl_stand_attack_" .. self.AttackSide .. "_end",true,false,false,0,{OnFinish=function(interrupted,anim)
									-- 	if interrupted or self.InFatality or IsValid(self.VJ_TheController) then return end
									-- 	self.CurrentSet = 1
									-- 	self.AnimTbl_Flinch = self.AnimTbl_FlinchCrouch
									-- 	self.ChangeSetT = CurTime() +0.5
									-- end})
								end
							end})
						else
							if self.CurrentSet == 1 then
								self:PlayAnim("light_attack_" .. self.AttackSide .. "_to_crawl_fwd",true,false,false)
							else
								self:PlayAnim("light_attack_" .. self.AttackSide .. "_to_run_fwd",true,false,false)
							end
							-- self:PlayAnim("crawl_stand_attack_" .. self.AttackSide .. "_end",true,false,false,0,{OnFinish=function(interrupted,anim)
							-- 	if interrupted or self.InFatality or IsValid(self.VJ_TheController) then return end
							-- 	self.CurrentSet = 1
							-- 	self.AnimTbl_Flinch = self.AnimTbl_FlinchCrouch
							-- 	self.ChangeSetT = CurTime() +0.5
							-- end})
						end
					end})
				else
					self:PlayAnim("light_step_attack_" .. self.AttackSide .. "_mid",true,false,true,0,{OnFinish=function(interrupted)
						if interrupted or self.InFatality then return end -- Means we hit something
						if IsValid(self:GetEnemy()) && self.LastEnemyDistance <= 130 then
							self.AttackSide = self.AttackSide == "right" && "left" or "right"
							self:PlaySound(self.SoundTbl_Attack,75)
							self:PlayAnim("light_step_attack_" .. self.AttackSide .. "_mid",true,false,true,0,{OnFinish=function(interrupted)
								if interrupted or self.InFatality or IsValid(self.VJ_TheController) then return end
								self.AttackSide = self.AttackSide == "right" && "left" or "right"
								self:PlayAnim({"light_attack_" .. self.AttackSide .. "_to_run_fwd","light_attack_" .. self.AttackSide .. "_to_crawl_fwd"},true,false,true,0,{OnFinish=function(interrupted,anim)
									if interrupted or self.InFatality then return end
									self.CurrentSet = (anim == "light_attack_" .. self.AttackSide .. "_to_run_fwd") && 2 or 1
									self.ChangeSetT = CurTime() +0.5
									if self.CurrentSet == 2 then
										self.AnimTbl_Flinch = self.AnimTbl_FlinchStand
									else
										self.AnimTbl_Flinch = self.AnimTbl_FlinchCrouch
									end
								end})
							end})
						end
					end})
				end
			end
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Gibs()
	local bloodeffect = EffectData()
	bloodeffect:SetOrigin(self:GetPos() +self:OBBCenter())
	bloodeffect:SetColor(VJ.Color2Byte(Color(255,221,35)))
	bloodeffect:SetScale(300)
	util.Effect("VJ_Blood1",bloodeffect)

	self:CreateGibEntity("obj_vj_gib","UseAlien_Small")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Small")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetGroundAngle(curSet)
	if self.InFatality then curSet = 0 end
	if !self.CanSetGroundAngle then return end
	local pos = self:GetPos()
	local len = self:GetUp() *50
	local ang = self:GetAngles()
	local ang_y = Angle(0,ang.y,0)
	local refreshRate = FrameTime() *20
	if curSet == 1 /*&& self:OnGround()*/ then
		local _, maxs = self:GetCollisionBounds()
		-- mins = mins *2
		-- maxs = maxs *2
		local posForward, posBackward, posRight, posLeft
		local directionVectors = {
			forward = ang_y:Forward(),
			backward = ang_y:Forward() * -1,
			right = ang_y:Right(),
			left = ang_y:Right() * -1,
		}
		local hits = {}
		for direction, vector in pairs(directionVectors) do
			local startPos = pos + vector * ((vector == directionVectors.right or vector == directionVectors.left) and maxs.y or maxs.x)
			local tr = util.TraceLine({
				start = startPos,
				endpos = startPos - len,
				filter = self
			})
			hits[direction] = tr.HitPos
			if direction == "forward" then
				posForward = startPos
			elseif direction == "backward" then
				posBackward = startPos
			elseif direction == "right" then
				posRight = startPos
			elseif direction == "left" then
				posLeft = startPos
			end
		end

		local hitForward = hits.forward
		local hitBackward = hits.backward
		local hitRight = hits.right
		local hitLeft = hits.left
		local pitch
		local roll
		local pitchDif = math_abs(hitForward.z -hitBackward.z)
		local rollDif = math_abs(hitLeft.z -hitRight.z)
		if posForward:Distance(hitForward) > posBackward:Distance(hitBackward) then
			pitch = 90 -math_deg(math_acos(pitchDif /hitForward:Distance(posBackward)))
		else
			pitch = -(90 -math_deg(math_acos(pitchDif /hitBackward:Distance(posForward))))
		end
		if posLeft:Distance(hitLeft) > posRight:Distance(hitRight) then
			roll = -(90 -math_deg(math_acos(rollDif /hitLeft:Distance(posRight))))
		else
			roll = 90 -math_deg(math_acos(rollDif /hitRight:Distance(posLeft)))
		end

		local tr = util.TraceLine({
			start = pos,
			endpos = pos -len,
			filter = self
		})

		self.Incline = pitch
		self:ManipulateBonePosition(0,Vector(0,0,Lerp(refreshRate,self:GetManipulateBonePosition(0).z,-(tr.HitPos +tr.HitNormal):Distance(pos))))
		self:SetAngles(LerpAngle(refreshRate,self:GetAngles(),Angle(pitch,ang.y,roll)))
	else
		self.Incline = 0
		self:ManipulateBonePosition(0,Vector(0,0,Lerp(refreshRate,self:GetManipulateBonePosition(0).z,0)))
		self:SetAngles(LerpAngle(refreshRate,self:GetAngles(),Angle(0,ang.y,0)))
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:JumpVelocityCode()
	self.JumpT = self.JumpT +0.1
	local currentPos = self:GetPos()
	local dist = currentPos:Distance(self.LongJumpPos)
	local targetPos = self.LongJumpPos +(dist < 250 && self:OBBCenter() *0.3 or self:OBBCenter() *0.5)
	local moveDirection = (targetPos -currentPos):GetNormalized()
	local moveSpeed = (dist < 250 && 800 or dist *4)
	self:SetLocalVelocity(moveDirection *moveSpeed)
	if dist >= 70 && self.JumpT <= 1 then
		self:SetCycle(0.5)
		self.NextChaseTime = CurTime() +1
		self.NextIdleTime = CurTime() +1
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:StalkingAI(ent)
	local eneData = self.EnemyData
	local dist = eneData.DistanceNearest
	if !self.SpawnedUsingMutator && (ent:IsPlayer() or ent:IsNPC() && ent:GetEnemy() != self && !ent.VJ_AVP_Predator or ent:IsNextBot()) && !ent:Visible(self) && dist < 2500 && dist > 300 && eneData && (CurTime() -eneData.VisibleTime) > 8 then
		self.StalkingAITime = CurTime() +2
		-- self:SCHEDULE_GOTO_POSITION("TASK_WALK_PATH",function(x)
		-- 	x:EngTask("TASK_FACE_ENEMY",0)
		-- 	x.TurnData = {Type = VJ.FACE_ENEMY}
		-- end)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local debugUseSurfaceClimbing = false
--
function ENT:OnThinkActive()
	if self.Dead then return end
	self.HasPoseParameterLooking = !self.InFatality
	if self.InFatality then
		local names = self.PoseParameterLooking_Names
		for x = 1, #names.pitch do
			self:SetPoseParameter(names.pitch[x],0)
		end
		for x = 1, #names.yaw do
			self:SetPoseParameter(names.yaw[x],0)
		end
		for x = 1, #names.roll do
			self:SetPoseParameter(names.roll[x],0)
		end
		if IsValid(self.FatalityKiller) && self.FatalityKiller:Health() <= 0 or !IsValid(self.FatalityKiller) then
			self:ResetFatality()
			self:SetHealth(0)
			self:TakeDamage(AVP.fFatalDamageAmount,self,self)
			-- self:SetCycle(self.FatalityKiller:GetCycle())
		end
		return
	end
	local curTime = CurTime()
	local ent = self:GetEnemy()
	local ply = self.VJ_TheController
	local curSet = self.CurrentSet
	if self.DarknessLevel != false && curTime -self.LastNetworkT >= 5 then
		self.DarknessLevel = false
		self.HasIdleSounds = true
		self.HasAlertSounds = true
	end
	local transAct = self:GetSequenceActivity(self:GetIdealSequence())
	local moveAct = self:IsMoving() && self:GetSequenceActivity(self:GetIdealSequence()) or 0
	local sprinting = !self.VJ_AVP_XenomorphPredalien && ((transAct == ACT_SPRINT or transAct == ACT_MP_SPRINT or transAct == ACT_HL2MP_RUN_SMG1) or self.AI_IsSprinting)
	-- print(self:GetActivity(),transAct)

	if !self.WasSprinting && sprinting then
		VJ.EmitSound(self,"cpthazama/avp/xeno/alien/footsteps/sprint/alien_sprint_burst_0" .. math.random(1,3) .. ".ogg",70)
		self.WasSprinting = true
	elseif self.WasSprinting && !sprinting then
		self.WasSprinting = false
	end

	if (self.IsBlocking or self.AI_IsBlocking) then
		if self:IsMoving() then
			self:StopMoving()
		end
		self:SetState(VJ_STATE_ONLY_ANIMATION,0.25)
	end
	
	self:SetHP(self:Health())
	self:SetStanding(self.CurrentSet == 1)

	if self.HasBreath then
		self:Breathe()
	else
		if curTime > self.CurrentVoiceLineTime && self.BreathLoop then
			self.BreathLoop:ChangeVolume(1)
		end
	end
	self:SetGroundAngle(curSet)

	-- if self.IsBlocking or self.AI_IsBlocking then
	-- 	self:PlayAnim(ACT_IDLE_STEALTH,true,false,false)
	-- 	return
	-- end

	if self.LongJumping && self.LongJumpPos then
		self:JumpVelocityCode()
	end

	if debugUseSurfaceClimbing then -- Experimental AI, allows Xenomorphs to climb on any surface
		local ply = self.VJ_TheController
		if IsValid(ply) then
			self.Aerial_FlyingSpeed_Calm = 400
			self.Aerial_FlyingSpeed_Alerted = 700
			if ply:KeyDown(IN_FORWARD) or ply:KeyDown(IN_BACK) or ply:KeyDown(IN_MOVELEFT) or ply:KeyDown(IN_MOVERIGHT) then
				self.Surface_IsMoving = true
				local moveF = ply:KeyDown(IN_FORWARD) && 1 or ply:KeyDown(IN_BACK) && -1 or 0
				local moveR = ply:KeyDown(IN_MOVERIGHT) && 1 or ply:KeyDown(IN_MOVELEFT) && -1 or 0
				local moveDir = self:GetRight() *moveR +self:GetForward() *moveF
				-- local moveDir = Vector(moveR,moveF,0):GetNormalized()
				local forwardTr = util.TraceHull({
					start = self:GetPos(),
					endpos = self:GetPos() +moveDir *50,
					filter = self,
					mins = self:OBBMins(),
					maxs = self:OBBMaxs(),
					mask = MASK_SOLID_BRUSHONLY
				})

				local hitNormal = forwardTr.HitNormal
				if forwardTr.Hit && !self.IsOnSurface && math_abs(hitNormal.x) >= 0.9 or math_abs(hitNormal.y) >= 0.9 then
					self:DoChangeMovementType(VJ_MOVETYPE_AERIAL)
					self:SetGroundEntity(NULL)
					self:SetLocalVelocity(Vector(0,0,0))
					self.IsOnSurface = true
					self.CurrentSurfaceNormal = forwardTr.HitNormal
					//print("Set to surface movement")
				elseif !forwardTr.Hit && self.IsOnSurface then
					-- Apply velocity based on the surface we're on
					local tr = util.TraceHull({
						start = self:GetPos(),
						endpos = self:GetPos() +moveDir *50 +self.CurrentSurfaceNormal *-10,
						filter = self,
						mins = self:OBBMins(),
						maxs = self:OBBMaxs()
					})
					
					if tr.Hit then
						-- self:SetPos(tr.HitPos +tr.HitNormal *(self:OBBMaxs().y *1.4))
						self.CurrentSurfaceNormal = tr.HitNormal
						local right = self:GetRight()
						local forward = right:Cross(self.CurrentSurfaceNormal)
						self:SetAngles(forward:Angle())
						self:SetLocalVelocity(forward *700) -- Adjust speed as needed
						-- self:SetLocalVelocity(moveDir *700) -- Adjust speed as needed
						//print("Surface movement")
					else
						-- Falling off the surface
						self:DoChangeMovementType(VJ_MOVETYPE_GROUND)
						self:SetLocalVelocity(Vector(0,0,0))
						self.IsOnSurface = false
						//print("Set to ground movement")
					end
				end
			else
				self.Surface_IsMoving = false
				if self.IsOnSurface then
					self:SetLocalVelocity(Vector(0,0,0))
				end
			end
		end
	end	

	if self.OnThink2 then
		self:OnThink2()
	end

	local darkness = self.DarknessLevel
	if VJ_AVP_CVAR_XENOSTEALTH && darkness && darkness <= 0.065 && !self:IsMoving() then
		for _,v in ents.Iterator() do
			if (v:IsNPC() or v:IsNextBot()) && v:GetClass() != "obj_vj_bullseye" && self:CheckRelationship(v) != D_LI then
				if v.VJ_AVP_Xenomorph or v.VJ_AVP_Predator && v:GetVisionMode() == 2 then
					continue
				end
				if v:GetPos():Distance(self:GetPos()) > (650 *(darkness *10)) then
					if v.HasEnemyMemory && v:HasEnemyMemory(self) then
						v:ClearEnemyMemory(self)
					end
					if v.GetEnemy && v:GetEnemy() == self then
						v:SetEnemy(nil)
					end
				end
			end
		end
		if self.NextMoveRandomlyT < curTime && !IsValid(ply) then
			self.NextMoveRandomlyT = 0
		end
	end

	self:SetSprinting(self:IsMoving() && sprinting)
	self:SetPoseParameter("standing", Lerp(FrameTime() *10,self:GetPoseParameter("standing"),curSet -1))

	-- local gib = self.Gibbed
	-- if gib && (gib.LeftLeg or gib.RightLeg or gib.LeftArm or gib.RightArm) then
	if self.IsCrawler then
		if curTime > self.NextGibbedFXTime then
			self.NextGibbedFXTime = curTime +math.Rand(0.1,0.5)
	
			local pos = self:GetPos()
			
			local tr = util.TraceLine({start = pos, endpos = pos +self:GetUp() *-150, filter = self})
			if !tr.HitWorld then return end
			local trNormalP = tr.HitPos +tr.HitNormal
			local trNormalN = tr.HitPos -tr.HitNormal
			-- local particle = ents.Create("info_particle_system")
			-- particle:SetKeyValue("effect_name",VJ.PICK(self.BloodParticle))
			-- particle:SetPos(trNormalP)
			-- particle:Spawn()
			-- particle:Activate()
			-- particle:Fire("Start")
			-- particle:Fire("Kill","",0.1)
			util.Decal(VJ.PICK(self.BloodDecal), trNormalP, trNormalN, self)
			for _ = 1, 2 do
				if math.random(1, 2) == 1 then util.Decal(VJ.PICK(self.BloodDecal), trNormalP + Vector(math.random(-25, 25), math.random(-25, 25), 0), trNormalN, self) end
			end
		end
	else
		if self.AlwaysStand && curSet != 2 then
			self.CurrentSet = 2
			self.NextIdleTime = 0
			self.NextIdleStandTime = 0
			self.AnimTbl_Flinch = self.AnimTbl_FlinchStand
			curSet = 2
		end

		if self.LastSet != curSet then
			local oldSet = self.LastSet
			self.LastSet = curSet
			-- if IsValid(self.Restraint) then
			-- 	self.PoseParameterLooking_Names = {
			-- 		pitch = {"head_pitch"},
			-- 		yaw = {"head_yaw"},
			-- 		roll={}
			-- 	}
			-- else
				self.PoseParameterLooking_Names = {
					pitch = curSet == 1 && {"head_pitch"} or {"standing_head_pitch","standing_body_pitch"},
					yaw = curSet == 1 && {"head_yaw"} or {"standing_head_yaw","standing_body_yaw"},
					roll={}
				}
			-- end
			if oldSet == 1 then -- We're changing from crawling to standing
				self:SetPoseParameter("standing_head_yaw",self:GetPoseParameter("head_yaw"))
				self:SetPoseParameter("standing_head_pitch",self:GetPoseParameter("head_pitch"))
				self:SetPoseParameter("standing_body_yaw",self:GetPoseParameter("head_yaw"))
				self:SetPoseParameter("standing_body_pitch",self:GetPoseParameter("head_pitch"))
				self:SetPoseParameter("head_yaw",0)
				self:SetPoseParameter("head_pitch",0)
				local bounds = self.StandingBounds or defStandingBounds
				self:SetCollisionBounds(bounds,Vector(-bounds.x, -bounds.y, 0))
				if !self.VJ_AVP_XenomorphLarge then
					self.AnimTbl_RangeAttack = {"vjges_spit_standing"}
				end
				self.RangeAttackAnimationStopMovement = false
				self.ControllerParams.ThirdP_Offset = Vector(0, 0, -35)
				self:SetStepHeight(self.StepHeight_Standing or 22)
				-- print("standing")
			else -- We're changing from standing to crawling
				self:SetPoseParameter("head_yaw",self:GetPoseParameter("standing_head_yaw"))
				self:SetPoseParameter("head_pitch",self:GetPoseParameter("standing_head_pitch"))
				self:SetPoseParameter("standing_head_yaw",0)
				self:SetPoseParameter("standing_head_pitch",0)
				self:SetPoseParameter("standing_body_yaw",0)
				self:SetPoseParameter("standing_body_pitch",0)
				local bounds = self.CrawlingBounds or defCrawlingBounds
				self:SetCollisionBounds(bounds,Vector(-bounds.x, -bounds.y, 0))
				if !self.VJ_AVP_XenomorphLarge then
					self.AnimTbl_RangeAttack = {"all4s_spit_left","all4s_spit_right"}
				end
				self.RangeAttackAnimationStopMovement = true
				self.ControllerParams.ThirdP_Offset = Vector(0, 0, 0)
				self:SetStepHeight(self.StepHeight_Crawling or 100)
				-- print("crawling")
			end
		end
		sprinting = self:GetSprinting()
		-- self.CanAttack = !sprinting
		if sprinting then
			if self.VJ_AVP_XenomorphRunner && transAct == ACT_SPRINT && self:OnGround() then
				self:SetVelocity(self:GetMoveVelocity() *1.25)
			end
			self.SprintT = self.SprintT +0.05
			if self.SprintT >= 4 then
				if self.AI_IsSprinting then
					self.AI_IsSprinting = false
				end
				self.NextSprintT = curTime +3
			end
		else
			if self.SprintT > 0 then
				self.SprintT = self.SprintT -0.25
			end
		end
		self.IsUsingFaceAnimation = VJ.HasValue(self.FaceEnemyMovements,moveAct)
		if self.AlwaysStand && self.CanStand && self.CurrentSet == 1 then
			self.AnimTbl_Flinch = self.AnimTbl_FlinchStand
			self.CurrentSet = 2
			self.NextIdleTime = 0
			self.NextIdleStandTime = 0
		end
		if IsValid(ply) then
			-- if !IsValid(ply.VJ_AVP_ViewModel) then
			-- 	ply.VJ_AVP_ViewModel = ply:Give("weapon_vj_avp_viewmodel")
			-- 	self.VJ_TheControllerEntity:DeleteOnRemove(ply.VJ_AVP_ViewModel)
			-- else
			-- 	local wep = ply.VJ_AVP_ViewModel
			-- 	ply.VJ_AVP_ViewModelNPC = self
			-- 	self:SetViewModelWeapon(wep,ply)
			-- 	wep:Think(self)
			-- end

			-- if ply:KeyDown(IN_WALK) then -- Wall walking
			-- 	if ply:KeyDown(IN_FORWARD) then
			-- 		local tr = util.TraceLine({
			-- 			start = self:GetPos(),
			-- 			endpos = self:GetPos() +ply:GetAimVector() *250,
			-- 			filter = {self,ply}
			-- 		})
			-- 		local touchDir = {L=false,R=false,U=false,D=false}
			-- 		for i = 1,4 do
			-- 			local dir = i == 1 && ply:GetRight() or i == 2 && ply:GetRight() *-1 or i == 3 && ply:GetUp() or ply:GetUp() *-1
			-- 			local tr = util.TraceLine({
			-- 				start = self:GetPos(),
			-- 				endpos = self:GetPos() +dir *250,
			-- 				filter = {self,ply}
			-- 			})
			-- 			if tr.Hit then
			-- 				if i == 1 then
			-- 					touchDir.R = true
			-- 				elseif i == 2 then
			-- 					touchDir.L = true
			-- 				elseif i == 3 then
			-- 					touchDir.U = true
			-- 				elseif i == 4 then
			-- 					touchDir.D = true
			-- 				end
			-- 			end
			-- 		end
			-- 		local moveSpeed = self:GetSequenceGroundSpeed(self:GetSequence())
			-- 		local moveDirection = (tr.HitPos -self:GetPos()):GetNormalized()
			-- 		self:SetLocalVelocity(moveDirection *(moveSpeed <= 0 && 100 or moveSpeed))
			-- 		self:SetMoveType(MOVETYPE_STEP)
			-- 		self:SetNavType(NAV_FLY)
			-- 		self:ResetIdealActivity(moveAct)
			-- 	else
			-- 		self:SetLocalVelocity(Vector(0,0,0))
			-- 		self:SetMoveType(MOVETYPE_NONE)
			-- 		self:SetNavType(NAV_GROUND)
			-- 		self:ResetIdealActivity(idleAct)
			-- 	end
			-- end
			-- if ply:KeyDown(IN_DUCK) && curTime > self.ChangeSetT then
			-- 	self.CurrentSet = (curSet == 1 && self.CanStand) && 2 or 1
			-- 	self.ChangeSetT = curTime +0.5
			-- 	self.NextIdleTime = 0
			-- 	self.NextIdleStandTime = 0
			-- 	if self.CurrentSet == 1 then
			-- 		self.AnimTbl_Flinch = self.AnimTbl_FlinchCrouch
			-- 	else
			-- 		self.AnimTbl_Flinch = self.AnimTbl_FlinchStand
			-- 	end
			-- end
		else
			self.ConstantlyFaceEnemy = self.IsUsingFaceAnimation
			if curTime > self.MoveAroundRandomlyT then
				if IsValid(ent) then
					self:StalkingAI(ent) // Let the creepy begin...
					if self.StalkingAITime > curTime then
						if !self.AlwaysStand then
							self.CurrentSet = 1
							self.NextIdleTime = 0
							self.NextIdleStandTime = 0
							self.ChangeSetT = curTime +math.Rand(15,35)
							self.AnimTbl_Flinch = self.AnimTbl_FlinchCrouch
						end
						return
					end
					if self.CanSprint && self.SprintT < 3 && !self.AI_IsSprinting && curTime > self.NextSprintT && math.random(1,12) == 1 then
						self.AI_IsSprinting = true
					end
					local dist = self.LastEnemyDistance
					if curTime > self.ChangeSetT then
						if curSet == 1 then
							if self.CanStand && (self.AlwaysStand or !self.AlwaysStand && dist < 750 && math.random(1,20) == 1) then
								self.CurrentSet = 2
								self.AnimTbl_Flinch = self.AnimTbl_FlinchStand
								self.NextIdleTime = 0
								self.NextIdleStandTime = 0
								self.ChangeSetT = curTime +math.Rand(15,35)
								self.MoveAroundRandomlyT = 0
								self.NextMoveRandomlyT = curTime +math.random(3,8)
								self.NextChaseTime = 0
							end
						else
							if !self.AlwaysStand && dist >= 750 && math.random(1,10) == 1 then
								self.CurrentSet = 1
								self.AnimTbl_Flinch = self.AnimTbl_FlinchCrouch
								self.NextIdleTime = 0
								self.NextIdleStandTime = 0
								self.ChangeSetT = curTime +math.Rand(15,35)
							end
						end
					end
				else
					if curTime > self.ChangeSetT then
						self.CurrentSet = self.AlwaysStand && 2 or 1
						self.NextIdleTime = 0
						self.NextIdleStandTime = 0
						self.ChangeSetT = curTime +math.Rand(3,8)
						if self.CurrentSet == 1 then
							self.AnimTbl_Flinch = self.AnimTbl_FlinchCrouch
						else
							self.AnimTbl_Flinch = self.AnimTbl_FlinchStand
						end
					end
				end
			else
				if self:GetGoalPos():Distance(self:GetPos()) > 50 then
					self.MoveAroundRandomlyT = curTime +self:GetPathTimeToGoal()
				end
			end
		end
	end
	if IsValid(ent) then
		self.LastEnemyDistance = VJ.GetNearestDistance(self, ent)
	end

	if (IsValid(self.VJ_TheController) or !IsValid(self.VJ_TheController) && !IsValid(ent) && !self.Alerted) && curTime > self.RoyalMorphT && math.random(1,250) == 1 && self.VJ_AVP_CanBecomeQueen && !self:IsBusy() && !VJ_AVP_QueenExists(self) then
		if self.VJ_AVP_XenomorphID == "praetorian" then
			self:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK)
			VJ.STOPSOUND(self.CurrentSpeechSound)
			VJ.STOPSOUND(self.CurrentIdleSound)
			VJ.CreateSound(self,"cpthazama/avp/xeno/praetorian/vocal/praetorian_death_scream_03.ogg",90,110)
			self:PlayAnim("knockdown_forward",true,false,false,0,{OnFinish=function(interrupted)
				if VJ_AVP_QueenExists(self) then return end
				local xeno = ents.Create(self.VJ_AVP_K_Xenomorph && "npc_vj_avp_kxeno_queen" or "npc_vj_avp_xeno_queen")
				xeno:SetPos(self:GetPos())
				xeno:SetAngles(self:GetAngles())
				xeno.VJ_NPC_Class = self.VJ_NPC_Class
				xeno:Spawn()
				xeno:Activate()
				xeno:ForceSetEnemy(self:GetEnemy(),true)
				xeno:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK)
				VJ.STOPSOUND(xeno.CurrentSpeechSound)
				VJ.STOPSOUND(xeno.CurrentIdleSound)
				xeno:SetModelScale(0.65)
				VJ.CreateSound(xeno,"cpthazama/avp/xeno/alien queen/vocal/alien_queen_scream_05.ogg",110,90)
				local _,dur = xeno:PlayAnim("Alien_Queen_fidget_roar",true,false,false,0,{OnFinish=function(interrupted)
					if interrupted then return end
					xeno:SetState()
				end})
				xeno.NextLookForBirthT = CurTime() +dur +5
				xeno.NextSpecialEggCheckT = CurTime() +dur +5
				xeno:SetModelScale(1,dur -1)
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
			end})
		else
			if VJ_AVP_GetPraetorianCount() < 2 then
				self:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK)
				VJ.STOPSOUND(self.CurrentSpeechSound)
				VJ.STOPSOUND(self.CurrentIdleSound)
				self:PlayAnim("crawl_to_block",true,false,false,0,{OnFinish=function(interrupted)
					local xeno = ents.Create(self.VJ_AVP_K_Xenomorph && "npc_vj_avp_kxeno_praetorian" or "npc_vj_avp_xeno_praetorian")
					xeno:SetPos(self:GetPos())
					xeno:SetAngles(self:GetAngles())
					xeno.VJ_NPC_Class = self.VJ_NPC_Class
					xeno:Spawn()
					xeno:Activate()
					xeno:ForceSetEnemy(self:GetEnemy(),true)
					xeno:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK)
					xeno:PlayAnim("Praetorian_Stand_Summon_Into",true,false,false,0,{OnFinish=function(interrupted)
						VJ.STOPSOUND(xeno.CurrentSpeechSound)
						VJ.STOPSOUND(xeno.CurrentIdleSound)
						VJ.CreateSound(xeno,"cpthazama/avp/xeno/praetorian/vocal/praetorian_summon_long_01.ogg",110)
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
				end})
			end
		end
	end

	if self.FootData then
		local checkPos = self:GetPos()
		for attName, var in pairs(self.FootData) do
			if !var.AttID then continue end
	
			local footPos = self:GetAttachment(var.AttID).Pos
			checkPos.x = footPos.x
			checkPos.y = footPos.y	
			if ((footPos -checkPos):LengthSqr()) > (var.Range *var.Range) then
				var.OnGround = false
			elseif !var.OnGround then
				var.OnGround = true
				self:FootStep(footPos, attName)
			end
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local model = "models/cpthazama/avp/xeno/hud.mdl"
--
function ENT:SetViewModelWeapon(wep,ply)
	local vm = ply:GetViewModel()
	if IsValid(vm) then
		local isScripted = wep:IsScripted()

		if isScripted and wep.ViewModelFOV then
			fov = wep.ViewModelFOV
		end

		if (self:GetVM() != wep or vm:GetModel() != model) then
			vm:SetModel(model)
			vm:SetNoDraw(false)

			if isScripted then
				timer.Simple(0, function()
					if wep:IsValid() then
						wep:Deploy()
					end
				end)
			end

			self:SetVM(wep)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local bit_band = bit.band
--
function ENT:OnDamaged(dmginfo, hitgroup, status)
	if status == "PreDamage" then
		local dmgType = dmginfo:GetDamageType()
		if (self.IsBlocking or self.AI_IsBlocking) && (bit_band(dmgType,DMG_CLUB) == DMG_CLUB or bit_band(dmgType,DMG_SLASH) == DMG_SLASH or bit_band(dmgType,DMG_VEHICLE) == DMG_VEHICLE) then
			local attacker = dmginfo:GetAttacker()
			if !IsValid(attacker) then
				attacker = dmginfo:GetInflictor()
			end
			local isBigDmg = (dmginfo:GetDamage() > (attacker.VJ_ID_Boss && 40 or 65) or bit_band(dmgType,DMG_VEHICLE) == DMG_VEHICLE)
			if IsValid(attacker) && isBigDmg then
				local attackerLookDir = attacker:GetAimVector()
				local dotForward = attackerLookDir:Dot(self:GetForward())
				if dotForward > 0.5 then -- Hit from the front
					self:PlayAnim("standing_guard_broken_back",true,false,false)
				elseif dotForward < -0.5 then -- Hit from the back
					self:PlayAnim("standing_guard_broken",true,false,false)
				else
					self:PlayAnim("standing_guard_broken",true,false,false)
				end
				self.SpecialBlockAnimTime = CurTime() +1
				self.IsBlocking = false
				self.AI_IsBlocking = false
			else
				dmginfo:SetDamage(0)
				if IsValid(attacker) && attacker.OnAttackBlocked then
					attacker:OnAttackBlocked(self)
				end
				if self.AI_IsBlocking && !IsValid(self.VJ_TheController) && math.random(1,3) == 1 then
					self.AI_IsBlocking = false
					self.IsBlocking = false
					self:AttackCode(false,5)
				else
					local _,animTime = self:PlayAnim({"standing_guard_block_left","standing_guard_block_right"},true,false,false)
					self.BlockAnimTime = CurTime() +animTime
					if IsValid(attacker) && attacker:IsPlayer() then
						attacker:ViewPunch(Angle(-15,math.random(-3,3),math.random(-3,3)))
						local impact = math.random(5,10)
						local ang = attacker:EyeAngles()
						ang.p = ang.p +math.random(-impact,impact)
						ang.y = ang.y +math.random(-impact,impact)
						attacker:SetEyeAngles(ang)
					end
				end
			end
		elseif dmginfo:IsBulletDamage() && (self.IsBlocking or self.AI_IsBlocking) then
			self.IsBlocking = false
			self.BlockAnimTime = 0
			self.AI_IsBlocking = false
			self.AI_BlockTime = 0
		end

		if dmginfo:IsBulletDamage() then
			local ammoType = dmginfo:GetAmmoType()
			if ammoType == 1 or ammoType == 5 or ammoType == 7 or ammoType == 13 or ammoType == 14 or ammoType == 20 or ammoType == 21 or ammoType == 22 or ammoType == 24 or ammoType == 36 then return end
			local bulletReq = self.BulletDamageReductionRequirement
			if dmginfo:GetDamage() <= bulletReq then
				dmginfo:SetDamage(dmginfo:GetDamage() <= (bulletReq *0.5) && 1 or math_Clamp(dmginfo:GetDamage() *self.BulletDamageReduction,1,bulletReq))
			end
			if self.VJ_AVP_XenomorphRavager then
				if self.HasSounds && self.HasImpactSounds then
					VJ.EmitSound(self, "vj_base/impact/armor"..math.random(1, 10)..".wav", 60)
				end
				-- if math.random(1, 3) == 1 then
				-- 	local effectData = EffectData()
				-- 	effectData:SetOrigin(dmginfo:GetDamagePosition())
				-- 	effectData:SetNormal(dmginfo:GetDamageForce():GetNormalized())
				-- 	effectData:SetMagnitude(3)
				-- 	effectData:SetScale(1)
				-- 	util.Effect("ElectricSpark", effectData)
				-- end
			end
		end

		local dmgInflictor = dmginfo:GetInflictor()
		local dmgAttacker = dmginfo:GetAttacker()
		if (self:IsOnFire() && IsValid(dmgInflictor) && IsValid(dmgAttacker) && dmgInflictor:GetClass() == "entityflame" && dmgAttacker:GetClass() == "entityflame") then
			dmginfo:ScaleDamage(2)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnBleed(dmginfo,hitgroup)
	-- print("Damaged!")
	self:Acid(dmginfo:GetDamagePosition(),65,5)
	-- VJ.AVP_ApplyRadiusDamage(self, self, dmginfo:GetDamagePosition(), 65, 5, DMG_ACID, true, true)
	self.HealthRegenDelayT = CurTime() +5
	if self.MoveAroundRandomlyT > CurTime() then
		self.NextChaseTime = 0
		self.MoveAroundRandomlyT = 0
		self:ClearGoal()
		self:StopMoving()
	end

	if !self.IsCrawler && self.CanDodge && !self:IsBusy() && math.random(1,8) == 1 then
		self:PlayAnim({"dodge_left","dodge_right"},true,false,true)
	end

	local decap = self.HitGroups[hitgroup]
	if decap then
		if decap.Dead then return end
		decap.HP = decap.HP -dmginfo:GetDamage()
		if decap.HP <= 0 then
			decap.Dead = true
			if hitgroup == HITGROUP_LEFTLEG or hitgroup == HITGROUP_RIGHTLEG or hitgroup == HITGROUP_LEFTARM or hitgroup == HITGROUP_RIGHTARM then
				self.IsCrawler = true
			end
			if decap.OnDecap then
				decap.OnDecap(self,dmginfo,hitgroup)
			end
		end
	end

	local explosion = dmginfo:IsExplosionDamage()
	if self.CanBeKnockedDown && self:GetState() == VJ_STATE_NONE && !self.InFatality && !self.DoingFatality && self:Health() > 0 && (explosion or dmginfo:GetDamage() > 100 or bit_band(dmginfo:GetDamageType(),DMG_SNIPER) == DMG_SNIPER or (bit_band(dmginfo:GetDamageType(),DMG_BUCKSHOT) == DMG_BUCKSHOT && dmginfo:GetDamage() > 75) or (!self.VJ_ID_Boss && bit_band(dmginfo:GetDamageType(),DMG_VEHICLE) == DMG_VEHICLE) or (dmginfo:GetAttacker().VJ_ID_Boss && bit_band(dmginfo:GetDamageType(),DMG_CRUSH) == DMG_CRUSH)) then
		if CurTime() < self.NextKnockdownT then return end
		local dmgAng = ((explosion && dmginfo:GetDamagePosition() or dmginfo:GetAttacker():GetPos()) -self:GetPos()):Angle()
		dmgAng.p = 0
		dmgAng.r = 0
		if self:Health() <= self:GetMaxHealth() *0.25 then
			decap = self.HitGroups[math.random(4,7)]
			if decap then
				if decap.Dead then return end
				decap.Dead = true
				if decap.OnDecap then
					decap.OnDecap(self,dmginfo,hitgroup)
				end
			end
		end
		self:TaskComplete()
		self:StopMoving()
		self:ClearSchedule()
		self:ClearGoal()
		self:SetAngles(dmgAng)
		self:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK)
		local dmgDir = self:GetDamageDirection(dmginfo)
		self:DoKnockdownAnimation(dmgDir)
		self.NextDamageAllyResponseT = CurTime() +1
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnFlinch(dmginfo, hitgroup, status)
	if status == "Execute" then
		self:SetState()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DoKnockdownAnimation(dmgDir)
	local _,dir = self:PlayAnim(dmgDir == 4 && "standing_knockdown_forward" or "standing_knockdown_back",true,false,false,0,{OnFinish=function(interrupted)
		if interrupted then return end
		self:SetState()
	end})
	self.NextKnockdownT = CurTime() +(dir *0.5)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnDeath(dmginfo, hitgroup, status)
	if status == "Finish" then
		-- VJ.AVP_ApplyRadiusDamage(self, self, self:GetPos(), 150, 20, DMG_ACID, true, true)
		self:Acid(self:GetPos(),150,20)

		if IsValid(self.VJ_TheController) then
			self.VJ_TheController:SetNW2Int("AVP_SurvivalRespawn",CurTime() +10)
		end

		if self:GetState() == VJ_STATE_NONE then
			for i = 1,self:GetBoneCount() -1 do
				if math.random(1,4) <= 3 then continue end
				local bone = self:GetBonePosition(i)
				if bone then
					local particle = ents.Create("info_particle_system")
					particle:SetKeyValue("effect_name", VJ.PICK(self.BloodParticle))
					particle:SetPos(bone +VectorRand() *15)
					particle:Spawn()
					particle:Activate()
					particle:Fire("Start")
					particle:Fire("Kill", "", 0.1)
				end
			end
		end

		if self.WhenKilled then
			self:WhenKilled()
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SelectMovementActivity(act)
	-- local act = ACT_RUN
	local ply = self.VJ_TheController
	local curTime = CurTime()
	local standing = self.CurrentSet == 2
	if self:IsOnFire() && self.ReactsToFire then
		return ACT_WALK_ON_FIRE
	end
	local gib = self.Gibbed
	if gib && (gib.LeftLeg or gib.RightLeg or gib.LeftArm or gib.RightArm) then
		return (gib.LeftArm && ACT_WALK_CROUCH or gib.RightArm && ACT_WALK_CROUCH_AIM) or ACT_RUN_CROUCH
	end
	if IsValid(ply) then
		if ply:KeyDown(IN_WALK) then
			return standing && ACT_WALK or ACT_WALK_RELAXED
		elseif ply:KeyDown(IN_SPEED) && self.NextSprintT < curTime then
			return standing && ACT_MP_SPRINT or ACT_SPRINT
		else
			return standing && ACT_RUN or ACT_RUN_RELAXED
		end
	end
	if curTime < self.StalkingAITime or curTime < self.MoveAroundRandomlyT then
		return ACT_WALK_RELAXED
	end
	if act == ACT_WALK then
		return standing && ((!moveRandom && self.Alerted) && ACT_WALK_STIMULATED or ACT_WALK) or ACT_WALK_RELAXED
	elseif act == ACT_RUN then
		if self.NextSprintT < curTime && self.AI_IsSprinting then
			return standing && ACT_MP_SPRINT or ACT_SPRINT
		else
			return standing && ACT_RUN or ACT_RUN_RELAXED
		end
	end
	return act
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SelectIdleActivity(act)
	-- local act = ACT_IDLE
	local standing = self.CurrentSet == 2
	local gib = self.Gibbed
	if gib && (gib.LeftLeg or gib.RightLeg or gib.LeftArm or gib.RightArm) then
		return (gib.LeftArm && ACT_WALK_CROUCH or gib.RightArm && ACT_WALK_CROUCH_AIM) or ACT_RUN_CROUCH
	end
	if standing then
		act = ACT_IDLE_ANGRY
	else
		act = ACT_IDLE
	end
	return act
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
function ENT:OnCreateDeathCorpse(dmginfo, hitgroup, ent)
	ent.VJ_AVP_Xenomorph = true
	ent:SetNW2Bool("AVP.Xenomorph",true)

	VJ_AVP_XenoBloodSpill(self,ent)
end
---------------------------------------------------------------------------------------------------------------------------------------------
local colorYellow = VJ.Color2Byte(Color(255, 221, 35))
--
function ENT:HandleGibOnDeath(dmginfo, hitgroup)
	if self.VJ_AVP_XenomorphLarge then return false end

	self.HasDeathSounds = false
	if self.HasGibOnDeathEffects then
		local effectData = EffectData()
		effectData:SetOrigin(self:GetPos() + self:OBBCenter())
		effectData:SetColor(colorYellow)
		effectData:SetScale(120)
		util.Effect("VJ_Blood1", effectData)
		effectData:SetScale(8)
		effectData:SetFlags(3)
		effectData:SetColor(1)
		util.Effect("bloodspray", effectData)
		util.Effect("bloodspray", effectData)
	end

	VJ_AVP_XenoBloodSpill(nil,nil,true,{Pos = self:GetPos(), Class = self.VJ_NPC_Class})
	
	-- self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/agib1.mdl", {BloodType="Yellow", CollisionDecal="VJ_HLR_Blood_Yellow", Pos=self:LocalToWorld(Vector(0, 0, 40))})
	self:PlaySoundSystem("Gib", "cpthazama/avp/xeno/alien/gib/alien_explode_0" .. math.random(1,6) .. ".ogg")
	return true, {AllowSound = false}
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnCreateSound(sdData, sdFile)
	if self.BreathLoop then
		self.BreathLoop:ChangeVolume(0.1)
		self.CurrentVoiceLineTime = CurTime() +SoundDuration(sdFile) *1.5
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:PlaySound(sndTbl,level,pitch,setCurSnd)
	if sndTbl == nil or istable(sndTbl) && #sndTbl <= 0 then return 0 end
	if setCurSnd then
		VJ.STOPSOUND(self.CurrentSpeechSound)
		VJ.STOPSOUND(self.CurrentIdleSound)
	end
	local sndName = VJ.PICK(sndTbl)
	if self.BreathLoop then
		self.BreathLoop:ChangeVolume(0.1)
	end
	local snd = VJ.CreateSound(self,sndName,level or 75,pitch or self:GetSoundPitch(false))
	if setCurSnd then
		self.CurrentVoiceLine = snd
	end
	self.CurrentVoiceLineTime = CurTime() +SoundDuration(sndName) *1.5
	self.DeleteSounds = self.DeleteSounds or {}
	table.insert(self.DeleteSounds,snd)
	return SoundDuration(sndName)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
	VJ.STOPSOUND(self.CurrentVoiceLine)
	VJ.STOPSOUND(self.BreathLoop)
	if self.DeleteSounds then
		for _,v in pairs(self.DeleteSounds) do
			VJ.STOPSOUND(v)
		end
	end
	if self.WhenRemoved then
		self:WhenRemoved()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local math_atan2 = math.atan2
--
function ENT:GetDamageDirection(dmginfo)
	local dir = (self:GetPos() +self:OBBCenter()) -dmginfo:GetDamagePosition()
	dir:Normalize()
	dir.z = 0.5

	local hitDir = 1
	local forward = self:GetForward()
	local angle = math_deg(math_atan2(dir:Dot(forward:Cross(Vector(0,0,1))),dir:Dot(forward)))
	if angle >= 45 and angle <= 135 then
		-- print("NPC was hit from the left")
		hitDir = 2
	elseif angle >= -135 and angle <= -45 then
		-- print("NPC was hit from the right")
		hitDir = 3
	elseif angle >= 135 or angle <= -135 then
		-- print("NPC was hit from the front")
		hitDir = 1
	else
		-- print("NPC was hit from the back")
		hitDir = 4
	end

	return hitDir
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
	if self.MovementType != VJ_MOVETYPE_STATIONARY && !self.InCharge then
		local gerta_lef = ply:KeyDown(IN_MOVELEFT)
		local gerta_rig = ply:KeyDown(IN_MOVERIGHT)
		local gerta_arak = ply:KeyDown(IN_SPEED)
		local aimVector = ply:GetAimVector()
		local FT = FrameTime() *(self.TurningSpeed *2.25)

		self.ControllerParams.TurnAngle = self.ControllerParams.TurnAngle or defAng
		
		if ply:KeyDown(IN_FORWARD) then
			if self.MovementType == VJ_MOVETYPE_AERIAL or self.MovementType == VJ_MOVETYPE_AQUATIC then
				self:AA_MoveTo(cont.VJCE_Bullseye, true, gerta_arak and "Alert" or "Calm", {IgnoreGround=true})
			else
				self.ControllerParams.TurnAngle = LerpAngle(FT, self.ControllerParams.TurnAngle, gerta_lef && angY45 or gerta_rig && angYN45 or defAng)
				cont:StartMovement(aimVector, self.ControllerParams.TurnAngle)
			end
		elseif ply:KeyDown(IN_BACK) then
			self.ControllerParams.TurnAngle = LerpAngle(FT, self.ControllerParams.TurnAngle, gerta_lef && angY135 or gerta_rig && angYN135 or angY180)
			cont:StartMovement(aimVector, self.ControllerParams.TurnAngle)
		elseif gerta_lef then
			self.ControllerParams.TurnAngle = LerpAngle(FT, self.ControllerParams.TurnAngle, angY90)
			cont:StartMovement(aimVector, self.ControllerParams.TurnAngle)
		elseif gerta_rig then
			self.ControllerParams.TurnAngle = LerpAngle(FT, self.ControllerParams.TurnAngle, angYN90)
			cont:StartMovement(aimVector, self.ControllerParams.TurnAngle)
		else
			self:StopMoving(!self.VJ_AVP_XenomorphLarge)
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

	local DEBUG = ply:GetInfoNum("vj_npc_cont_debug", 0) == 1
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
		self:SCHEDULE_GOTO_POSITION(ply:KeyDown(IN_SPEED) and "TASK_RUN_PATH" or "TASK_WALK_PATH", function(x)
			if ply:KeyDown(IN_ATTACK2) && self.IsVJBaseSNPC_Human then
				x.TurnData = {Type = VJ.FACE_ENEMY}
				x.CanShootWhenMoving = true
			else
				if cont.VJC_BullseyeTracking then
					x.TurnData = {Type = VJ.FACE_ENEMY}
				else
					x:EngTask("TASK_FACE_LASTPOSITION", 0)
				end
			end
		end)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local math_angApproach = math.ApproachAngle
local math_angDif = math.AngleDifference
local offset = Vector(0,0,-16)
--
function ENT:UpdatePoseParamTracking(resetPoses)
	if !self.HasPoseParameterLooking then return end
	//self:GetPoseParameters(true)
	local ene = self:GetEnemy()
	local newPitch = 0 -- Pitch
	local newYaw = 0 -- Yaw
	local newRoll = 0 -- Roll
	if IsValid(ene) && !resetPoses then
		local myEyePos = self:EyePos()
		myEyePos = myEyePos +offset
		local myAng = self:GetAngles()
		local enePos = self:GetAimPosition(ene, myEyePos)
		local eneAng = (enePos - myEyePos):Angle()
		newPitch = math_angDif(eneAng.p, myAng.p)
		if self.PoseParameterLooking_InvertPitch == true then newPitch = -newPitch end
		newYaw = math_angDif(eneAng.y, myAng.y)
		if self.PoseParameterLooking_InvertYaw == true then newYaw = -newYaw end
		newRoll = math_angDif(eneAng.z, myAng.z)
		if self.PoseParameterLooking_InvertRoll == true then newRoll = -newRoll end
	elseif !self.PoseParameterLooking_CanReset then
		return
	end
	
	//self:OnUpdatePoseParamTracking(newPitch, newYaw, newRoll)
	
	local names = self.PoseParameterLooking_Names
	for x = 1, #names.pitch do
		if IsValid(self.Restraint) && names.pitch[x] != "head_pitch" then
			self:SetPoseParameter(names.pitch[x], 0)
			-- print("Reset",names.pitch[x],"to 0")
		else
			self:SetPoseParameter(names.pitch[x], math_angApproach(self:GetPoseParameter(names.pitch[x]), newPitch, self.PoseParameterLooking_TurningSpeed))
		end
	end
	for x = 1, #names.yaw do
		if IsValid(self.Restraint) && names.yaw[x] != "head_yaw" then
			self:SetPoseParameter(names.yaw[x], 0)
			-- print("Reset",names.yaw[x],"to 0")
		else
			self:SetPoseParameter(names.yaw[x], math_angApproach(self:GetPoseParameter(names.yaw[x]), newYaw, self.PoseParameterLooking_TurningSpeed))
		end
	end
	for x = 1, #names.roll do
		if IsValid(self.Restraint) then
			self:SetPoseParameter(names.roll[x], 0)
		else
			self:SetPoseParameter(names.roll[x], math_angApproach(self:GetPoseParameter(names.roll[x]), newRoll, self.PoseParameterLooking_TurningSpeed))
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local varGes = "vjges_"
local varSeq = "vjseq_"
local string_sub = string.sub
local table_concat = table.concat
--
function ENT:PlayAnim(animation, lockAnim, lockAnimTime, faceEnemy, animDelay, extraOptions, customFunc)
	animation = VJ.PICK(animation)
	if !animation then return ACT_INVALID, 0, ANIM_TYPE_NONE end
	
	lockAnim = lockAnim or false
	if lockAnimTime == nil then -- If user didn't put anything, then default it to 0
		lockAnimTime = 0 -- Set this value to false to let the base calculate the time
	end
	faceEnemy = faceEnemy or false -- Should it face the enemy while playing this animation?
	animDelay = tonumber(animDelay) or 0 -- How much time until it starts playing the animation (seconds)
	extraOptions = extraOptions or {}
	local isGesture = false
	local isSequence = false
	local isString = isstring(animation)
	
	-- Handle "vjges_" and "vjseq_"
	if isString then
		local finalString; -- Only define a table if we need to!
		local posCur = 1
		for i = 1, #animation do
			local posStartGes, posEndGes = string_find(animation, varGes, posCur) -- Check for "vjges_"
			local posStartSeq, posEndSeq = string_find(animation, varSeq, posCur) -- Check for "vjges_"
			if !posStartGes && !posStartSeq then -- No ges or seq was found, end the loop!
				if finalString then
					finalString[#finalString + 1] = string_sub(animation, posCur)
				end
				break
			end
			if !finalString then finalString = {} end -- Found a match, create table if needed
			if posStartGes then
				isGesture = true
				finalString[i] = string_sub(animation, posCur, posStartGes - 1)
				posCur = posEndGes + 1
			end
			if posStartSeq then
				isSequence = true
				finalString[i] = string_sub(animation, posCur, posStartSeq - 1)
				posCur = posEndSeq + 1
			end
		end
		if finalString then
			animation = table_concat(finalString)
		end
		-- If animation is -1 then it's probably an activity, so turn it into an activity
		-- EX: "vjges_"..ACT_MELEE_ATTACK1
		if isGesture && !isSequence && self:LookupSequence(animation) == -1 then
			animation = tonumber(animation)
			isString = false
		end
	end
	
	if extraOptions.AlwaysUseGesture == true then isGesture = true end -- Must play as a gesture
	if extraOptions.AlwaysUseSequence == true then -- Must play as a sequence
		//isGesture = false -- Leave this alone to allow gesture-sequences to play even when "AlwaysUseSequence" is true!
		isSequence = true
		if isnumber(animation) then -- If it's an activity, then convert it to a string
			animation = self:GetSequenceName(self:SelectWeightedSequence(animation))
		end
	elseif isString && !isSequence then -- Only for regular & gesture strings
		-- If it can be played as an activity, then convert it!
		local result = self:GetSequenceActivity(self:LookupSequence(animation))
		if result == nil or result == -1 then -- Leave it as string
			isSequence = true
		else -- Set it as an activity
			animation = result
			isString = false
		end
	end
	
	-- If the given animation doesn't exist, then check to see if it does in the weapon translation list
	if VJ.AnimExists(self, animation) == false then
		if !isString then -- If it's an activity then check for possible translation
			-- If it returns the same activity as "animation", then there isn't even a translation for it so don't play any animation =(
			if self:TranslateActivity(animation) == animation then
				return ACT_INVALID, 0, ANIM_TYPE_NONE
			end
		else -- No animation =(
			return ACT_INVALID, 0, ANIM_TYPE_NONE
		end
	end
	
	local animType = ((isGesture and ANIM_TYPE_GESTURE) or isSequence and ANIM_TYPE_SEQUENCE) or ANIM_TYPE_ACTIVITY -- Find the animation type
	local seed = CurTime() -- Seed the current animation, used for animation delaying & on complete check
	self.LastAnimType = animType
	self.LastAnimSeed = seed
	
	local function PlayAct()
		local originalPlaybackRate = self.AnimPlaybackRate
		local customPlaybackRate = extraOptions.PlayBackRate
		local playbackRate = customPlaybackRate or originalPlaybackRate
		self:SetPlaybackRate(playbackRate) -- Call this to change "self.AnimPlaybackRate" so "DecideAnimationLength" can be calculated correctly
		local animTime = self:DecideAnimationLength(animation, false)
		self.AnimPlaybackRate = originalPlaybackRate -- Change it back to the true rate
		local doRealAnimTime = true -- Only for activities, recalculate the animTime after the schedule starts to get the real sequence time, if `lockAnimTime` is NOT set!
		
		if lockAnim then
			if isbool(lockAnimTime) then -- false = Let the base calculate the time
				lockAnimTime = animTime
			else -- Manually calculated
				doRealAnimTime = false
				if !extraOptions.PlayBackRateCalculated then -- Make sure not to calculate the playback rate when it already has!
					lockAnimTime = lockAnimTime / playbackRate
				end
				animTime = lockAnimTime
			end
			
			local curTime = CurTime()
			self.NextChaseTime = curTime + lockAnimTime
			self.NextIdleTime = curTime + lockAnimTime
			self.AnimLockTime = curTime + lockAnimTime
			
			if lockAnim != "LetAttacks" then
				self:StopAttacks(true)
				self.PauseAttacks = true
				timer.Create("attack_pause_reset"..self:EntIndex(), lockAnimTime, 1, function() self.PauseAttacks = false end)
			end
		end
		self.LastAnimSeed = seed -- We need to set it again because self:StopAttacks() above will reset it when it calls to chase enemy!
		
		if isGesture then
			-- If it's an activity gesture AND it's already playing it, then remove it! Fixes same activity gestures bugging out when played right after each other!
			if !isSequence && self:IsPlayingGesture(animation) then
				self:RemoveGesture(animation)
				//self:RemoveAllGestures() -- Disallows the ability to layer multiple gestures!
			end
			local gesture = isSequence and self:AddGestureSequence(self:LookupSequence(animation)) or self:AddGesture(animation)
			//print(gesture)
			if gesture != -1 then
				self:SetLayerPriority(gesture, 1) // 2
				//self:SetLayerWeight(gesture, 1)
				self:SetLayerPlaybackRate(gesture, extraOptions.GesturePlayBackRate or playbackRate * 0.5)
			end
		else -- Sequences & Activities
			local schedule = vj_ai_schedule.New("PlayAnim_"..animation)
			
			-- For humans NPCs, internally the base will set these variables back to true after this function if it's called by weapon attack animations!
			self.WeaponAttackState = VJ.WEP_ATTACK_STATE_NONE
			
			//self:StartEngineTask(ai.GetTaskID("TASK_RESET_ACTIVITY"), 0) //schedule:EngTask("TASK_RESET_ACTIVITY", 0)
			//if self.Dead then schedule:EngTask("TASK_STOP_MOVING", 0) end
			//self:FrameAdvance(0)
			self:TaskComplete()
			self:StopMoving()
			self:ClearSchedule()
			self:ClearGoal()
			
			if isSequence then
				doRealAnimTime = false -- Sequences already have the correct time
				local seqID = self:LookupSequence(animation)
				--
				-- START: Experimental transition system for sequences
				local transitionAnim = self:FindTransitionSequence(self:GetSequence(), seqID) -- Find the transition sequence
				local transitionAnimTime = 0
				if transitionAnim != -1 && seqID != transitionAnim then -- If it exists AND it's not the same as the animation
					transitionAnimTime = self:SequenceDuration(transitionAnim) / playbackRate
					schedule:AddTask("TASK_VJ_PLAY_SEQUENCE", {
						animation = transitionAnim,
						playbackRate = customPlaybackRate or false,
						duration = transitionAnimTime
					})
				end
				-- END: Experimental transition system for sequences
				--
				schedule:AddTask("TASK_VJ_PLAY_SEQUENCE", {
					animation = animation,
					playbackRate = customPlaybackRate or false,
					duration = animTime
				})
				//self:PlaySequence(animation, playbackRate, extraOptions.SequenceDuration != false, dur)
				animTime = animTime + transitionAnimTime -- Adjust the animation time in case we have a transition animation!
			else -- Only if activity
				//self:SetActivity(ACT_RESET)
				schedule:AddTask("TASK_VJ_PLAY_ACTIVITY", {
					animation = animation,
					playbackRate = customPlaybackRate or false,
					duration = doRealAnimTime or animTime
				})
				-- Old engine task animation system
				/*if self.MovementType == VJ_MOVETYPE_AERIAL or self.MovementType == VJ_MOVETYPE_AQUATIC then
					self:ResetIdealActivity(animation)
					//schedule:EngTask("TASK_SET_ACTIVITY", animation) -- To avoid AutoMovement stopping the velocity
				//elseif faceEnemy == true then
					//schedule:EngTask("TASK_PLAY_SEQUENCE_FACE_ENEMY", animation)
				else
					-- Engine's default animation task
					-- REQUIRED FOR TASK_PLAY_SEQUENCE: It fixes animations NOT applying walk frames if the previous animation was the same!
					if self:GetActivity() == animation then
						self:ResetSequenceInfo()
						self:SetSaveValue("sequence", 0)
					end
					schedule:EngTask("TASK_PLAY_SEQUENCE", animation)
				end*/
			end
			schedule.IsPlayActivity = true
			schedule.CanBeInterrupted = !lockAnim
			if (customFunc) then customFunc(schedule, animation) end
			self:StartSchedule(schedule)
			if doRealAnimTime then
				-- Get the calculated duration (Only done in Activity type)
				animTime = self.CurrentTask.TaskData.duration
			end
			if faceEnemy then
				self:SetTurnTarget("Enemy", animTime, false, faceEnemy == "Visible")
			end
		end
		
		-- If it has a OnFinish function, then set the timer to run it when it finishes!
		if (extraOptions.OnFinish) then
			timer.Simple(animTime, function()
				if IsValid(self) && !self.Dead then
					extraOptions.OnFinish(self.LastAnimSeed != seed, animation)
				end
			end)
		end
		return animTime
	end
	
	-- For delay system
	if animDelay > 0 then
		timer.Simple(animDelay, function()
			if IsValid(self) && self.LastAnimSeed == seed then
				PlayAct()
			end
		end)
		return animation, animDelay + self:DecideAnimationLength(animation, false), animType -- Approximation, this may be inaccurate!
	else
		return animation, PlayAct(), animType
	end
end