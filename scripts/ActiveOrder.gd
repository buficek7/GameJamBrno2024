extends Node2D

class_name ActiveOrder

@onready var level : Node2D = $"../Node2D"
@onready var desc : String = level.get_order_descript()

