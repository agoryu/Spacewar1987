extends Panel

signal switch_pause

class_name GameOverMenu

func _ready():
	$Screen/Title.text = tr("menu_label_gameover")


func _on_StartButton_switch_pause():
	emit_signal("switch_pause")
