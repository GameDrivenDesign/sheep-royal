extends Spatial

const Plate = preload("res://plate.gd")
const PlateType = preload("res://plate.gd").PlateType
const DieScene = preload("res://die_scene.tscn")

func _ready():
	$player.connect("reached_plate", self, "apply_plate")
	update_coins(0)
	new_turn()

func new_turn():
	var die_scene = DieScene.instance()
	add_child(die_scene)
	var num = yield(die_scene, "finished")
	$player.apply_die_roll(num)
	yield($player, "reached_plate")
	print('REACHED PLATE!')
	die_scene.queue_free()
	new_turn()

func apply_plate(plate):
	if plate.plate_type == PlateType.coins_gain:
		update_coins(2)
	if plate.plate_type == PlateType.coins_lose:
		update_coins(-2)
	if plate.plate_type == PlateType.event:
		print("EVENT!")

func update_coins(delta):
	$player.coins += delta
	$player/Camera/CanvasLayer/hud.set_coins($player.coins)