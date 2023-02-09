extends Ship

class_name Enterprise

onready var _laser_beam : LaserBeam = $Weapons/LaserBeam

func action():
	_laser_beam.set_is_casting(true)
