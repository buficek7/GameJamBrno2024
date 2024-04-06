class_name Level
extends Node2D

var waiting_orders : Array[Order]
var active_order : Order
@export var filename = "res://data/levels/level%d.json"
@export var level: int = 1
var orders = [
	"Cafe-Sucks", 
	"Suckujes-Cafe"
]
var recipes = {
	"dante" : ["tequilla:1", "herbal:1", "liquer:1"]
}

# Called when the node enters the scene tree for the first time.
func _ready():
	active_order = null
	FileFunctions.json_make_data(orders, "res://data/levels/level1.json")
	var recipe_file = "res://data/Recipes/%s.json"
	for key in recipes.keys():
		FileFunctions.json_make_data(recipes[key], recipe_file % key)
	read_level(level)
	active_order = waiting_orders[0]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func read_level(level: int):
	var real_filename = filename % level
	print_debug(real_filename)
	var data = FileFunctions.json_get_data(real_filename, TYPE_ARRAY)
	if data == null:
		return
	for string in data:
		waiting_orders.append(Order.make_order(string))

func get_order():
	return active_order
	
