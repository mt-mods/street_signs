-- node definitions

local S = street_signs.gettext

street_signs.lbm_restore_nodes = {}

local cbox = {
	type = "fixed",
	fixed = {
		{ -1/32, 23/16, -1/32, 1/32, 24/16, 1/32 },
		{ -1/32, 18/16, -8/16, 1/32, 23/16, 8/16 },
		{ -1/32, 17/16, -1/32, 1/32, 18/16, 1/32 },
		{ -8/16, 12/16, -1/32, 8/16, 17/16, 1/32 },
		{ -1/16, -8/16, -1/16, 1/16, 12/16, 1/16 },
	}
}

local stdyaw = {
	0,
	math.pi / -2,
	math.pi,
	math.pi / 2,
}

local wmyaw = {
	nil,
	nil,
	math.pi / -2,
	math.pi / 2,
	0,
	math.pi,
}

local on_construct =function(pos) 
	street_signs.construct_sign(pos)
end
local on_destruct = function(pos)
	street_signs.destruct_sign(pos)
end
local on_receive_fields = function(pos, formname, fields, sender)
	street_signs.receive_fields(pos, formname, fields, sender)
end
local on_punch = function(pos, node, puncher)
	street_signs.update_sign(pos)
end

table.insert(street_signs.lbm_restore_nodes, "street_signs:sign_basic")
table.insert(street_signs.lbm_restore_nodes, "street_signs:sign_basic_top_only")

minetest.register_node("street_signs:sign_basic", {
	description = "D3-1a: Generic intersection street name sign",
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	drawtype = "mesh",
	node_box = cbox,
	selection_box = cbox,
	mesh = "street_signs_basic.obj",
	tiles = { "street_signs_basic.png" },
	groups = {choppy=2, dig_immediate=2},
	default_color = "f",
	on_construct = on_construct,
	on_destruct = on_destruct,
	on_receive_fields = on_receive_fields,
	on_punch = on_punch,
	on_rotate = street_signs.facedir_rotate,
	number_of_lines = 2,
	horiz_scaling = 1,
	vert_scaling = 1,
	line_spacing = 6,
	font_size = 15,
	x_offset = 1,
	y_offset = 3,
	chars_per_line = 30,
	entity_info = {
		mesh = "street_signs_basic_entity.obj",
		yaw = stdyaw
	}
})

cbox = {
	type = "fixed",
	fixed = {
		{ -1/32,  7/16, -1/32, 1/32,  8/16, 1/32 },
		{ -1/32,  2/16, -8/16, 1/32,  7/16, 8/16 },
		{ -1/32,  1/16, -1/32, 1/32,  2/16, 1/32 },
		{ -8/16, -4/16, -1/32, 8/16,  1/16, 1/32 },
		{ -1/16, -8/16, -1/16, 1/16, -4/16, 1/16 },

	}
}

minetest.register_node("street_signs:sign_basic_top_only", {
	description = "D3-1a: Generic intersection street name sign (top only)",
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	drawtype = "mesh",
	node_box = cbox,
	selection_box = cbox,
	mesh = "street_signs_basic_top_only.obj",
	tiles = { "street_signs_basic.png" },
	groups = {choppy=2, dig_immediate=2},
	default_color = "f",
	on_construct = on_construct,
	on_destruct = on_destruct,
	on_receive_fields = on_receive_fields,
	on_punch = on_punch,
	on_rotate = street_signs.facedir_rotate,
	number_of_lines = 2,
	horiz_scaling = 1,
	vert_scaling = 1,
	line_spacing = 6,
	font_size = 15,
	x_offset = 1,
	y_offset = 3,
	chars_per_line = 30,
	entity_info = {
		mesh = "street_signs_basic_top_only_entity.obj",
		yaw = stdyaw
	}
})

for _, c in ipairs(street_signs.big_sign_colors) do

	cbox = {
		type = "wallmounted",
		wall_side = { -0.5, -0.4375, -0.4375, -0.375, 0.4375, 1.4375 }
	}

	local color = c[1]
	local defc = c[2]

	table.insert(street_signs.lbm_restore_nodes, "street_signs:sign_highway_small_"..color)
	table.insert(street_signs.lbm_restore_nodes, "street_signs:sign_highway_medium_"..color)
	table.insert(street_signs.lbm_restore_nodes, "street_signs:sign_highway_large_"..color)

	minetest.register_node("street_signs:sign_highway_small_"..color, {
		description = "Small generic highway sign (3-line, "..color..")",
		inventory_image = "street_signs_highway_small_"..color.."_inv.png",
		wield_image = "street_signs_highway_small_"..color.."_inv.png",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_highway_small.obj",
		tiles = { "street_signs_highway_small_"..color..".png" },
		default_color = defc,
		groups = {choppy=2, dig_immediate=2},
		on_construct = on_construct,
		on_destruct = on_destruct,
		on_receive_fields = on_receive_fields,
		on_punch = on_punch,
		on_rotate = street_signs.wallmounted_rotate,
		number_of_lines = 3,
		horiz_scaling = 2,
		vert_scaling = 1.15,
		line_spacing = 2,
		font_size = 31,
		x_offset = 9,
		y_offset = 7,
		chars_per_line = 22,
		entity_info = {
			mesh = "street_signs_highway_small_entity.obj",
			yaw = wmyaw
		}
	})
	cbox = {
		type = "wallmounted",
		wall_side = { -0.5, -0.4375, -0.4375, -0.375, 1.4375, 1.4375 }
	}

	minetest.register_node("street_signs:sign_highway_medium_"..color, {
		description = "Medium generic highway sign (5-line, "..color..")",
		inventory_image = "street_signs_highway_medium_"..color.."_inv.png",
		wield_image = "street_signs_highway_medium_"..color.."_inv.png",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_highway_medium.obj",
		tiles = { "street_signs_highway_medium_"..color..".png" },
		default_color = defc,
		groups = {choppy=2, dig_immediate=2},
		on_construct = on_construct,
		on_destruct = on_destruct,
		on_receive_fields = on_receive_fields,
		on_punch = on_punch,
		on_rotate = street_signs.wallmounted_rotate,
		number_of_lines = 6,
		horiz_scaling = 2,
		vert_scaling = 0.915,
		line_spacing = 2,
		font_size = 31,
		x_offset = 7,
		y_offset = 10,
		chars_per_line = 22,
		entity_info = {
			mesh = "street_signs_highway_medium_entity.obj",
			yaw = wmyaw
		}
	})

	cbox = {
		type = "wallmounted",
		wall_side = { -0.5, -0.4375, -0.4375, -0.375, 1.4375, 2.4375 }
	}

	minetest.register_node("street_signs:sign_highway_large_"..color, {
		description = "Large generic highway sign (5-line, "..color..")",
		inventory_image = "street_signs_highway_large_"..color.."_inv.png",
		wield_image = "street_signs_highway_large_"..color.."_inv.png",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_highway_large.obj",
		tiles = { "street_signs_highway_large_"..color..".png" },
		default_color = defc,
		groups = {choppy=2, dig_immediate=2},
		on_construct = on_construct,
		on_destruct = on_destruct,
		on_receive_fields = on_receive_fields,
		on_punch = on_punch,
		on_rotate = street_signs.wallmounted_rotate,
		number_of_lines = 6,
		horiz_scaling = 2,
		vert_scaling = 0.915,
		line_spacing = 2,
		font_size = 31,
		x_offset = 12,
		y_offset = 11,
		chars_per_line = 25,
		entity_info = {
			mesh = "street_signs_highway_large_entity.obj",
			yaw = wmyaw
		}
	})
end

local after_place_node = function(pos, placer, itemstack, pointed_thing)
	local ppos = minetest.get_pointed_thing_position(pointed_thing)
	local pnode = minetest.get_node(ppos)
	local pdef = minetest.registered_items[pnode.name]
	if (pdef and pdef.drawtype == "fencelike")
	  or string.find(pnode.name, "default:fence_")
	  or pnode.name == "coloredwood:fence"
	  or (pnode.name == "streets:bigpole" and pnode.param2 < 4)
	  or (pnode.name == "streets:bigpole" and pnode.param2 > 19 and pnode.param2 < 24) then
		local node = minetest.get_node(pos)
		minetest.swap_node(pos, {name = itemstack:get_name().."_onpole", param2 = node.param2})
	end
end

local function shift_to_pole(t, m)
	if m ~= "" then
		return {
			type = "wallmounted",
			wall_side = { t[1] - 0.3125, t[2], t[3], t[4] - 0.3125, t[5], t[6] },
			wall_top = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5 },
			wall_bottom = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5 },
		}
	else
		return {
			type = "wallmounted",
			wall_side = t,
			wall_top = { t[3], -t[1], t[2], t[6], -t[4], t[5] },
			wall_bottom = { t[3], t[1], t[2], t[6], t[4], t[5] }
		}
	end
end


for _, m in ipairs({"", "_onpole"}) do

	cbox = shift_to_pole({ -0.5, -0.46, -0.46, -0.4375, 0.46, 0.46 }, m)

	local nci = nil
	local on_rotate = street_signs.wallmounted_rotate
	local pole_mount_tex = nil

	if m ~= "" then
		nci = 1
		on_rotate = nil
		pole_mount_tex = "street_signs_pole_mount.png"
	end

	table.insert(street_signs.lbm_restore_nodes, "street_signs:sign_us_route"..m)
	table.insert(street_signs.lbm_restore_nodes, "street_signs:sign_us_interstate"..m)

	minetest.register_node("street_signs:sign_us_route"..m, {
		description = "M1-4: Generic \"US Route\" sign",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_regulatory_36x36"..m..".obj",
		tiles = { "street_signs_us_route.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_us_route_inv.png",
		wield_image = "street_signs_us_route_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		on_construct = on_construct,
		on_destruct = on_destruct,
		after_place_node = after_place_node,
		on_receive_fields = on_receive_fields,
		on_punch = on_punch,
		on_rotate = on_rotate,
		number_of_lines = 1,
		horiz_scaling = 3.5,
		vert_scaling = 1.4,
		line_spacing = 6,
		font_size = 31,
		x_offset = 8,
		y_offset = 11,
		chars_per_line = 3,
		entity_info = {
			mesh = "street_signs_regulatory_36x36_entity"..m..".obj",
			yaw = wmyaw
		},
		drop = "street_signs:sign_us_route"
	})

	minetest.register_node("street_signs:sign_us_interstate"..m, {
		description = "M1-1: Generic US Interstate sign",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_interstate_shield"..m..".obj",
		tiles = { "street_signs_us_interstate.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_us_interstate_inv.png",
		wield_image = "street_signs_us_interstate_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "f",
		on_construct = on_construct,
		on_destruct = on_destruct,
		after_place_node = after_place_node,
		on_receive_fields = on_receive_fields,
		on_punch = on_punch,
		on_rotate = on_rotate,
		number_of_lines = 1,
		horiz_scaling = 4.3,
		vert_scaling = 1.4,
		line_spacing = 6,
		font_size = 31,
		x_offset = 8,
		y_offset = 14,
		chars_per_line = 3,
		entity_info = {
			mesh = "street_signs_interstate_shield_entity"..m..".obj",
			yaw = wmyaw
		},
		drop = "street_signs:sign_us_interstate"
	})

	cbox = shift_to_pole({ -0.5, -0.5, -0.5, -0.4375, 0.5, 0.5 }, m)

	table.insert(street_signs.lbm_restore_nodes, "street_signs:sign_warning_3_line"..m)
	table.insert(street_signs.lbm_restore_nodes, "street_signs:sign_warning_4_line"..m)
	table.insert(street_signs.lbm_restore_nodes, "street_signs:sign_warning_orange_3_line"..m)
	table.insert(street_signs.lbm_restore_nodes, "street_signs:sign_warning_orange_4_line"..m)

	minetest.register_node("street_signs:sign_warning_3_line"..m, {
		description = "W3-4: Generic US diamond \"warning\" sign (3-line, yellow)",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning_36x36"..m..".obj",
		tiles = { "street_signs_warning.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_warning_3_line_inv.png",
		wield_image = "street_signs_warning_3_line_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		on_construct = on_construct,
		on_destruct = on_destruct,
		after_place_node = after_place_node,
		on_receive_fields = on_receive_fields,
		on_punch = on_punch,
		on_rotate = on_rotate,
		number_of_lines = 3,
		horiz_scaling = 1.75,
		vert_scaling = 1.75,
		line_spacing = 1,
		font_size = 15,
		x_offset = 6,
		y_offset = 19,
		chars_per_line = 15,
		entity_info = {
			mesh = "street_signs_warning_36x36_entity"..m..".obj",
			yaw = wmyaw
		},
		drop = "street_signs:sign_warning_3_line"
	})

	minetest.register_node("street_signs:sign_warning_4_line"..m, {
		description = "W23-2: Generic US diamond \"warning\" sign (4-line, yellow)",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning_36x36"..m..".obj",
		tiles = { "street_signs_warning.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_warning_4_line_inv.png",
		wield_image = "street_signs_warning_4_line_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		on_construct = on_construct,
		on_destruct = on_destruct,
		after_place_node = after_place_node,
		on_receive_fields = on_receive_fields,
		on_punch = on_punch,
		on_rotate = on_rotate,
		number_of_lines = 4,
		horiz_scaling = 1.75,
		vert_scaling = 1.75,
		line_spacing = 1,
		font_size = 15,
		x_offset = 6,
		y_offset = 25,
		chars_per_line = 15,
		entity_info = {
			mesh = "street_signs_warning_36x36_entity"..m..".obj",
			yaw = wmyaw
		},
		drop = "street_signs:sign_warning_4_line"
	})

	minetest.register_node("street_signs:sign_warning_orange_3_line"..m, {
		description = "W3-4: Generic US diamond \"warning\" sign (3-line, orange)",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning_36x36"..m..".obj",
		tiles = { "street_signs_warning_orange.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_warning_orange_3_line_inv.png",
		wield_image = "street_signs_warning_orange_3_line_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		on_construct = on_construct,
		on_destruct = on_destruct,
		after_place_node = after_place_node,
		on_receive_fields = on_receive_fields,
		on_punch = on_punch,
		on_rotate = on_rotate,
		number_of_lines = 3,
		horiz_scaling = 1.75,
		vert_scaling = 1.75,
		line_spacing = 1,
		font_size = 15,
		x_offset = 6,
		y_offset = 19,
		chars_per_line = 15,
		entity_info = {
			mesh = "street_signs_warning_36x36_entity"..m..".obj",
			yaw = wmyaw
		},
		drop = "street_signs:sign_warning_orange_3_line"
	})

	minetest.register_node("street_signs:sign_warning_orange_4_line"..m, {
		description = "W23-2: Generic US diamond \"warning\" sign (4-line, orange)",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning_36x36"..m..".obj",
		tiles = { "street_signs_warning_orange.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_warning_orange_4_line_inv.png",
		wield_image = "street_signs_warning_orange_4_line_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		on_construct = on_construct,
		on_destruct = on_destruct,
		after_place_node = after_place_node,
		on_receive_fields = on_receive_fields,
		on_punch = on_punch,
		on_rotate = on_rotate,
		number_of_lines = 4,
		horiz_scaling = 1.75,
		vert_scaling = 1.75,
		line_spacing = 1,
		font_size = 15,
		x_offset = 6,
		y_offset = 25,
		chars_per_line = 15,
		entity_info = {
			mesh = "street_signs_warning_36x36_entity"..m..".obj",
			yaw = wmyaw
		},
		drop = "street_signs:sign_warning_orange_4_line"
	})

	cbox = shift_to_pole({ -0.5, -0.47, -0.4, -0.4375, 0.47, 0.4 }, m)

	table.insert(street_signs.lbm_restore_nodes, "street_signs:sign_speed_limit"..m)

	minetest.register_node("street_signs:sign_speed_limit"..m, {
		description = "R2-1: Generic speed limit sign",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_regulatory_30x36"..m..".obj",
		tiles = { "street_signs_speed_limit.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_speed_limit_inv.png",
		wield_image = "street_signs_speed_limit_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		on_construct = on_construct,
		on_destruct = on_destruct,
		after_place_node = after_place_node,
		on_receive_fields = on_receive_fields,
		on_punch = on_punch,
		on_rotate = on_rotate,
		number_of_lines = 1,
		horiz_scaling = 2.65,
		vert_scaling = 2.3,
		line_spacing = 1,
		font_size = 31,
		x_offset = 8,
		y_offset = 37,
		chars_per_line = 4,
		entity_info = {
			mesh = "street_signs_regulatory_30x36_entity"..m..".obj",
			yaw = wmyaw
		},
		drop = "street_signs:sign_speed_limit"
	})

-- below this point are image-only signs (i.e. no user-input)

	cbox = shift_to_pole({ -0.5, -0.5, -0.5, -0.4375, 0.5, 0.5 }, m)

	minetest.register_node("street_signs:sign_stop"..m, {
		description = "R1-1: Stop sign",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_stop"..m..".obj",
		tiles = { "street_signs_stop.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_stop_inv.png",
		wield_image = "street_signs_stop_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_stop"
	})

	cbox = shift_to_pole({ -0.5, -0.61, -0.61, -0.4375, 0.61, 0.61 }, m)

	minetest.register_node("street_signs:sign_yield"..m, {
		description = "R1-2: Yield sign",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_yield"..m..".obj",
		tiles = { "street_signs_yield.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_yield_inv.png",
		wield_image = "street_signs_yield_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_yield"
	})

	cbox = shift_to_pole({ -0.5, -0.5, -0.5, -0.4375, 0.5, 0.5 }, m)

	minetest.register_node("street_signs:sign_pedestrian_crossing"..m, {
		description = "W11-2: Pedestrian crossing sign",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning_36x36"..m..".obj",
		tiles = { "street_signs_pedestrian_crossing.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_pedestrian_crossing_inv.png",
		wield_image = "street_signs_pedestrian_crossing_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_pedestrian_crossing"
	})

	minetest.register_node("street_signs:sign_signal_ahead"..m, {
		description = "W3-3: Traffic signal ahead",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning_36x36"..m..".obj",
		tiles = { "street_signs_signal_ahead.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_signal_ahead_inv.png",
		wield_image = "street_signs_signal_ahead_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_signal_ahead"
	})

	minetest.register_node("street_signs:sign_stop_ahead"..m, {
		description = "W3-1: Stop sign ahead",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning_36x36"..m..".obj",
		tiles = { "street_signs_stop_ahead.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_stop_ahead_inv.png",
		wield_image = "street_signs_stop_ahead_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_stop_ahead"
	})

	minetest.register_node("street_signs:sign_yield_ahead"..m, {
		description = "W3-2: Yield sign ahead",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning_36x36"..m..".obj",
		tiles = { "street_signs_yield_ahead.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_yield_ahead_inv.png",
		wield_image = "street_signs_yield_ahead_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_yield_ahead"
	})

	minetest.register_node("street_signs:sign_merging_traffic"..m, {
		description = "W4-1: Traffic merging from right sign",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning_36x36"..m..".obj",
		tiles = { "street_signs_merging_traffic.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_merging_traffic_inv.png",
		wield_image = "street_signs_merging_traffic_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_merging_traffic"
	})

	minetest.register_node("street_signs:sign_two_way_traffic"..m, {
		description = "W6-3: Two-way traffic sign",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning_36x36"..m..".obj",
		tiles = { "street_signs_two_way_traffic.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_two_way_traffic_inv.png",
		wield_image = "street_signs_two_way_traffic_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_two_way_traffic"
	})

	minetest.register_node("street_signs:sign_left_lane_ends"..m, {
		description = "W4-2: Left lane ends sign",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning_36x36"..m..".obj",
		tiles = { "street_signs_left_lane_ends.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_left_lane_ends_inv.png",
		wield_image = "street_signs_left_lane_ends_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_left_lane_ends"
	})

	minetest.register_node("street_signs:sign_right_lane_ends"..m, {
		description = "W4-2: Right lane ends sign",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning_36x36"..m..".obj",
		tiles = { "street_signs_right_lane_ends.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_right_lane_ends_inv.png",
		wield_image = "street_signs_right_lane_ends_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_right_lane_ends"
	})

	cbox = shift_to_pole({ -0.5, -0.47, -0.4, -0.4375, 0.47, 0.4 }, m)

	minetest.register_node("street_signs:sign_left_on_green_arrow_only"..m, {
		description = "R10-5: Left on green arrow only sign",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_regulatory_30x36"..m..".obj",
		tiles = { "street_signs_left_on_green_arrow_only.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_left_on_green_arrow_only_inv.png",
		wield_image = "street_signs_left_on_green_arrow_only_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		after_place_node = after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_left_on_green_arrow_only"
	})

	cbox = shift_to_pole({ -0.5, -0.47, -0.32, -0.4375, 0.47, 0.32 }, m)

	minetest.register_node("street_signs:sign_stop_here_on_red"..m, {
		description = "R10-6: Stop here on red sign",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_regulatory_24x36"..m..".obj",
		tiles = { "street_signs_stop_here_on_red.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_stop_here_on_red_inv.png",
		wield_image = "street_signs_stop_here_on_red_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		after_place_node = after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_stop_here_on_red"
	})

	cbox = shift_to_pole({ -0.5, -0.47, -0.4, -0.4375, 0.47, 0.4 }, m)

	minetest.register_node("street_signs:sign_left_turn_yield_on_green_light"..m, {
		description = "R10-12: Left turn yield on green light",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_regulatory_30x36"..m..".obj",
		tiles = { "street_signs_left_turn_yield_on_green_light.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_left_turn_yield_on_green_light_inv.png",
		wield_image = "street_signs_left_turn_yield_on_green_light_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		after_place_node = after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_left_turn_yield_on_green_light"
	})

	cbox = shift_to_pole({ -0.5, -0.47, -0.4, -0.4375, 0.47, 0.4 }, m)

	minetest.register_node("street_signs:sign_crosswalk_stop_on_red_light"..m, {
		description = "R10-23: Crosswalk: stop on red light",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_regulatory_24x30"..m..".obj",
		tiles = { "street_signs_crosswalk_stop_on_red_light.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_crosswalk_stop_on_red_light_inv.png",
		wield_image = "street_signs_crosswalk_stop_on_red_light_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		after_place_node = after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_crosswalk_stop_on_red_light"
	})


	cbox = shift_to_pole({ -0.5, -0.625, -0.47, -0.4375, 0.625, 0.47 }, m)

	minetest.register_node("street_signs:sign_keep_right"..m, {
		description = "R4-7: Keep right sign",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_regulatory_36x48"..m..".obj",
		tiles = { "street_signs_keep_right.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_keep_right_inv.png",
		wield_image = "street_signs_keep_right_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		after_place_node = after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_keep_right"
	})

	minetest.register_node("street_signs:sign_keep_left"..m, {
		description = "R4-8: Keep left sign",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_regulatory_36x48"..m..".obj",
		tiles = { "street_signs_keep_left.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_keep_left_inv.png",
		wield_image = "street_signs_keep_left_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		after_place_node = after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_keep_left"
	})

	cbox = shift_to_pole({ -0.5, -0.46, -0.46, -0.4375, 0.46, 0.46 }, m)

	minetest.register_node("street_signs:sign_do_not_enter"..m, {
		description = "R5-1: Do not enter sign",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_regulatory_36x36"..m..".obj",
		tiles = {
			"street_signs_do_not_enter.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_do_not_enter_inv.png",
		wield_image = "street_signs_do_not_enter_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		after_place_node = after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_do_not_enter"
	})

	cbox = shift_to_pole({ -0.5, -0.4, -0.5625, -0.4375, 0.4, 0.5625 }, m)

	minetest.register_node("street_signs:sign_wrong_way"..m, {
		description = "R5-1a: Wrong way sign",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_regulatory_42x30"..m..".obj",
		tiles = { "street_signs_wrong_way.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_wrong_way_inv.png",
		wield_image = "street_signs_wrong_way_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		after_place_node = after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_wrong_way"
	})

	cbox = shift_to_pole({ -0.5, -0.55, -0.5, -0.4375, 0.55, 0.5 }, m)

	minetest.register_node("street_signs:use_lane_with_green_arrow"..m, {
		description = "R10-8: Use lane with green arrow",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_regulatory_36x42"..m..".obj",
		tiles = { "street_signs_use_lane_with_green_arrow.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_use_lane_with_green_arrow_inv.png",
		wield_image = "street_signs_use_lane_with_green_arrow_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		after_place_node = after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:use_lane_with_green_arrow"
	})

	cbox = shift_to_pole({ -0.5, -0.625, -0.47, -0.4375, 0.625, 0.47 }, m)

	minetest.register_node("street_signs:no_turn_on_red_light"..m, {
		description = "R10-11: No turn on red light",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_regulatory_36x48"..m..".obj",
		tiles = { "street_signs_no_turn_on_red_light.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_no_turn_on_red_light_inv.png",
		wield_image = "street_signs_no_turn_on_red_light_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		after_place_node = after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:no_turn_on_red_light"
	})

end

cbox = {
	type = "fixed",
	fixed = { -0.1875, -0.5, -0.25, 0.1875, 0.6125, 0.25 }
}

minetest.register_node("street_signs:sign_stop_for_ped", {
	description = "R1-6a: Stop for pedestrian in crosswalk sign",
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	drawtype = "mesh",
	node_box = cbox,
	selection_box = cbox,
	mesh = "street_signs_stop_for_ped.obj",
	tiles = { "street_signs_stop_for_ped.png" },
	inventory_image = "street_signs_stop_for_ped_inv.png",
	groups = {choppy=2, dig_immediate=2},
})

for _, d in ipairs({"l", "c", "r"}) do

	cbox = {
		type = "wallmounted",
		wall_side = { -0.5, -0.5, -0.1875, -0.4375, 0.5, 0.1875 }
	}

	minetest.register_node("street_signs:sign_object_marker_type3_"..d, {
		description = "OM3-"..string.upper(d)..": Type 3 object marker",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_object_marker_type_3.obj",
		tiles = { "street_signs_object_marker_type3_"..d..".png",
			"street_signs_sign_edge.png"
		},
		inventory_image = "street_signs_object_marker_type3_"..d.."_inv.png",
		groups = {choppy=2, dig_immediate=2},
	})
end
