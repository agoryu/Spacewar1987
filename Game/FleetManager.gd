extends Node

signal lvl_up
signal add_ship

var player : Ship
var parent_ally : Node2D

func add_ship(ship: Ship):
	parent_ally.add_child(ship)
	ship.global_position = (
		player.global_position 
		+ (Vector2.UP * (player.area_collision_radius + ship.area_collision_radius))
	)
	emit_signal("add_ship", ship)
