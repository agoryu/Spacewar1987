extends ProgressBar

class_name XPBar

var _xp_step = 0

func add_xp(xp: int):
	value += xp
	if value >= max_value:
		value -= max_value
		max_value += _xp_step / 2
		_xp_step += 1
		FleetManager.lvl_up()
