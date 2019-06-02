extends CanvasLayer

var curseurpos_p1 = 1 # Rouge
var curseurpos_p2 = 2 # Bleu

var maxPos = 2
var minPos = 1

export (Array, String) var actions_p1 # [Left, Right]
export (Array, String) var actions_p2

export (NodePath) var anim_1
export (NodePath) var anim_2

onready var Animator_1 = get_node(anim_1)
onready var Animator_2 = get_node(anim_2)

func _ready():
	manage_animations()

func _process(delta):
	manage_input()
	
func manage_animations():
	if curseurpos_p1 == 1 and curseurpos_p2 == 2:
		Animator_1.play("blink_1")
		Animator_2.play("blink_2")
	if curseurpos_p1 == 2 and curseurpos_p2 == 1:
		Animator_1.play("blink_2")
		Animator_2.play("blink_1")
	if curseurpos_p1 == curseurpos_p2:
		if curseurpos_p1 == 1:
			Animator_1.play("blink_both")
			Animator_2.play("idle")
		if curseurpos_p1 == 2:
			Animator_2.play("blink_both")
			Animator_1.play("idle")

func manage_input():
	if Input.is_action_just_pressed(actions_p1[0]):
		curseurpos_p1 -= 1
		if curseurpos_p1 < minPos:
			curseurpos_p1 = maxPos
		manage_animations()
	if Input.is_action_just_pressed(actions_p1[1]):
		curseurpos_p1 += 1
		if curseurpos_p1 > maxPos:
			curseurpos_p1 = minPos
		manage_animations()
			
	if Input.is_action_just_pressed(actions_p2[0]):
		curseurpos_p2 -= 1
		if curseurpos_p2 < minPos:
			curseurpos_p2 = maxPos
		manage_animations()
	if Input.is_action_just_pressed(actions_p2[1]):
		curseurpos_p2 += 1
		if curseurpos_p2 > maxPos:
			curseurpos_p2 = minPos
		manage_animations()

func _on_Next_Button_button_up():
	get_tree().change_scene("res://Scenes/World.tscn")


func _on_Back_Button_button_up():
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
