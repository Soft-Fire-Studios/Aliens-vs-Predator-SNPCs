ENT.Base 			= "npc_vj_avp_xeno_warrior"
ENT.Type 			= "ai"
ENT.PrintName 		= ""
ENT.Author 			= "Cpt. Hazama"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Category		= ""

ENT.VJ_AVP_XenomorphID = "praetorian"
ENT.VJ_AVP_Xenomorph = true
ENT.VJ_AVP_XenomorphLarge = true
ENT.VJ_AVP_XenomorphPraetorianSubClass = true
ENT.VJ_AVP_CanBecomeQueen = false

if CLIENT then
    if EmissiveSys then
        EmissiveSys:Add("models/cpthazama/avp/xeno/ranger/Goo",{
            Brightness=1,
            Color={1,0.3,0.6},
            Mask="models/cpthazama/avp/xeno/ranger/XenoRanger_Head_I"
        })
	end
end