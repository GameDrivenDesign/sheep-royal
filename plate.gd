extends Spatial

export (Array) var reachable = Array()

func reachable_nodes():
	var nodes = Array()
	for path in reachable:
		nodes.append(get_node(path))
	return nodes

func _ready():
	pass
