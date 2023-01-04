extends Camera2D

onready var _timer = $Timer
onready var _tween = $Tween

export var shake_amount : float = 5.0

var can_move : bool = true

func _ready():
	FleetManager.connect("get_damage", self, "get_damage")

func _process(delta):
	if not _timer.is_stopped():
		offset = Vector2(
			rand_range(-1.0, 1.0) * shake_amount,
			rand_range(-1.0, 1.0) * shake_amount
		)
	else:
		offset = Vector2.ZERO
	if Input.is_action_pressed("ui_right") and offset.x < 50:
		offset.x += 5
	if Input.is_action_pressed("ui_left") and offset.x > -50:
		offset.x -= 5
		
	if can_move:
		global_position = FleetManager.player.global_position

func get_damage():
	_timer.start()
	
func loose_ally(ship: Ship):
	var ally_position = ship.global_position
	var ally_radius = ship.area_zone_fleet
	Engine.time_scale = 0.1
	var vector_zoom = Vector2.ONE * (ally_radius/100.0)
	$SlowMotionStreamPlayer.play()
	_tween.interpolate_property(self, "global_position", global_position, ally_position, 0.2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	_tween.interpolate_property(self, "zoom", zoom, vector_zoom, 0.2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	_tween.start()
	can_move = false
	yield(_tween, "tween_all_completed")
	_tween.interpolate_property(self, "global_position", ally_position, FleetManager.player.global_position, 0.2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	_tween.interpolate_property(self, "zoom", vector_zoom, FleetManager.calc_vector_radius(), 0.2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	_tween.start()
	can_move = true
	Engine.time_scale = 1.0
