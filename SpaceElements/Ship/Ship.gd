extends SpaceElement

class_name Ship

signal set_life
signal set_shield
signal set_level

export var is_player : bool
export var is_enemie : bool
export var is_stop : bool = false
export var ship_info : Resource

onready var _animation_player : AnimationPlayer = $AnimationPlayer
onready var _action_timer : Timer = $ActionTimer
onready var _sprite : Sprite = $Sprite
onready var _shield : Sprite = $Shield
onready var _weapons : Node = $Weapons
onready var area_collision_radius : int = $Area/CollisionShape2D.shape.radius

const MAX_LVL : int = 10
const MOVE_THRESHOLD : int = 20

#Stats
var lvl : int = 0 setget set_lvl
var max_life : int = 0
var power : int = 0
var area_zone_fleet : int = 0
var crit_ratio : int = 0
var shield : int = 0 setget set_shield
var energy_consume : int = 0
var energy_container : int = 0

var time_after_collision : int = 0
var is_invincible : bool = false setget set_is_invincible

func _ready():
	init_data()
	_action_timer.start()
	if not is_player:
		_animation_player.play("spawn")
	else:
		set_is_player(true)
		
func init_data():
	ship_info = ship_info as ShipResource
	max_life = ship_info.life
	life = max_life
	power = ship_info.power
	area_zone_fleet = ship_info.area_zone_fleet
	initial_speed = ship_info.initial_speed
	speed = initial_speed
	_action_timer.wait_time = ship_info.cooldown
	crit_ratio = ship_info.crit_ratio
	energy_consume = ship_info.energy_consume
	energy_container = ship_info.container_energy
	
func set_life(value : int):
	.set_life(value)
	emit_signal("set_life", life, max_life)
	
func set_lvl(value : int):
	lvl = value
	emit_signal("set_level", lvl, max_life)
	
func set_shield(value : int):
	shield = value
	_shield.visible = shield > 0
	emit_signal("set_shield", shield)

func _physics_process(delta):
	if is_player:
		move_player()
	else:
		move()
	_shield.visible = shield > 0

########################## Move ###############################################
func get_gamepad_direction():
	return Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()

func move_player():
	move_in_direction(get_gamepad_direction())
	
func move():
	if is_stop:
		return
	
	var player = FleetManager.player
	var direction = player.global_position - global_position
	var distance = direction.length() - player.area_collision_radius
	
	if distance < area_zone_fleet:
		direction = get_gamepad_direction()
		speed = min(player.speed, initial_speed)
	elif distance > MOVE_THRESHOLD:
		direction = direction.limit_length(
			direction.length() - player.area_collision_radius
		).normalized()
		speed = initial_speed
		
	move_in_direction(direction)
	if get_slide_count() > 0 and time_after_collision == 0:
		time_after_collision = 10
	if time_after_collision > 0:
		time_after_collision -= 1
		
func move_in_direction(direction: Vector2):
	.move_in_direction(direction)
	if get_slide_count() < 1 and time_after_collision == 0:
		_sprite.rotation = _velocity.angle() + PI / 2
		if _weapons:
			_weapons.rotation = _sprite.rotation
		
########################## End move ###############################################
########################## Ship management ########################################
func set_is_player(value : bool):
	is_player = value
	if is_player:
		FleetManager.player = self
		speed = initial_speed
		set_collision_layer_bit(0, true)
		set_collision_layer_bit(1, false)
		set_collision_mask_bit(1, false)
	else:
		set_collision_layer_bit(0, false)
		set_collision_layer_bit(1, true)
		set_collision_mask_bit(1, true)
		
func set_is_invincible(value: bool):
	is_invincible = value
	if value:
		_animation_player.play("invincibility")
		$InvincibilityTimer.start()
	else:
		_animation_player.stop()
		
func level_up():
	if lvl >= MAX_LVL:
		return
	self.lvl += 1
	update_level_up()
	
func add_damage(damage: int):
	if is_invincible:
		return
	if shield > 0:
		self.shield -= damage
		if shield < 0:
			.add_damage(abs(shield))
			self.shield = 0
	else:
		.add_damage(damage)
	if life <= 0:
		FleetManager.loose_ship(self)
		if is_player:
			FleetManager.game_over()
	else:
		FleetManager.get_damage()
	
func die():
	_animation_player.play("die")
	
func impact():
	_animation_player.play("impact")

func become_ally():
	# mettre le comportement lorsqu'un enemie devient un allié
	pass

func _on_InvincibilityTimer_timeout():
	set_is_invincible(false)
	
########################## End ship management ######################################
############################ Action in daughter class ###############################
func action():
	# Implement
	pass

func update_level_up():
	# Implement
	pass
