extends Node

signal add_ship
signal add_xp
signal lvl_up
signal game_over
signal loose_ship

var player : Ship
var parent_ally : Node2D

var warning_level = 0
var fleet : Array = []

func add_ship(ship: Ship):
	parent_ally.add_child(ship)
	ship.global_position = (
		player.global_position 
		+ (Vector2.UP * (player.area_collision_radius + ship.area_collision_radius))
	)
	emit_signal("add_ship", ship)

func add_xp(value: int):
	emit_signal("add_xp", value)
	
func loose_ship(ship: Ship):
	emit_signal("loose_ship")

func lvl_up():
	warning_level += 1
	emit_signal("lvl_up")

func game_over():
	emit_signal("game_over")
	
func set_player(ship: Ship):
	player.set_is_player(false)
	player = ship
	player.set_is_player(true)
