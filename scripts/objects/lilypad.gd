extends Area2D

@onready var sprite = $AnimatedSprite2D
@onready var sound = $Shroom
var tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if sprite.animation == "bounce" and sprite.frame == 1:
		sprite.play("default")

func _on_body_entered(body: Node2D) -> void:
	sound.play()
	sprite.play("bounce")
	tween = create_tween()
	tween.tween_property(self, "position:y", self.position.y + 3, 1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position:y",  self.position.y - 3, 1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
