extends Node

var actions = Array()

export (NodePath) var Animation_Player
onready var Animator = get_node(Animation_Player)

# Attacks
var is_attacking = false
export (PackedScene) var light_attack
export (NodePath) var pos

func _ready():
	if not owner.playerOne:
		actions = ["light_attack", "heavy_attack"]
	else:
		actions = ["light_attack_2", "heavy_attack_2"]
	
	Animator.play("Idle")
	
func _process(delta):
	manage_input()

func manage_input():
	if owner.is_blocking:
		return
	if Input.is_action_just_pressed(actions[0]):
		is_attacking = true
		Animator.play("Atk")
		
		var instance = light_attack.instance()
		add_child(instance)
		instance.set_global_position(get_node(pos).global_position)
		
		if owner.playerOne:
			instance.Speed = 8
			instance.flip_h = true
		else:
			instance.Speed = -8
		
		yield(Animator, "animation_finished")
		Animator.play("Idle")
		is_attacking = false
	elif Input.is_action_just_pressed(actions[1]):
		print("heavy attack")
	
