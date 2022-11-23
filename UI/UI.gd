extends Control

onready var _powerup_menu : PowerupMenu = get_node("%PowerupMenuPanel")
onready var _xp_bar : XPBar = get_node("%XPBar")
onready var _energy_indicator : EnergyIndicator = get_node("%EnergyIndicator")
onready var _game_timer : GameTimer = get_node("%GameTimer")
onready var _tree : SceneTree = get_tree()

func _ready():
	FleetManager.connect("lvl_up", self, "open_powerup_menu")
	FleetManager.connect("add_xp", self, "add_xp")

func open_powerup_menu():
	_tree.paused = true
	_powerup_menu.open()
	
func add_xp(value: int):
	_xp_bar.add_xp(value)

func activate_alarm():
	pass # Replace with function body.
