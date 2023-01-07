extends SpaceElement

class_name Weapon

onready var _timer : Timer = $Timer

export var range_value : int = 3

var is_stop = false
var is_ally_weapon : bool = false setget set_is_ally_weapon
var damage_caused : int = 1

func _ready():
	_timer.wait_time = range_value
	_timer.start()

func _physics_process(delta : float):
	if not is_stop:
		action(delta)
	
func action(delta : float):
	pass

func end_action():
	queue_free()

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
