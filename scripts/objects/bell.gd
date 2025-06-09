extends Area2D


var in_body = false
var selected = false

@onready var sprite = $AnimatedSprite2D
@onready var sound = $Bells
@export var id = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Globals.bell1 and id == 1:
		sound.free()
		selected = true
	elif Globals.shut_up and id == 2:
		sound.free()
		selected = true
	elif Globals.bell2 and id == 3:
		sound.free()
		selected = true
	elif Globals.bell3 and id == 4:
		sound.free()
		selected = true
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not selected:
		if in_body:
			sprite.animation = "select"
		else:
			sprite.animation = "ringing"
	else:
		sprite.play("default")
	
	
	if Globals.current_dialog > 3:
		sprite.play("default")
		$Bells.volume_db = -100
			
	
	if in_body and not selected:
		#interact_label.show()
		if Input.is_action_just_pressed("ui_accept"):
			Click.play()
			in_body = false
			selected = true
			if id == 2:
				Globals.shut_up = true
			elif id == 1:
				Globals.bell1 = true
			elif id == 3:
				Globals.bell2 = true
			elif id == 4:
				Globals.bell3 = true
			sound.queue_free()
	else:
		#interact_label.hide()
		pass


func _on_body_entered(body: CharacterBody2D) -> void:
	in_body = true

func _on_body_exited(body: Node2D) -> void:
	in_body = false
