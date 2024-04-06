class_name Inspection
extends Control

@onready var label = $RichTextLabel

func change_visibility():
	self.visible = !self.visible

func change_label(new_text: String):
	label.text = "[center][font_size=30]" + new_text + "[/font_size][/center]"


func _on_texture_button_pressed():
	change_visibility()
