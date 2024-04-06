extends Control


func _on_start_pressed():
	get_tree().change_scene_to_file("res://scenes/Test Scene.tscn")


func _on_quit_pressed():
	get_tree().quit()


func _on_autori_pressed():
	get_tree().change_scene_to_file("res://scenes/Credits.tscn")

