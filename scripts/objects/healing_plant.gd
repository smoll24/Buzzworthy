extends Area2D

@onready var sprite = $AnimatedSprite2D
var player : CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_parent().get_node("Player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func _on_body_entered(_body: Node2D) -> void:
	player.apply_heal_effect()
	Advance.play()
