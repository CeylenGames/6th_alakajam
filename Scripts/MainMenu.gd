extends Node

export (PackedScene) var ControlScene

func _on_QuitButton_button_up():
	get_tree().quit()


func _on_PlayButton_button_up():
	get_tree().change_scene("res://Scenes/World.tscn")


func _on_ControlButton_button_up():
	var instance = ControlScene.instance()
	add_child(instance)
