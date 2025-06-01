extends CanvasLayer


@onready var healthbar = $ProgressBar
@onready var wetbar = $MoistureBar
@onready var label_frames = $Label
@onready var log_label = $Log_Label
@onready var stone_label = $Stone_Label

var timer = 0
var timer_on = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	timer += delta
	
	if timer_on and timer > 2:
		var wet = Globals.get_wet()
		if wet > 0:
			wet -= 1
			Globals.set_wet(wet) 
		timer_on = false
	
	healthbar.frame = Globals.get_health()
	wetbar.frame = Globals.get_wet()
	label_frames.text = str(Engine.get_frames_per_second())
	log_label.text = str(Globals.logs)
	stone_label.text = str(Globals.stones)


func _on_moisture_bar_frame_changed() -> void:
	timer_on = true
	timer = 0
