extends KinematicBody2D

class_name SpaceElement

export var drag := 5.0

var _velocity = Vector2.ZERO
var initial_speed = 300.0
var speed = 300.0

func move_in_direction(direction: Vector2):
	var desired_velocity = direction * speed
	var steering = desired_velocity - _velocity
	_velocity += steering / drag
	_velocity = _velocity.clamped(speed)
	_velocity = move_and_slide(_velocity)
	
