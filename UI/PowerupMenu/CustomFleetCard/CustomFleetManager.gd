extends ResourceManager

var shield_resource = preload("res://UI/PowerupMenu/CustomFleetCard/Resources/AddShield.tres")

var custom_list = [
	shield_resource,
	preload("res://UI/PowerupMenu/CustomFleetCard/Resources/AddLife.tres"),
	preload("res://UI/PowerupMenu/CustomFleetCard/Resources/AddSpeed.tres"),
	preload("res://UI/PowerupMenu/CustomFleetCard/Resources/ReduceEnergyConsume.tres")
]

func _init():
	card_constructor = preload("res://UI/PowerupMenu/CustomFleetCard/CustomFleetCard.tscn")
	for custom in custom_list:
		dictionary_item[custom.rarity].push_back(custom)

func create_card() -> CustomFleetCard:
	var card = card_constructor.instance()
	var nb_retry = 0
	while card.value == null and nb_retry < MAX_RETRY:
		var rand = randi() % 100
		if not dictionary_item[RARITY.LEGENDARY].empty() and rand >= 0 and rand < 10:
			compute_data_card(RARITY.LEGENDARY, card)
		elif (not dictionary_item[RARITY.EXTRAORDINARY].empty() 
				and ((rand >= 10 and rand < 25) or dictionary_item[RARITY.LEGENDARY].empty())):
			compute_data_card(RARITY.EXTRAORDINARY, card)
		elif (not dictionary_item[RARITY.SUPER_RARE].empty() 
				and ((rand >= 25 and rand < 45) or dictionary_item[RARITY.EXTRAORDINARY].empty())):
			compute_data_card(RARITY.SUPER_RARE, card)
		elif (not dictionary_item[RARITY.RARE].empty() 
				and ((rand >= 45 and rand < 70) or dictionary_item[RARITY.SUPER_RARE].empty())):
			compute_data_card(RARITY.RARE, card)
		else:
			compute_data_card(RARITY.COMMON, card)
		nb_retry += 1
		
	if nb_retry >= MAX_RETRY and card.value == null:
		card.custom_resource = shield_resource
		card.value = rand_value(shield_resource.min_value, shield_resource.max_value)
	return card
	
func compute_data_card(rarity, card: CustomFleetCard):
	var custom = rand_custom_fleet(dictionary_item[rarity])
	card.custom_resource = custom
	card.value = rand_value(custom.min_value, custom.max_value)

func rand_custom_fleet(customs: Array) -> CustomFleetResource:
	var rand = randi() % customs.size()
	return customs[rand]

func rand_value(min_value: int, max_value: int) -> int:
	return randi() % (max_value - min_value) + min_value
