if !CLIENT then return end

if !AVP or !AVP.TDM then
    include("autorun/vj_avp_tdm_shared.lua")
end
if !AVP.UI or !AVP.UI.Theme then
    include("autorun/client/vj_avp_theme.lua")
end

AVP.TDM.UI = AVP.TDM.UI or {}
local UI = AVP.TDM.UI
UI.PendingLobbyStates = UI.PendingLobbyStates or {}
local TDM = AVP.TDM
local Theme = AVP.UI.Theme
local C = Theme.Colors

local materialCache = {}
local function Mat(path)
    if !path or path == "" then return nil end
    if !materialCache[path] then
        materialCache[path] = Material(path, "smooth")
    end
    return materialCache[path]
end

local function FormatTime(seconds)
    seconds = math.max(0, math.ceil(seconds or 0))
    return string.format("%02d:%02d", math.floor(seconds / 60), seconds % 60)
end

local function SendAction(ent, action, value, extra)
    if !IsValid(ent) then return end
    net.Start("VJ.AVP.TDM.Action")
        net.WriteEntity(ent)
        net.WriteString(action or "")
        net.WriteString(value or "")
        net.WriteString(extra or "")
    net.SendToServer()
end

local function FindLocalSlot(slots)
    local sid = IsValid(LocalPlayer()) && LocalPlayer():SteamID64() or ""
    for _, slot in ipairs(slots or {}) do
        if !slot.IsAI && slot.SteamID64 == sid then
            return slot
        end
    end
    return nil
end

local function OpenSteamProfile(steamID64)
    if !steamID64 or steamID64 == "" then return end

    for _, ply in ipairs(player.GetAll()) do
        if IsValid(ply) && ply:SteamID64() == steamID64 then
            if isfunction(ply.ShowProfile) then
                ply:ShowProfile()
                return
            end
            break
        end
    end

    gui.OpenURL("https://steamcommunity.com/profiles/" .. steamID64)
end

local function CreateAVPButton(parent, text, width, height, accent)
    local button = vgui.Create("DButton", parent)
    button:SetSize(width, height)
    button:SetText("")
    button._AVPText = text
    button._AVPAccent = accent or C.Yellow
    button.Paint = function(self, w, h)
        Theme.DrawButton(self, w, h, {accentColor = self._AVPAccent})
        local col = self:GetDisabled() && Color(145, 146, 137) or C.White
        draw.SimpleText(self._AVPText or "", "AVP.UI.BodyBold", Theme.S(14), h * 0.5, col, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end
    Theme.BindButtonSounds(button)
    return button
end

local function DrawFactionIcon(teamID, x, y, size, alpha, col)
    local team = TDM.TeamData[teamID]
    if !team then return end
    local mat = Mat(team.Icon)
    if !mat then return end
    surface.SetMaterial(mat)
    surface.SetDrawColor(col && col.r or 255, col && col.g or 255, col && col.b or 255, alpha or 255)
    surface.DrawTexturedRect(x, y, size, size)
end

local function DrawTeamHeader(teamID, x, y)
    local team = TDM.TeamData[teamID]
    if !team then return end
    DrawFactionIcon(teamID, x, y, Theme.S(26), 255, Theme.TeamColor(teamID))
    draw.SimpleText(string.upper(team.Name), "AVP.UI.Small", x + Theme.S(34), y + Theme.S(13), Theme.TeamColor(teamID), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
end

function UI.CloseLobby(sendLeave)
    local frame = UI.LobbyFrame
    if !IsValid(frame) then return end
    if sendLeave && IsValid(frame.TDMEntity) then
        SendAction(frame.TDMEntity, "leave")
    end
    frame._AVPClosing = true
    Theme.StopMusic(frame)
    frame:Remove()
    UI.LobbyFrame = nil
end

function UI.OpenSkinPicker(frame)
    if !IsValid(frame) then return end
    local slot = FindLocalSlot(frame.Slots)
    if !slot then return end
    local skins = TDM.Skins[slot.Team] or {}

    if IsValid(frame.Modal) then frame.Modal:Remove() end
    local modal = vgui.Create("DPanel", frame)
    modal:SetPos(0, 0)
    modal:SetSize(frame:GetWide(), frame:GetTall())
    modal:SetZPos(500)
    modal:SetMouseInputEnabled(true)
    frame.Modal = modal
    modal.Paint = function(_, w, h)
        surface.SetDrawColor(0, 0, 0, 205)
        surface.DrawRect(0, 0, w, h)
        local pw, ph = Theme.S(1120), Theme.S(720)
        local px, py = (w - pw) * 0.5, (h - ph) * 0.5
        surface.SetDrawColor(12, 15, 14, 248)
        surface.DrawRect(px, py, pw, ph)
        surface.SetDrawColor(C.Yellow.r, C.Yellow.g, C.Yellow.b, 170)
        surface.DrawOutlinedRect(px, py, pw, ph, 1)
        draw.SimpleText("SELECT SKIN", "AVP.UI.Title", px + Theme.S(26), py + Theme.S(22), C.Yellow, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        DrawTeamHeader(slot.Team, px + Theme.S(26), py + Theme.S(65))
    end

    local pw, ph = Theme.S(1120), Theme.S(720)
    local px, py = (frame:GetWide() - pw) * 0.5, (frame:GetTall() - ph) * 0.5
    local scroll = vgui.Create("DScrollPanel", modal)
    scroll:SetPos(px + Theme.S(24), py + Theme.S(108))
    scroll:SetSize(pw - Theme.S(48), ph - Theme.S(174))
    Theme.StyleScrollPanel(scroll)

    local layout = vgui.Create("DIconLayout", scroll)
    layout:Dock(FILL)
    layout:SetSpaceX(Theme.S(12))
    layout:SetSpaceY(Theme.S(12))

    local cardW, cardH = Theme.S(250), Theme.S(190)
    for _, skin in ipairs(skins) do
        local data = skin
        local card = layout:Add("DButton")
        card:SetSize(cardW, cardH)
        card:SetText("")
        card.Paint = function(self, w, h)
            local hover = Theme.LerpHover(self, 12)
            local selected = data.ID == slot.Skin
            surface.SetDrawColor(13, 16, 15, 242)
            surface.DrawRect(0, 0, w, h)

            local skinMat = Mat(data.Material)
            if skinMat then
                surface.SetMaterial(skinMat)
                surface.SetDrawColor(255, 255, 255, 245)
                surface.DrawTexturedRect(Theme.S(4), Theme.S(4), w - Theme.S(8), h - Theme.S(38))
            end

            local border = selected && C.Yellow or C.BorderBright
            surface.SetDrawColor(border.r, border.g, border.b, math.floor((selected && 220 or 85) + hover * 80))
            surface.DrawOutlinedRect(0, 0, w, h, selected && Theme.S(2) or 1)
            if selected then
                surface.SetDrawColor(C.Yellow.r, C.Yellow.g, C.Yellow.b, 170)
                surface.DrawRect(0, h - Theme.S(3), w, Theme.S(3))
            end
            draw.SimpleText(string.upper(data.Name), "AVP.UI.Small", Theme.S(10), h - Theme.S(20), C.White, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        end
        Theme.BindButtonSounds(card)
        card.DoClick = function()
            Theme.PlayUISound("Accept")
            cookie.Set("vj_avp_tdm_skin_" .. slot.Team, data.ID)
            SendAction(frame.TDMEntity, "skin", data.ID)
            modal:Remove()
            frame.Modal = nil
        end
    end

    local close = CreateAVPButton(modal, "BACK", Theme.S(170), Theme.S(42), C.Red)
    close:SetPos(px + Theme.S(24), py + ph - Theme.S(56))
    close.DoClick = function()
        Theme.PlayUISound("Cancel")
        modal:Remove()
        frame.Modal = nil
    end
end

function UI.OpenFactionPicker(frame)
    if !IsValid(frame) then return end
    local slot = FindLocalSlot(frame.Slots)
    if !slot then return end

    if IsValid(frame.Modal) then frame.Modal:Remove() end
    local modal = vgui.Create("DPanel", frame)
    modal:SetPos(0, 0)
    modal:SetSize(frame:GetWide(), frame:GetTall())
    modal:SetZPos(500)
    modal:SetMouseInputEnabled(true)
    frame.Modal = modal
    modal.Paint = function(_, w, h)
        surface.SetDrawColor(0, 0, 0, 210)
        surface.DrawRect(0, 0, w, h)
        local pw, ph = Theme.S(1180), Theme.S(500)
        local px, py = (w - pw) * 0.5, (h - ph) * 0.5
        surface.SetDrawColor(12, 15, 14, 248)
        surface.DrawRect(px, py, pw, ph)
        surface.SetDrawColor(C.Yellow.r, C.Yellow.g, C.Yellow.b, 170)
        surface.DrawOutlinedRect(px, py, pw, ph, 1)
        draw.SimpleText("CHANGE FACTION", "AVP.UI.Title", px + Theme.S(26), py + Theme.S(22), C.Yellow, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        draw.SimpleText("Teams are capped at six combatants. Empty slots are filled by AI.", "AVP.UI.Small", px + Theme.S(26), py + Theme.S(57), C.Muted, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    end

    local pw, ph = Theme.S(1180), Theme.S(500)
    local px, py = (frame:GetWide() - pw) * 0.5, (frame:GetTall() - ph) * 0.5
    local cardW, cardH = Theme.S(350), Theme.S(300)
    local gap = Theme.S(30)
    local startX = px + (pw - (cardW * 3 + gap * 2)) * 0.5
    local cardY = py + Theme.S(95)

    for i, teamID in ipairs(TDM.TeamOrder) do
        local id = teamID
        local team = TDM.TeamData[id]
        local card = vgui.Create("DButton", modal)
        card:SetPos(startX + (i - 1) * (cardW + gap), cardY)
        card:SetSize(cardW, cardH)
        card:SetText("")
        card.Paint = function(self, w, h)
            local hover = Theme.LerpHover(self, 12)
            local bg = Mat(team.Background)
            if bg then
                surface.SetMaterial(bg)
                surface.SetDrawColor(255, 255, 255, math.floor(180 + hover * 65))
                surface.DrawTexturedRect(0, 0, w, h)
            else
                surface.SetDrawColor(20, 23, 21, 245)
                surface.DrawRect(0, 0, w, h)
            end
            surface.SetDrawColor(0, 0, 0, 105)
            surface.DrawRect(0, 0, w, h)
            DrawFactionIcon(id, Theme.S(29), Theme.S(8), Theme.S(34), 255, Theme.TeamColor(id))
            draw.SimpleText(string.upper(team.Name), "AVP.UI.Heading", Theme.S(104), h - Theme.S(30), Theme.TeamColor(id), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
            surface.SetDrawColor(C.Yellow.r, C.Yellow.g, C.Yellow.b, slot.Team == id && 230 or math.floor(80 + hover * 100))
            surface.DrawOutlinedRect(0, 0, w, h, slot.Team == id && Theme.S(2) or 1)
        end
        Theme.BindButtonSounds(card)
        card.DoClick = function()
            Theme.PlayUISound("Accept")
            if id != slot.Team then
                local saved = cookie.GetString("vj_avp_tdm_skin_" .. id, "")
                SendAction(frame.TDMEntity, "faction", id, saved)
            end
            modal:Remove()
            frame.Modal = nil
        end
    end

    local close = CreateAVPButton(modal, "BACK", Theme.S(170), Theme.S(42), C.Red)
    close:SetPos(px + Theme.S(24), py + ph - Theme.S(56))
    close.DoClick = function()
        Theme.PlayUISound("Cancel")
        modal:Remove()
        frame.Modal = nil
    end
end

function UI.UpdateLobby(frame)
    if !IsValid(frame) then return end
    local localSlot = FindLocalSlot(frame.Slots)
    frame.LocalSlot = localSlot

    local readyLocked = IsValid(frame.TDMEntity) && frame.TDMEntity:GetLobbyReadyLocked()
    if IsValid(frame.SkinButton) then frame.SkinButton:SetDisabled(!localSlot) end
    if IsValid(frame.FactionButton) then frame.FactionButton:SetDisabled(!localSlot) end
    if IsValid(frame.ReadyButton) then
        frame.ReadyButton:SetDisabled(!localSlot or readyLocked)
        if !localSlot then
            frame.ReadyButton._AVPText = "LOBBY FULL"
            frame.ReadyButton._AVPAccent = C.Red
        elseif readyLocked then
            frame.ReadyButton._AVPText = "READY - LOCKED"
            frame.ReadyButton._AVPAccent = C.Green
        else
            frame.ReadyButton._AVPText = localSlot.Ready && "READY" or "READY TO PLAY"
            frame.ReadyButton._AVPAccent = localSlot.Ready && C.Green or C.Yellow
        end
    end

    if IsValid(frame.Roster) then
        frame.Roster:Clear()
        for index, slot in ipairs(frame.Slots or {}) do
            local rowData = slot
            local rowIndex = index
            local row = vgui.Create(rowData.IsAI && "DPanel" or "DButton", frame.Roster)
            row:Dock(TOP)
            row:SetTall(Theme.S(24))
            row:DockMargin(0, 0, 0, Theme.S(1))

            if !rowData.IsAI then
                row:SetText("")
                row:SetCursor("hand")
                row.OnCursorEntered = function()
                    Theme.PlayUISound("Navigate")
                end
                row.DoClick = function()
                    Theme.PlayUISound("Accept")
                    OpenSteamProfile(rowData.SteamID64)
                end
            end

            row.Paint = function(self, w, h)
                local localRow = !rowData.IsAI && IsValid(LocalPlayer()) && rowData.SteamID64 == LocalPlayer():SteamID64()
                local hover = !rowData.IsAI && Theme.LerpHover(self, 14) or 0

                if localRow then
                    surface.SetDrawColor(C.Yellow.r, C.Yellow.g, C.Yellow.b, math.floor(40 + hover * 22))
                elseif hover > 0.01 then
                    surface.SetDrawColor(C.Yellow.r, C.Yellow.g, C.Yellow.b, math.floor(10 + hover * 24))
                elseif rowIndex % 2 == 0 then
                    surface.SetDrawColor(255, 255, 255, 8)
                else
                    surface.SetDrawColor(0, 0, 0, 18)
                end
                surface.DrawRect(0, 0, w, h)

                local readyX = Theme.S(18)
                if rowData.Ready then
                    draw.SimpleText("✓", "AVP.UI.BodyBold", readyX, h * 0.5, C.White, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                else
                    draw.SimpleText("•", "AVP.UI.BodyBold", readyX, h * 0.5, C.Red, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                end

                DrawFactionIcon(rowData.Team, Theme.S(48), (h - Theme.S(20)) * 0.5, Theme.S(20), rowData.IsAI && 165 or 255, Theme.TeamColor(rowData.Team))

                local nameColor = rowData.IsAI && C.Muted or (hover > 0.05 && C.Yellow or C.White)
                draw.SimpleText(rowData.Name or "Unknown", "AVP.UI.Small", Theme.S(82), h * 0.5, nameColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                draw.SimpleText(rowData.IsAI && "AI" or "PLAYER", "AVP.UI.Tiny", w - Theme.S(14), h * 0.5, rowData.IsAI && C.Muted or C.Yellow, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
            end
        end
    end

    if localSlot then
        local saved = cookie.GetString("vj_avp_tdm_skin_" .. localSlot.Team, "")
        if saved != "" && saved != localSlot.Skin && TDM.GetSkin(localSlot.Team, saved) && frame._LastSavedSkinTeam != localSlot.Team then
            frame._LastSavedSkinTeam = localSlot.Team
            SendAction(frame.TDMEntity, "skin", saved)
        end
    end
end

function UI.OpenLobby(ent)
    if !IsValid(ent) then return end
    if IsValid(UI.ResultsFrame) then
        UI.ResultsFrame:Remove()
        UI.ResultsFrame = nil
    end
    if IsValid(UI.LobbyFrame) then
        if UI.LobbyFrame.TDMEntity == ent then return end
        UI.CloseLobby(false)
    end

    local frame = vgui.Create("DFrame")
    frame:SetSize(ScrW(), ScrH())
    frame:SetPos(0, 0)
    frame:SetTitle("")
    frame:ShowCloseButton(false)
    frame:SetDraggable(false)
    frame:MakePopup()
    frame.TDMEntity = ent
    frame.Slots = UI.PendingLobbyStates[ent] or {}
    UI.PendingLobbyStates[ent] = nil
    frame:SetKeyboardInputEnabled(true)
    UI.LobbyFrame = frame

    Theme.PlayMusic(frame, TDM.MenuTrack, 0.3, true)

    frame.Paint = function(self, w, h)
        Theme.DrawFlickerBackground(self, w, h)

        local padX = Theme.S(58)
        local topY = Theme.S(35)
        draw.SimpleText("Player Match Lobby", "AVP.UI.Title", padX, topY, C.Yellow, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        draw.SimpleText("Species Team Deathmatch", "AVP.UI.Heading", padX, topY + Theme.S(36), C.White, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        draw.SimpleText(game.GetMap(), "AVP.UI.Heading", padX, topY + Theme.S(62), C.White, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

        local remaining = IsValid(self.TDMEntity) && (self.TDMEntity:GetLobbyEndTime() - CurTime()) or 0
        draw.SimpleText("MATCH STARTS IN  " .. FormatTime(remaining), "AVP.UI.BodyBold", w - padX, topY + Theme.S(7), C.Yellow, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)

        if !self.LocalSlot then
            local status = IsValid(self.TDMEntity) && self.TDMEntity:GetLobbyReadyLocked() && "MATCH STARTING - SPECTATOR" or "18/18 SLOTS FILLED - SPECTATOR"
            draw.SimpleText(status, "AVP.UI.Small", w - padX, topY + Theme.S(40), C.Red, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
        end
    end

    frame.OnKeyCodePressed = function(_, key)
        if key == KEY_BACKSPACE then
            UI.CloseLobby(true)
        end
    end
    frame.Think = function(self)
        if !IsValid(self.TDMEntity) then
            UI.CloseLobby(false)
            return
        end

        local locked = self.TDMEntity:GetLobbyReadyLocked()
        if self._LastReadyLocked != locked then
            self._LastReadyLocked = locked
            UI.UpdateLobby(self)
        end
    end

    local previewX, previewY = Theme.S(58), Theme.S(225)
    local previewW, previewH = Theme.S(780), Theme.S(610)
    local preview = vgui.Create("DPanel", frame)
    preview:SetPos(previewX, previewY)
    preview:SetSize(previewW, previewH)
    preview.Paint = function(self, w, h)
        local slot = frame.LocalSlot
        local teamID = slot && slot.Team or "marine"
        local team = TDM.TeamData[teamID]
        local bg = team && Mat(team.Background)
        if bg then
            surface.SetMaterial(bg)
            surface.SetDrawColor(255, 255, 255, 205)
            surface.DrawTexturedRect(0, 0, w, h)
        else
            surface.SetDrawColor(18, 21, 19, 240)
            surface.DrawRect(0, 0, w, h)
        end
        surface.SetDrawColor(0, 0, 0, 80)
        surface.DrawRect(0, 0, w, h)

        local skin = slot && TDM.GetSkin(teamID, slot.Skin) or TDM.GetDefaultSkin(teamID)
        if skin then
            local skinMat = Mat(skin.Material)
            if skinMat then
                local imageW = w * 0.96
                local imageH = h * 0.98
                surface.SetMaterial(skinMat)
                surface.SetDrawColor(255, 255, 255, 255)
                surface.DrawTexturedRect((w - imageW) * 0.5, (h - imageH) * 0.5, imageW, imageH)
            end
        end

        surface.SetDrawColor(12, 15, 13, 190)
        surface.DrawRect(0, h - Theme.S(82), w, Theme.S(82))
        surface.SetMaterial(Theme.Materials.SelectBar)
        surface.SetDrawColor(59, 59, 59, 150)
        surface.DrawTexturedRect(0, 0, w, h)

        local iconX = Theme.S(50)
        for i, id in ipairs(TDM.TeamOrder) do
            DrawFactionIcon(id, iconX + (i - 1) * Theme.S(50), Theme.S(14), Theme.S(34), id == teamID && 255 or 70, id == teamID && Theme.TeamColor(teamID) or C.Muted)
        end

        if slot then
            draw.SimpleText("You are a " .. (team && team.Singular or "Combatant"), "AVP.UI.BodyBold", Theme.S(22), h - Theme.S(55), C.White, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
            draw.SimpleText(skin && skin.Name or "Default", "AVP.UI.Heading", Theme.S(22), h - Theme.S(36), Theme.TeamColor(teamID), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        else
            draw.SimpleText("Spectator", "AVP.UI.BodyBold", Theme.S(22), h - Theme.S(55), C.White, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
            draw.SimpleText("The lobby is full.", "AVP.UI.Small", Theme.S(22), h - Theme.S(28), C.Muted, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        end
    end

    local rosterX = previewX + previewW + Theme.S(30)
    local rosterY = previewY
    local rosterW = ScrW() - rosterX - Theme.S(58)
    local rosterH = previewH
    local rosterBack = vgui.Create("DPanel", frame)
    rosterBack:SetPos(rosterX, rosterY)
    rosterBack:SetSize(rosterW, rosterH)

    local rosterInsetX = math.max(Theme.S(24), math.floor(rosterW * 0.028))
    local rosterTop = Theme.S(60)
    local rosterBottom = Theme.S(30)

    rosterBack.Paint = function(_, w, h)
        Theme.DrawGlassPanel(w, h, {accent = false, alpha = 205})
        surface.SetDrawColor(C.Yellow.r, C.Yellow.g, C.Yellow.b, 115)
        surface.DrawRect(0, 0, w, Theme.S(3))

        draw.SimpleText("PLAYERS", "AVP.UI.Heading", rosterInsetX + Theme.S(130), Theme.S(29), C.Yellow, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end

    local roster = vgui.Create("DScrollPanel", rosterBack)
    roster:SetPos(rosterInsetX, rosterTop)
    roster:SetSize(rosterW - rosterInsetX * 2, rosterH - rosterTop - rosterBottom)
    Theme.StyleScrollPanel(roster)
    frame.Roster = roster

    local bottomY = previewY + previewH + Theme.S(24)
    local buttonH = Theme.S(54)
    local leave = CreateAVPButton(frame, "LEAVE LOBBY", Theme.S(220), buttonH, C.Red)
    leave:SetPos(previewX, bottomY)
    leave.DoClick = function()
        Theme.PlayUISound("Cancel")
        UI.CloseLobby(true)
    end

    local skinButton = CreateAVPButton(frame, "CHANGE SKIN", Theme.S(220), buttonH, C.Yellow)
    skinButton:SetPos(previewX + Theme.S(236), bottomY)
    skinButton.DoClick = function()
        if skinButton:GetDisabled() then return end
        Theme.PlayUISound("Accept")
        UI.OpenSkinPicker(frame)
    end
    frame.SkinButton = skinButton

    local factionButton = CreateAVPButton(frame, "CHANGE FACTION", Theme.S(235), buttonH, C.Yellow)
    factionButton:SetPos(previewX + Theme.S(472), bottomY)
    factionButton.DoClick = function()
        if factionButton:GetDisabled() then return end
        Theme.PlayUISound("Accept")
        UI.OpenFactionPicker(frame)
    end
    frame.FactionButton = factionButton

    local ready = CreateAVPButton(frame, "READY TO PLAY", Theme.S(280), buttonH, C.Yellow)
    ready:SetPos(ScrW() - Theme.S(58) - Theme.S(280), bottomY)
    ready.DoClick = function()
        if ready:GetDisabled() then return end
        Theme.PlayUISound("Accept")
        SendAction(frame.TDMEntity, "ready")
    end
    frame.ReadyButton = ready

    UI.UpdateLobby(frame)
end

function UI.OpenResults(results)
    if IsValid(UI.ResultsFrame) then UI.ResultsFrame:Remove() end

    surface.PlaySound("cpthazama/avp/shared/grapple/grapple_sting_04.ogg")
    local frame = vgui.Create("DFrame")
    frame:SetSize(ScrW(), ScrH())
    frame:SetPos(0, 0)
    frame:SetTitle("")
    frame:ShowCloseButton(false)
    frame:SetDraggable(false)
    frame:MakePopup()
    UI.ResultsFrame = frame

    frame.Paint = function(self, w, h)
        Theme.DrawFlickerBackground(self, w, h)
        draw.SimpleText("MATCH RESULTS", "AVP.UI.Hero", Theme.S(62), Theme.S(42), C.Yellow, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        draw.SimpleText("Species Team Deathmatch", "AVP.UI.Heading", Theme.S(62), Theme.S(82), C.White, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        draw.SimpleText(game.GetMap(), "AVP.UI.Small", Theme.S(62), Theme.S(112), C.Muted, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

        local winnerTeam = results.WinnerTeam or ""
        local winnerColor = winnerTeam != "" && Theme.TeamColor(winnerTeam) or C.White
        draw.SimpleText("WINNER", "AVP.UI.Small", w - Theme.S(62), Theme.S(47), C.Muted, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
        draw.SimpleText(string.upper(results.Winner or "Draw"), "AVP.UI.Title", w - Theme.S(62), Theme.S(70), winnerColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
    end

    local scores = results.Scores or {}
    local scoreY = Theme.S(155)
    local scoreW, scoreH = Theme.S(300), Theme.S(100)
    local scoreGap = Theme.S(24)
    local scoreStart = (ScrW() - (scoreW * 3 + scoreGap * 2)) * 0.5
    for i, teamID in ipairs(TDM.TeamOrder) do
        local team = TDM.TeamData[teamID]
        local panel = vgui.Create("DPanel", frame)
        panel:SetPos(scoreStart + (i - 1) * (scoreW + scoreGap), scoreY)
        panel:SetSize(scoreW, scoreH)
        panel.Paint = function(_, w, h)
            Theme.DrawGlassPanel(w, h, {accentColor = Theme.TeamColor(teamID), alpha = 225})
            DrawFactionIcon(teamID, Theme.S(14), Theme.S(15), Theme.S(38), 255, Theme.TeamColor(teamID))
            draw.SimpleText(string.upper(team.Name), "AVP.UI.Small", Theme.S(62), Theme.S(20), Theme.TeamColor(teamID), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
            draw.SimpleText(tostring(scores[teamID] or 0), "AVP.UI.Title", w - Theme.S(18), h * 0.5, C.White, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        end
    end

    local tableX, tableY = Theme.S(110), Theme.S(290)
    local tableW, tableH = ScrW() - Theme.S(220), ScrH() - Theme.S(420)
    local back = vgui.Create("DPanel", frame)
    back:SetPos(tableX, tableY)
    back:SetSize(tableW, tableH)

    local resultInsetX = math.max(Theme.S(28), math.floor(tableW * 0.028))
    local resultTop = Theme.S(62)
    local resultBottom = Theme.S(30)
    local resultHeaderY = Theme.S(52)
    back.Paint = function(_, w, h)
        Theme.DrawGlassPanel(w, h, {accent = false, alpha = 220})
        draw.SimpleText("KILLS", "AVP.UI.Small", w - resultInsetX - Theme.S(182), resultHeaderY, C.Yellow, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        draw.SimpleText("DEATHS", "AVP.UI.Small", w - resultInsetX - Theme.S(62), resultHeaderY, C.Yellow, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
    end

    local scroll = vgui.Create("DScrollPanel", back)
    scroll:SetPos(resultInsetX, resultTop)
    scroll:SetSize(tableW - resultInsetX * 2, tableH - resultTop - resultBottom)
    Theme.StyleScrollPanel(scroll)

    for index, rowData in ipairs(results.Rows or {}) do
        local row = vgui.Create("DPanel", scroll)
        row:Dock(TOP)
        row:SetTall(Theme.S(32))
        row:DockMargin(0, 0, 0, Theme.S(1))
        row.Paint = function(_, w, h)
            surface.SetDrawColor(index % 2 == 0 && Color(255, 255, 255, 9) or Color(0, 0, 0, 18))
            surface.DrawRect(0, 0, w, h)
            DrawFactionIcon(rowData.Team, Theme.S(18), Theme.S(6), Theme.S(20), 230, Theme.TeamColor(rowData.Team))
            draw.SimpleText(string.upper((TDM.TeamData[rowData.Team] && TDM.TeamData[rowData.Team].Singular) or rowData.Team or ""), "AVP.UI.Tiny", Theme.S(48), h * 0.5, Theme.TeamColor(rowData.Team), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            draw.SimpleText((rowData.Name or "Unknown") .. (rowData.IsAI && "  [AI]" or ""), "AVP.UI.Small", Theme.S(142), h * 0.5, rowData.IsAI && C.Muted or C.White, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            draw.SimpleText(tostring(rowData.Kills or 0), "AVP.UI.Small", w - Theme.S(182), h * 0.5, C.White, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
            draw.SimpleText(tostring(rowData.Deaths or 0), "AVP.UI.Small", w - Theme.S(62), h * 0.5, C.White, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        end
    end

    local close = CreateAVPButton(frame, "CLOSE", Theme.S(240), Theme.S(54), C.Yellow)
    close:SetPos(ScrW() - Theme.S(110) - Theme.S(240), ScrH() - Theme.S(96))
    close.DoClick = function()
        Theme.PlayUISound("Accept")
        frame:Remove()
        UI.ResultsFrame = nil
    end
    frame.OnKeyCodePressed = function(_, key)
        if key == KEY_BACKSPACE then close:DoClick() end
    end
end

local spectatorProxy = spectatorProxy or {}
local spectatorProxyCamera = nil
local spectatorLastTarget = nil
local spectatorViewPos = nil
local spectatorViewAng = nil
local spectatorController = nil
local spectatorControllerNPC = nil
local spectatorControllerCheckT = 0

local function IsTDMSpectating(ply)
    return IsValid(ply)
        && ply:GetNW2Bool("AVP_TDM_Participant", false)
        && ply:GetNW2Float("AVP_TDM_RespawnAt", 0) > CurTime()
        && IsValid(ply:GetNW2Entity("AVP_TDM_SpectateTarget"))
end

local function FindLiveControllerForNPC(npc)
    if spectatorControllerNPC == npc && IsValid(spectatorController) && spectatorController:GetNPC() == npc then
        return spectatorController
    end
    if CurTime() < spectatorControllerCheckT && spectatorControllerNPC == npc then
        return nil
    end

    spectatorControllerCheckT = CurTime() + 0.15
    spectatorController = nil
    spectatorControllerNPC = npc
    for _, controller in ipairs(ents.FindByClass("obj_vj_controller")) do
        if IsValid(controller) && controller:GetNPC() == npc then
            spectatorController = controller
            return controller
        end
    end
    return nil
end

local function GetNPCAimAngles(npc)
    if npc.GetAimVector then
        local aim = npc:GetAimVector()
        if aim && aim:LengthSqr() > 0.001 then
            return aim:Angle()
        end
    end
    local ang = npc:GetAngles()
    return Angle(ang.p, ang.y, 0)
end

local function ConfigureSpectatorProxy(npc, ply)
    local params = npc.ControllerParams or {}
    local mode = params.CameraMode or 1
    local third = params.ThirdP_Offset or vector_origin
    local first = params.FirstP_Offset or Vector(0, 0, 5)
    local bone = npc:LookupBone(params.FirstP_Bone or "ValveBiped.Bip01_Head1") or -1

    spectatorProxyCamera = npc
    spectatorProxy.VJC_Camera_Zoom = spectatorProxy.VJC_Camera_Zoom or 100
    spectatorProxy.GetCamera = function() return spectatorProxyCamera end
    spectatorProxy.GetNPC = function() return npc end
    spectatorProxy.GetPlayer = function() return ply end
    spectatorProxy.GetCameraMode = function() return mode end
    spectatorProxy.GetCameraTP_Offset = function() return third end
    spectatorProxy.GetCameraFP_Offset = function() return first end
    spectatorProxy.GetCameraFP_Bone = function() return bone end
    spectatorProxy.GetCameraFP_ShrinkBone = function() return params.FirstP_ShrinkBone == true end
    spectatorProxy.GetCameraFP_BoneAng = function() return params.FirstP_CameraBoneAng or 0 end
    spectatorProxy.GetCameraFP_BoneAngOffset = function() return params.FirstP_CameraBoneAng_Offset or 0 end
    return spectatorProxy, mode
end

local function RunNPCControllerCalcView(npc, spectator, origin, fov)
    local liveController = FindLiveControllerForNPC(npc)
    local controller, sourcePly, angles, cameraMode, camera

    if IsValid(liveController) then
        controller = liveController
        sourcePly = liveController:GetPlayer()
        if !IsValid(sourcePly) then sourcePly = spectator end
        -- angles = GetNPCAimAngles(npc)
        angles = IsValid(sourcePly) && sourcePly:EyeAngles() or GetNPCAimAngles(npc)
        cameraMode = liveController:GetCameraMode()
        camera = liveController:GetCamera()
    else
        controller, cameraMode = ConfigureSpectatorProxy(npc, spectator)
        sourcePly = spectator
        angles = GetNPCAimAngles(npc)
        camera = controller:GetCamera()
    end

    local baseOrigin = IsValid(liveController) && IsValid(sourcePly) && sourcePly:EyePos() or npc:EyePos()
    local customData = npc.Controller_OnCalcView && npc:Controller_OnCalcView(controller, sourcePly, baseOrigin, angles, fov) or false

    if npc.Controller_CalcView then
        local oldCamera = sourcePly.VJCE_Camera
        local oldNPC = sourcePly.VJCE_NPC
        local oldMode = sourcePly.VJC_Camera_Mode
        local oldTP = sourcePly.VJC_TP_Offset
        local oldFP = sourcePly.VJC_FP_Offset
        local oldBone = sourcePly.VJC_FP_Bone
        local oldShrink = sourcePly.VJC_FP_ShrinkBone
        local oldBoneAng = sourcePly.VJC_FP_CameraBoneAng
        local oldBoneAngOff = sourcePly.VJC_FP_CameraBoneAng_Offset

        sourcePly.VJCE_Camera = camera
        if IsValid(camera) then camera.Zoom = controller.VJC_Camera_Zoom or 100 end
        sourcePly.VJCE_NPC = npc
        sourcePly.VJC_Camera_Mode = cameraMode
        sourcePly.VJC_TP_Offset = controller:GetCameraTP_Offset()
        sourcePly.VJC_FP_Offset = controller:GetCameraFP_Offset()
        sourcePly.VJC_FP_Bone = controller:GetCameraFP_Bone()
        sourcePly.VJC_FP_ShrinkBone = controller:GetCameraFP_ShrinkBone()
        sourcePly.VJC_FP_CameraBoneAng = controller:GetCameraFP_BoneAng()
        sourcePly.VJC_FP_CameraBoneAng_Offset = controller:GetCameraFP_BoneAngOffset()

        local oldData = npc:Controller_CalcView(sourcePly, baseOrigin, angles, fov, camera, cameraMode)
        if oldData then customData = oldData end

        sourcePly.VJCE_Camera = oldCamera
        sourcePly.VJCE_NPC = oldNPC
        sourcePly.VJC_Camera_Mode = oldMode
        sourcePly.VJC_TP_Offset = oldTP
        sourcePly.VJC_FP_Offset = oldFP
        sourcePly.VJC_FP_Bone = oldBone
        sourcePly.VJC_FP_ShrinkBone = oldShrink
        sourcePly.VJC_FP_CameraBoneAng = oldBoneAng
        sourcePly.VJC_FP_CameraBoneAng_Offset = oldBoneAngOff
    end

    local pos = baseOrigin
    local ang = angles
    local outFOV = fov
    local lerpSpeed = spectator:GetInfoNum("vj_npc_cont_cam_speed", 6)

    if customData then
        if istable(customData) then
            pos = customData.origin or baseOrigin
            ang = customData.angles or angles
            outFOV = customData.fov or fov
            lerpSpeed = customData.speed or lerpSpeed
        end
    elseif cameraMode == 2 then
        local setPos = npc:EyePos() + npc:GetForward() * 20
        local offset = controller:GetCameraFP_Offset()
        local bone = controller:GetCameraFP_Bone()
        if bone != -1 then
            local bonePos, boneAng = npc:GetBonePosition(bone)
            if bonePos then setPos = bonePos end
            if boneAng && controller:GetCameraFP_BoneAng() > 0 then
                ang = Angle(ang.p, ang.y, ang.r)
                ang[3] = boneAng[controller:GetCameraFP_BoneAng()] + controller:GetCameraFP_BoneAngOffset()
            end
        end
        pos = setPos + npc:GetForward() * offset.x + npc:GetRight() * offset.y + npc:GetUp() * offset.z
        lerpSpeed = 0
    else
        local offset = controller:GetCameraTP_Offset() + Vector(0, 0, npc:OBBMaxs().z - npc:OBBMins().z)
        local zoom = controller.VJC_Camera_Zoom or 100
        local center = npc:GetPos() + npc:OBBCenter()
        local tr = util.TraceHull({
            start = center,
            endpos = center + angles:Forward() * -zoom + npc:GetForward() * offset.x + npc:GetRight() * offset.y + npc:GetUp() * offset.z,
            filter = {spectator, camera, npc},
            mins = Vector(-5, -5, -5),
            maxs = Vector(5, 5, 5),
            mask = MASK_BLOCKLOS,
        })
        pos = tr.HitPos + tr.HitNormal * 2
    end

    if spectatorLastTarget != npc then
        spectatorLastTarget = npc
        spectatorViewPos = pos
        spectatorViewAng = ang
    end

    local npcAim = GetNPCAimAngles(npc)
    -- if npc.VJ_AVP_Marine then
    --     npcAim = npcAim +Angle(npc:GetPoseParameter("pp_thw_pitch"), npc:GetPoseParameter("pp_thw_yaw"), 0)
    -- else
    --     npcAim = npcAim +Angle(npc:GetPoseParameter("aim_pitch"), npc:GetPoseParameter("aim_yaw"), 0)
    -- end
    if lerpSpeed == 0 then
        spectatorViewPos = pos
        spectatorViewAng = ang
    else
        spectatorViewPos = LerpVector(FrameTime() * lerpSpeed, spectatorViewPos or pos, pos)
        spectatorViewAng = LerpAngle(FrameTime() * lerpSpeed, spectatorViewAng or ang, npcAim)
    end

    return {
        origin = spectatorViewPos,
        angles = spectatorViewAng,
        fov = outFOV,
        drawviewer = false,
    }
end

hook.Add("CalcView", "VJ.AVP.TDM.RespawnSpectateView", function(ply, origin, angles, fov)
    if !IsTDMSpectating(ply) then
        spectatorLastTarget = nil
        spectatorViewPos = nil
        spectatorViewAng = nil
        return
    end

    local target = ply:GetNW2Entity("AVP_TDM_SpectateTarget")
    if !IsValid(target) then return end
    return RunNPCControllerCalcView(target, ply, origin, fov)
end)

hook.Add("PreDrawViewModel", "VJ.AVP.TDM.HideRespawnViewModel", function(vm, ply)
    if ply == LocalPlayer() && IsTDMSpectating(ply) then return true end
end)

hook.Add("ShouldDrawLocalPlayer", "VJ.AVP.TDM.HideRespawnPlayer", function(ply)
    if ply == LocalPlayer() && IsTDMSpectating(ply) then return false end
end)

local matTDMHUDBlock = Material("hud/cpthazama/avp/avp_m_hud_block.png", "smooth additive")
local matTDMHUDBlockShort = Material("hud/cpthazama/avp/avp_m_hud_block_short.png", "smooth additive")
local colTDMHUDDistort = Color(170, 238, 255)

local function DrawTDMHUDBlock(mat, x, y, w, h, col, alpha)
    if !mat then return end
    col = col or C.White
    alpha = alpha or 210

    local distortionAmount = math.random(1, 600) == 1 && Theme.S(2.2) or Theme.S(0.22)
    local distortion = math.abs(math.sin(CurTime() * 2) * 35)
    surface.SetMaterial(mat)
    surface.SetDrawColor(
        colTDMHUDDistort.r,
        colTDMHUDDistort.g,
        colTDMHUDDistort.b,
        math.Clamp(alpha + math.Rand(-distortion, distortion), 0, 255)
    )
    surface.DrawTexturedRect(
        x + math.Rand(-distortionAmount, distortionAmount),
        y + math.Rand(-distortionAmount, distortionAmount),
        w,
        h
    )

    surface.SetDrawColor(col.r, col.g, col.b, alpha)
    surface.DrawTexturedRect(x, y, w, h)
end

local function GetTDMScore(ent, teamID)
    if teamID == "marine" then return ent:GetMarineScore() end
    if teamID == "xeno" then return ent:GetXenoScore() end
    if teamID == "predator" then return ent:GetPredatorScore() end
    return 0
end

hook.Add("HUDPaint", "VJ.AVP.TDM.MatchHUD", function()
    local ply = LocalPlayer()
    if !IsValid(ply) or !ply:GetNW2Bool("AVP_TDM_Participant", false) then return end

    local ent = ply:GetNW2Entity("AVP_TDM_Entity")
    if !IsValid(ent) or ent:GetClass() != "sent_vj_avp_tdm" or !ent:GetMatchActive() then return end

    local sw = ScrW()
    local top = Theme.S(44)
    local totalW = math.min(sw - Theme.S(90), Theme.S(1540))
    local gap = Theme.S(8)
    local teamH = Theme.S(52)
    local x = math.floor((sw - totalW) * 0.5)
    local teamY = top + Theme.S(30)
    local teamW = math.floor((totalW - gap * 2) / 3)

    surface.SetDrawColor(0, 0, 0, 118)
    surface.DrawRect(x, teamY + Theme.S(3), totalW, teamH - Theme.S(6))

    for i, teamID in ipairs(TDM.TeamOrder) do
        local team = TDM.TeamData[teamID]
        local cellX = x + (i - 1) * (teamW + gap)
        local col = Theme.TeamColor(teamID)
        local score = GetTDMScore(ent, teamID)

        DrawTDMHUDBlock(matTDMHUDBlock, cellX, teamY, teamW, teamH, col, 175)

        local iconSize = Theme.S(28)
        DrawFactionIcon(teamID, cellX + Theme.S(14), teamY + math.floor((teamH - iconSize) * 0.5), iconSize, 235, col)
        draw.SimpleText(
            string.upper(team && team.Name or teamID),
            "AVP.UI.Small",
            cellX + Theme.S(50),
            teamY + teamH * 0.5,
            col,
            TEXT_ALIGN_LEFT,
            TEXT_ALIGN_CENTER
        )

        draw.SimpleText(
            string.format("%03d", math.max(0, score or 0)),
            "VJFont_AVP_MarineSmall",
            cellX + teamW - Theme.S(18),
            teamY + teamH * 0.5 - Theme.S(1),
            C.White,
            TEXT_ALIGN_RIGHT,
            TEXT_ALIGN_CENTER
        )
    end

    local remaining = math.max(0, ent:GetMatchEndTime() - CurTime())
    local timerW = Theme.S(210)
    local timerH = Theme.S(42)
    local timerX = math.floor((sw - timerW) * 0.5)
    local timerY = top -Theme.S(30)
    local timerCol = C.Yellow

    if remaining <= 60 then
        local pulse = 0.55 + math.abs(math.sin(CurTime() * 4.5)) * 0.45
        timerCol = Color(
            math.floor(Lerp(pulse, C.Yellow.r, C.Red.r)),
            math.floor(Lerp(pulse, C.Yellow.g, C.Red.g)),
            math.floor(Lerp(pulse, C.Yellow.b, C.Red.b)),
            255
        )
    end

    surface.SetDrawColor(0, 0, 0, 160)
    surface.DrawRect(timerX + Theme.S(8), timerY + Theme.S(4), timerW - Theme.S(16), timerH - Theme.S(8))
    DrawTDMHUDBlock(matTDMHUDBlockShort, timerX, timerY, timerW, timerH, timerCol, 205)
    draw.SimpleText(
        FormatTime(remaining),
        "VJFont_AVP_MarineSmall",
        sw * 0.5,
        timerY + timerH * 0.5 - Theme.S(1),
        C.White,
        TEXT_ALIGN_CENTER,
        TEXT_ALIGN_CENTER
    )
end)

net.Receive("VJ.AVP.TDM.OpenLobby", function()
    local ent = net.ReadEntity()
    if IsValid(ent) then UI.OpenLobby(ent) end
end)

net.Receive("VJ.AVP.TDM.LobbyState", function()
    local ent = net.ReadEntity()
    local slots = net.ReadTable() or {}
    local frame = UI.LobbyFrame
    if !IsValid(frame) or frame.TDMEntity != ent then
        if IsValid(ent) then UI.PendingLobbyStates[ent] = slots end
        return
    end
    frame.Slots = slots
    UI.UpdateLobby(frame)
end)

net.Receive("VJ.AVP.TDM.MatchStart", function()
    local ent = net.ReadEntity()
    net.ReadFloat()
    UI.PendingLobbyStates[ent] = nil
    local frame = UI.LobbyFrame
    if IsValid(frame) && frame.TDMEntity == ent then
        UI.CloseLobby(false)
    end
end)

net.Receive("VJ.AVP.TDM.Results", function()
    local results = net.ReadTable() or {}
    UI.CloseLobby(false)
    UI.OpenResults(results)
end)
