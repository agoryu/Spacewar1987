extends Control

onready var _powerup_menu : PowerupMenu = get_node("%PowerupMenuPanel")
onready var _xp_bar : XPBar = get_node("%XPBar")
onready var _energy_indicator : EnergyIndicator = get_node("%EnergyIndicator")
onready var _game_timer : GameTimer = get_node("%GameTimer")
onready var _game_over_menu : GameOverMenu = get_node("%GameOverMenu")
onready var _menu : Menu = get_node("%Menu")
onready var _switch_player : SwitchPlayerComponent = get_node("%SwitchPlayerComponent")
onready var _fleet_board : FleetBoard = get_node("%FleetBoard")
onready var _tree : SceneTree = get_tree()

func _ready():
	FleetManager.connect("lvl_up", self, "open_powerup_menu")
	FleetManager.connect("add_xp", self, "add_xp")
	FleetManager.connect("game_over", self, "game_over")
	FleetManager.connect("add_ship", self, "add_ship")
	FleetManager.connect("loose_ship", self, "loose_ship")
	
func _unhandled_input(event):
	if event.is_action_released("ui_cancel"):
		if _menu.visible:
			_menu.close()
			stop_pause()
		else:
			_menu.open()

func open_powerup_menu():
	_tree.paused = true
	_powerup_menu.open()
	
func add_xp(value: int):
	_xp_bar.add_xp(value)

func activate_alarm():
	pass # Replace with function body.
	
func game_over():
	_tree.paused = true
	_game_over_menu.open()
	
func stop_pause():
	_tree.paused = false
	
func add_ship(ship: Ship):
	_energy_indicator.add_ship(ship)
	_switch_player.recalculate_buttons()
	_fleet_board.add_ship(ship)
	
func loose_ship(ship: Ship):
	_energy_indicator.loose_ship(ship)
	_fleet_board.loose_ship(ship)
	ship.queue_free()
