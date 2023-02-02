extends Ship

class_name Hero

onready var _laser_shoot_constructor = preload("res://SpaceElements/Weapons/LaserShoot/LaserShoot.tscn")

var weapon_uses : int = 1

func action():
	var laser_shoot = _laser_shoot_constructor.instance()
	laser_shoot.global_position = _weapons.get_child(weapon_uses).global_position
	laser_shoot.rotation = _sprite.rotation
	laser_shoot.scale.x *= 1.5
	add_child(laser_shoot)
	laser_shoot.set_as_toplevel(true)
	laser_shoot.damage_caused = power
	laser_shoot.is_ally_weapon = true
	weapon_uses = (weapon_uses + 1) % 2
