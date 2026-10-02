if !CLIENT then return end

AVP = AVP or {}
AVP.UI = AVP.UI or {}
-- if AVP.UI.Theme then return end

local Theme = {}
AVP.UI.Theme = Theme

Theme.Colors = {
    Background = Color(7, 9, 9, 255),
    Panel = Color(16, 19, 18, 228),
    PanelSoft = Color(26, 29, 27, 205),
    PanelHover = Color(43, 45, 38, 235),
    Border = Color(180, 185, 157, 115),
    BorderBright = Color(224, 231, 197, 215),
    Yellow = Color(211, 205, 65, 255),
    YellowSoft = Color(171, 168, 62, 255),
    White = Color(232, 234, 224, 255),
    Muted = Color(151, 155, 144, 255),
    DarkText = Color(42, 44, 39, 255),
    Red = Color(168, 48, 43, 255),
    Green = Color(133, 170, 95, 255),
    Marine = Color(184, 210, 205, 255),
    Xeno = Color(167, 204, 114, 255),
    Predator = Color(243, 64, 64),
}

Theme.Materials = {
    Background = Material("vgui/avp/bg1.png", "smooth"),
    BoxWide = Material("vgui/avp/box1.png", "smooth"),
    BoxSmall = Material("vgui/avp/box2.png", "smooth"),
    SelectBar = Material("vgui/avp/bar.png", "smooth"),
    SmallSelectBar = Material("vgui/avp/small_select_bar.png", "smooth"),
    SkinHolder = Material("vgui/avp/skin_holder.png", "smooth"),
    Lights = Material("vgui/avp/lights_bg.png", "smooth"),
}

Theme.Sounds = {
    Navigate = "cpthazama/avp/shared/menu/menu_2nd_navigation.ogg",
    Accept = "cpthazama/avp/shared/menu/menu_2nd_accept.ogg",
    Cancel = "cpthazama/avp/shared/menu/menu_2nd_cancel.ogg",
    Change = "cpthazama/avp/shared/menu/menu_2nd_value_change.ogg",
}

function Theme.ScaleFactor()
    return math.Clamp(math.min(ScrW() / 1920, ScrH() / 1080), 0.62, 2.0)
end

function Theme.S(value)
    return math.floor(value * Theme.ScaleFactor() + 0.5)
end

local function FontSize(px)
    return math.max(10, Theme.S(px))
end

surface.CreateFont("AVP.UI.Hero", {
    font = "Orbitron Regular",
    size = FontSize(30),
    weight = 700,
    antialias = true,
    extended = true,
})

surface.CreateFont("AVP.UI.Title", {
    font = "Orbitron Regular",
    size = FontSize(24),
    weight = 700,
    antialias = true,
    extended = true,
})

surface.CreateFont("AVP.UI.Heading", {
    font = "Orbitron Regular",
    size = FontSize(20),
    weight = 650,
    antialias = true,
    extended = true,
})

surface.CreateFont("AVP.UI.BodyBold", {
    font = "Orbitron Regular",
    size = FontSize(17),
    weight = 700,
    antialias = true,
    extended = true,
})

surface.CreateFont("AVP.UI.Body", {
    font = "Orbitron Regular",
    size = FontSize(16),
    weight = 500,
    antialias = true,
    extended = true,
})

surface.CreateFont("AVP.UI.Small", {
    font = "Orbitron Regular",
    size = FontSize(13),
    weight = 600,
    antialias = true,
    extended = true,
})

surface.CreateFont("AVP.UI.Tiny", {
    font = "Orbitron Regular",
    size = FontSize(11),
    weight = 600,
    antialias = true,
    extended = true,
})

function Theme.TeamColor(teamID)
    if teamID == "marine" then return Theme.Colors.Marine end
    if teamID == "xeno" then return Theme.Colors.Xeno end
    if teamID == "predator" then return Theme.Colors.Predator end
    return Theme.Colors.White
end

function Theme.PlayUISound(kind)
    local path = Theme.Sounds[kind]
    if path then surface.PlaySound(path) end
end

function Theme.BindButtonSounds(button, acceptKind)
    if !IsValid(button) then return end
    button.OnCursorEntered = function()
        Theme.PlayUISound("Navigate")
    end
    button.OnCursorExited = function()
        Theme.PlayUISound("Cancel")
    end
    button._AVPAcceptSound = acceptKind or "Accept"
end

function Theme.DrawFlickerBackground(panel, w, h)
    if !panel._AVPIntroStart then
        panel._AVPIntroStart = CurTime()
        panel._AVPIntroDuration = 1.45
    end

    local frac = math.TimeFraction(panel._AVPIntroStart, panel._AVPIntroStart + panel._AVPIntroDuration, CurTime())
    frac = math.Clamp(frac, 0, 1)
    local t = CurTime() * (math.pi * 2) * 1.5
    local brightness = 0.85 + 0.12 * math.sin(t)
    if math.random() < 0.03 then
        brightness = brightness - math.Rand(0.1, 0.25)
    end
    brightness = (brightness + math.Rand(-0.02, 0.02)) * frac
    local value = math.Clamp(math.floor(255 * brightness + 0.5), 0, 255)

    surface.SetDrawColor(value, value, value, 255)
    surface.SetMaterial(Theme.Materials.Background)
    surface.DrawTexturedRect(0, 0, w, h)

    surface.SetDrawColor(0, 0, 0, 86)
    surface.DrawRect(0, 0, w, h)

    surface.SetDrawColor(211, 205, 65, 22)
    surface.DrawRect(0, 0, w, Theme.S(2))
end

function Theme.DrawGlassPanel(w, h, opts)
    opts = opts or {}
    local hover = opts.hover or 0
    local alpha = opts.alpha or 218
    local border = opts.border or Theme.Colors.Border
    local base = Theme.Colors.Panel
    local hot = Theme.Colors.PanelHover
    local r = math.floor(Lerp(hover, base.r, hot.r))
    local g = math.floor(Lerp(hover, base.g, hot.g))
    local b = math.floor(Lerp(hover, base.b, hot.b))

    surface.SetDrawColor(r, g, b, alpha)
    surface.DrawRect(0, 0, w, h)

    if Theme.Materials.BoxWide then
        surface.SetMaterial(Theme.Materials.BoxWide)
        surface.SetDrawColor(255, 255, 255, opts.boxAlpha or 105)
        surface.DrawTexturedRect(0, 0, w, h)
    else
        surface.SetDrawColor(border.r, border.g, border.b, border.a)
        surface.DrawOutlinedRect(0, 0, w, h, 1)
    end

    if opts.accent != false then
        local accent = opts.accentColor or Theme.Colors.Yellow
        surface.SetDrawColor(accent.r, accent.g, accent.b, 155)
        surface.DrawRect(0, h - Theme.S(2), w, Theme.S(2))
    end
end

function Theme.LerpHover(panel, speed)
    local hovered = IsValid(panel) && isfunction(panel.IsHovered) && panel:IsHovered() or false
    panel._AVPHover = Lerp(FrameTime() * (speed or 12), panel._AVPHover or 0, hovered && 1 or 0)
    return panel._AVPHover
end

function Theme.DrawButton(panel, w, h, opts)
    opts = opts or {}
    local hover = Theme.LerpHover(panel, 14)
    local accent = opts.accentColor or Theme.Colors.Yellow
    local disabled = panel.GetDisabled && panel:GetDisabled()

    surface.SetDrawColor(13, 15, 14, disabled && 150 or 225)
    surface.DrawRect(0, 0, w, h)

    if Theme.Materials.SelectBar then
        surface.SetMaterial(Theme.Materials.SelectBar)
        surface.SetDrawColor(255, 255, 255, disabled && 38 or math.floor(65 + hover * 75))
        surface.DrawTexturedRect(0, 0, w, h)
    end

    surface.SetDrawColor(accent.r, accent.g, accent.b, disabled && 45 or math.floor(70 + hover * 100))
    surface.DrawRect(0, h - Theme.S(2), w, Theme.S(2))
    surface.SetDrawColor(Theme.Colors.BorderBright.r, Theme.Colors.BorderBright.g, Theme.Colors.BorderBright.b, disabled && 45 or math.floor(80 + hover * 100))
    surface.DrawOutlinedRect(0, 0, w, h, 1)
end

function Theme.StyleScrollPanel(scroll)
    if !IsValid(scroll) then return end
    local bar = scroll:GetVBar()
    if !IsValid(bar) then return end
    bar:SetWide(Theme.S(9))
    bar.Paint = function(_, w, h)
        surface.SetDrawColor(8, 10, 9, 205)
        surface.DrawRect(0, 0, w, h)
    end
    bar.btnUp.Paint = function() end
    bar.btnDown.Paint = function() end
    bar.btnGrip.Paint = function(pnl, w, h)
        local hover = Theme.LerpHover(pnl, 12)
        local c = Theme.Colors.Yellow
        surface.SetDrawColor(c.r, c.g, c.b, math.floor(95 + hover * 110))
        surface.DrawRect(Theme.S(2), 0, w - Theme.S(4), h)
    end
end

function Theme.PlayMusic(owner, path, volume, shouldLoop)
    if !IsValid(owner) or !path or path == "" then return end
    Theme.StopMusic(owner)
    owner._AVPMusicPath = path
    sound.PlayFile("sound/" .. path, "noplay noblock", function(station, errCode, errStr)
        if !IsValid(owner) then
            if IsValid(station) then station:Stop() end
            return
        end
        if !IsValid(station) then
            print("[AVP UI] Error playing sound!", errCode, errStr)
            return
        end
        if owner._AVPMusicPath != path then
            station:Stop()
            return
        end
        station:EnableLooping(shouldLoop != false)
        station:SetVolume(volume or 0.3)
        station:SetPlaybackRate(1)
        station:Play()
        owner._AVPMusic = station
    end)
end

function Theme.StopMusic(owner)
    if !owner then return end
    owner._AVPMusicPath = nil
    if IsValid(owner._AVPMusic) then
        owner._AVPMusic:Stop()
    end
    owner._AVPMusic = nil
end
