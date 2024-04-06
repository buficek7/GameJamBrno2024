extends Control
@onready var parent = $"../QuitGame"
@onready var timer = $"../../Node2D"


func _on_no_pressed():
	parent.visible = false
	timer.orderTimer.change_timer()
