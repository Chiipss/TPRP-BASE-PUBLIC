Config = {}
Config["debug"] = false -- เปิดปิดโหมดพัฒนา (ใช้เพื่อเปิดคำสั่ง sc_bench)
Config["craft_duration"] = 5 -- เวลาที่ใช้ในการคราฟเริ่มต้น
Config["craft_duration_multiply"] = true -- จะคูณเวลาไหมหากมีการคราฟมากกว่า 1 ชิ้น
Config["craft_duration_max"] = 30 -- กำหนดเวลาคราฟสูงสุดหากเกินกว่าค่า จะถูกตั้งกลับเป็นค่านี้ ตั้งเป็น nil หรือลบบรรทัดนี้ออกหากอยากปลดล็อค
Config["craft_enable_fail"] = true -- เปิดปิดอัตราคราฟล้มเหลว 
Config["craft_cost"] = 100 -- เสียเงินเวลาสร้างไหม ปรับเป็น 0 หากไม่เสีย
Config["craft_table"] = {
	{
		position = {x = 604.62, y = -3082.76, z = 5.0, h = 92.30},
		max_distance = 2.0, -- ระยะที่สามารถใช้โต๊ะได้
		map_blip = true,
		blip_name = "Pachatipad Carft Table"
	},
}

--[[
	ทุกครั้งที่มีการต่อเพิ่มในตารางอย่าลืมใส่ , ที่ปีกกาปิดของอันเก่า
	
	ตัวอย่างการเพิ่ม หมวด
	[1] = { -- ต้องใช้เป็นเลขใหม่ต่อท้ายหมวดเก่า
		name = "หมวดทั่วไป", -- ชื่อหมวด
		animation = { -- เพิ่มอนิเมชั้นเองโดยเปลี่ยนทั้งหมวด ลบหากต้องการใช้แบบธรรมดา
			dict = "world_human_welding",
			anim = "world_human_welding",
			flag = 30
		},
		list = { -- สำหรับเพิ่มไอเทม ต้องใส่ภายในปีกกาเท่านั้น
		}
	}
		
	ตัวอย่างการเพิ่ม ไอเทมลงในหมวด
	{
		item = "cloth", --ชื่อของไอเทม
		fail_chance = 15, --โอกาสที่จะล้มเหลวเวลาคราฟ
		amount = 3, --เมื่อคราฟแล้วจะได้กี่ชิ้น
		cost = 500, -- เพิ่มราคาคราฟ ถ้าไม่มีจะยึดจาก Config["craft_cost"]
		
		craft_duration = 10, -- สำหรับปรับเวลาที่จะใช้คราฟของชิ้นนี้
		
		animation = { -- เพิ่มอนิเมชั้นเองโดยเปลี่ยนแค่ชิ้นนี้ สามารถลบออกได้ถ้าไม่ต้องการ
			dict = "mp_player_inteat@burger",
			anim = "mp_player_int_eat_burger",
			flag = 30
		},
		
		equipment = { -- ถ้าต้องมีอุปกรณ์บางชิ้นก่อนถึงใส่ได้ให้เพิ่ม ถ้าไม่มีให้ลบออก
			["scissors"] = true, -- => true คือ เปิด false คือปิด
			["pro_wood"] = false -- ทั้งหมดหมายความว่าต้องการแค่กรรไกรในการคราฟ
		},
		
		blueprint = { -- ลิสของที่ต้องการ => ["ชื่อของไอเทม"] = @จำนวนที่ใช้
			["leather"] = 1, -- => หนังสัตว์ 1 ชิ้น
			["wood"] = 2 -- => ไม้ 2 ท่อน
		},
	},
]]

Config["category"] = {
	[1] = {
		name = "General raw materials",
		list = {
			{
				item = "water",
				fail_chance = 50,
				amount = 1,
				cost = 300,
				craft_duration = 10,
				blueprint = {
					["bread"] = 10,
					--["wood"] = 5,
				},
				equipment = {
					["WEAPON_WRENCH"] = true,
					-- ["wood"] = true,
				},
				
			},
		{
				item = "fixkit",
				fail_chance = 20,
				amount = 1,
				cost = 300,
				craft_duration = 10,
				blueprint = {
					["SteelScrap"] = 50,
					["wood"] = 3,
				},
				equipment = {
					["SteelScrap"] = true,
					["wood"] = true,
				},
				
			},
		{
				item = "bread",
				fail_chance = 20,
				amount = 1,
				cost = 300,
				craft_duration = 10,
				blueprint = {
					["SteelScrap"] = 9,
				},
				equipment = {
					["SteelScrap"] = true,
				},
				
			},
		{
				item = "beef",
				fail_chance = 50,
				amount = 1,
				cost = 300,
				craft_duration = 10,
				blueprint = {
					["rubber_pack"] = 5,
					["wood"] = 3,
				},
				equipment = {
					["rubber_pack"] = true,
					["wood"] = true,
				},
				
			},
		}
	},
	[2] = {
		name = "Drug category",
		list = {
		{
				item = "coke_pooch",
				fail_chance = 30,
				amount = 1,
				cost = 300,
				craft_duration = 10,
				blueprint = {
					["coke_pooch"] = 1,
					["meth_pooch"] = 1,
					["honey_a"] = 1,
				},
				equipment = {
					["coke_pooch"] = true,
					["meth_pooch"] = true,
					["honey_a"] = true,
				},
				
			},
		{
				item = "weed_pooch",
				fail_chance = 30,
				amount = 1,
				cost = 300,
				craft_duration = 10,
				blueprint = {
					["cigarett"] = 2,
					["weed_pooch"] = 1,
				},
				equipment = {
					["cigarett"] = true,
					["weed_pooch"] = true,
				},
				
				
			},
		
		}
		
	},
	[3] = {
		name = "ingredient",
		list = {
		{
				item = "iron",
				fail_chance = 85,
				amount = 1,
				cost = 500,
				craft_duration = 10,
				blueprint = {
					["steel"] = 10,
					["diamond"] = 4,
					["gold"] = 10,
					["leather"] = 5,
					["fixkit"] = 1,
					["pro_wood"] = 10,
				},
				equipment = {
					["steel"] = true,
					["diamond"] = true,
					["gold"] = true,
					["leather"] = true,
					["fixkit"] = true,
					["pro_wood"] = true,
				},
				
			},
		{
				item = "Meat",
				fail_chance = 98,
				amount = 1,
				cost = 500,
				craft_duration = 10,
				blueprint = {
					["steel"] = 7,
					["diamond"] = 2,
					["leather"] = 4,
					["iron"] = 15,
					["fixkit"] = 1,
					["pro_wood"] = 7,
				},
				equipment = {
					["steel"] = true,
					["diamond"] = true,
					["leather"] = true,
					["iron"] = true,
					["fixkit"] = true,
					["pro_wood"] = true,
				},
				
			},
		
		{
				item = "gunpowder",
				fail_chance = 98,
				amount = 1,
				cost = 500,
				craft_duration = 10,
				blueprint = {
					["steel"] = 13,
					["diamond"] = 2,
					["pro_wood"] = 10,
					["leather"] = 2,
					["fixkit"] = 2,
				},
				equipment = {
				    ["steel"] = true,
					["diamond"] = true,
					["pro_wood"] = true,
					["leather"] = true,
					["fixkit"] = true,
				},
				
				
			},
		{
				item = "parts4",
				fail_chance = 82,
				amount = 1,
				cost = 500,
				craft_duration = 10,
				blueprint = {
					["steel"] = 25,
					["diamond"] = 6,
					["iron"] = 15,
					["gold"] = 15,
					["fixkit"] = 3,
				},
				equipment = {
				    ["steel"] = true,
					["diamond"] = true,
					["iron"] = true,
					["gold"] = true,
					["fixkit"] = true,
				},
				
			},
		
		{
				item = "parts5",
				fail_chance = 75,
				amount = 1,
				cost = 500,
				craft_duration = 10,
				blueprint = {
					["steel"] = 7,
					["diamond"] = 1,
					["pro_wood"] = 10,
					["gold"] = 15,
					["fixkit"] = 1,
				},
				equipment = {
				    ["steel"] = true,
					["diamond"] = true,
					["pro_wood"] = true,
					["gold"] = true,
					["fixkit"] = true,
				},
				
			},
		
		}
	},
	[4] = {
		name = "Normal weapon category",
		list = {
			{
				item = "weapon_SWITCHBLADE",
				fail_chance = 93,
				amount = 1,
				cost = 1000,
				craft_duration = 10,
				blueprint = {
					["steel"] = 10,
					["diamond"] = 3,
					["fixkit"] = 1,
				},
				equipment = {
					["steel"] = true,
					["diamond"] = true,
					["fixkit"] = true,
				},

				
			},
		{
				item = "weapon_KNIFE",
				fail_chance = 85,
				amount = 1,
				cost = 1000,
				craft_duration = 10,
				blueprint = {
					["steel"] = 10,
					["diamond"] = 1,
					["wood"] = 10,
				},
				equipment = {
					["steel"] = true,
					["diamond"] = true,
					["wood"] = true,
				},
				
			},
		
		},
	},
	[5] = {
		name = "Premium weapons category",
		list = {
		{
				item = "weapon_SMG",
				fail_chance = 60,
				amount = 1,
				cost = 10000,
				craft_duration = 10,
				blueprint = {
					["parts1"] = 1,
					["parts2"] = 1,
					["parts3"] = 1,
					["parts4"] = 1,
					["parts5"] = 1,
				},
				equipment = {
					["parts1"] = true,
					["parts2"] = true,
					["parts3"] = true,
					["parts4"] = true,
					["parts5"] = true,
				},
				
			},
		},
	}
}
Config["translate"] = {
	you_crafted = "You have created %d pieces of %d !",
	not_enough = "Insufficient components",
	not_enough2 = "Please prepare the components",
	you_blow = "You failed to create %s",
	no_equipment = "You don't have equipment",
	no_equipment2 = "This equipment is required to craft.",
	no_money = "insufficient funds",
	no_money2 = "You need $ %s in crafting"
}