extends SpaceElement

var is_ally_weapon : bool = false setget set_is_ally_weapon

func end_action():
	pass

func set_is_ally_weapon(value: bool):
	is_ally_weapon = value
	if value:
		set_collision_layer_bit(3, true)
		set_collision_mask_bit(4, true)
		set_collision_mask_bit(5, true)
		set_collision_mask_bit(6, true)
	else:
		set_collision_layer_bit(5, true)
		set_collision_mask_bit(0, true)
		set_collision_mask_bit(1, true)
		set_collision_mask_bit(3, true)
