extends Panel

class_name FleetBoard

onready var _ship_list : Array = $ShipList.get_children()
onready var _card_constructor = preload("res://UI/FleetBoard/FleetShipCard.tscn")

func add_ship(ship: Ship):
	var card = _card_constructor.instance()
	var last_ship_card : FleetShipCard = null
	for ship_card in _ship_list:
		if ship_card.ship.ship_info.rarity < ship.ship_info.rarity:
			break
		else:
			last_ship_card = ship_card
	
	if last_ship_card == null:
		add_child(card)
		move_child(card, 0)
	else:
		$ShipList.add_child_below_node(last_ship_card, card)
	card.ship = ship
	
func loose_ship(ship: Ship):
	for ship_card in _ship_list:
		if ship_card.ship == ship:
			remove_child(ship_card)
			break
