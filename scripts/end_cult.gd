class_name Cultist
extends Area2D
@onready var mouse_hover = false
@onready var ingDesc = $IngDesc
@onready var endScreen : EndingScreen = $"../ColorRect"

func _input(event):
	if event.is_action_pressed("Mouse") and mouse_hover == true:
		endScreen.show_screen()

func _mouse_enter():
	mouse_hover = true
	ingDesc.show_tex(name)

func _mouse_exit():
	mouse_hover = false
	ingDesc.unshow_text()

func _on_quit_pressed():
	get_tree().quit()

