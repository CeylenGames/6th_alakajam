extends Node

#Menu Pause
export (NodePath) var menu_node
onready var animator = get_node(str(menu_node) + "/AnimationPlayer")
export (NodePath) var buttons_node
onready var menu = get_node(buttons_node)
export (PackedScene) var ControlScene

# Win
export (NodePath) var p1_win
export (NodePath) var p2_win
onready var p1 = get_node(p1_win)
onready var p2 = get_node(p2_win)

# Setup match
export (Array, PackedScene) var players
export (Array, NodePath) var Healthbars
export (Array, NodePath) var Staminabars

export (NodePath) var camera_path
onready var Cam = get_node(camera_path)

export (Array, Resource) var icons # [Bob, Garor]
export (Array, NodePath) var icon_paths

export (Array, NodePath) var name_labels

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
	var scene = preload("res://Scenes/MainMenu.tscn")
	var instance = scene.instance()
	get_node("/root/World").queue_free()
	get_node("/root").add_child(instance)

func win(playerOne):
	animator.play("fade_in")
	get_tree().paused = true
	yield(animator, "animation_finished")
	if not playerOne:
		p2.visible = true
	else:
		p1.visible = true
	yield(get_tree().create_timer(3), "timeout")
	get_tree().paused = false
	_on_QuitButton_button_up()

func _on_ControlsButton_button_up():
	var instance = ControlScene.instance()
	get_node("../CanvasLayer").add_child(instance)
	
func set_game(p1, p2, name1, name2):
	var player1 = players[p1-1].instance()
	var player2 = players[p2-1].instance()
	
	# Set transforms
	player1.position = get_node("/root/World/Player1").position
	player1.scale = Vector2(-1, 1)
	player2.position = get_node("/root/World/Player2").position
	
	# Set Ui
	player1.health_bar = get_node(Healthbars[0])
	player2.health_bar = get_node(Healthbars[1])
	
	player1.stamina_bar = get_node(Staminabars[0])
	player2.stamina_bar = get_node(Staminabars[1])
	
	get_node(icon_paths[0]).texture = icons[p1-1]
	get_node(icon_paths[1]).texture = icons[p2-1]
	
	if name1 == "":
		name1 = "Player 1"
	if name2 == "":
		name2 = "Player 2"
	get_node(name_labels[0]).text = name1
	get_node(name_labels[1]).text = name2
	
	# Set other stuffs
	player1.playerOne = true
	
	Cam.player_one = player1
	Cam.player_two = player2
	
	get_node("/root/World").add_child(player1)
	get_node("/root/World").add_child(player2)