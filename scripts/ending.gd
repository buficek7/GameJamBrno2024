class_name EndingScreen
extends ColorRect
@onready var text_score : RichTextLabel = $RichTextLabel
@onready var finalscore = $"/root/Score".gl_score
@onready var button = $Quit
const new_text = "[center][font_size=60]
Thanks for playing
Final Score: %d
[/font_size]
[/center]
"
@onready var woman : AudioStreamPlayer = $"../woman"

func show_screen():
	visible = true
	await get_tree().create_timer(0.5).timeout
	woman.play()
	await get_tree().create_timer(2).timeout
	woman.stop()
	text_score.text = new_text % finalscore
	text_score.visible = true
	await get_tree().create_timer(1).timeout
	button.visible = true
	
