extends PowerupCard

class_name AddShipCard

onready var _picture : NinePatchRect = get_node("%Picture")
onready var _description : Label = get_node("%Description")
onready var _ship_name : Label = get_node("%ShipName")

var ship_resource : ShipResource

func _ready():
	_picture.texture = ship_resource.icon
	_description.text = tr(ship_resource.description)
	_ship_name.text = ship_resource.name
	
func action():
	pass
