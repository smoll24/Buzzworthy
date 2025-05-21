extends CanvasLayer

@onready var up = $VBoxContainer/Up_Button
@onready var left = $VBoxContainer/Left_Button
@onready var right = $VBoxContainer/Right_Button
@onready var down = $VBoxContainer/Down_Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	up.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
