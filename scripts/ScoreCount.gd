class_name ScoreCount
extends RichTextLabel


func change_text(number: int):
	var new_text = "Score: %d"
	text = "[center][font_size=25]" + (new_text % number) + "[/font_size][/center]"
