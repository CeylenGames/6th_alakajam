extends AnimatedSprite

var Speed = 0

# warning-ignore:unused_argument
func _physics_process(delta):
	position.x += Speed

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		body.take_damage(1)
		queue_free()


# warning-ignore:unused_argument
# warning-ignore:unused_argument
# warning-ignore:unused_argument
func _on_Area2D_area_shape_entered(area_id, area, area_shape, self_shape):
	print(area)
	if area.owner.is_in_group("light_attack"):
		queue_free()
		area.owner.queue_free()
