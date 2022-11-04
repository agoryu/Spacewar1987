extends PowerupCard

class_name CustomFleetCard

onready var _icon_custom : NinePatchRect = get_node("%IconCustom")
onready var _description : Label = get_node("%Description")
onready var _value : Label = get_node("%Value")

var custom_resource : CustomFleetResource
var value : int

func _ready():
	_icon_custom.texture = custom_resource.icon
	_description.text = tr(custom_resource.description)
	_value.text = String(value)
	
func action():
	pass
