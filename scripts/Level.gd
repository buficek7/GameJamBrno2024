class_name Level
extends Node2D

var waiting_orders : Array[Order]
var active_order : Order
@onready var endGame = false
@onready var drinkDish = $DrinkDish
@onready var orderTimer = $Order_TImer
@onready var scoreCount = $ScoreCount
@onready var inspect = $Inspect
@export var filename : String = "res://data/levels/level%d.json"
@export var level: int = 1
var score = 0
var orders = [
	"Cafe-Sucks", 
	"Suckujes-Cafe",
	"test-sucks",
]

# Called when the node enters the scene tree for the first time.
func _ready():
	active_order = null
	inspect.visible = false
	read_level(level)
	next_order()

func read_level(level_int: int):
	if endGame:
		return
	var real_filename = filename % level_int
	var data = FileFunctions.json_get_data(real_filename, TYPE_ARRAY)
	if data == null:
		return
	for string in data:
		waiting_orders.append(Order.make_order(string))

func change_score(value):
	if score + value < 0:
		score = 0
	else:
		score += value

func next_order():
	scoreCount.change_text(score)
	if endGame:
		return
	if len(waiting_orders) == 0:
		endGame = true
		active_order = null
		orderTimer.stop_timer()
		return
	active_order = waiting_orders.pop_back()
	inspect.change_label(self.get_order_descript())
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
	change_score(-1)
	next_order()
