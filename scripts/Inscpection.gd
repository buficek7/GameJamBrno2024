class_name Inspection
extends Control

@onready var label = $RichTextLabel
@onready var parent = $"../../Node2D"

func change_visibility():
	self.visible = !self.visible
	parent.orderTimer.change_timer()

func change_label(new_text: String):
	label.text = "[font_size=30]" + new_text + "[/font_size]"


func _on_texture_button_pressed():
	change_visibility()
