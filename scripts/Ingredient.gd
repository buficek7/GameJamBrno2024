extends Area2D

var mouse_hover : bool = false
var defPosition : Vector2
var IsDraged : bool = false
@export_category("Base")
@export var Ingredient_Number : int = 0
@export var dringDish : Dish
@export_category("Movement")
@export var MoveUp : float = 30
@export var MoveUpSpeed : float = 30
@export var IngredientRotation : float = 30
@export var ReturnSpeed : float = 75

# Called when the node enters the scene tree for the first time.
func _ready():
	defPosition = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if mouse_hover == true:
		self.position.y = lerp(self.position.y, defPosition.y - MoveUp, MoveUpSpeed * delta)
		if Input.is_action_pressed("Mouse"):
			IsDraged = true
		
	else: if mouse_hover == false:
		if position != defPosition:
			position.y = lerp(position.y, defPosition.y, MoveUpSpeed * delta)
		
	if Input.is_action_pressed("Mouse") and IsDraged == true:
		#self.rotation_degrees = lerp(-30, 0, 20 * delta)
		rotation_degrees = -IngredientRotation
		position = get_global_mouse_position()
	else: if Input.is_action_just_released("Mouse") and IsDraged == true:
		drop()
		#self.position = defPosition
		if rotation_degrees != 0:
			#self.rotation_degrees = lerp(0, -30, 20 * delta)
			rotation_degrees = 0
		IsDraged = false
	else:
		position = lerp(defPosition, self.position, ReturnSpeed * delta)

func _mouse_enter():
	mouse_hover = true

func _mouse_exit():
	mouse_hover = false
	
func _on_Area2D_body_enter(body):
	#if body = dringDish:
		pass
	
func drop():
	dringDish.addIngredient(Ingredient_Number)
	print_debug(Ingredient_Number)
