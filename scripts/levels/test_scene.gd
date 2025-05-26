extends Node2D

var in_body = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if in_body:
		$Test_Dialog/Label.show()
		if Input.is_action_just_pressed("ui_accept"):
			Dialogic.start("test_timeline")
			in_body = false
	else:
		$Test_Dialog/Label.hide()
		

func _on_test_dialog_body_entered(body: Node2D) -> void:
	in_body = true


func _on_test_dialog_body_exited(body: Node2D) -> void:
	in_body = false
