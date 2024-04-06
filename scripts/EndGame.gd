class_name EndGame
extends Control
@onready var score_label = $Label

func set_score(score: int):
	var score_str = "Score: %d"
	score_label.text = score_str % score
