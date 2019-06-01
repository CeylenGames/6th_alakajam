extends Sprite

export (NodePath) var p1
export (NodePath) var p2

onready var player1 = get_node(p1)
onready var player2 = get_node(p2)

func _physics_process(delta):
	var pos = (player1.position + player2.position)/2
	position = pos
