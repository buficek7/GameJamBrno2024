extends CollisionShape2D
var ingredients = {} #dictionary of put ingredients
@onready var texture = $Sprite2D
@onready var parent = get_node("../../../Node2D")
@export var scaleTexture = Vector2(0.1, 0.1)
@export var scaleMax = 0.05
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
		print("Hello")
		return
		dish_ready()

func addIngredient(ingredient):
	ingredients[ingredient] = ingredients.get(ingredient, 0) + 1

func dish_ready():
	var recipe = parent.get_parent() #code to get value of recipe
	check_recipe(recipe, ingredients)
	ingredients.clear()
	
func check_recipe(recipe: Dictionary, ingredients: Dictionary):
	for value in ingredients.keys():
		var ingredient = recipe.get(value, null)
		if ingredient == null or ingredients[value] != ingredient:
			return false
	return true
