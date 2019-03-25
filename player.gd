extends Spatial

export (NodePath) var last_plate_path
export (NodePath) var current_plate_path

var last_plate
var current_plate

var timer = null

func _ready():
	last_plate = get_node(last_plate_path)
	current_plate = get_node(current_plate_path)
	
	timer = Timer.new()
	add_child(timer)
	
	timer.connect("timeout", self, "on_timer_timeout")
	timer.set_wait_time(2.0)
	timer.set_one_shot(false)
	timer.start()
	
func on_timer_timeout():
	var targets = reachable_plates()
	if (targets.empty()):
		return
	var target = targets[randi() % targets.size()]
	jump_to_plate(target)
	
func reachable_plates():
	var reachable_from_here = Array()
	for item in current_plate.reachable_nodes():
		if (item != last_plate):
			reachable_from_here.append(item)
	return reachable_from_here

func jump_to_plate(new_plate):
	last_plate = current_plate
	current_plate = new_plate
	
	last_plate_path = last_plate.get_path()
	current_plate_path = current_plate.get_path()

func _process(delta):
	var offset = current_plate.get_transform().origin - self.get_transform().origin
	translate(offset * delta * 4)
