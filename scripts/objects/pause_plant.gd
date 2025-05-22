extends StaticBody2D

@onready var sprite = $AnimatedSprite2D
@onready var collision = $CollisionShape2D
@onready var area = $Area2D

@export var stand_time: float = 2.0 

var timer: float = 0.0
var player_on_platform: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _process(delta):
	$Label.text = str(timer)
	
	if player_on_platform:
		timer += delta
		if timer >= stand_time:
			collision.disabled = true
			
	else:
		timer = 0

func _on_area_2d_body_entered(_body: Node2D) -> void:
	player_on_platform = true

func _on_area_2d_body_exited(_body: Node2D) -> void:
	player_on_platform = false
