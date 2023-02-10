extends Node2D

func _ready():
	randomize()
	TranslationServer.set_locale("fr")
	FleetManager.parent_ally = self
	FleetManager.add_ship($Ship)
	FleetManager.add_ship(preload("res://SpaceElements/Ship/Allies/Kargo/Kargo.tscn").instance())
#	FleetManager.add_ship(preload("res://SpaceElements/Ship/Allies/Enterprise/Enterprise.tscn").instance())
	#$PowerupMenuPanel/PowerupMenu.open()
