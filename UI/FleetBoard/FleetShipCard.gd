extends Panel

class_name FleetShipCard

onready var icon : NinePatchRect = get_node("%Icon")
onready var life : ProgressBar = get_node("%Life")
onready var shield : ProgressBar = get_node("%Shield")
onready var level : TextureProgress = get_node("%Level")

var ship : Ship setget set_ship

func set_ship(value : Ship):
	ship = value
	icon.texture = ship.ship_info.icon
	life.max_value = ship.life
	life.value = ship.life
	shield.max_value = ship.shield
	shield.value = ship.shield
	level.max_value = ship.MAX_LVL
	level.value = ship.lvl
	ship.connect("set_level", self, "set_level")
	ship.connect("set_life", self, "set_life")
	ship.connect("set_shield", self, "self_shield")
	shield.visible = shield.value > 0
	
func set_level(value : int):
	level.value = value
	
func set_life(value : int, max_life : int):
	life.value = value
	life.max_value = max_life
	
func set_shield(value : int):
	shield.value = value
	shield.visible = shield.value > 0
	shield.max_value = max(shield.value, shield.max_value)
