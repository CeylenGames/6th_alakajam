extends CanvasLayer

export (NodePath) var control_1
export (NodePath) var control_2

onready var Controls_1 = get_node(control_1)
onready var Controls_2 = get_node(control_2)

export (NodePath) var animation_player

onready var Animator = get_node(animation_player)
onready var ControlPanel = get_node("ChangeControl")
onready var ControlTitle = get_node("ChangeControl/Title")
onready var ControlLabel = get_node("ChangeControl/Label")

var is_grabbing_events = false
var actual_event = null
var actual_action = null

func set_ui(controls_list):
	for child in controls_list.get_children():
		if child.is_in_group("Label_Control"):
			var label = get_node(str(child.get_path()) + "/Name")
			label.text = str(child.name.substr(0, len(child.name) -1))
			
			var button = get_node(str(child.get_path()) + "/Button")
			var event_name = button.get_groups()[0]
			button.text = InputMap.get_action_list(event_name)[0].as_text()

func _ready():
	update_ui()

func update_ui():
	set_ui(Controls_1)
	set_ui(Controls_2)

func _unhandled_key_input(event):
	if is_grabbing_events:
		if event.scancode == KEY_ESCAPE:
			quit_control_panel()
		else:
			ControlLabel.text = event.as_text()
			actual_event = event

func _on_Button_button_up(action_name):
	Animator.play("fade_in")
	yield(Animator, "animation_finished")
	ControlPanel.visible = true
	is_grabbing_events = true
	ControlTitle.text = "Previous input :" + InputMap.get_action_list(action_name)[0].as_text()
	actual_action = action_name

func _on_OK_Button_button_up():
	# Save input
	if actual_action != null and actual_event != null:
		InputMap.action_erase_event(actual_action, InputMap.get_action_list(actual_action)[0])
		InputMap.action_add_event(actual_action, actual_event)
		
		update_ui()
	
	quit_control_panel()

func quit_control_panel():
	actual_event = null
	actual_action = null
	ControlPanel.visible = false
	is_grabbing_events = false
	Animator.play("fade_out")


func _on_ReturnButton_button_up():
	queue_free()
