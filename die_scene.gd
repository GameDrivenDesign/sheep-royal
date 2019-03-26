extends Spatial

signal finished(num)

var pending = 2
var sum = 0

func _ready():
	$die.connect("finished", self, "check_finished")
	$die2.connect("finished", self, "check_finished")

func check_finished(num):
	sum += num
	pending -= 1
	if pending == 0:
		emit_signal("finished", sum)