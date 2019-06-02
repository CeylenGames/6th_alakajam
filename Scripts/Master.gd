extends Node

export (NodePath) var menu_node
onready var animator = get_node(str(menu_node) + "/AnimationPlayer")

export (NodePath) var buttons_node
onready var menu = get_node(buttons_node)

export (NodePath) var p1_win
export (NodePath) var p2_win
onready var p1 = get_node(p1_win)
onready var p2 = get_node(p2_win)

export (PackedScene) var ControlScene

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if not get_tree().paused:
			animator.play("fade_in")
			get_tree().paused = true
			yield(animator, "animation_finished")
			menu.visible = true
		else:
			menu.visible = false
			get_tree().paused = false
			animator.play("fade_out")

func _on_ResumeButton_button_up():
	menu.visible = false
	get_tree().paused = false
	animator.play("fade_out")

func _on_QuitButton_button_up():
	get_tree().change_scene("res://Scenes/MainMenu.tscn")

func win(playerOne):
	animator.play("fade_in")
	get_tree().paused = true
	yield(animator, "animation_finished")
	if not playerOne:
		p2.visible = true
		print("p2")
	else:
		p1.visible = true
		print("p1")
	yield(get_tree().create_timer(3), "timeout")
	get_tree().paused = false
	_on_QuitButton_button_up()

func _on_ControlsButton_button_up():
	var instance = ControlScene.instance()
	get_node("../CanvasLayer").add_child(instance)
