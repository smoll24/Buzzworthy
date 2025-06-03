extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D
@onready var sound = $Shroom
var tween

@export var distance_x = 100
@export var distance_y = 100
@export var speed = 5

var player
var in_body

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tween = create_tween().set_loops()
	tween.tween_property(self, "position:x", self.position.x + distance_x, speed).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(self, "position:y", self.position.y + distance_y, speed).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position:x",  self.position.x - distance_x, speed).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(self, "position:y", self.position.y - distance_y, speed).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if in_body:
		player.velocity.x = velocity.x
		pass
	elif not in_body and player:
		pass

func _on_area_body_2d_body_entered(body: Node2D) -> void:
	player = body
	in_body = true
	sound.play()
	#sprite.play("bounce")
	#tween = create_tween()
	#tween.tween_property(self, "position:y", self.position.y + 3, 1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	#tween.tween_property(self, "position:y",  self.position.y - 3, 1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)


func _on_area_body_2d_body_exited(body: Node2D) -> void:
	in_body = false
