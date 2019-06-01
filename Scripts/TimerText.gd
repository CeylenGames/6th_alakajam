extends Label

func _on_Timer_timeout():
	text = str(int(text) -1)
	if text == "0":
		pass
