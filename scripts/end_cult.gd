class_name Cultist
extends Area2D
@onready var mouse_hover = false
@onready var ingDesc = $IngDesc
@onready var endScreen : EndingScreen = $"../ColorRect"

func _input(event):
	if event.is_action_pressed("Mouse") and mouse_hover == true:
		endScreen.show_screen()
		pass

func _mouse_enter():
	ingDesc.show_tex(name)
	mouse_hover = true

func _mouse_exit():
	ingDesc.unshow_text()
	mouse_hover = false

func _on_quit_pressed():
	get_tree().quit()

