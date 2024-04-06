class_name Level
extends Node2D

var waiting_orders : Array[Order]
var active_order : Order
@export var filename = "res://data/levels/level%d.json"
@export var level: int = 1
var orders = [
	"test-sucks",
	"Cafe-Sucks", 
	"Suckujes-Cafe"
]
var recipes = {
	"dante" : ["tequilla:1", "herbal:1", "liquer:1", "sugar:1", "basil:1", "shaken:1"],
	"curtain_call" : ["basil:3", "rum:2", "sugar:2", "cherry:1", "shaken:1", "ice:1"],
	"especial_day" : ["berries:3", "white_rum:4", "vanilla:1", "citrus:2", "ice:1"],
	"Thimisis" : ["white_rum:1", "berries:1", "honey:2", "lavender_sirup:1", "shaken:1"],
	"Arte de Volar" : ["tequilla:2", "lavener_sirup:1", "shugar_sirup:2", "citrus:1", "ice:1"],
	"Bird of Paradise" : ["tequila:3", "white_knight:3", "citrus:1", "herbal_liqueur:2"],
	"Great Gatsby" : ["vodka:1", "lemon:2", "sugar_sirup:2", "basil:1", "shaken:1"],
	"Bloody Mary" : ["vodka:2", "cherry:2", "citrus:3", "basil:1", "shaken:1"],
	"Lazarus" : ["vodka:1", "rum:1", "vanilla:1", "berries:1"]
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
	print_debug(active_order.get_name())


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
	
