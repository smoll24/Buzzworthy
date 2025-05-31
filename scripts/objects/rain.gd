extends Area2D

@onready var sprite = $AnimatedSprite2D
var player : CharacterBody2D
var timer = 0
var ground = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_parent().get_parent().get_node("Player")
	sprite.play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer += delta
	if timer > 0.001 and not ground:
		self.position = Vector2(self.position.x-3,self.position.y+3)
		timer = 0
	if sprite.animation == "ground":
		if sprite.frame == 6:
			self.queue_free()


func _on_body_entered(body: Node2D) -> void:
	ground = true
	if body == player:
		player.apply_hit2_effect()
	sprite.play("ground")


func _on_area_entered(area: Area2D) -> void:
	ground = true
	sprite.play("ground")
