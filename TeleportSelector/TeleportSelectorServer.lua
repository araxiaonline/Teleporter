local AIO = AIO or require("AIO")
local TeleportSelectorServer = AIO.AddHandlers("TeleportSelectorServer", {})

local locations = {
    -- Capital Cities
    [1] = {map = 0, x = -8833.38, y = 628.628, z = 94.0066, o = 1.06535},       -- Stormwind City
    [2] = {map = 1, x = 1629.85, y = -4373.64, z = 31.5573, o = 3.69762},      -- Orgrimmar
    [3] = {map = 530, x = -1904.76, y = 5443.43, z = -12.42721, o = 5.93},     -- Shattrath City
    [4] = {map = 571, x = 5807.75, y = 588.346, z = 660.93915, o = 1.663},     -- Dalaran
    [5] = {map = 0, x = -4918.88, y = -940.406, z = 501.564, o = 5.42347},     -- Ironforge
    [6] = {map = 0, x = 1584.14, y = 240.308, z = -52.1534, o = 0.041793},     -- Undercity
    [7] = {map = 1, x = -1277.37, y = 124.804, z = 131.287, o = 5.22274},      -- Thunder Bluff
    [8] = {map = 1, x = 9949.56, y = 2284.21, z = 1341.4, o = 1.59587},        -- Darnassus
    [9] = {map = 530, x = 9998.490234, y = -7106.779785, z = 47.705502, o = 2.44}, -- Silvermoon City
    [10] = {map = 530, x = -3965.7, y = -11653.6, z = -138.844, o = 0.852154}, -- The Exodar
    
-- Kalimdor
    [11] = {map = 1, x = 1928.34, y = -2165.95, z = 93.7896, o = 0.205731},    -- Ashenvale
    [12] = {map = 1, x = 3341.36, y = -4603.79, z = 92.5027, o = 5.28142},     -- Azshara
    [13] = {map = 1, x = 48.9976, y = -2715.55, z = 91.6677, o = 0.158612},    -- The Barrens
    [14] = {map = 1, x = -2918.9114, y = -263.6406, z = 53.5418, o = 0.200739},-- Camp Narache
    [15] = {map = 1, x = 5756.25, y = 298.505, z = 20.6049, o = 5.96504},      -- Darkshore
    [16] = {map = 1, x = -606.395, y = 2211.75, z = 92.9818, o = 0.809746},    -- Desolace
    [17] = {map = 1, x = 1007.78, y = -4446.22, z = 11.2022, o = 0.20797},     -- Durotar
    [18] = {map = 1, x = -4043.65, y = -2991.32, z = 36.3984, o = 3.37443},    -- Dustwallow Marsh
    [19] = {map = 1, x = 6725.69, y = -4619.44, z = 720.909, o = 4.66802},     -- Everlook
    [20] = {map = 1, x = 4102.25, y = -1006.79, z = 272.717, o = 0.790048},    -- Felwood
    [21] = {map = 1, x = -4841.19, y = 1309.44, z = 81.3937, o = 1.48501},     -- Feralas
    [22] = {map = 1, x = -7177.15, y = -3785.34, z = 8.36981, o = 6.081007},   -- Gadgetzan
    [23] = {map = 1, x = -2192.62, y = -736.317, z = -13.3274, o = 0.487569},  -- Mulgore
    [24] = {map = 1, x = -956.664, y = -3754.71, z = 5.33239, o = 0.996637},   -- Ratchet
    [25] = {map = 1, x = -813.097, y = -4880.08, z = 18.995, o = 4.42647},     -- Sen'jin Village
    [26] = {map = 1, x = 10334.0, y = 833.902, z = 1326.11, o = 3.62142},      -- Shadowglen
    [27] = {map = 1, x = 1570.92, y = 1031.52, z = 137.959, o = 3.33006},      -- Stonetalon Mountains
    [28] = {map = 1, x = -7931.2, y = -3414.28, z = 80.7365, o = 0.66522},     -- Tanaris
    [29] = {map = 1, x = 10111.3, y = 1557.73, z = 1324.33, o = 4.04239},      -- Teldrassil
    [30] = {map = 1, x = -3730.72, y = -4422.21, z = 30.48361, o = 0.810732},  -- Theramore
    [31] = {map = 1, x = -4969.02, y = -1726.89, z = -62.1269, o = 3.7933},    -- Thousand Needles
    [32] = {map = 1, x = -7943.22, y = -2119.09, z = -218.343, o = 6.0727},    -- Un'Goro Crater
    [33] = {map = 1, x = -601.294, y = -4296.76, z = 37.8115, o = 1.65401},    -- Valley of Trials
    [34] = {map = 1, x = 6759.18, y = -4419.63, z = 763.214, o = 4.43476},     -- Winterspring

-- Eastern Kingdoms
    [35] = {map = 0, x = 370.763,     y = -491.355,   z = 175.361,   o = 5.37858},   -- Alterac Mountains
    [36] = {map = 0, x = -1508.51,    y = -2732.06,   z = 32.4986,   o = 3.35708},   -- Arathi Highlands
    [37] = {map = 0, x = -6779.2,     y = -3423.64,   z = 241.667,   o = 0.647481},  -- Badlands
    [38] = {map = 0, x = -11182.5,    y = -3016.67,   z = 7.42235,   o = 4.0004},    -- Blasted Lands
    [39] = {map = 0, x = -14297.2,    y = 530.993,    z = 8.77916,   o = 3.98863},   -- Booty Bay
    [40] = {map = 0, x = -8118.54,    y = -1633.83,   z = 132.996,   o = 0.089067},  -- Burning Steppes
    [41] = {map = 0, x = -6231.77,    y = 332.993,    z = 383.171,   o = 0.480178},  -- Coldridge Valley
    [42] = {map = 0, x = 1843.5,      y = 1590.0,     z = 93.2971,   o = 3.08757},   -- Deathknell
    [43] = {map = 0, x = -5451.55,    y = -656.992,   z = 392.675,   o = 0.66789},   -- Dun Morogh
    [44] = {map = 0, x = -10898.3,    y = -364.784,   z = 39.2681,   o = 3.04614},   -- Duskwood
    [45] = {map = 0, x = 2300.97,     y = -4613.36,   z = 73.6231,   o = 0.367722},  -- Eastern Plaguelands
    [46] = {map = 0, x = -9617.06,    y = -288.949,   z = 57.3053,   o = 4.72687},   -- Elwynn Forest
    [47] = {map = 530, x = 7360.86,   y = -6803.3,    z = 44.2942,   o = 5.83679},   -- Ghostlands
    [48] = {map = 0, x = -436.657,    y = -581.254,   z = 53.5944,   o = 1.25917},   -- Hillsbrad Foothills
    [49] = {map = 0, x = -5202.94,    y = -2855.18,   z = 336.822,   o = 0.37651},   -- Loch Modan
    [50] = {map = 0, x = -8921.0898,  y = -119.135,   z = 82.195,    o = 2.958306},  -- Northshire Abbey
    [51] = {map = 0, x = -9551.81,    y = -2204.73,   z = 93.473,    o = 5.47141},   -- Redridge Mountains
    [52] = {map = 0, x = -7012.47,    y = -1065.13,   z = 241.786,   o = 5.63162},   -- Searing Gorge
    [53] = {map = 0, x = 878.74,      y = 1359.33,    z = 50.355,    o = 5.89929},   -- Silverpine Forest
    [54] = {map = 0, x = -10446.9,    y = -3261.91,   z = 20.1795,   o = 5.02142},   -- Stonard
    [55] = {map = 0, x = -12644.3,    y = -377.411,   z = 10.1021,   o = 6.09978},   -- Stranglethorn Vale
    [56] = {map = 0, x = -10345.4,    y = -2773.42,   z = 21.99,     o = 5.08426},   -- Swamp of Sorrows
    [57] = {map = 0, x = 119.387,     y = -3190.37,   z = 117.331,   o = 2.34064},   -- The Hinterlands
    [58] = {map = 0, x = 2036.02,     y = 161.331,    z = 33.8674,   o = 0.143896},  -- Tirisfal Glades
    [59] = {map = 0, x = 1728.65,     y = -1602.25,   z = 63.429,    o = 1.6558},    -- Western Plaguelands
    [60] = {map = 0, x = -10235.2,    y = 1222.47,    z = 43.6252,   o = 6.2427},    -- Westfall
    [61] = {map = 0, x = -3242.81,    y = -2469.04,   z = 15.9226,   o = 6.03924},   -- Wetlands

-- Outland
    [62] = {map = 530, x = -4021.4,  y = -13582.1, z = 54.7153,   o = 2.06953},   -- Ammen Vale
    [63] = {map = 530, x = -4216.87, y = -12336.9, z = 4.34247,   o = 6.02008},   -- Azuremyst Isle
    [64] = {map = 530, x = -1993.62, y = -11475.8, z = 63.9657,   o = 5.29437},   -- Bloodmyst Isle
    [65] = {map = 530, x = 3037.67,  y = 5962.86,  z = 130.774,   o = 1.27253},   -- Blade's Edge Mountains
    [66] = {map = 530, x = 9079.92,  y = -7193.23, z = 55.6013,   o = 5.94597},   -- Eversong Woods
    [67] = {map = 530, x = -211.237, y = 4278.54,  z = 86.5678,   o = 4.59776},   -- Hellfire Peninsula
    [68] = {map = 530, x = -1145.95, y = 8182.35,  z = 3.60249,   o = 6.13478},   -- Nagrand
    [69] = {map = 530, x = 3830.23,  y = 3426.5,   z = 88.6145,   o = 5.16677},   -- Netherstorm
    [70] = {map = 530, x = -2000.47, y = 4451.54,  z = 8.37917,   o = 4.40447},   -- Terokkar Forest
    [71] = {map = 530, x = 10331.1,  y = -6235.42, z = 26.7759,   o = 1.94594},   -- Sunstrider Isle
    [72] = {map = 530, x = -54.8621, y = 5813.44,  z = 20.9764,   o = 0.081722},  -- Zangarmarsh


-- Northrend
    [73] = {map = 571, x = 3256.57,  y = 5278.23,  z = 40.8046,   o = 0.246367},  -- Borean Tundra
    [74] = {map = 571, x = 5474.07,  y = 39.7615,   z = 149.546,   o = 6.27193},   -- Crystalsong Forest
    [75] = {map = 571, x = 4103.36,  y = 264.478,   z = 50.5019,   o = 3.09349},   -- Dragonblight
    [76] = {map = 571, x = 4391.73,  y = -3587.92,  z = 238.531,   o = 3.57526},   -- Grizzly Hills
    [77] = {map = 571, x = 1902.15,  y = -4883.91,  z = 171.363,   o = 3.11537},   -- Howling Fjord
    [78] = {map = 571, x = 7253.64,  y = 1644.78,   z = 433.68,    o = 4.83412},   -- Icecrown
    [79] = {map = 571, x = 5323.0,   y = 4942.0,    z = -133.5,    o = 2.17},      -- Sholazar Basin
    [80] = {map = 571, x = 7527.14,  y = -1260.89,  z = 919.049,   o = 2.0696},    -- Storm Peaks
    [81] = {map = 571, x = 2213.95,  y = 5273.15,   z = 11.2565,   o = 5.89294},   -- Valiance Keep
    [82] = {map = 571, x = 2741.29,  y = 6097.16,   z = 76.9055,   o = 0.731543},  -- Warsong Hold
    [83] = {map = 571, x = 4760.7,   y = 2143.7,    z = 423.0,     o = 1.13},      -- Wintergrasp

-- Dungeons
    [84] = {map = 1, x = 4249.99,   y = 740.102,    z = -25.671,    o = 1.34062},   -- Blackfathom Deeps
    [85] = {map = 0, x = -7179.34,  y = -921.212,   z = 165.821,    o = 5.09599},   -- Blackrock Depths
    [86] = {map = 0, x = -7527.05,  y = -1226.77,   z = 285.732,    o = 5.29626},   -- Blackrock Spire
    [87] = {map = 0, x = -5163.54,  y = 925.423,    z = 257.181,    o = 1.57423},   -- Gnomeregan
    [88] = {map = 1, x = -1419.13,  y = 2908.14,    z = 137.464,    o = 1.57366},   -- Maraudon
    [89] = {map = 1, x = 1811.78,   y = -4410.5,    z = -18.4704,   o = 5.20165},   -- Ragefire Chasm
    [90] = {map = 1, x = -4657.3,   y = -2519.35,   z = 81.0529,    o = 4.54808},   -- Razorfen Downs
    [91] = {map = 1, x = -4470.28,  y = -1677.77,   z = 81.3925,    o = 1.16302},   -- Razorfen Kraul
    [92] = {map = 0, x = 2872.6,    y = -764.398,   z = 160.332,    o = 5.05735},   -- Scarlet Monastery
    [93] = {map = 0, x = 1269.64,   y = -2556.21,   z = 93.6088,    o = 0.620623},  -- Scholomance
    [94] = {map = 0, x = -234.675,  y = 1561.63,    z = 76.8921,    o = 1.24031},   -- Shadowfang Keep
    [95] = {map = 0, x = 3352.92,   y = -3379.03,   z = 144.782,    o = 6.25978},   -- Stratholme
    [96] = {map = 0, x = -10449.5,  y = -3827.47,   z = 18.0675,    o = 6.04945},   -- Sunken Temple
    [97] = {map = 0, x = -11208.7,  y = 1673.52,    z = 24.6361,    o = 1.51067},   -- The Deadmines
    [98] = {map = 0, x = -8779.9,   y = 834.349,    z = 94.6801,    o = 0.653013},  -- The Stockade
    [99] = {map = 0, x = -6071.37,  y = -2955.16,   z = 209.782,    o = 0.015708},  -- Uldaman
    [100] = {map = 1, x = -731.607, y = -2218.39,   z = 17.0281,    o = 2.78486},   -- Wailing Caverns
    [101] = {map = 1, x = -6801.19, y = -2893.02,   z = 9.00388,    o = 0.158639},  -- Zul'Farrak

-- BC Dungeons
    [102] = {map = 530, x = -3362.04,  y = 5209.85,  z = -101.05,     o = 1.60924},   -- Auchenai Crypts
    [103] = {map = 530, x = -360.671,  y = 3071.9,   z = -15.0977,    o = 1.89389},   -- Hellfire Ramparts
    [104] = {map = 530, x = 12884.6,   y = -7317.69, z = 65.5023,     o = 4.799},     -- Magisters' Terrace
    [105] = {map = 530, x = -3104.18,  y = 4945.52,  z = -101.507,    o = 6.22344},   -- Mana-Tombs
    [106] = {map = 1,   x = -8404.3,   y = -4070.62, z = -208.586,    o = 0.237038},  -- Old Hillsbrad Foothills
    [107] = {map = 530, x = -3362.2,   y = 4664.12,  z = -101.049,    o = 4.6605},    -- Sethekk Halls
    [108] = {map = 530, x = -3627.9,   y = 4941.98,  z = -101.049,    o = 3.16039},   -- Shadow Labyrinth
    [109] = {map = 530, x = 3308.92,   y = 1340.72,  z = 505.56,      o = 4.94686},   -- The Arcatraz
    [110] = {map = 1,   x = -8734.3,   y = -4230.11, z = -209.5,      o = 2.16212},   -- The Black Morass
    [111] = {map = 530, x = -291.324,  y = 3149.1,   z = 31.5541,     o = 2.27147},   -- The Blood Furnace
    [112] = {map = 530, x = 3407.11,   y = 1488.48,  z = 182.838,     o = 5.59559},   -- The Botanica
    [113] = {map = 530, x = 2867.12,   y = 1549.42,  z = 252.159,     o = 3.82218},   -- The Mechanar
    [114] = {map = 530, x = -305.79,   y = 3061.63,  z = -2.53847,    o = 1.88888},   -- The Shattered Halls
    [115] = {map = 530, x = 717.282,   y = 6979.87,  z = -73.0281,    o = 1.50287},   -- The Slave Pens
    [116] = {map = 530, x = 794.537,   y = 6927.81,  z = -80.4757,    o = 0.159089},  -- The Steamvault
    [117] = {map = 530, x = 763.307,   y = 6767.81,  z = -67.7695,    o = 5.99726},   -- The Underbog

-- WOTLK Dungeons
    [118] = {map = 571, x = 3677.53,   y = 2166.7,    z = 35.808,     o = 2.30108},   -- Azjol-Nerub
    [119] = {map = 1,   x = -8750.76,  y = -4442.2,   z = -199.26,    o = 4.37694},   -- The Culling of Stratholme
    [120] = {map = 571, x = 4774.6,    y = -2032.92,  z = 229.15,     o = 1.59},      -- Drak'Tharon Keep
    [121] = {map = 571, x = 5666.25,   y = 2009.2,    z = 798.041,    o = 5.43184},   -- The Forge of Souls
    [122] = {map = 571, x = 8921.91,   y = -993.503,  z = 1039.41,    o = 1.55263},   -- Halls of Stone
    [123] = {map = 571, x = 9182.92,   y = -1384.82,  z = 1110.21,    o = 5.57779},   -- Halls of Lightning
    [124] = {map = 571, x = 5630.44,   y = 1994.01,   z = 798.059,    o = 4.58756},   -- Halls of Reflection
    [125] = {map = 571, x = 6952.3,    y = -4419.98,  z = 450.078,    o = 0.807518},  -- Gundrak
    [126] = {map = 571, x = 5598.74,   y = 2015.85,   z = 798.042,    o = 3.81001},   -- Pit of Saron
    [127] = {map = 571, x = 8588.42,   y = 791.888,   z = 558.236,    o = 3.23819},   -- Trial of the Champion
    [128] = {map = 571, x = 1219.72,   y = -4865.28,  z = 41.2479,    o = 0.313228},  -- Utgarde Keep
    [129] = {map = 571, x = 1259.33,   y = -4852.02,  z = 215.763,    o = 3.48293},   -- Utgarde Pinnacle
    [130] = {map = 571, x = 5696.73,   y = 507.4,     z = 652.97,     o = 4.03},      -- The Violet Hold

-- Raids
    [131] = {map = 571,  x = -8177.89,   y = -4181.23,   z = -167.552,    o = 0.913338},  -- Battle for Mount Hyjal
    [132] = {map = 530,  x = -3649.92,   y = 317.469,    z = 35.2827,     o = 2.94285},   -- Black Temple
    [133] = {map = 229,  x = 164.789,    y = -475.305,   z = 116.842,     o = 0.022714},  -- Blackwing Lair
    [134] = {map = 571,  x = 3859.44,    y = 6989.85,    z = 152.041,     o = 5.79635},   -- Eye of Eternity
    [135] = {map = 530,  x = 3530.06,    y = 5104.08,    z = 3.50861,     o = 5.51117},   -- Gruul's Lair
    [136] = {map = 571,  x = 5873.82,    y = 2110.98,    z = 636.011,     o = 3.5523},    -- Icecrown Citadel
    [137] = {map = 0,    x = -11118.9,   y = -2010.33,   z = 47.0819,     o = 0.649895},  -- Karazhan
    [138] = {map = 530,  x = -312.7,     y = 3087.26,    z = -116.52,     o = 5.19026},   -- Magtheridon's Lair
    [139] = {map = 230,  x = 1126.64,    y = -459.94,    z = -102.535,    o = 3.46095},   -- Molten Core
    [140] = {map = 571,  x = 3668.72,    y = -1262.46,   z = 243.622,     o = 4.785},     -- Naxxramas
    [141] = {map = 571,  x = 3457.11,    y = 262.394,    z = -113.819,    o = 3.28258},   -- Obsidian Sanctum
    [142] = {map = 1,    x = -4708.27,   y = -3727.64,   z = 54.5589,     o = 3.72786},   -- Onyxia's Lair (Vanilla)
    [143] = {map = 249,  x = 29.1607,    y = -71.3372,   z = -8.18032,    o = 4.43584},   -- Onyxia's Lair (WOTLK)
    [144] = {map = 571,  x = 3600.5,     y = 197.34,     z = -113.76,     o = 5.29905},   -- Ruby Sanctum
    [145] = {map = 530,  x = 820.025,    y = 6864.93,    z = -66.7556,    o = 6.28127},   -- Serpentshrine Cavern
    [146] = {map = 530,  x = 12574.1,    y = -6774.81,   z = 15.0904,     o = 3.13788},   -- Sunwell Plateau
    [147] = {map = 530,  x = 3099.36,    y = 1518.73,    z = 190.3,       o = 4.72592},   -- Tempest Keep
    [148] = {map = 1,    x = -8409.82,   y = 1499.06,    z = 27.7179,     o = 2.51868},   -- The Ruins of Ahn'Qiraj
    [149] = {map = 1,    x = -8240.09,   y = 1991.32,    z = 129.072,     o = 0.941603},  -- The Temple of Ahn'Qiraj
    [150] = {map = 571,  x = 8515.68,    y = 716.982,    z = 558.248,     o = 1.57315},   -- Trial of the Crusader
    [151] = {map = 571,  x = 9049.37,    y = -1282.35,   z = 1060.19,     o = 5.8395},    -- Ulduar
    [152] = {map = 571,  x = 5453.72,    y = 2840.79,    z = 421.28,      o = 0.0},       -- Vault of Archavon

-- Custom
    [153] = {map = 1,    x = 16225.988, y = 16248.773, z = 14.061647,   o = 1.7947958},  -- Guild Hall
    [154] = {map = 800,  x = 6012.925,  y = 1603.3754, z = 34.00426,    o = 4.637557},   -- Isle of Giants
    [155] = {map = 5000, x = -13950,    y = 2877,      z = 9,           o = 1.276430},   -- Morza Island
    [156] = {map = 1,    x = -10737.604,y = 2468.4258, z = 6.3820477,   o = 5.7822013},  -- Silithus Camp
    [157] = {map = 0,    x = -5119.211, y = 4028.4114, z = 51.434544,   o = 0.31480914}, -- Windpeak Island

}


function TeleportSelectorServer.TeleportTo(player, locationId)
    local loc = locations[locationId]
    if loc then
        player:Teleport(loc.map, loc.x, loc.y, loc.z, loc.o or 0)
    else
        player:SendBroadcastMessage("Invalid teleport location.")
    end
end

RegisterCreatureGossipEvent(300300, 1, function(_, player, creature)
    AIO.Handle(player, "TeleportSelectorClient", "ShowTeleportUI")
    player:GossipComplete()
end)
