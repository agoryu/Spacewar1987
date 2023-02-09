extends TextureProgress

class_name EnergyIndicator

signal activate_alarm

export var activate_alarm_limit : int = 10

var energy_consume = 0

func recalculate_energy_consume():
	energy_consume = 0
	for ship in get_tree().get_nodes_in_group("ally"):
		energy_consume += ship.energy_consume

func add_ship(ship: Ship):
	max_value += ship.energy_container
	value += ship.energy_container
	energy_consume += ship.energy_consume
	
func loose_ship(ship: Ship):
	max_value -= ship.energy_container
	value -= ship.energy_container
	energy_consume -= ship.energy_consume

func consume_energy():
	value -= energy_consume
	if max_value * activate_alarm_limit / 100 >= value:
		emit_signal("activate_alarm")
