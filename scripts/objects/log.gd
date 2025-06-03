extends Area2D

var in_body = false
var tween

@export var type = 0
@onready var sprite = $AnimatedSprite2D

#logs = 0
#stones = 1

#sword recipe = 10
#shield recipe = 11
#helmet recipe = 12
#boots recipe = 13

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(type)
	tween = create_tween().set_loops()
	tween.tween_property(self, "position:y", self.position.y + 5, 1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position:y",  self.position.y - 5, 1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if in_body:
		sprite.play("select")
	else:
		sprite.play("default")


func _on_body_entered(body: Node2D) -> void:
	Pickup.play()
	self.queue_free()
	if type == 0:
		Globals.logs += 1
	elif type == 1:
		Globals.stones += 1
	
	elif type == 10:
		Globals.has_sword_recipe = true
	elif type == 11:
		Globals.has_shield_recipe = true
	elif type == 12:
		Globals.has_helmet_recipe = true
	elif type == 13:
		Globals.has_boots_recipe = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	in_body = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	in_body = false
