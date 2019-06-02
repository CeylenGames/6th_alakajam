extends Sprite

export (float) var rotation_speed = -10

var Speed = 0

func set_attack(flip, speed):
	if flip:
		Speed = speed
		rotation_speed *= -1
		flip_h = true
	else:
		Speed = -speed

func rot():
	rotation_degrees += rotation_speed

# warning-ignore:unused_argument
func _physics_process(delta):
	rot()
	position.x += Speed
	
func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		body.take_damage(3)
		queue_free()

# warning-ignore:unused_argument
# warning-ignore:unused_argument
# warning-ignore:unused_argument
func _on_Area2D_area_shape_entered(area_id, area, area_shape, self_shape):
	if area.owner.is_in_group("light_attack"):
		area.owner.queue_free()
	if area.owner.is_in_group("heavy_attack"):
		area.owner.queue_free()
		queue_free()