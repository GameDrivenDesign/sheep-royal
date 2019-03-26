extends Spatial

signal choose(direction)

var num_directions = 0
var direction = 0
var directions = []

func _ready():
	set_process(true)

func set_directions(directions):
	num_directions = directions.size()
	self.directions = directions
	set_direction(0)

func _process(dt):
	if Input.is_action_just_pressed("ui_left"):
		set_direction((direction + 1) % num_directions)
	if Input.is_action_just_pressed("ui_accept"):
		emit_signal("choose", direction)
		get_parent().remove_child(self)

func set_direction(dir):
	direction = dir
	$Tween.interpolate_property(self, "rotation",
		rotation, Vector3(0, directions[dir], 0), 0.2,
		Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	$Tween.start()