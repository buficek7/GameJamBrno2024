extends Area2D

@export var Ingredient_Number : int = 0
var mouse_hover : bool = false
var defPosition : Vector2
var IsDraged : bool = false
@export var dringDish : Dish

# Called when the node enters the scene tree for the first time.
func _ready():
	defPosition = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if mouse_hover == true:
		self.position.y = lerp(self.position.y, defPosition.y - 30, 30 * delta)
		if Input.is_action_pressed("Mouse"):
			IsDraged = true
		
	else: if mouse_hover == false:
		if position != defPosition:
			position.y = lerp(position.y, defPosition.y, 10 * delta)
		
	if Input.is_action_pressed("Mouse") and IsDraged == true:
		#self.rotation_degrees = lerp(-30, 0, 20 * delta)
		rotation_degrees = -30
		position = get_global_mouse_position()
	else:
		drop()
		position = lerp(defPosition, self.position, 75 * delta)
		#self.position = defPosition
		if rotation_degrees != 0:
			#self.rotation_degrees = lerp(0, -30, 20 * delta)
			rotation_degrees = 0
		IsDraged = false

func _mouse_enter():
	mouse_hover = true

func _mouse_exit():
	mouse_hover = false
	
func drop():
	pass
