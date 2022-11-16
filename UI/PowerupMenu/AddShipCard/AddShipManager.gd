extends ResourceManager

var ship_list = [
	preload("res://SpaceElements/Ship/Allies/Hero/Hero.tres"),
	preload("res://SpaceElements/Ship/Allies/Enterprise/Enterprise.tres"),
	preload("res://SpaceElements/Ship/Allies/Kargo/Kargo.tres"),
	preload("res://SpaceElements/Ship/Allies/RadHar/RadHar.tres"),
	preload("res://SpaceElements/Ship/Allies/SamOid/SamOid.tres"),
	preload("res://SpaceElements/Ship/Allies/Viper/Viper.tres"),
	preload("res://SpaceElements/Ship/Allies/XWyng/XWyng.tres")
]

func _init():
	card_constructor = preload("res://UI/PowerupMenu/AddShipCard/AddShipCard.tscn")
	for ship in ship_list:
		dictionary_item[ship.rarity].push_back(ship)
	
func can_add_card() -> bool:
	for ship in ship_list:
		if FleetManager.get_tree().get_nodes_in_group(ship.group).size() < ship.max_ship:
			return true
	return false
	
func create_card() -> AddShipCard:
	var card = card_constructor.instance()
	var nb_retry = 0
	while card.ship_resource == null and nb_retry < MAX_RETRY:
		var rand = randi() % 100
		if rand >= 0 and rand < 10:
			card.ship_resource = rand_ship(dictionary_item[RARITY.LEGENDARY])
		elif rand >= 10 and rand < 25:
			card.ship_resource = rand_ship(dictionary_item[RARITY.EXTRAORDINARY])
		elif rand >= 25 and rand < 45:
			card.ship_resource = rand_ship(dictionary_item[RARITY.SUPER_RARE])
		elif rand >= 45 and rand < 70:
			card.ship_resource = rand_ship(dictionary_item[RARITY.RARE])
		else:
			card.ship_resource = rand_ship(dictionary_item[RARITY.COMMON])
			
	if card.ship_resource == null and nb_retry >= MAX_RETRY:
		#TODO ajouter un vaisseau basique sans lvl up
		pass
	return card

func rand_ship(ships: Array) -> ShipResource:
	var ship : ShipResource = null
	var nb_retry : int = 0
	var can_add_ship : bool = false
	
	while not can_add_ship and MAX_RETRY / 2 > nb_retry:
		var rand = randi() % ships.size()
		ship = ships[rand] as ShipResource
		can_add_ship = ship.max_ship > FleetManager.get_tree().get_nodes_in_group(ship.group).size()
	if nb_retry >= MAX_RETRY / 2 and not can_add_ship:
		return null
	return ship
