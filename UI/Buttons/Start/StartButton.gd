extends Button

signal switch_pause

export var text_key : String = ""
export(Resource) var scene_node

func _ready():
	text = tr(text_key)

func _on_StartButton_button_up():
	if scene_node != null:
		get_tree().change_scene(scene_node)
	else:
		for enemy in get_tree().get_nodes_in_group("enemy"):
			enemy.queue_free()
		get_tree().reload_current_scene()
		emit_signal("switch_pause")
