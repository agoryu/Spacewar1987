extends Weapon

class_name Asteroid

onready var _sprite = $Sprite
onready var _animation_player = $AnimationPlayer
onready var _sprite_tab = [
	preload("res://SpaceElements/Asteroid/asteroidA.png"),
	preload("res://SpaceElements/Asteroid/asteroidB.png"),
	preload("res://SpaceElements/Asteroid/asteroidC.png")
]
var speed_rotation : float
var _life = 1

func _ready():
	speed_rotation = (PI / ((randi() % 5 + 5) * 10)) * (1 if (randi() % 6 < 3) else -1)
	_sprite.texture = _sprite_tab[randi() % 3]
	_animation_player.play("RESET")

func action(delta):
	var direction = Vector2(sin(rotation), -cos(rotation))
	_sprite.rotate(speed_rotation)
	move_and_collide(direction.normalized() * speed * delta)

func _on_VisibilityNotifier2D_screen_exited():
	$Timer.start()

func add_damage(damage: int):
	_life -= damage
	_animation_player.play("impact")
	if damage_caused != 1 and _life <= 0 :
		divide_asteroid()
	if _life <= 0:
		end_action()

func _on_Timer_timeout():
	if not $VisibilityNotifier2D.is_on_screen():
		end_action()

func divide_asteroid():
	for i in range(damage_caused):
		var asteroid = duplicate() as Asteroid
		asteroid.set_scale_damage(1)
		asteroid.global_rotation = global_rotation + 2 * i * PI / damage_caused
		asteroid.set_as_toplevel(true)
		asteroid.global_position = global_position
		get_parent().add_child(asteroid)

func set_scale_damage(value: int):
	damage_caused = value
	scale = Vector2.ONE * value
	_life = value
	
