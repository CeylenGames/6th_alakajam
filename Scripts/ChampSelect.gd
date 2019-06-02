extends CanvasLayer

# Curseurs
var curseurpos_p1 = 1 # Rouge
var curseurpos_p2 = 2 # Bleu
var maxPos = 2
var minPos = 1

var p1_chose = false
var p2_chose = false

# Actions
export (Array, String) var actions_p1 # [Left, Right, Light, Heavy]
export (Array, String) var actions_p2

# Animators
export (NodePath) var anim_1
export (NodePath) var anim_2
onready var Animator_1 = get_node(anim_1)
onready var Animator_2 = get_node(anim_2)

# Fonds selection
onready var Fond_1 = get_node("CharacterColor1")
onready var p1Name = get_node("CharacterColor1/Character_Name2")
onready var Fond_2 = get_node("CharacterColor2")
onready var p2Name = get_node("CharacterColor2/Character_Name")

# Line Edits
onready var line1 = get_node("P1/P1_name/LineEdit")
onready var line2 = get_node("P2/P2_name/LineEdit")

func _ready():
	if get_node("/root/MainMenu") != null:
		get_node("/root/MainMenu").queue_free()
	manage_animations()

# warning-ignore:unused_argument
func _unhandled_input(event):
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
	if not p1_chose:
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
		if Input.is_action_just_pressed(actions_p1[3]):
			p1_chose = true
			Fond_1.visible = true
			if curseurpos_p1 == 1:
				p1Name.text = "Bob"
			else:
				print("garor")
				p1Name.text = "Garor"
	if Input.is_action_just_pressed(actions_p1[2]):
			p1_chose = false
			Fond_1.visible = false

	if not p2_chose:
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
		if Input.is_action_just_pressed(actions_p2[3]):
			p2_chose = true
			Fond_2.visible = true
			if curseurpos_p2 == 1:
				p2Name.text = "Bob"
			else:
				p2Name.text = "Garor"
	if Input.is_action_just_pressed(actions_p2[2]):
			p2_chose = false
			Fond_2.visible = false

func _on_Next_Button_button_up():
	if p1_chose and p2_chose:
		var world = preload("res://Scenes/World.tscn")
		var instance = world.instance()
		get_node("/root").add_child(instance)
		get_node("/root/World/Master").set_game(curseurpos_p1, 
												curseurpos_p2,
												line1.get_text(), 
												line2.get_text())
		queue_free()

func _on_Back_Button_button_up():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
