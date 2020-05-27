--[[
    Made by @Loaf Scripts#7785
    Other scripts by me: https://gta5-store.com/store/loaf
    This script REQUIRES the bowling map made by Breze, https://gta5-store.com/shop/mlo-bowling-hall
    You are *not* allowed to resell/trade/give away this script
]]

Config = {
    ['Bowling'] = {
        ['GetBall'] = vector3(107.60, -1795.77, 27.45),
        ['Cam'] = {
            ['Start'] = vector3(117.04, -1786.41, 29.23),
            ['End'] = vector3(108.26, -1779.13, 27.14),
            ['Fov'] = 65.0
        },
        ['Heading'] = {48.0, 60.0}, -- min heading, max heading
        ['Tracks'] = {
            vector4(101.22, -1787.76, 26.14, 50.2),
            vector4(103.25, -1785.33, 26.14, 50.2),
            vector4(105.04, -1783.17, 26.14, 50.2),
            vector4(107.21, -1780.73, 26.14, 50.2),
            vector4(109.73, -1777.66, 26.14, 50.2),
            vector4(111.77, -1775.22, 26.14, 50.2),
            vector4(113.51, -1773.03, 26.14, 50.2),
            vector4(115.53, -1770.67, 26.14, 50.2)
        },
        ['BowlingPinSets'] = {
            {
                vector3(86.6585, -1776.239, 26.14),
                vector3(86.83975, -1776.024, 26.14),
                vector3(87.01727, -1775.809, 26.14),
                vector3(87.20467, -1775.587, 26.14),
                vector3(87.25916, -1775.813, 26.14),
                vector3(87.31023, -1776.047, 26.14),
                vector3(87.34837, -1776.269, 26.14),
                vector3(87.11907, -1776.258, 26.14),
                vector3(86.89953, -1776.252, 26.14),
                vector3(87.07229, -1776.04, 26.14)
            },
            
            {
                vector3(88.68642, -1773.788, 26.14),
                vector3(88.85713, -1773.589, 26.14),
                vector3(89.03779, -1773.369, 26.14),
                vector3(89.22035, -1773.133, 26.14),
                vector3(89.27628, -1773.371, 26.14),
                vector3(89.33644, -1773.607, 26.14),
                vector3(89.38523, -1773.842, 26.14),
                vector3(88.91372, -1773.814, 26.14),
                vector3(89.15772, -1773.829, 26.14),
                vector3(89.09306, -1773.603, 26.14)
            },

            {
                vector3(90.46119, -1771.626, 26.14),
                vector3(90.64706, -1771.412, 26.14),
                vector3(90.82555, -1771.191, 26.14),
                vector3(91.01556, -1770.967, 26.14),
                vector3(91.08172, -1771.217, 26.14),
                vector3(91.13525, -1771.458, 26.14),
                vector3(91.18863, -1771.703, 26.14),
                vector3(90.72, -1771.649, 26.14),
                vector3(90.94798, -1771.687, 26.14),
                vector3(90.89204, -1771.441, 26.14)
            },

            {
                vector3(92.48643, -1769.192, 26.14),
                vector3(92.67383, -1768.965, 26.14),
                vector3(92.85804, -1768.747, 26.14),
                vector3(93.03439, -1768.531, 26.14),
                vector3(93.10458, -1768.787, 26.14),
                vector3(92.91759, -1769.009, 26.14),
                vector3(92.74084, -1769.226, 26.14),
                vector3(92.98795, -1769.249, 26.14),
                vector3(93.17336, -1769.036, 26.14),
                vector3(93.24885, -1769.276, 26.14)
            },

            {
                vector3(95.08292, -1766.071, 26.14),
                vector3(95.26379, -1765.855, 26.14),
                vector3(95.44389, -1765.636, 26.14),
                vector3(95.62601, -1765.422, 26.14),
                vector3(95.68877, -1765.680, 26.14),
                vector3(95.50967, -1765.9, 26.14),
                vector3(95.32588, -1766.115, 26.14),
                vector3(95.57598, -1766.135, 26.14),
                vector3(95.7626, -1765.931, 26.14),
                vector3(95.78624, -1766.147, 26.14),
            },

            {
                vector3(97.1003, -1763.647, 26.14),
                vector3(97.28828, -1763.423, 26.14),
                vector3(97.47159, -1763.207, 26.14),
                vector3(97.65216, -1762.985, 26.14),
                vector3(97.36129, -1763.679, 26.14),
                vector3(97.53376, -1763.47, 26.14),
                vector3(97.71603, -1763.248, 26.14),
                vector3(97.78146, -1763.476, 26.14),
                vector3(97.61171, -1763.696, 26.14),
                vector3(97.8136, -1763.69, 26.14)
            },

            {
                vector3(98.90438, -1761.483, 26.14),
                vector3(99.08117, -1761.271, 26.14),
                vector3(99.25982, -1761.051, 26.14),
                vector3(99.44587, -1760.826, 26.14),
                vector3(99.52315, -1761.085, 26.14),
                vector3(99.33319, -1761.298, 26.14),
                vector3(99.16653, -1761.518, 26.14),
                vector3(99.40795, -1761.541, 26.14),
                vector3(99.5986, -1761.334, 26.14),
                vector3(99.64442, -1761.559, 26.14)
            },

            {
                vector3(100.9308, -1759.053, 26.14),
                vector3(101.1151, -1758.829, 26.14),
                vector3(101.2827, -1758.624, 26.14),
                vector3(101.473, -1758.398, 26.14),
                vector3(101.5462, -1758.652, 26.14),
                vector3(101.3651, -1758.874, 26.14),
                vector3(101.1859, -1759.082, 26.14),
                vector3(101.4319, -1759.097, 26.14),
                vector3(101.603, -1758.887, 26.14),
                vector3(101.6512, -1759.112, 26.14)
            }
        },

        ['BowlingBalls'] = {
            vector3(-141.0396, -252.3092, 43.82756),
            vector3(-141.1883, -252.7568, 43.82756),
            vector3(-141.2772, -253.1083, 43.82756),
            vector3(-141.4393, -253.4855, 43.82756),
            vector3(-141.4393, -253.4855, 43.5381),
            vector3(-141.2557, -253.0987, 43.5381),
            vector3(-141.1771, -252.7275, 43.5381),
            vector3(-141.0329, -252.2919, 43.5381),
            vector3(-141.0329, -252.2919, 43.22288),
            vector3(-141.1889, -252.734, 43.22288),
            vector3(-141.33, -253.1166, 43.22288),
            vector3(-141.4617, -253.4859, 43.22288)
        },
    },
}

Strings = {
    ['press_start'] = 'Press ~INPUT_PICKUP~ to get a bowling ball',
    ['next_last_select'] = '~INPUT_CELLPHONE_RIGHT~ ~INPUT_CELLPHONE_LEFT~ Browse\n~INPUT_FRONTEND_ENDSCREEN_ACCEPT~ Choose\n~INPUT_FRONTEND_RRIGHT~ Cancel',
    ['bowling_info'] = '~INPUT_CELLPHONE_LEFT~ ~INPUT_CELLPHONE_RIGHT~ Rotate\n~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ Change force\n~INPUT_MOVE_LEFT_ONLY~ ~INPUT_MOVE_RIGHT_ONLY~ Browse cams\n~INPUT_ATTACK~ Throw\n~INPUT_FRONTEND_RRIGHT~ Stop playing',
    ['force'] = 'Power: %s',
    ['strike'] = {'A CONGRATULTIONS, ITS A CELEBRATION', 'YOU GOT A STRIKE!!'},
    ['spare'] = {'Bowling', 'Well played! You got a spare'},
    ['x_pinsdown'] = {'Bowling', 'You got %s out of %s pins'},
    ['this_occupied'] = 'This bowling lane is occupied.',
    ['every_occupied'] = 'Every bowling lane is occupied.',
    ['blip'] = 'Bowling'
}