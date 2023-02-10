extends Particles2D

class_name ReloadEnergy

onready var _timer : Timer = $Timer

export var timer_value : int = 1

func _ready():
	_timer.wait_time = timer_value
	
func reload():
	emitting = true
	_timer.start()

func _on_Timer_timeout():
	emitting = false
