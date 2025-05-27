extends CanvasLayer


@onready var healthbar = $ProgressBar
@onready var label_frames = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	healthbar.frame = Globals.get_health() - 1
	label_frames.text = str(Engine.get_frames_per_second())
