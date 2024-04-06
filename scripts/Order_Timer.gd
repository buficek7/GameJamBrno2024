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
	_Timer.autostart = false
	_Timer.start(time)

func stop_timer():
	_Timer.stop()

func _on_timer_timeout():
	TimeOut.emit()
