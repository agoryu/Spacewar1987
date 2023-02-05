extends Button

func _ready():
	text = tr("menu_button_quit")

func _on_QuitButton_button_up():
	get_tree().quit()
