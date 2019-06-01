extends KinematicBody2D

export (bool) var playerOne

# Physics
var can_jump = false

export (float) var gravity = 400
export (float) var Speed = 150
export (float) var JumpForce = 300

var velocity = Vector2(0, 0)

#Inputs
var actions = Array()

# Gameplay

var MaxHealth = 10
var MaxStamina = 10

var Health = MaxHealth
var Stamina = MaxStamina

export (NodePath) var HealthBar
export (NodePath) var StaminaBar

onready var health_bar = get_node(HealthBar)
onready var stamina_bar = get_node(StaminaBar)

func _ready():
	if not playerOne:
		actions = ["ui_left", "ui_right", "ui_up", "ui_down"]
	else:
		actions = ["ui_left_2", "ui_right_2", "ui_up_2", "ui_down_2"]
	
	updateUi()

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		can_jump = true

	if Input.is_action_pressed(actions[0]):
		velocity.x = -Speed
	elif Input.is_action_pressed(actions[1]):
		velocity.x = Speed
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

func _process(delta):
	if Input.is_action_just_pressed("test_b"):
		take_damage(1)
	if Input.is_action_just_pressed("test_n"):
		use_stamina(1)

func updateUi():
	health_bar.value = (float(Health)/float(MaxHealth)) * health_bar.max_value
	stamina_bar.value = (float(Stamina)/float(MaxStamina)) * stamina_bar.max_value

func take_damage(amount):
	$Health_regen.stop()
	var result = Health - amount
	if result <= 0:
		result = 0
		print("died")
	Health = result
	updateUi()
	$Health_wait.start()

func use_stamina(amount):
	$Stamina_regen.stop()
	var result = Stamina - amount
	if result <= 0:
		result = 0
	Stamina = result
	updateUi()
	$Stamina_wait.start()

# Timers
func _on_Health_wait_timeout():
	$Health_regen.start()

func _on_Health_regen_timeout():
	Health += 1
	updateUi()
	if Health == MaxHealth:
		$Health_regen.stop()

func _on_Stamina_wait_timeout():
	$Stamina_regen.start()

func _on_Stamina_regen_timeout():
	Stamina += 1
	updateUi()
	if Stamina == MaxStamina:
		$Stamina_regen.stop()

