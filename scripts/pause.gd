extends Button


func _on_pressed() -> void:
	get_tree().paused = !get_tree().paused
	if get_tree().paused:
		text = "Resume"
	else:
		text = "Pause"
