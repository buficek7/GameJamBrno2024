extends Area2D
class_name Dish

var ingredients = {} #dictionary of put ingredients
@onready var texture = $Sprite2D
@onready var parent = $"../../Node2D"
@onready var quitGame = $"../QuitGame"
@export var scaleTexture = Vector2(0.1, 0.1)
@export var scaleTextureMax = 0.25
@export var scaleMax = 0.01
@onready var anim = $AnimationPlayer
@onready var done_drink : DoneDrink = $"../DoneDrink"
@onready var anim_fail = $"../PassFailIndicator/AnimationPlayer"
@onready var fail_win = $"../PassFailIndicator"
@onready var fail_sprite = $"../PassFailIndicator/fail"
@onready var win_sprite = $"../PassFailIndicator/pass"
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
	if event.is_action_pressed("Shake") and not parent.inspect.visible:
		addIngredient("shaken")
		return
	if event.is_action_pressed("Reset"):
		anim.play("Reset")
		parent.playing_anim = true
		ingredients.clear()
		await get_tree().create_timer(1).timeout
		parent.playing_anim = false
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
	if recipe.get_name() == "tutorial":
		fail_win.visible = true
		anim_fail.stop()
		fail_sprite.visible = false
		anim_fail.play("Pass")
		done_drink.change_picture("fail")
		await get_tree().create_timer(0.3).timeout
		fail_sprite.visible = true
		fail_win.visible = false
		anim_fail.play("RESET")
		parent.next_order()
		ingredients.clear()
		return
	var recipe_ing: Dictionary = Recipes.get_recipe(recipe.get_name())
	#should check and implement losing function
	if !check_recipe(recipe_ing, ingredients):
		fail_win.visible = true
		win_sprite.visible = false
		anim_fail.play("Fail")
		done_drink.change_picture("fail")
		parent.change_score(-10)
		await get_tree().create_timer(0.3).timeout
		win_sprite.visible = true
		fail_win.visible = false
		
	else:
		fail_win.visible = true
		anim_fail.stop()
		fail_sprite.visible = false
		anim_fail.play("Pass")
		done_drink.change_picture(recipe.get_name())
		var bonus = parent.orderTimer.get_time_left()
		if parent.orderTimer.get_time_left() < 30:
			bonus = bonus * 2
		bonus = round(bonus)
		print(10 + bonus)
		parent.change_score(10 + bonus)
		await get_tree().create_timer(0.3).timeout
		fail_sprite.visible = true
		fail_win.visible = false
	anim_fail.play("RESET")
	parent.next_order()
	ingredients.clear()
	
func check_recipe(recipe: Dictionary, ingredients_sec: Dictionary):
	if len(recipe) != len(ingredients_sec):
		return false
	for value in recipe.keys():
		var ingredient = ingredients_sec.get(value, null)
		if ingredient == null or recipe[value] != ingredient:
			return false
	return true
