extends SpaceElement

class_name Weapon

onready var _xp_constructor = preload("res://BonusObjects/XP/XP.tscn")
onready var _root = get_tree().root
onready var _timer : Timer = $Timer
onready var _collision_area : Area2D = $Area2D
onready var _start_audio_player : AudioStreamPlayer2D = $StartAudioPlayer
onready var _finish_audio_player : AudioStreamPlayer2D = $FinishAudioPlayer

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
	if not is_ally_weapon:
		var xp = _xp_constructor.instance()
		xp.global_position = global_position
		xp.set_as_toplevel(true)
		_root.add_child(xp)
	die()
	
func touch(body : SpaceElement):
	body.add_damage(damage_caused)
	die()

func set_is_ally_weapon(value: bool):
	is_ally_weapon = value
	if value:
		set_collision_layer_bit(3, true)
		_collision_area.set_collision_mask_bit(4, true)
		_collision_area.set_collision_mask_bit(5, true)
		_collision_area.set_collision_mask_bit(6, true)
	else:
		set_collision_layer_bit(5, true)
		_collision_area.set_collision_mask_bit(0, true)
		_collision_area.set_collision_mask_bit(1, true)
		_collision_area.set_collision_mask_bit(3, true)
