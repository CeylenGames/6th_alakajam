extends Camera2D

var player_one
var player_two

func change_position():
	var new_pos = (player_one.position + player_two.position)/2
	position.x = new_pos.x
	var distance = player_one.position.distance_to(player_two.position) * 2
	var zoom_factor = distance * 0.0005
	
	set_zoom(Vector2(1, 1) * zoom_factor/1.35)

func _physics_process(delta):
	if player_one != null and player_two != null:
		change_position()
		align()