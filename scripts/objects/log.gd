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
#sword2 recipe = 14
#shield2 recipe = 15

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tween = create_tween().set_loops()
	tween.tween_property(self, "position:y", self.position.y + 5, 1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position:y",  self.position.y - 5, 1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if in_body:
		sprite.play("select")
	else:
		sprite.play("default")
		
	if type == 15: 
		if Globals.pillbug:
			self.show()
		else:
			self.hide()

	if type == 14:
		if Globals.weevil2:
			self.show()
		else:
			self.hide()
			
		
	if type == 12: 
		if Globals.stinkbug:
			self.show()
		else:
			self.hide()

	if type == 13:
		if Globals.spider:
			self.show()
		else:
			self.hide()

func _on_body_entered(body: Node2D) -> void:
	if self.visible:
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
		elif type == 14:
			Globals.has_sword2_recipe = true
		elif type == 15:
			Globals.has_shield2_recipe = true

func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	in_body = true

func _on_area_2d_body_exited(body: CharacterBody2D) -> void:
	in_body = false
