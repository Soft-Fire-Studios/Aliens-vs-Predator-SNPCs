if SERVER then
    AddCSLuaFile()
end

AVP = AVP or {}
AVP.TDM = AVP.TDM or {}

local TDM = AVP.TDM

TDM.MaxSlots = 18
TDM.TeamSize = 6
TDM.LobbyDuration = 120
TDM.MatchDuration = 600
TDM.RespawnDelay = 10

TDM.TeamOrder = {"marine", "xeno", "predator"}
TDM.TeamData = {
    marine = {
        Name = "Marines",
        Singular = "Marine",
        Health = 100,
        Icon = "vgui/avp/menu_ico_faction_marine.png",
        Background = "vgui/avp/bg_human.png",
        Banner = "vgui/avp/faction_marine.png",
    },
    xeno = {
        Name = "Xenomorphs",
        Singular = "Xenomorph",
        Health = 150,
        Icon = "vgui/avp/menu_ico_faction_xenomorph.png",
        Background = "vgui/avp/bg_alien.png",
        Banner = "vgui/avp/faction_alien.png",
    },
    predator = {
        Name = "Predators",
        Singular = "Predator",
        Health = 250,
        Icon = "vgui/avp/menu_ico_faction_predator.png",
        Background = "vgui/avp/bg_predator.png",
        Banner = "vgui/avp/faction_predator.png",
    },
}

TDM.Skins = {
    marine = {
        {ID = "rookie", Name = "Rookie", Class = "npc_vj_avp_hum_rookie", Material = "vgui/avp/skins/hum_rookie.png"},
        {ID = "connor", Name = "Connor", Class = "npc_vj_avp_hum_connor", Material = "vgui/avp/skins/hum_connor.png"},
        {ID = "franco", Name = "Franco", Class = "npc_vj_avp_hum_franco", Material = "vgui/avp/skins/hum_franco.png"},
        {ID = "gibson", Name = "Gibson", Class = "npc_vj_avp_hum_gibson", Material = "vgui/avp/skins/hum_gibson.png"},
        {ID = "johnson", Name = "Johnson", Class = "npc_vj_avp_hum_johnson", Material = "vgui/avp/skins/hum_johnson.png"},
        {ID = "moss", Name = "Moss", Class = "npc_vj_avp_hum_moss", Material = "vgui/avp/skins/hum_moss.png"},
        {ID = "van", Name = "Van Zandt", Class = "npc_vj_avp_hum_van", Material = "vgui/avp/skins/hum_van.png"},
    },
    xeno = {
        {ID = "warrior", Name = "Warrior", Class = "npc_vj_avp_xeno_warrior", Material = "vgui/avp/skins/xeno_warrior.png"},
        {ID = "six", Name = "Specimen Six", Class = "npc_vj_avp_xeno_six", Material = "vgui/avp/skins/xeno_six.png"},
        {ID = "nethead", Name = "Nethead", Class = "npc_vj_avp_xeno_nethead", Material = "vgui/avp/skins/xeno_nethead.png"},
        {ID = "praetorian", Name = "Praetorian", Class = "npc_vj_avp_xeno_praetorian", Material = "vgui/avp/skins/xeno_praetorian.png"},
        {ID = "drone", Name = "Drone", Class = "npc_vj_avp_xeno_drone", Material = "vgui/avp/skins/xeno_drone.png"},
        {ID = "rigid", Name = "Ridged Warrior", Class = "npc_vj_avp_xeno_ridged", Material = "vgui/avp/skins/xeno_rigid.png"},
    },
    predator = {
        {ID = "default", Name = "Youngblood", Class = "npc_vj_avp_pred", Material = "vgui/avp/skins/pred_default.png"},
        {ID = "dark", Name = "Dark", Class = "npc_vj_avp_pred_dark", Material = "vgui/avp/skins/pred_dark.png"},
        {ID = "claw", Name = "Claw", Class = "npc_vj_avp_pred_claw", Material = "vgui/avp/skins/pred_claw.png"},
        {ID = "stalker", Name = "Stalker", Class = "npc_vj_avp_pred_stalker", Material = "vgui/avp/skins/pred_stalker.png"},
        {ID = "hunter", Name = "Hunter", Class = "npc_vj_avp_pred_hunter", Material = "vgui/avp/skins/pred_hunter.png"},
        {ID = "wolf", Name = "Wolf", Class = "npc_vj_avp_pred_wolf", Material = "vgui/avp/skins/pred_wolf.png"},
        {ID = "spartan", Name = "Spartan", Class = "npc_vj_avp_pred_spartan", Material = "vgui/avp/skins/pred_spartan.png"},
        {ID = "lord", Name = "Lord", Class = "npc_vj_avp_pred_lord", Material = "vgui/avp/skins/pred_lord.png"},
        {ID = "alien", Name = "Alien", Class = "npc_vj_avp_pred_alien", Material = "vgui/avp/skins/pred_alien.png"},
    },
}

TDM.MarineWeapons = {
    [1] = {Class = "weapon_vj_avp_pistol", Name = "Pistol"},
    [2] = {Class = "weapon_vj_avp_pulserifle", Name = "Pulse Rifle"},
    [3] = {Class = "weapon_vj_avp_shotgun", Name = "Shotgun"},
    [4] = {Class = "weapon_vj_avp_flamethrower", Name = "Flamethrower"},
    [5] = {Class = "weapon_vj_avp_scopedrifle", Name = "Scoped Rifle"},
    [6] = {Class = "weapon_vj_avp_smartgun", Name = "Smartgun"},
}

TDM.PickupToWeapon = {
    [1] = "weapon_vj_avp_pulserifle",
    [2] = "weapon_vj_avp_pistol",
    [3] = "weapon_vj_avp_shotgun",
    [4] = "weapon_vj_avp_flamethrower",
    [5] = "weapon_vj_avp_scopedrifle",
    [6] = "weapon_vj_avp_smartgun",
}

TDM.PickupResetTimes = {
    [0] = 30,
    [1] = 60,
    [2] = 60,
    [3] = 60,
    [4] = 120,
    [5] = 120,
    [6] = 180,
    [7] = 120,
}

TDM.SurvivalTracks = {
    "cpthazama/avp/music/survival/Incidental_01.mp3",
    "cpthazama/avp/music/survival/Incidental_02.mp3",
    "cpthazama/avp/music/survival/Incidental_03.mp3",
    "cpthazama/avp/music/survival/Incidental_04.mp3",
    "cpthazama/avp/music/survival/Incidental Colony 01.mp3",
    "cpthazama/avp/music/survival/Incidental Colony 02.mp3",
    "cpthazama/avp/music/survival/Incidental Temple 01.mp3",
}
TDM.FinalMinuteTrack = "cpthazama/avp/music/boss/Full Tilt Rampage.mp3"
TDM.MenuTrack = "cpthazama/avp/music/Menu.mp3"

function TDM.GetSkin(teamID, skinID)
    local list = TDM.Skins[teamID]
    if !list then return nil end
    for _, skin in ipairs(list) do
        if skin.ID == skinID then
            return skin
        end
    end
    return nil
end

function TDM.GetDefaultSkin(teamID)
    local list = TDM.Skins[teamID]
    return list && list[1] or nil
end

function TDM.IsValidTeam(teamID)
    return TDM.TeamData[teamID] != nil
end
