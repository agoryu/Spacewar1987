extends BonusObject

func apply_effect(body: Ship):
	for object in get_tree().get_nodes_in_group("attracted"):
		object.is_attracted = true
	.apply_effect(body)
