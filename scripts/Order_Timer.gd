extends Control

@onready var Progress : ProgressBar = $ProgressBar
@onready var _Timer : Timer = $Timer
signal  TimeOut

func _ready():
	pass

func _process(delta):
	Progress.value = _Timer.time_left

func start_timer(time):
	Progress.max_value = time
	_Timer.start(time)

func _on_timer_timeout():
	TimeOut.emit()
