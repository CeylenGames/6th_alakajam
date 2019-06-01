extends KinematicBody2D

export (bool) var playerOne

# Physics
var can_jump = false

export (float) var gravity = 400
export (float) var Speed = 150
export (float) var JumpForce = 300

var velocity = Vector2(0, 0)

export (Array, float) var limits

#Inputs
var actions = Array()

# Gameplay

var MaxHealth = 10
var MaxStamina = 10

export (NodePath) var HealthBar
export (NodePath) var StaminaBar

func _ready():
	if not playerOne:
		actions = ["ui_left", "ui_right", "ui_up", "ui_down"]
	else:
		actions = ["ui_left_2", "ui_right_2", "ui_up_2", "ui_down_2"]

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		can_jump = true

	if Input.is_action_pressed(actions[0]):
		if position.x > limits[0]:
			velocity.x = -Speed
		else:
			position.x = limits[0]
	elif Input.is_action_pressed(actions[1]):
		if position.x < limits[1]:
			velocity.x = Speed
		else:
			position.x = limits[1]
	else:
		velocity.x = 0
	
	if Input.is_action_pressed(actions[3]):
		can_jump = false
		print("dodge")
	
	if Input.is_action_just_pressed(actions[2]):
		if can_jump:
			velocity.y = -JumpForce
			can_jump = false
		
	move_and_slide(velocity, Vector2.UP)