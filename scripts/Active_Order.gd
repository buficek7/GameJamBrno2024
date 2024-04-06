extends RichTextLabel

@onready var orderControl : Level = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	text = orderControl.get_order_descript()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("Serve"):
		text = orderControl.get_order_descript()
