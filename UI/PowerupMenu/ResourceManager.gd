class_name ResourceManager

const MAX_RETRY = 10

enum RARITY {
	COMMON,
	RARE,
	SUPER_RARE,
	EXTRAORDINARY,
	LEGENDARY
}

var dictionary_item = {
	RARITY.COMMON: [],
	RARITY.RARE: [],
	RARITY.SUPER_RARE: [],
	RARITY.EXTRAORDINARY: [],
	RARITY.LEGENDARY: []
}

var card_constructor
