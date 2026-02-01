extends Control

func _on_button_pressed_play() -> void:
	get_tree().change_scene_to_file("res://root.tscn")
	pass # Replace with function body.


func _on_button_2_pressed_quit() -> void:
	get_tree().quit()
	pass # Replace with function body.


func _on_button_3_pressed_credits() -> void:
	get_tree().change_scene_to_file("res://UI/credits.tscn")
