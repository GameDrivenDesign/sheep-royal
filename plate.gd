extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text
export (Array) var reachable = Array()

func reachable_nodes():
	var nodes = Array()
	for path in reachable:
		nodes.append(get_node(path))
	return nodes

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
