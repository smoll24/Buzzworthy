extends Area2D


var in_body = false
var selected = false

@onready var sprite = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not selected:
		if in_body:
			sprite.play("select")
		else:
			sprite.play("default")
			
	
	if in_body and not selected:
		#interact_label.show()
		if Input.is_action_just_pressed("ui_accept"):
			sprite.play("saving")
			in_body = false
			selected = true
	else:
		#interact_label.hide()
		pass


func _on_body_entered(body: CharacterBody2D) -> void:
	in_body = true

func _on_body_exited(body: Node2D) -> void:
	in_body = false
