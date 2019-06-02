extends KinematicBody2D

export (bool) var playerOne

# Physics
export (float) var Speed = 150

var velocity = Vector2(0, 0)

#Inputs
var actions = Array()

# Gameplay

var MaxHealth = 10
var MaxStamina = 3

var Health = MaxHealth
var Stamina = MaxStamina

var health_bar
var stamina_bar

export (Array, Resource) var shields
var is_blocking = false

# Animations
export (NodePath) var Animation_Player
onready var Animator = get_node(Animation_Player)

var is_moving = false
var light = null

func _ready():
	if not playerOne:
		actions = ["ui_left", "ui_right", "ui_up", "ui_down"]
	else:
		actions = ["ui_left_2", "ui_right_2", "ui_up_2", "ui_down_2"]
	
	updateUi()

# warning-ignore:unused_argument
func _physics_process(delta):
	if Input.is_action_pressed(actions[0]):
		if not $Attacks.is_attacking:
			velocity.x = -Speed
			is_moving = true
		else:
			velocity.x = 0
	elif Input.is_action_pressed(actions[1]):
		if not $Attacks.is_attacking:
			velocity.x = Speed
			is_moving = true
		else:
			velocity.x = 0
	else:
		velocity.x = 0
		is_moving = false

	if Input.is_action_pressed(actions[3]): # Block
		if Stamina != 0:
			set_shield()
	if Input.is_action_just_pressed(actions[3]): # Reverse
		if light != null:
			light.flip_h = not light.flip_h
			light.Speed = -light.Speed
			light = null

	if Input.is_action_just_released(actions[3]):
		$Shield.visible = false
		is_blocking = false
		if Stamina != MaxStamina:
			$Stamina_wait.start()
	
# warning-ignore:return_value_discarded
	move_and_slide(velocity, Vector2.UP)

func set_shield():
	is_blocking = true
	$Shield.visible = true
	$Shield.texture = shields[3-Stamina]
	$Stamina_wait.stop()
	$Stamina_regen.stop()

# warning-ignore:unused_argument
func _process(delta):
	"""
	if Input.is_action_just_pressed("test_b"):
		take_damage(1)
	"""
	manage_animations()

func manage_animations():
	var current = Animator.current_animation
	if is_moving:
		if current == "Idle":
			Animator.play("Walk")
	else:
		if not $Attacks.is_attacking:
			Animator.play("Idle")

func updateUi():
	health_bar.value = (float(Health)/float(MaxHealth)) * health_bar.max_value
	stamina_bar.value = (float(Stamina)/float(MaxStamina)) * stamina_bar.max_value
	
func die():
	Animator.play("Death")
	get_node("/root/World/Master").win(playerOne)

func take_damage(amount):
	if not is_blocking:
		var result = Health - amount
		if result <= 0:
			result = 0
			die()
		Health = result
	else:
		Stamina -= 1
		if Stamina <= 0:
			Stamina = 0
			$Shield.visible = false
	updateUi()

# Timers
func _on_Stamina_wait_timeout():
	$Stamina_regen.start()

func _on_Stamina_regen_timeout():
	Stamina += 1
	updateUi()
	if Stamina == MaxStamina:
		$Stamina_regen.stop()

func _on_Area2D_area_entered(area):
	if area.owner.is_in_group("light_attack"):
		light = area.owner
