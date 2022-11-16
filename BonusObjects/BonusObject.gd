extends Area2D

class_name BonusObject

onready var _animation_player : AnimationPlayer = $AnimationPlayer

const DRAG := 14.0
var max_speed := 400.0

var _velocity := Vector2.ZERO
var is_attracted : bool = false

func _physics_process(delta: float):
	var attractors : Array
	if not is_attracted:
		attractors = get_overlapping_areas()
	else:
		attractors = [FleetManager.player]
		max_speed *= 2
		
	if attractors:
		var desired_velocity: Vector2 = (
			(attractors[0].global_position - global_position).normalized() * max_speed
		)
		var steering := desired_velocity - _velocity
		_velocity += steering / DRAG
	else:
		_velocity = Vector2.ZERO
	position += _velocity * delta


func apply_effect(body: Ship):
	_animation_player.play("pickup")
