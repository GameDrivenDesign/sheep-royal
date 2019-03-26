tool
extends Spatial

enum PlateType {
	event,
	coins_gain,
	coins_lose
}

export (Array) var reachable = Array()
export (PlateType) var plate_type = PlateType.coins_gain
export (Material) var event_material
export (Material) var coins_gain_material
export (Material) var coins_lose_material

func reachable_nodes():
	var nodes = Array()
	for path in reachable:
		nodes.append(get_node(path))
	return nodes

func _ready():
	if plate_type == PlateType.event:
		$mesh.material_override = event_material
	if plate_type == PlateType.coins_gain:
		$mesh.material_override = coins_gain_material
	if plate_type == PlateType.coins_lose:
		$mesh.material_override = coins_lose_material