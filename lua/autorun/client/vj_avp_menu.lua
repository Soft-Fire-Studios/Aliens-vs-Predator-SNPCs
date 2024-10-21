local menu = {}

local function ScreenPos(x,y)
    local w = ScrW()
    local h = ScrH()

    return w *0.5 +w *x *0.01,h *0.5 +w *y *0.01
end

local function ScreenScale(x,y)
    local w = ScrW()
    local h = ScrH()

    return (w *x *0.01), (w *y *0.01)
end

local function AddButton(parent,x,y,w,h,text,font,mat,onClick)
    local button = vgui.Create("DButton",parent)
    button:SetSize(w,h)
    button:SetPos(ScreenPos(x,y))
    button:SetText("")
    if mat then
        button.Paint = function(self,w,h)
            surface.SetMaterial(mat)
            surface.SetDrawColor(255,255,255,255)
            surface.DrawTexturedRect(0,0,w,h)
        end
    end
    button.DoClick = function(self)
        surface.PlaySound("cpthazama/avp/shared/menu/menu_2nd_accept.ogg")
        onClick()
    end
    button.DoRightClick = function(self)
        surface.PlaySound("cpthazama/avp/shared/menu/menu_2nd_cancel.ogg")
    end
    button.OnCursorEntered = function(self)
        surface.PlaySound("cpthazama/avp/shared/menu/menu_2nd_navigation.ogg")
    end
    return button
end

local function AddSlider(parent,x,y,w,h,text,font,min,max,decimals,onChange)
    local slider = vgui.Create("DNumSlider",parent)
    slider:SetSize(w,h)
    slider:SetPos(ScreenPos(x,y))
    slider:SetText(text)
    slider:SetMin(min)
    slider:SetMax(max)
    slider:SetDecimals(decimals)
    slider:SetValue(0)
    slider:SetDark(true)
    slider:SetFont(font)
    slider.Paint = function(self,w,h)
        surface.SetMaterial(bar)
        surface.SetDrawColor(255,255,255,255)
        surface.DrawTexturedRect(0,0,w,h)
    end
    slider.OnValueChanged = function(self,val)
        onChange(val)
    end
    return slider
end

local function AddPanel(parent,x,y,w,h,mat)
    local panel = vgui.Create("DPanel",parent)
    panel:SetSize(w,h)
    panel:SetPos(ScreenPos(x,y))
    if mat then
        panel.Paint = function(self,w,h)
            surface.SetMaterial(mat)
            surface.SetDrawColor(255,255,255,255)
            surface.DrawTexturedRect(0,0,w,h)
        end
    end
    return panel
end

local function AddImage(parent,x,y,w,h,mat)
    local image = vgui.Create("DImage",parent)
    image:SetSize(w,h)
    image:SetPos(ScreenPos(x,y))
    -- image:SetImage(mat)
    image.Paint = function(self,w,h)
        surface.SetMaterial(mat)
        surface.SetDrawColor(255,255,255,255)
        surface.DrawTexturedRect(0,0,w,h)
    end
    return image
end

local function AddCheckBox(parent,x,y,w,h,text,font,onChange)
    local checkbox = vgui.Create("DCheckBoxLabel",parent)
    checkbox:SetSize(w,h)
    checkbox:SetPos(ScreenPos(x,y))
    checkbox:SetText(text)
    checkbox:SetFont(font)
    checkbox:SetValue(0)
    checkbox.Paint = function(self,w,h)
        surface.SetMaterial(bar)
        surface.SetDrawColor(255,255,255,255)
        surface.DrawTexturedRect(0,0,w,h)
    end
    checkbox.OnChange = function(self,val)
        onChange(val)
    end
    return checkbox
end

function menu:SetMusic(snd)
    sound.PlayFile("sound/" .. snd,"noplay",function(station,errCode,errStr)
        if IsValid(station) then
            station:EnableLooping(true)
            station:Play()
            station:SetVolume(0.4)
            station:SetPlaybackRate(1)
            self.BGAudio = station
        else
            print("Error playing sound!",errCode,errStr)
        end
        return station
    end)
end

function menu:Close(ply)
    if !CLIENT then return end
    if !ply.VJ_AVP_MenuOpen then return end
    ply.VJ_AVP_MenuOpen = false
    if IsValid(self.BGAudio) && self.BGAudio:GetState() == 1 then
        self.BGAudio:Stop()
        self.BGAudio = nil
    end
    if self.Frame then
        self.Frame:Delete()
    end
end

local bgBG = Material("vgui/white", "smooth additive")
local bg_Empty = Material("vgui/avp/empty_fmv.png", "smooth additive")
local bg_Alien = Material("vgui/avp/bg_alien.png", "smooth additive")
local bg_Human = Material("vgui/avp/bg_human.png", "smooth additive")
local bg_Predator = Material("vgui/avp/bg_predator.png", "smooth additive")
local faction_Alien = Material("vgui/avp/faction_alien.png", "smooth additive")
local faction_Human = Material("vgui/avp/faction_marine.png", "smooth additive")
local faction_Predator = Material("vgui/avp/faction_predator.png", "smooth additive")
local bar = Material("vgui/avp/bar.png", "smooth additive") -- Background bar for text
local box1 = Material("vgui/avp/box1.png", "smooth additive")
local box2 = Material("vgui/avp/box2.png", "smooth additive")
local selectBar = Material("vgui/avp/select_bar.png", "smooth additive") -- When hovering over the bar, it will switch to this material
local smallSelectBar = Material("vgui/avp/small_select_bar.png", "smooth additive") -- or this one depending on the size

/*
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

    Old code for reference so we can convert it to the menu
*/

function menu:Open(ply)
    if ply.VJ_AVP_MenuOpen then
        self:Close(ply)
        return
    end
    ply.VJ_AVP_MenuOpen = true

    local scrW, scrH = ScrW(), ScrH()
    local frameBG = vgui.Create("DFrame")
    frameBG:ShowCloseButton(true)
    frameBG:SetTitle("")
    frameBG:SetSize(scrW, scrH)
    frameBG:Center()
    frameBG:SetDraggable(false)
    frameBG:MakePopup()
    frameBG:SetPopupStayAtBack(true)
    self.Frame = frameBG
    self.BackgroundID = math.random(1,3)
    self.NextBackgroundChangeT = CurTime() +math.Rand(6,12)
    -- self:SetMusic("cpthazama/avp/shared/menu/menu_background.mp3")

    frameBG.Paint = function(self,w,h)
        surface.SetMaterial(bgBG)
        surface.SetDrawColor(0,0,0,255)
        surface.DrawTexturedRect(0,0,w,h)
    end

    function frameBG:OnClose()
        ply.VJ_AVP_MenuOpen = false
        if IsValid(menu.BGAudio) && menu.BGAudio:GetState() == 1 then
            menu.BGAudio:Stop()
            menu.BGAudio = nil
        end
    end

    self.ContentPanel = vgui.Create("DPanel", frameBG)
    self.ContentPanel:Dock(FILL)
    self.ContentPanel.Paint = function(self,w,h)
        surface.SetMaterial(menu.BackgroundID == 1 && bg_Alien or menu.BackgroundID == 2 && bg_Predator or bg_Human)
        surface.SetDrawColor(255,255,255,255)
        surface.DrawTexturedRect(0,0,w,h)
    end
    self.ContentPanel.Think = function(self)
        if CurTime() > menu.NextBackgroundChangeT then
            menu.BackgroundID = menu.BackgroundID +1
            if menu.BackgroundID > 3 then
                menu.BackgroundID = 1
            end
            menu.NextBackgroundChangeT = CurTime() +math.Rand(6,12)
        end
    end
    
    local box_general = AddPanel(self.ContentPanel,-45,-25,scrW *0.4,scrH *0.4,box1)
    local box_alien = AddPanel(self.ContentPanel,5,-25,scrW *0.4,scrH *0.4,box1)
    local box_predator = AddPanel(self.ContentPanel,-45,2,scrW *0.4,scrH *0.4,box1)
    local box_human = AddPanel(self.ContentPanel,5,2,scrW *0.4,scrH *0.4,box1)
end

concommand.Add("vj.avp.menu",function(ply)
    menu:Open(ply)
end)