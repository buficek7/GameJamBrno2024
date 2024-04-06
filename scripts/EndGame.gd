class_name EndGame
extends Control
@onready var score_label = $Label
@onready var curr_level = $"../../Node2D"
const path = "res://scenes/%s.tscn"

func set_score(score: int):
	var score_str = "Score: %d"
	score_label.text = score_str % score
	

func _on_next_level_pressed():
	get_tree().change_scene_to_file(path % ("level%i" % (curr_level.level + 1)))
	

func _on_back_to_main_menu_pressed():
	get_tree().change_scene_to_file(path % "Menu")
