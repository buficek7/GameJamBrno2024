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
@onready var done_drink : DoneDrink = $"../DoneDrink"
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
		return
	if event.is_action_pressed("Quit") and parent.inspect.visible:
		parent.inspect.change_visibility()
		return
	if event.is_action_pressed("Inspect"):
		parent.inspect.change_visibility()
		return
	if event.is_action_pressed("Serve"):
		if ingEmpty():
			return
		dish_ready()
		return
	if event.is_action_pressed("Shake"):
		addIngredient("shaken")
		return
	if event.is_action_pressed("Reset"):
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
	ingredients[ingredient] = ingredients.get(ingredient, 0) + 1

func dish_ready():
	var recipe: Order = parent.get_order() #code to get value of recipe
	var recipe_ing: Dictionary = Recipes.get_recipe(recipe.get_name())
	#should check and implement losing function
	if !check_recipe(recipe_ing, ingredients):
		done_drink.change_picture("fail")
		parent.change_score(-10)
	else:
		done_drink.change_picture(recipe.get_name())
		var bonus = parent.orderTimer.get_time_left()
		if parent.orderTimer.get_time_left() < 30:
			bonus = bonus * 2
		bonus = round(bonus)
		print(10 + bonus)
		parent.change_score(10 + bonus)
	parent.next_order()
	ingredients.clear()
	
func check_recipe(recipe: Dictionary, ingredients_sec: Dictionary):
	if len(recipe) != len(ingredients_sec):
		return false
	for value in ingredients_sec.keys():
		var ingredient = ingredients_sec.get(value, null)
		if ingredient == null or recipe[value] != ingredient:
			return false
	return true
