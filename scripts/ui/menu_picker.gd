extends CanvasLayer

@onready var up = $VBoxContainer/Up_Button
@onready var left = $VBoxContainer/HBoxContainer/Left_Button
@onready var right = $VBoxContainer/HBoxContainer/Right_Button
@onready var down = $VBoxContainer/Down_Button


func _input(event):
	if event.is_action_pressed("pause"):
		var new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
		visible = new_pause_state
		up.grab_focus()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
