extends Weapon

class_name LaserBeam

onready var _fill := $LaserBeam/FillLine
onready var _tween := $LaserBeam/Tween
onready var _casting_particles = $LaserBeam/CastingParticle
onready var _beam_particles = $LaserBeam/BeamParticle
onready var _collision_particles = $LaserBeam/CollisionParticle
onready var _laser_bream = $LaserBeam

onready var line_width: float = _fill.width

export var max_length := 3000
export var growth_time := 0.1

var is_casting : bool = false setget set_is_casting

func _ready():
	._ready()
	set_physics_process(false)
	_fill.points[1] = Vector2.ZERO

func action(delta: float) -> void:
	_laser_bream.cast_to = (_laser_bream.cast_to + Vector2.RIGHT * speed * delta).clamped(max_length)
	cast_beam()
	
func cast_beam():
	var cast_point = _laser_bream.cast_to
	_laser_bream.force_raycast_update()
	
	_collision_particles.emitting = _laser_bream.is_colliding()
	
	if _laser_bream.is_colliding():
		cast_point = _laser_bream.to_local(_laser_bream.get_collision_point())
		_collision_particles.global_rotation = _laser_bream.get_collision_normal().angle()
		_collision_particles.position = cast_point
		var collider = _laser_bream.get_collider()
		collider.add_damage(damage_caused)
		_start_audio_player.play()
		
	_fill.points[1] = cast_point
	_beam_particles.position = cast_point * 0.5
	_beam_particles.process_material.emission_box_extents.x = cast_point.length() * 0.5

func appear():
	if _tween.is_active():
		_tween.stop_all()
	_tween.interpolate_property(_fill, "width", 0, line_width, growth_time * 2)
	_tween.start()
	_start_audio_player.play()
	_timer.start()
	
func disappear():
	if _tween.is_active():
		_tween.stop_all()
	_tween.interpolate_property(_fill, "width", line_width, 0, growth_time)
	_tween.start()

func set_is_casting(cast: bool):
	is_casting = cast
	if is_casting:
		_laser_bream.cast_to = Vector2.ZERO
		_fill.points[1] = _laser_bream.cast_to
		appear()
	else:
		_collision_particles.emitting = false
		disappear()
	
	set_physics_process(is_casting)
	_casting_particles.emitting = is_casting
	_beam_particles.emitting = is_casting

func end_action():
	set_is_casting(false)
