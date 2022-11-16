extends BonusObject

func apply_effect(body: Ship):
	for ship in get_tree().get_nodes_in_group("ally"):
		ship.is_invincible = true
	.apply_effect(body)
