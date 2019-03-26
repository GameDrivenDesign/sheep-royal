extends Control

func _ready():
	pass

func set_coins(num: int):
	$coins.text = str(num)