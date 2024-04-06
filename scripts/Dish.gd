extends Area2D
class_name Dish

var ingredients = {} #dictionary of put ingredients
@onready var texture = $Sprite2D
@onready var parent = get_node("../../Node2D")
@export var scaleTexture = Vector2(0.1, 0.1)
@export var scaleMax = 0.05
var score = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if not ingEmpty():
		texture.scale = Vector2(scaleTexture.x + scaleMax, scaleTexture.y + scaleMax)
	else:
		texture.scale = scaleTexture
	

func ingEmpty():
	return len(ingredients.keys()) == 0

func _input(event):
	if event is InputEventMouseButton:
		if ingEmpty():
			return
		dish_ready()
		return

func addIngredient(ingredient):
	ingredients[ingredient] = ingredients.get(ingredient, 0) + 1

func dish_ready():
	return
	var recipe: Order = parent.get_order() #code to get value of recipe
	var recipe_ing: Dictionary = Recipes.get_recipe(recipe.get_name())
	#should check and implement losing function
	if check_recipe(recipe_ing, ingredients):
		if score - 2 < 0:
			score = 0
		else:
			score -= 2
	else:
		score += 1
	ingredients.clear()
	
func check_recipe(recipe: Dictionary, ingredients: Dictionary):
	if len(recipe) != len(ingredients):
		return false
	for value in ingredients.keys():
		var ingredient = recipe.get(value, null)
		if ingredient == null or ingredients[value] != ingredient:
			return false
	return true
