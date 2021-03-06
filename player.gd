extends Spatial

const DirectionChooser = preload("res://direction_chooser.tscn")

export (NodePath) var last_plate_path
export (NodePath) var current_plate_path

signal reached_plate(plate)

const jump_height = 4.5
const speed = 0.2
var last_plate
var current_plate
var coins = 5

func _ready():
	last_plate = get_node(last_plate_path)
	current_plate = get_node(current_plate_path)

func create_direction_chooser(num_directions):
	var chooser = DirectionChooser.instance()
	chooser.set_directions(num_directions)
	add_child(chooser)
	return chooser

func apply_die_roll(num):
	var steps = num
	while steps > 0:
		var targets = reachable_plates()
		if targets.empty():
			return
		var direction = 0
		if targets.size() > 1:
			direction = yield(create_direction_chooser(directions_from_plates(current_plate, targets)), "choose")
		var target = targets[direction]
		jump_to_plate(target)
		yield(get_tree().create_timer(0.5), "timeout")
		steps -= 1
	emit_signal("reached_plate", current_plate)

func directions_from_plates(current_plate: Spatial, plates: Array):
	var directions = []
	var position = current_plate.get_transform().origin
	for plate in plates:
		var null_direction = Vector3(1, 0, 0)
		#directions.append(null_direction.angle_to(plate.get_transform().origin - position))
		directions.append(transform.looking_at(plate.get_transform().origin, Vector3.UP).basis.get_euler().y + PI/2)
	return directions

func reachable_plates():
	var reachable_from_here = Array()
	for item in current_plate.reachable_nodes():
		if (item != last_plate):
			reachable_from_here.append(item)
	return reachable_from_here

func jump_to_plate(new_plate):
	last_plate = current_plate
	current_plate = new_plate
	
	#$MeshContainer.rotation = Vector3(0, PI + Vector3(-1, 0, 0).angle_to(last_plate.get_transform().origin - current_plate.get_transform().origin), 0)
	$MeshContainer.transform.basis = transform.looking_at(current_plate.get_transform().origin, Vector3.UP).basis
	last_plate_path = last_plate.get_path()
	current_plate_path = current_plate.get_path()
	
	var tween = get_node("Tween")
	tween.interpolate_property(self, "translation",
		self.get_transform().origin, current_plate.get_transform().origin, speed,
		Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	tween.start()
	
	#var tweenJ = get_node("TweenJ")
	#tweenJ.interpolate_property($MeshContainer, "translation",
	#	Vector3(0,0,0), Vector3(0,jump_height,0), speed/2,
	#	Tween.TRANS_SINE, Tween.EASE_OUT)
	#tweenJ.start()
	#
	#var tweenF = get_node("TweenF")
	#tweenF.interpolate_property($MeshContainer, "translation",
	#	Vector3(0,jump_height,0), Vector3(0,0,0), speed/2,
	#	Tween.TRANS_SINE, Tween.EASE_IN, speed/2)
	#tweenF.start()
