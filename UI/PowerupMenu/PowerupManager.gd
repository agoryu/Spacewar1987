extends Node

onready var add_ship_manager = load("res://UI/PowerupMenu/AddShipCard/AddShipManager.gd").new()
onready var custom_fleet_manager = load("res://UI/PowerupMenu/CustomFleetCard/CustomFleetManager.gd").new()
onready var custom_ship_manager = load("res://UI/PowerupMenu/CustomShipCard/CustomShipManager.gd").new()

func rand_card() -> Array:
	var cards = []
	var can_create_ship : bool = add_ship_manager.can_create_card()
	var can_custom_ship : bool = custom_ship_manager.can_create_card()
	for index in range(3):
		var rand = randi() % 100
		if (can_create_ship and (
				(rand >= 0 and rand < 20) or not can_create_ship
			)
		):
			cards.push_back(add_ship_manager.create_card())
		elif (can_custom_ship and (
				(rand >= 20 and rand < 50)
			)
		):
			cards.push_back(custom_ship_manager.create_card())
		else:
			cards.push_back(custom_fleet_manager.create_card())
	return cards
