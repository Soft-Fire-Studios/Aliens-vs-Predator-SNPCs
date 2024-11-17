/*--------------------------------------------------
	*** Copyright (c) 2012-2024 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
AddCSLuaFile()

ENT.Base 			= "obj_vj_spawner_base"
ENT.Type 			= "anim"
ENT.PrintName 		= "Marine"
ENT.Author 			= "Cpt. Hazama"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Purpose 		= "Spawn it and fight with it!"
ENT.Instructions 	= "Click on the spawnicon to spawn it."
ENT.Category		= "Aliens vs Predator - Humans"

ENT.Spawnable		= false
ENT.AdminSpawnable	= false
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if !SERVER then return end

ENT.SingleSpawner = true
ENT.EntitiesToSpawn = {
	{
		Entities = {
			"npc_vj_avp_hum_connor",
			"npc_vj_avp_hum_franco",
			"npc_vj_avp_hum_gibson",
			"npc_vj_avp_hum_johnson",
			"npc_vj_avp_hum_moss",
			"npc_vj_avp_hum_youngwhite",
			"npc_vj_avp_hum_hispanic",
			"npc_vj_avp_hum_youngwhite",
			"npc_vj_avp_hum_butch",
			"npc_vj_avp_hum_blonde",
			"npc_vj_avp_hum_black",
			"npc_vj_avp_hum_black2",
		},
		WeaponsList = {"default"}
	},
}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnSpawnEntity(ent, spawnKey, spawnTbl, initSpawn)
	local wep = GetConVar("gmod_npcweapon"):GetString()
	if wep != "" then
		SafeRemoveEntity(ent:GetActiveWeapon())
		ent:DoChangeWeapon(wep)
	end
end