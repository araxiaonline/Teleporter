local AIO = AIO or require("AIO")
if AIO.AddAddon() then return end

local TeleportSelectorHandlers = AIO.AddHandlers("TeleportSelectorClient", {})

local teleportFrame
local locationFrame
local selectedCategory = "Capital Cities"
local currentPage = 1
local locationsPerPage = 6

-- Category & location data (client side; your real server decides where you go)
local teleportCategories = {
["Capital Cities"] = {
    {id = 1, name = "Stormwind City", image = "Interface\\Buttons\\Teleport\\StormwindCity"},
    {id = 2, name = "Orgrimmar", image = "Interface\\Buttons\\Teleport\\Orgrimmar"},
    {id = 3, name = "Shattrath City", image = "Interface\\Buttons\\Teleport\\ShattrathCity"},
    {id = 4, name = "Dalaran", image = "Interface\\Buttons\\Teleport\\Dalaran"},
    {id = 5, name = "Ironforge", image = "Interface\\Buttons\\Teleport\\Ironforge"},
    {id = 6, name = "Undercity", image = "Interface\\Buttons\\Teleport\\Undercity"},
    {id = 7, name = "Thunder Bluff", image = "Interface\\Buttons\\Teleport\\ThunderBluff"},
    {id = 8, name = "Darnassus", image = "Interface\\Buttons\\Teleport\\Darnassus"},
    {id = 9, name = "Silvermoon City", image = "Interface\\Buttons\\Teleport\\SilvermoonCity"},
    {id = 10, name = "The Exodar", image = "Interface\\Buttons\\Teleport\\TheExodar"},
},

["Kalimdor"] = {
    {id = 11, name = "Ashenvale", image = "Interface\\Buttons\\Teleport\\Ashenvale"},
    {id = 12, name = "Azshara", image = "Interface\\Buttons\\Teleport\\Azshara"},
    {id = 13, name = "The Barrens", image = "Interface\\Buttons\\Teleport\\Barrens"},
    {id = 14, name = "Camp Narache", image = "Interface\\Buttons\\Teleport\\CampNarache"},
    {id = 15, name = "Darkshore", image = "Interface\\Buttons\\Teleport\\Darkshore"},
    {id = 16, name = "Desolace", image = "Interface\\Buttons\\Teleport\\Desolace"},
    {id = 17, name = "Durotar", image = "Interface\\Buttons\\Teleport\\Durotar"},
    {id = 18, name = "Dustwallow Marsh", image = "Interface\\Buttons\\Teleport\\DustwallowMarsh"},
    {id = 19, name = "Everlook", image = "Interface\\Buttons\\Teleport\\Everlook"},
    {id = 20, name = "Felwood", image = "Interface\\Buttons\\Teleport\\Felwood"},
    {id = 21, name = "Feralas", image = "Interface\\Buttons\\Teleport\\Feralas"},
    {id = 22, name = "Gadgetzan", image = "Interface\\Buttons\\Teleport\\Gadgetzan"},
    {id = 23, name = "Mulgore", image = "Interface\\Buttons\\Teleport\\Mulgore"},
    {id = 24, name = "Ratchet", image = "Interface\\Buttons\\Teleport\\Ratchet"},
    {id = 25, name = "Sen'jin Village", image = "Interface\\Buttons\\Teleport\\SenjinVillage"},
    {id = 26, name = "Shadowglen", image = "Interface\\Buttons\\Teleport\\Shadowglen"},
    {id = 27, name = "Stonetalon Mountains", image = "Interface\\Buttons\\Teleport\\Stonetalon"},
    {id = 28, name = "Tanaris", image = "Interface\\Buttons\\Teleport\\Tanaris"},
    {id = 29, name = "Teldrassil", image = "Interface\\Buttons\\Teleport\\Teldrassil"},
    {id = 30, name = "Theramore", image = "Interface\\Buttons\\Teleport\\Theramore"},
    {id = 31, name = "Thousand Needles", image = "Interface\\Buttons\\Teleport\\Needles"},
    {id = 32, name = "Un'Goro Crater", image = "Interface\\Buttons\\Teleport\\UnGoro"},
    {id = 33, name = "Valley of Trials", image = "Interface\\Buttons\\Teleport\\ValleyofTrials"},
    {id = 34, name = "Winterspring", image = "Interface\\Buttons\\Teleport\\Winterspring"},
},

["Eastern Kingdoms"] = {
    {id = 35, name = "Alterac Mountains", image = "Interface\\Buttons\\Teleport\\AlteracMountains"},
    {id = 36, name = "Arathi Highlands", image = "Interface\\Buttons\\Teleport\\ArathiHighlands"},
    {id = 37, name = "Badlands", image = "Interface\\Buttons\\Teleport\\Badlands"},
    {id = 38, name = "Blasted Lands", image = "Interface\\Buttons\\Teleport\\BlastedLands"},
    {id = 39, name = "Booty Bay", image = "Interface\\Buttons\\Teleport\\BootyBay"},
    {id = 40, name = "Burning Steppes", image = "Interface\\Buttons\\Teleport\\BurningSteppes"},
    {id = 41, name = "Coldridge Valley", image = "Interface\\Buttons\\Teleport\\Coldridge"},
    {id = 42, name = "Deathknell", image = "Interface\\Buttons\\Teleport\\Deathknell"},
    {id = 43, name = "Dun Morogh", image = "Interface\\Buttons\\Teleport\\DunMorogh"},
    {id = 44, name = "Duskwood", image = "Interface\\Buttons\\Teleport\\Duskwood"},
    {id = 45, name = "Eastern Plaguelands", image = "Interface\\Buttons\\Teleport\\EasternPlaguelands"},
    {id = 46, name = "Elwynn Forest", image = "Interface\\Buttons\\Teleport\\ElwynnForest"},
    {id = 47, name = "Ghostlands", image = "Interface\\Buttons\\Teleport\\Ghostlands"},
    {id = 48, name = "Hillsbrad Foothills", image = "Interface\\Buttons\\Teleport\\HillsbradFoothills"},
    {id = 49, name = "Loch Modan", image = "Interface\\Buttons\\Teleport\\LochModan"},
    {id = 50, name = "Northshire Abbey", image = "Interface\\Buttons\\Teleport\\NorthshireAbbey"},
    {id = 51, name = "Redridge Mountains", image = "Interface\\Buttons\\Teleport\\RedridgeMountains"},
    {id = 52, name = "Searing Gorge", image = "Interface\\Buttons\\Teleport\\SearingGorge"},
    {id = 53, name = "Silverpine Forest", image = "Interface\\Buttons\\Teleport\\SilverpineForest"},
    {id = 54, name = "Stonard", image = "Interface\\Buttons\\Teleport\\Stonard"},
    {id = 55, name = "Stranglethorn Vale", image = "Interface\\Buttons\\Teleport\\StranglethornVale"},
    {id = 56, name = "Swamp of Sorrows", image = "Interface\\Buttons\\Teleport\\SwampOfSorrows"},
    {id = 57, name = "The Hinterlands", image = "Interface\\Buttons\\Teleport\\TheHinterlands"},
    {id = 58, name = "Tirisfal Glades", image = "Interface\\Buttons\\Teleport\\TirisfalGlades"},
    {id = 59, name = "Western Plaguelands", image = "Interface\\Buttons\\Teleport\\WesternPlaguelands"},
    {id = 60, name = "Westfall", image = "Interface\\Buttons\\Teleport\\Westfall"},
    {id = 61, name = "Wetlands", image = "Interface\\Buttons\\Teleport\\Wetlands"},
},

["Outland"] = {
    {id = 62, name = "Ammen Vale", image = "Interface\\Buttons\\Teleport\\AmmenVale"},
    {id = 63, name = "Azuremyst Isle", image = "Interface\\Buttons\\Teleport\\Azuremyst"},
    {id = 64, name = "Bloodmyst Isle", image = "Interface\\Buttons\\Teleport\\Bloodmyst"},
    {id = 65, name = "Blade's Edge Mountains", image = "Interface\\Buttons\\Teleport\\BladesEdgeMountains"},
    {id = 66, name = "Eversong Woods", image = "Interface\\Buttons\\Teleport\\Eversong"},
    {id = 67, name = "Hellfire Peninsula", image = "Interface\\Buttons\\Teleport\\HellfirePeninsula"},
    {id = 68, name = "Nagrand", image = "Interface\\Buttons\\Teleport\\Nagrand"},
    {id = 69, name = "Netherstorm", image = "Interface\\Buttons\\Teleport\\Netherstorm"},
    {id = 70, name = "Terokkar Forest", image = "Interface\\Buttons\\Teleport\\TerokkarForest"},
    {id = 71, name = "Sunstrider Isle", image = "Interface\\Buttons\\Teleport\\SunstriderIsle"},
    {id = 72, name = "Zangarmarsh", image = "Interface\\Buttons\\Teleport\\Zangarmarsh"},
},

["Northrend"] = {
    {id = 73, name = "Borean Tundra", image = "Interface\\Buttons\\Teleport\\BoreanTundra"},
    {id = 74, name = "Crystalsong Forest", image = "Interface\\Buttons\\Teleport\\CrystalsongForest"},
    {id = 75, name = "Dragonblight", image = "Interface\\Buttons\\Teleport\\Dragonblight"},
    {id = 76, name = "Grizzly Hills", image = "Interface\\Buttons\\Teleport\\GrizzlyHills"},
    {id = 77, name = "Howling Fjord", image = "Interface\\Buttons\\Teleport\\HowlingFjord"},
    {id = 78, name = "Icecrown", image = "Interface\\Buttons\\Teleport\\Icecrown"},
    {id = 79, name = "Sholazar Basin", image = "Interface\\Buttons\\Teleport\\SholazarBasin"},
    {id = 80, name = "Storm Peaks", image = "Interface\\Buttons\\Teleport\\StormPeaks"},
    {id = 81, name = "Valiance Keep", image = "Interface\\Buttons\\Teleport\\ValianceKeep"},
    {id = 82, name = "Warsong Hold", image = "Interface\\Buttons\\Teleport\\WarsongHold"},
    {id = 83, name = "Wintergrasp", image = "Interface\\Buttons\\Teleport\\Wintergrasp"},
},

["Dungeons"] = {
    {id = 84, name = "Blackfathom Deeps", image = "Interface\\Buttons\\Teleport\\BlackfathomDeeps"},
    {id = 85, name = "Blackrock Depths", image = "Interface\\Buttons\\Teleport\\BlackrockDepths"},
    {id = 86, name = "Blackrock Spire", image = "Interface\\Buttons\\Teleport\\BlackrockSpire"},
    {id = 87, name = "Gnomeregan", image = "Interface\\Buttons\\Teleport\\Gnomeregan"},
    {id = 88, name = "Maraudon", image = "Interface\\Buttons\\Teleport\\Maraudon"},
    {id = 89, name = "Ragefire Chasm", image = "Interface\\Buttons\\Teleport\\RagefireChasm"},
    {id = 90, name = "Razorfen Downs", image = "Interface\\Buttons\\Teleport\\RazorfenDowns"},
    {id = 91, name = "Razorfen Kraul", image = "Interface\\Buttons\\Teleport\\RazorfenKraul"},
    {id = 92, name = "Scarlet Monastery", image = "Interface\\Buttons\\Teleport\\ScarletMonastery"},
    {id = 93, name = "Scholomance", image = "Interface\\Buttons\\Teleport\\Scholomance"},
    {id = 94, name = "Shadowfang Keep", image = "Interface\\Buttons\\Teleport\\ShadowFangKeep"},
    {id = 95, name = "Stratholme", image = "Interface\\Buttons\\Teleport\\Stratholme"},
    {id = 96, name = "Sunken Temple", image = "Interface\\Buttons\\Teleport\\SunkenTemple"},
    {id = 97, name = "The Deadmines", image = "Interface\\Buttons\\Teleport\\TheDeadmines"},
    {id = 98, name = "The Stockade", image = "Interface\\Buttons\\Teleport\\TheStockade"},
    {id = 99, name = "Uldaman", image = "Interface\\Buttons\\Teleport\\Uldaman"},
    {id = 100, name = "Wailing Caverns", image = "Interface\\Buttons\\Teleport\\WailingCaverns"},
    {id = 101, name = "Zul'Farrak", image = "Interface\\Buttons\\Teleport\\ZulFarrak"},
},

["BC Dungeons"] = {
    {id = 102, name = "Auchenai Crypts", image = "Interface\\Buttons\\Teleport\\AuchenaiCrypts"},
    {id = 103, name = "Hellfire Ramparts", image = "Interface\\Buttons\\Teleport\\HellfireRamparts"},
    {id = 104, name = "Magisters' Terrace", image = "Interface\\Buttons\\Teleport\\MagistersTerrace"},
    {id = 105, name = "Mana-Tombs", image = "Interface\\Buttons\\Teleport\\ManaTombs"},
    {id = 106, name = "Old Hillsbrad Foothills", image = "Interface\\Buttons\\Teleport\\HillsbradFoothills"},
    {id = 107, name = "Sethekk Halls", image = "Interface\\Buttons\\Teleport\\SethekkHalls"},
    {id = 108, name = "Shadow Labyrinth", image = "Interface\\Buttons\\Teleport\\ShadowLabyrinth"},
    {id = 109, name = "The Arcatraz", image = "Interface\\Buttons\\Teleport\\TheArcatraz"},
    {id = 110, name = "The Black Morass", image = "Interface\\Buttons\\Teleport\\TheBlackMorass"},
    {id = 111, name = "The Blood Furnace", image = "Interface\\Buttons\\Teleport\\TheBloodFurnace"},
    {id = 112, name = "The Botanica", image = "Interface\\Buttons\\Teleport\\TheBotanica"},
    {id = 113, name = "The Mechanar", image = "Interface\\Buttons\\Teleport\\TheMechanar"},
    {id = 114, name = "The Shattered Halls", image = "Interface\\Buttons\\Teleport\\TheShatteredHalls"},
    {id = 115, name = "The Slave Pens", image = "Interface\\Buttons\\Teleport\\TheSlavePens"},
    {id = 116, name = "The Steamvault", image = "Interface\\Buttons\\Teleport\\TheSteamvault"},
    {id = 117, name = "The Underbog", image = "Interface\\Buttons\\Teleport\\TheUnderbog"},
},

["WOTLK Dungeons"] = {
    {id = 118, name = "Azjol-Nerub", image = "Interface\\Buttons\\Teleport\\AzjolNerub"},
    {id = 119, name = "The Culling of Stratholme", image = "Interface\\Buttons\\Teleport\\TheCullingOfStratholme"},
    {id = 120, name = "Drak'Tharon Keep", image = "Interface\\Buttons\\Teleport\\DrakTharonKeep"},
    {id = 121, name = "The Forge of Souls", image = "Interface\\Buttons\\Teleport\\ForgeOfSouls"},
    {id = 122, name = "Halls of Stone", image = "Interface\\Buttons\\Teleport\\HallsOfStone"},
    {id = 123, name = "Halls of Lightning", image = "Interface\\Buttons\\Teleport\\HallsOfLightning"},
    {id = 124, name = "Halls of Reflection", image = "Interface\\Buttons\\Teleport\\HallsOfReflection"},
    {id = 125, name = "Gundrak", image = "Interface\\Buttons\\Teleport\\GundrakDungeon"},
    {id = 126, name = "Pit of Saron", image = "Interface\\Buttons\\Teleport\\PitOfSaron"},
    {id = 127, name = "Trial of the Champion", image = "Interface\\Buttons\\Teleport\\TrialOfTheChampion"},
    {id = 128, name = "Utgarde Keep", image = "Interface\\Buttons\\Teleport\\UtgardeKeep"},
    {id = 129, name = "Utgarde Pinnacle", image = "Interface\\Buttons\\Teleport\\UtgardePinnacle"},
    {id = 130, name = "The Violet Hold", image = "Interface\\Buttons\\Teleport\\VioletHold"},
},

["Raids"] = {
    {id = 131, name = "Battle for Mount Hyjal", image = "Interface\\Buttons\\Teleport\\HyjalSummit"},
    {id = 132, name = "Black Temple", image = "Interface\\Buttons\\Teleport\\BlackTemple"},
    {id = 133, name = "Blackwing Lair", image = "Interface\\Buttons\\Teleport\\BlackwingLair"},
    {id = 134, name = "Eye of Eternity", image = "Interface\\Buttons\\Teleport\\EyeOfEternity"},
    {id = 135, name = "Gruul's Lair", image = "Interface\\Buttons\\Teleport\\GruulsLair"},
    {id = 136, name = "Icecrown Citadel", image = "Interface\\Buttons\\Teleport\\IcecrownCitadelRaid"},
    {id = 137, name = "Karazhan", image = "Interface\\Buttons\\Teleport\\Karazhan"},
    {id = 138, name = "Magtheridon's Lair", image = "Interface\\Buttons\\Teleport\\MagtheridonsLair"},
    {id = 139, name = "Molten Core", image = "Interface\\Buttons\\Teleport\\MoltenCore"},
    {id = 140, name = "Naxxramas", image = "Interface\\Buttons\\Teleport\\Naxxramas"},
    {id = 141, name = "Obsidian Sanctum", image = "Interface\\Buttons\\Teleport\\ObsidianSanctum"},
    {id = 142, name = "Onyxia's Lair (Vanilla)", image = "Interface\\Buttons\\Teleport\\OnyxiasLair"},
    {id = 143, name = "Onyxia's Lair (WOTLK)", image = "Interface\\Buttons\\Teleport\\OnyxiasLairWOTLK"},
    {id = 144, name = "Ruby Sanctum", image = "Interface\\Buttons\\Teleport\\RubySanctum"},
    {id = 145, name = "Serpentshrine Cavern", image = "Interface\\Buttons\\Teleport\\SerpentshrineCavern"},
    {id = 146, name = "Sunwell Plateau", image = "Interface\\Buttons\\Teleport\\SunwellPlateau"},
    {id = 147, name = "Tempest Keep", image = "Interface\\Buttons\\Teleport\\TempestKeep"},
    {id = 148, name = "The Ruins of Ahn'Qiraj", image = "Interface\\Buttons\\Teleport\\RuinsOfAhnQiraj"},
    {id = 149, name = "The Temple of Ahn'Qiraj", image = "Interface\\Buttons\\Teleport\\TempleOfAhnQiraj"},
    {id = 150, name = "Trial of the Crusader", image = "Interface\\Buttons\\Teleport\\TrialOfTheCrusader"},
    {id = 151, name = "Ulduar", image = "Interface\\Buttons\\Teleport\\Ulduar"},
    {id = 152, name = "Vault of Archavon", image = "Interface\\Buttons\\Teleport\\VaultOfArchavon"},
},

["Araxia"] = {
    {id = 153, name = "Guild Hall", image = "Interface\\Buttons\\Teleport\\GuildHall"},
    {id = 154, name = "Isle of Giants", image = "Interface\\Buttons\\Teleport\\IsleGiants"},
    {id = 155, name = "Morza Island", image = "Interface\\Buttons\\Teleport\\MorzaIsland"},
    {id = 156, name = "Silithus Camp", image = "Interface\\Buttons\\Teleport\\SilithusCamp"},
    {id = 157, name = "Windpeak Island", image = "Interface\\Buttons\\Teleport\\Windpeak"},
},

}

function TeleportSelectorHandlers.ShowTeleportUI()
    if teleportFrame then
        teleportFrame:Show()
        ShowTeleportButtons()
        return
    end

    teleportFrame = CreateFrame("Frame", "TeleportSelectorFrame", UIParent, BackdropTemplateMixin and "BackdropTemplate")
    teleportFrame:SetSize(1000, 800)
    teleportFrame:SetPoint("CENTER")
    teleportFrame:SetBackdrop({
        bgFile = "Interface/DialogFrame/UI-DialogBox-Background-Dark",
        edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
        tile = true, tileSize = 32, edgeSize = 32,
        insets = { left = 8, right = 8, top = 8, bottom = 8 },
    })
    teleportFrame:SetFrameStrata("FULLSCREEN_DIALOG")
    teleportFrame:SetMovable(true)
    teleportFrame:EnableMouse(true)
    teleportFrame:RegisterForDrag("LeftButton")
    teleportFrame:SetScript("OnDragStart", teleportFrame.StartMoving)
    teleportFrame:SetScript("OnDragStop", teleportFrame.StopMovingOrSizing)
    tinsert(UISpecialFrames, teleportFrame:GetName())

    -- Close button
    local closeButton = CreateFrame("Button", nil, teleportFrame, "UIPanelCloseButton")
    closeButton:SetPoint("TOPRIGHT", teleportFrame, "TOPRIGHT", -5, -5)

    -- Title
    local titleFont = CreateFont("TitleFont")
    titleFont:SetFont("Interface/Fonts/friz-quadrata-regular.ttf", 28, "OUTLINE")
    titleFont:SetShadowOffset(1, -1)
    titleFont:SetShadowColor(0, 0, 0, 0.5)

    local title = teleportFrame:CreateFontString(nil, "OVERLAY")
    title:SetPoint("TOP", 0, -30)
    title:SetFontObject(titleFont)
    title:SetText("Choose Your Destination")
    title:SetTextColor(209 / 255, 163 / 255, 14 / 255)

    -- Hardcoded categories
    local categories = {
        "Capital Cities",
        "Kalimdor",
        "Eastern Kingdoms",
        "Outland",
        "Northrend",
        "Dungeons",
        "BC Dungeons",
        "WOTLK Dungeons",
        "Raids",
        "Araxia",
    }

    for i, category in ipairs(categories) do
        local btn = CreateFrame("Button", nil, teleportFrame, "UIPanelButtonTemplate")
        btn:SetSize(150, 30)
        btn:SetPoint("TOPLEFT", 10, -50 - (i - 1) * 40)
        btn:SetText(category)
        btn:SetScript("OnClick", function()
            selectedCategory = category
            currentPage = 1
            ShowTeleportButtons()
        end)
    end

    -- Location button container
    locationFrame = CreateFrame("Frame", nil, teleportFrame)
    locationFrame:SetSize(560, 500)
    locationFrame:SetPoint("TOPLEFT", 200, -60)

    -- Page label
    pageLabel = teleportFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    pageLabel:SetPoint("BOTTOM", teleportFrame, "BOTTOM", 0, 20)
    pageLabel:SetTextColor(1, 1, 1)

    -- Pagination buttons
local prevButton = CreateFrame("Button", nil, teleportFrame, "UIPanelButtonTemplate")
prevButton:SetSize(100, 25)
prevButton:SetText("Previous")
prevButton:SetPoint("BOTTOM", teleportFrame, "BOTTOM", -200, 20)
    prevButton:SetScript("OnClick", function()
        currentPage = math.max(1, currentPage - 1)
        ShowTeleportButtons()
    end)

 local nextButton = CreateFrame("Button", nil, teleportFrame, "UIPanelButtonTemplate")
nextButton:SetSize(100, 25)
nextButton:SetText("Next")
nextButton:SetPoint("BOTTOM", teleportFrame, "BOTTOM", 200, 20)
    nextButton:SetScript("OnClick", function()
        local locs = teleportCategories[selectedCategory]
        if not locs then return end
        local maxPage = math.ceil(#locs / locationsPerPage)
        currentPage = math.min(maxPage, currentPage + 1)
        ShowTeleportButtons()
    end)

    ShowTeleportButtons()
end

function ShowTeleportButtons()
    for _, child in ipairs({ locationFrame:GetChildren() }) do
        child:Hide()
    end

    local locs = teleportCategories[selectedCategory]
    if not locs then return end

    local totalPages = math.ceil(#locs / locationsPerPage)
    pageLabel:SetText("Page " .. currentPage .. " of " .. totalPages)

    local buttonWidth, buttonHeight = 300, 150
    local spacingX, spacingY = 10, 40
    local cols = 2

    local startIndex = (currentPage - 1) * locationsPerPage + 1
    local endIndex = math.min(startIndex + locationsPerPage - 1, #locs)

    for i = startIndex, endIndex do
        local loc = locs[i]
        local row = math.floor((i - startIndex) / cols)
        local col = (i - startIndex) % cols

        local button = CreateFrame("Button", nil, locationFrame)
        button:SetSize(buttonWidth, buttonHeight)
        button:SetPoint("TOPLEFT", col * (buttonWidth + spacingX), -row * (buttonHeight + spacingY))
        button:SetNormalTexture(loc.image or "Interface\\Icons\\INV_Misc_QuestionMark")
        button:SetHighlightTexture(nil)

        -- Glowing border (golden)
        local glow = CreateFrame("Frame", nil, button, BackdropTemplateMixin and "BackdropTemplate")
        glow:SetPoint("TOPLEFT", -6, 6)
        glow:SetPoint("BOTTOMRIGHT", 6, -6)
        glow:SetBackdrop({
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            edgeSize = 16,
        })
        glow:SetBackdropBorderColor(1, 0.82, 0, 1)
        glow:SetAlpha(0)
        button.glow = glow

        -- Border
        local border = CreateFrame("Frame", nil, button, BackdropTemplateMixin and "BackdropTemplate")
        border:SetPoint("TOPLEFT", -3, 3)
        border:SetPoint("BOTTOMRIGHT", 3, -3)
        border:SetBackdrop({
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            edgeSize = 15,
        })

        button:SetScript("OnEnter", function(self)
            self.glow:SetAlpha(0.8)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText(loc.name, 1, 1, 1)
        end)

        button:SetScript("OnLeave", function(self)
            self.glow:SetAlpha(0)
            GameTooltip:Hide()
        end)

        button:SetScript("OnClick", function()
            AIO.Handle("TeleportSelectorServer", "TeleportTo", loc.id)
            teleportFrame:Hide()
        end)

        local label = button:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        label:SetPoint("TOP", button, "BOTTOM", 0, -10)
        label:SetFont("Interface/Fonts/friz-quadrata-regular.ttf", 14)
        label:SetText(loc.name)
        label:SetTextColor(209 / 255, 163 / 255, 14 / 255)
    end
end
