extends BonusObject

var value : int = 0

func _ready():
	var warning_level = FleetManager.warning_level
	if warning_level < 20:
		value = 1
	elif warning_level >= 20 and warning_level < 50:
		value = randi() % 5 + 1
	else:
		 value = randi() % 10 + 1

	scale += Vector2.ONE * (value / 10)

func apply_effect(body: Ship):
	FleetManager.add_xp(value)
	.apply_effect(body)
