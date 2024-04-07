extends Area2D

var mouse_hover : bool = false
var defPosition : Vector2
var IsDraged : bool = false
var OverDish : bool = false
@onready var Sprite = $Sprite2D
@onready var parent = $"../../Node2D"
@onready var ingLabel : IngLabel = $"IngLabel"
@export_category("Base")
@export var Ingredient_Name : String
@export var drinkDish : Dish
@export_category("Movement")
@export var MoveUp : float = 30
@export var MoveUpSpeed : float = 30
@export var IngredientRotation : float = 30
@export var ReturnSpeed : float = 75

# Called when the node enters the scene tree for the first time.
func _ready():
	defPosition = position	
	Ingredient_Name = name

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if parent.playing_anim or parent.endGame:
		return
	if mouse_hover == true:
		self.position.y = lerp(self.position.y, defPosition.y - MoveUp, MoveUpSpeed * delta)

	else:
		self.position.y = lerp(self.position.y, defPosition.y, MoveUpSpeed * delta)

func _input(event):
	if parent.playing_anim or parent.endGame:
		return
	if event.is_action_pressed("Mouse") and mouse_hover == true:
		print_debug("added")
		drinkDish.addIngredient(Ingredient_Name)

func _mouse_enter():
	if parent.playing_anim or parent.endGame:
		return
	ingLabel.show_text(name.to_upper())
	mouse_hover = true

func _mouse_exit():
	if parent.playing_anim or parent.endGame:
		return
	ingLabel.unshow()
	mouse_hover = false
