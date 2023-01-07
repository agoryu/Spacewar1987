extends Weapon

class_name LaserShoot

func action(delta : float):
	var direction = Vector2(sin(rotation), -cos(rotation))
	move_and_collide(direction.normalized() * speed * delta)
	
func end_action():
	.end_action()
