extends Control

@onready var TextField : RichTextLabel = $RichTextLabel
@onready var ForwardButton : TextureButton = $Forward
@onready var BackwardsButton : TextureButton = $Backward
var page : int = 0
var lenght : int
var content : Array

# Called when the node enters the scene tree for the first time.
func _ready():
	content = FileFunctions.json_get_data("res://data/Recipes/RecipeBook.json", TYPE_ARRAY)
	TextField.text = content[page]
	lenght = content.size()

func _on_forward_pressed():
	if page < lenght - 1:
		page += 1
	else:
		page = 0
	TextField.text = content[page]

func _on_backward_pressed():
	if page > 0:
		page -= 1
	else:
		page = 8
	TextField.text = content[page]
