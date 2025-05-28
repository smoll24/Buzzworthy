extends StaticBody2D

var in_body = false
var tween

@onready var interact_area = $Interact_Area
@onready var interact_label = $Interact_Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interact_label.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_label(delta)
	
	if in_body:
		interact_label.show()
		if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("dialogic_default_action"):
			Dialogic.start("test_timeline")
			in_body = false
	else:
		interact_label.hide()
		
func _on_interact_area_body_entered(body: CharacterBody2D) -> void:
	in_body = true

func _on_interact_area_body_exited(body: CharacterBody2D) -> void:
	in_body = false

func move_label(delta):
	pass
	
