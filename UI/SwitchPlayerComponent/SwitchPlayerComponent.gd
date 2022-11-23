extends Control

class_name SwitchPlayerComponent

onready var _left_button : SwitchButton = get_node("%LeftButton")
onready var _right_button : SwitchButton = get_node("%RightButton")
onready var _audio_player : AudioStreamPlayer = $AudioStreamPlayer

func _unhandled_input(event):
	if event.is_action_pressed("switch_left"):
		_left_button.grab_focus()
	if event.is_action_pressed("switch_right"):
		_right_button.grab_focus()
	if event.is_action_released("switch_left"):
		_left_button.release_focus()
		switch_player(_left_button.ship)
	if event.is_action_released("switch_right"):
		_right_button.release_focus()
		switch_player(_right_button.ship)
		
	if event.is_action_released("switch_left") or event.is_action_released("switch_right"):
		$AudioStreamPlayer.play()

func switch_player(ship: Ship):
	FleetManager.set_player(ship)
	recalculate_buttons()
	
func fleet_update():
	recalculate_buttons()

func recalculate_buttons():
	_left_button.disabled = FleetManager.fleet.size() <= 1
	_right_button.disabled = FleetManager.fleet.size() <= 1
	if FleetManager.fleet.size() > 1:
		_left_button.set_ship((FleetManager.fleet.find(FleetManager.player) - 1) % FleetManager.fleet.size())
		_right_button.set_ship((FleetManager.fleet.find(FleetManager.player) + 1) % FleetManager.fleet.size())
