extends Node2D

func _ready():
	randomize()
	TranslationServer.set_locale("fr")
	FleetManager.parent_ally = self
	FleetManager.add_ship($Ship)
	#$PowerupMenuPanel/PowerupMenu.open()
