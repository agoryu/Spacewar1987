extends PowerupCard

class_name CustomShipCard

onready var _ship_icon : NinePatchRect = get_node("%ShipIcon")
onready var _boost_icon : NinePatchRect = get_node("%BoostIcon")
onready var _description : Label = get_node("%Description")

var ship : Ship

func _ready():
	_ship_icon.texture = ship.ship_info.icon
	# gérer l'icon de boost
#	_boost_icon.
	_description.text = tr("")
