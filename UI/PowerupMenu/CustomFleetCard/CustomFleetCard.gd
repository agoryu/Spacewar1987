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
	for ship in get_tree().get_nodes_in_group("ally"):
		match custom_resource.type:
			CustomFleetResource.TYPES.ADD_LIFE:
				ship.life = min(
					ship.life + max(1, round(value * ship.life / 100)), 
					ship.ship_info.max_life
				)
			CustomFleetResource.TYPES.ADD_SPEED:
				ship.speed = min(
					ship.speed + max(1, round(value * ship.speed / 100)), 
					ship.ship_info.max_speed
				)
			CustomFleetResource.TYPES.REDUCE_ENERGY_CONSUME:
				ship.energy_consume = max(
					ship.energy_consume - max(1, round(value * ship.energy_consume / 100)), 
					ship.ship_info.min_energy_consume
				)
			_:
				ship.shield += value
