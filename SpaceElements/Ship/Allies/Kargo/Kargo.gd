extends Ship

class_name Kargo

signal reload_energy

onready var _reload_energy_component : ReloadEnergy = $Weapons/ReloadEnergy

func action():
	_reload_energy_component.reload()
	emit_signal("reload_energy", power)
