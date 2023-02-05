extends Node2D

func _ready():
	randomize()
	TranslationServer.set_locale("fr")
	FleetManager.parent_ally = self
	FleetManager.add_ship($Ship)
	($Ship as Ship).life = 2
	#$PowerupMenuPanel/PowerupMenu.open()
