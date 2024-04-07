extends Control


func _ready():
	print_debug(DisplayServer.window_get_size())
	var screenSize = DisplayServer.screen_get_size()
	if screenSize == Vector2i(1920, 1080):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else: if get_aspect_ratio(screenSize.x, screenSize.y) == Vector2i(16, 9):
		print_debug("Wrong resolution, but right aspect ratio")
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		var Ratio : float = float(screenSize.x) / 1920
		get_tree().root.content_scale_factor = Ratio
	else:
		print_debug("wrong resolution, Trying to adjust screen")
		var Ratio : float = float(screenSize.x) / 1920
		get_tree().root.content_scale_factor = Ratio
		get_window().size = Vector2i(1920 * Ratio, 1080 * Ratio)
		get_window().position = Vector2i(0, (screenSize.y - 1080 * Ratio) * 0.2)
		


func _on_start_pressed():
	get_tree().change_scene_to_file("res://scenes/Test Scene.tscn")


func _on_quit_pressed():
	get_tree().quit()


func _on_autori_pressed():
	get_tree().change_scene_to_file("res://scenes/Credits.tscn")

func get_aspect_ratio(width: int, height: int):
	const ratios = [Vector2i(16, 10), Vector2i(16, 9), Vector2i(4, 3)]
	for ratio in ratios:
		if width % ratio.x == 0 and height % ratio.y == 0:
			return ratio
	return null
