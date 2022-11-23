extends TextureProgress

class_name EnergyIndicator

signal activate_alarm

export var activate_alarm_limit : int = 10

var energy_consume = 0

# All function take positive value to add energy and
# negative value to reduce energy

func recalculate_energy_consume():
	pass

func set_max_energy(value: int):
	pass
	
func set_energy(value: int):
	pass

func consume_energy():
	value -= energy_consume
	if max_value * activate_alarm_limit / 100 >= value:
		emit_signal("activate_alarm")
