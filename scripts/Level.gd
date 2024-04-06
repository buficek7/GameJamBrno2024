class_name Level
extends Node2D

var waiting_orders : Array[Order]
var active_order : Order
@onready var endGame = false
@onready var childOrder = $"Active_Order"
@onready var drinkDish = $DrinkDish
@onready var orderTimer = $Order_TImer
@export var filename : String = "res://data/levels/level%d.json"
@export var level: int = 1
var score = 0
var orders = [
	"Cafe-Sucks", 
	"Suckujes-Cafe",
	"test-sucks",
]
var recipes = {
	"dante" : ["tequilla:1", "herbal:1", "liquer:1", "sugar:1", "basil:1", "shaken:1"],
	"curtain_call" : ["basil:3", "rum:2", "sugar:2", "cherry:1", "shaken:1", "ice:1"],
	"especial_day" : ["berries:3", "white_rum:4", "vanilla:1", "citrus:2", "ice:1"],
	"test" : ["water:1"]
}

# Called when the node enters the scene tree for the first time.
func _ready():
	active_order = null
	FileFunctions.json_make_data(orders, "res://data/levels/level1.json")
	var recipe_file = "res://data/Recipes/%s.json"
	for key in recipes.keys():
		FileFunctions.json_make_data(recipes[key], recipe_file % key)
	read_level(level)
	next_order()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func read_level(level: int):
	if endGame:
		return
	var real_filename = filename % level
	var data = FileFunctions.json_get_data(real_filename, TYPE_ARRAY)
	if data == null:
		return
	for string in data:
		waiting_orders.append(Order.make_order(string))

func next_order():
	if endGame:
		return
	if len(waiting_orders) == 0:
		endGame = true
		return
	active_order = waiting_orders.pop_back()
	childOrder.change_text(self.get_order_descript())
	orderTimer.start_timer(10)
	

func get_order():
	if endGame:
		return
	return active_order

func get_order_descript():
	if endGame:
		return null
	print(active_order)
	if active_order == null:
		return null
	return active_order.get_desc()

func _on_order_t_imer_time_out():
	if endGame:
		return
	drinkDish.clearIngredients()
	if score > 0:
		score -= 1
	next_order()
