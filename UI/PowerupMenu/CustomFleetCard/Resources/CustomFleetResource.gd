extends ResourceManager

class_name CustomFleetResource

enum TYPES {
	ADD_SHIELD,
	REDUCE_ENERGY_CONSUME,
	ADD_LIFE,
	ADD_SPEED
}

export(TYPES) var type
export var min_value : int
export var max_value : int
export(RARITY) var rarity
export var description : String
export var icon : Texture
