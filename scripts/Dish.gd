extends Area2D
class_name Dish

var ingredients = {} #dictionary of put ingredients
@onready var texture = $Sprite2D
@onready var parent = get_node("../../Node2D")
@onready var quitGame = $"../QuitGame"
@export var scaleTexture = Vector2(0.1, 0.1)
@export var scaleTextureMax = 0.25
@export var scaleMax = 0.01
@onready var anim = $AnimationPlayer
var currentscale = scaleTexture
var mouse_hover = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func ingEmpty():
	return len(ingredients.keys()) == 0

func _input(event):
	if parent.playing_anim or parent.endGame or quitGame.visible:
		return
	if event.is_action_pressed("Quit") and not parent.inspect.visible:
		parent.orderTimer.change_timer()
		quitGame.visible = true
	if event.is_action_pressed("Quit") and parent.inspect.visible:
		parent.inspect.change_visibility()
	if event.is_action_pressed("Inspect"):
		parent.inspect.change_visibility()
	if event.is_action_pressed("Serve"):
		if ingEmpty():
			return
		dish_ready()
		return
	if event.is_action("Shake"):
		addIngredient("shaken")
		return
	if event.is_action("Reset"):
		ingredients.clear()
		return

func _mouse_enter():
	mouse_hover = true

func _mouse_exit():
	mouse_hover = false

func clearIngredients():
	ingredients.clear()

func addIngredient(ingredient):
	if ingredient == "shaken":
		anim.play("Shake")
	else:
		anim.play("Ing_Added")
	print_debug("Added ingridient")
	print_debug(ingredient)
	ingredients[ingredient] = ingredients.get(ingredient, 0) + 1

func dish_ready():
	var recipe: Order = parent.get_order() #code to get value of recipe
	var recipe_ing: Dictionary = Recipes.get_recipe(recipe.get_name())
	#should check and implement losing function
	if !check_recipe(recipe_ing, ingredients):
		print_debug(recipe_ing)
		print_debug(ingredients)
		print_debug("Lose")
		parent.change_score(-2)
	else:
		print_debug("You did it")
		parent.change_score(10)
	parent.next_order()
	ingredients.clear()
	print_debug("dish_ready_end")
	
func check_recipe(recipe: Dictionary, ingredients_sec: Dictionary):
	if len(recipe) != len(ingredients_sec):
		return false
	for value in ingredients_sec.keys():
		print_debug("check_recipe")
		var ingredient = recipe.get(value, null)
		if ingredient == null or ingredients_sec[value] != ingredient:
			return false
	return true
