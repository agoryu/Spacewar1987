extends ResourceManager

func _init():
	card_constructor = preload("res://UI/PowerupMenu/CustomShipCard/CustomShipCard.tscn")
	
func init_dictionary():
	for ship in FleetManager.get_tree().get_nodes_in_group("ally"):
		dictionary_item[ship.ship_info.rarity].push_back(ship)

func can_add_card() -> bool:
	for ship in FleetManager.get_tree().get_nodes_in_group("ally"):
		if ship.lvl < ship.MAX_LVL:
			return true
	return false
	
func create_card() -> PowerupCard:
	var card = card_constructor.instance()
	var nb_retry = 0
	init_dictionary()
	while card.ship == null and nb_retry < MAX_RETRY:
		var rand = randi() % 100
		if not dictionary_item[RARITY.LEGENDARY].empty() and rand >= 0 and rand < 10:
			card.ship = find_ship(dictionary_item[RARITY.LEGENDARY])
		elif (not dictionary_item[RARITY.EXTRAORDINARY].empty() 
				and ((rand >= 10 and rand < 25) or dictionary_item[RARITY.LEGENDARY].empty())):
			card.ship = find_ship(dictionary_item[RARITY.EXTRAORDINARY])
		elif (not dictionary_item[RARITY.SUPER_RARE].empty() 
				and ((rand >= 25 and rand < 45) or dictionary_item[RARITY.EXTRAORDINARY].empty())):
			card.ship = find_ship(dictionary_item[RARITY.SUPER_RARE])
		elif (not dictionary_item[RARITY.RARE].empty() 
				and ((rand >= 45 and rand < 70) or dictionary_item[RARITY.SUPER_RARE].empty())):
			card.ship = find_ship(dictionary_item[RARITY.RARE])
		else:
			card.ship = find_ship(dictionary_item[RARITY.COMMON])
	return card
	
func find_ship(item_list: Array) -> Ship:
	var ship : Ship = null
	var nb_retry : int = 0
	var can_add_ship : bool = false
	
	while not can_add_ship and MAX_RETRY / 2 > nb_retry:
		var rand = randi() % item_list.size()
		ship = item_list[rand] as Ship
		can_add_ship = ship.lvl < ship.MAX_LVL
		
	if nb_retry >= MAX_RETRY / 2 and not can_add_ship:
		return null
	return ship
