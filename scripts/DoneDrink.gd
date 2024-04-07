class_name DoneDrink
extends Sprite2D
const path = "res://art/%s.png"

func change_picture(new_name: String):
	visible = true
	texture = load(path % new_name)
	await get_tree().create_timer(2).timeout
	visible = false
	
