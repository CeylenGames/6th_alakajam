extends Node

var actions = Array()

func _ready():
	if not owner.playerOne:
		actions = ["light_attack", "heavy_attack"]
	else:
		actions = ["light_attack_2", "heavy_attack_2"]
		

func _process(delta):
	if Input.is_action_just_pressed(actions[0]):
		print("light attack")
	elif Input.is_action_just_pressed(actions[1]):
		print("heavy attack")
	
