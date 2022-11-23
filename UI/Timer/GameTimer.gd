extends Label

class_name GameTimer

signal time_over

var time := 0.0

func _process(delta):
	time += delta
	var sec = fmod(time, 60)
	var mins = fmod(time, 60*60) / 60
	var hours = fmod(fmod(time, 3600 * 60) / 3600, 24) 
	text = "%02d:%02d:%02d" % [hours, mins, sec]
