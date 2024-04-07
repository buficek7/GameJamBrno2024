extends Control

@onready var Progress : ProgressBar = $ProgressBar
@onready var _Timer : Timer = $Timer
@onready var parent : Node2D = $"../../Node2D"
var timeLeft = null
signal  TimeOut

func _process(_delta):
	Progress.value = _Timer.time_left

func change_timer():
	if _Timer.is_stopped():
		_Timer.start(timeLeft)
		timeLeft = null
	else:
		timeLeft = _Timer.time_left
		stop_timer()

func start_timer():
	timeLeft = null
	Progress.max_value = parent.timerTime
	_Timer.autostart = false
	_Timer.start(parent.timerTime)

func stop_timer():
	_Timer.stop()

func _on_timer_timeout():
	TimeOut.emit()
	
func get_time_left():
	return _Timer.time_left
