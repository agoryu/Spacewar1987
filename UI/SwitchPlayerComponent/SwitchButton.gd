extends Button

class_name SwitchButton

export var is_right : bool = false

var ship : Ship

func set_ship(index):
	ship = FleetManager.fleet[index]
