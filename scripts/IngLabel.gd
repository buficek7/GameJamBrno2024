class_name IngLabel
extends ColorRect
@onready var label : Label = $Label

func show_text(string : String):
	visible = true
	label.text = string

func unshow():
	visible = false
	label.text = ""
