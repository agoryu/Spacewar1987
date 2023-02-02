extends Timer

var _asteroid_constructor = preload("res://SpaceElements/Asteroid/Asteroid.tscn")

var _safe_range : int = 800

func spawn():
	var asteroid = _asteroid_constructor.instance()
	asteroid.set_as_toplevel(true)
	asteroid.global_position = calc_coordinate()
	
	var direction = FleetManager.player.global_position.angle_to_point(asteroid.global_position)
	asteroid.global_rotation = direction + PI/2
	
	asteroid.set_scale_damage(randi() % 3 + 1)
	
	get_tree().root.add_child(asteroid)

func calc_coordinate() -> Vector2 :
	return FleetManager.player.global_position + Vector2(_safe_range, 0).rotated(rand_range(0, 2 * PI))
