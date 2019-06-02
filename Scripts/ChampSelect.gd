extends CanvasLayer


func _on_Next_Button_button_up():
	get_tree().change_scene("res://Scenes/World.tscn")


func _on_Back_Button_button_up():
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
