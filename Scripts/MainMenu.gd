extends Node

func _on_QuitButton_button_up():
	get_tree().quit()


func _on_PlayButton_button_up():
	get_tree().change_scene("res://Scenes/World.tscn")
