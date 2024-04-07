class_name DoneDrink
extends Sprite2D
const path = "res://art/%s.png"

func change_picture(name: String):
	visible = true
	texture = load(path % name)
	await get_tree().create_timer(2).timeout
	visible = false
	
