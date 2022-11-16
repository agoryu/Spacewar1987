extends Node

signal add_ship
signal add_xp
signal lvl_up

var player : Ship
var parent_ally : Node2D

var warning_level = 0

func add_ship(ship: Ship):
	parent_ally.add_child(ship)
	ship.global_position = (
		player.global_position 
		+ (Vector2.UP * (player.area_collision_radius + ship.area_collision_radius))
	)
	emit_signal("add_ship", ship)

func add_xp(value: int):
	emit_signal("add_xp", value)

func lvl_up():
	warning_level += 1
	emit_signal("lvl_up")
