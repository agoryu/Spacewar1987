extends Resource

class_name ShipResource

enum RARITY {
	COMMON,
	RARE,
	SUPER_RARE,
	EXTRAORDINARY,
	LEGENDARY
}

export var name : String
export var group : String
export var initial_speed : int
export var life : int
export var power : int
export var container_energy : int
export var energy_consume : int
export var cooldown : float
export var crit_ratio : int
export var second_cooldown : float
export(RARITY) var rarity
export var max_life : int
export var max_speed : int
export var max_power : int
export var min_energy_consume : int
export var min_cooldown : float
export var min_second_cooldown : float
export var area_zone_fleet : int
export var icon : Resource
export var description : String
export var max_ship : int
export var lvl_icon : Array
export var lvl_description : Array

func get_description_level(level: int) -> Array:
	return [lvl_icon[level], lvl_description[level]]
