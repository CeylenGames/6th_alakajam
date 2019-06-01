extends AnimatedSprite

var Speed = 0

func _physics_process(delta):
	position.x += Speed

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		body.take_damage(1)
		queue_free()
