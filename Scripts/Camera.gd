extends Camera2D


export (NodePath) var player_1
export (NodePath) var player_2

onready var player_one = get_node(player_1)
onready var player_two = get_node(player_2)

func change_position():
	var new_pos = (player_one.position + player_two.position)/2
	position.x = new_pos.x
	var distance = player_one.position.distance_to(player_two.position) * 2
	var zoom_factor = distance * 0.0005
	
	set_zoom(Vector2(1, 1) * zoom_factor/1.35)

func _physics_process(delta):
	change_position()
	align()