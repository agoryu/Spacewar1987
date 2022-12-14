extends Panel

class_name PowerupMenu

signal close

onready var manager = load("res://UI/PowerupMenu/PowerupManager.gd").new()
onready var powerup_place = $PowerupMenu/PowerupList.get_children()

var is_open : bool = false
var nb_open : int = 0

func _process(delta):
	if not is_open and nb_open > 0:
		open()

func open():
	nb_open += 1
	if is_open:
		return
	var cards = manager.rand_card()
	for i in range(3):
		powerup_place[i].add_child(cards[i])
		cards[i].connect("button_up", self, "close")
	cards[0].grab_focus()
	animation(false)
	is_open = true
	
func close():
	animation(true)
	for powerup in powerup_place:
		powerup.get_child(0).queue_free()
	nb_open -= 1
	is_open = false
	emit_signal("close")

func animation(is_open: bool):
	visible = not is_open
