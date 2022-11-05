extends PowerupCard

class_name CustomShipCard

onready var _ship_icon : NinePatchRect = get_node("%ShipIcon")
onready var _boost_icon : NinePatchRect = get_node("%BoostIcon")
onready var _description : Label = get_node("%Description")

var ship : Ship

func _ready():
	_ship_icon.texture = ship.ship_info.icon
	var lvl_info = ship.ship_info.get_description_level(ship.lvl)
	_boost_icon.texture = lvl_info[0]
	_description.text = tr(lvl_info[1])
