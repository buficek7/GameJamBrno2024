extends Area2D
class_name Dish

var ingredients = {} #dictionary of put ingredients
@onready var texture = $Sprite2D
@onready var parent = get_node("../../Node2D")
@export var scaleTexture = Vector2(0.1, 0.1)
@export var scaleTextureMax = 0.25
@export var scaleMax = 0.01
var currentscale = scaleTexture
var mouse_hover = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if not ingEmpty():
		texture.scale = currentscale
	else:
		texture.scale = scaleTexture
		currentscale = scaleTexture
	

func ingEmpty():
	return len(ingredients.keys()) == 0

func _input(event):
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
	print_debug("Added ingridient")
	print_debug(ingredient)
	if currentscale.x + scaleMax <= scaleTextureMax and ingredient != "shaken":
		currentscale = Vector2(currentscale.x + scaleMax, currentscale.y + scaleMax)
	ingredients[ingredient] = ingredients.get(ingredient, 0) + 1

func dish_ready():
	var recipe: Order = parent.get_order() #code to get value of recipe
	var recipe_ing: Dictionary = Recipes.get_recipe(recipe.get_name())
	#should check and implement losing function
	if !check_recipe(recipe_ing, ingredients):
		print_debug(recipe_ing)
		print_debug(ingredients)
		print_debug("Lose")
		if parent.score - 2 < 0:
			parent.score = 0
		else:
			parent.score -= 2
	else:
		print_debug("You did it")
		parent.score += 1
	parent.next_order()
	ingredients.clear()
	print_debug("dish_ready_end")
	
func check_recipe(recipe: Dictionary, ingredients: Dictionary):
	if len(recipe) != len(ingredients):
		return false
	for value in ingredients.keys():
		print_debug("check_recipe")
		var ingredient = recipe.get(value, null)
		if ingredient == null or ingredients[value] != ingredient:
			return false
	return true
