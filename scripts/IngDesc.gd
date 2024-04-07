class_name IngDesc
extends ColorRect
@onready var label : Label = $Label

func show_tex(string : String):
	label.text = string
	visible = true

func unshow_text():
	label.text = ""
	visible = false
