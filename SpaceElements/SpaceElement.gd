extends KinematicBody2D

class_name SpaceElement

export var drag := 5.0
export var speed = 300.0

var _velocity = Vector2.ZERO
var initial_speed = 300.0

var life : int = 0 setget set_life

func add_damage(damage: int):
	self.life -= damage
	if life <= 0:
		die()
	else:
		impact()

func move_in_direction(direction: Vector2):
	var desired_velocity = direction * speed
	var steering = desired_velocity - _velocity
	_velocity += steering / drag
	_velocity = _velocity.clamped(speed)
	_velocity = move_and_slide(_velocity)
	
func die():
	queue_free()
	
func impact():
	# Implement
	pass

func set_life(value : int):
	life = value
