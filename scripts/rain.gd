extends Area2D

@onready var area = $CollisionShape2D
var rand_x
var rand_a
var timer = 0

var raining = false

var player : CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer += delta
	if timer > 0.01:
		spawn_rain()
		timer = 0


func spawn_rain():
	rand_x = randf_range(-1000,1000)
	rand_a = randf_range(0.00,1.00)
	var raindrop = preload("res://scenes/objects/Raindrop.tscn").instantiate()
	add_child(raindrop)
	raindrop.position = Vector2(area.position.x+rand_x, area.position.y-100)
	raindrop.get_node("AnimatedSprite2D").modulate = Color(1,1,1,rand_a)
	

func _on_body_entered(body: Node2D) -> void:
	raining = true

func _on_body_exited(body: Node2D) -> void:
	raining = false
