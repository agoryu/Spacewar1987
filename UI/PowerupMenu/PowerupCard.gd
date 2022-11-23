extends Button

class_name PowerupCard

signal close

func action():
	emit_signal("close")
