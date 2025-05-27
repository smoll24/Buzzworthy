extends Area2D

@onready var sprite = $AnimatedSprite2D
@onready var player : CharacterBody2D

const JUMP_VELOCITY = -400.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_parent().get_node("Player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if sprite.animation == "bounce" and sprite.frame == 3:
		sprite.play("default")

func _on_body_entered(body: CharacterBody2D) -> void:
	if body.velocity.y > 0:
		body.velocity.y = JUMP_VELOCITY
		body.sprite.frame = 2
		body.sprite.play("jump")
	sprite.play("bounce")


func _on_rain_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
