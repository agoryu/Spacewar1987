extends VBoxContainer

class_name PowerupMenu

onready var manager = load("res://UI/PowerupMenu/PowerupManager.gd").new()
onready var powerup_place = $PowerupList.get_children()

var is_open : bool = false
var nb_open : int = 0

func _ready():
	FleetManager.connect("lvl_up", self, "open")

func _process(delta):
	if not is_open and nb_open > 0:
		open()

func open():
	if is_open:
		nb_open += 1
	var cards = manager.rand_card()
	for i in range(3):
		powerup_place[i].add_child(cards[i])
		cards[i].connect("button_up", self, "close")
	animation(false)
	is_open = true
	
func close():
	animation(true)
	for powerup in powerup_place:
		powerup.get_child(0).queue_free()
	nb_open -= 1
	is_open = false

func animation(is_open: bool):
	pass
