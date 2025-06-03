extends StaticBody2D

var in_body = false
var tween

@onready var interact_area = $Interact_Area
@onready var interact_label = $Interact_Label
@export var type = 1

var dialog = null

#Stinkbug = 1
#Clickbug = 2
#Spider = 3
#Museum beetle = 4
#Cockroach = 5
#Weevil = 6
#Moth1 = 20
#Moth2 = 21
#Moth3 = 22
#Moth4 = 23

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interact_label.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_label(delta)
	
	if in_body:
		interact_label.show()
		if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("dialogic_default_action"):
			if type == 1:
				dialog = Dialogic.start("StinkBug1")
			elif type == 2:
				dialog = Dialogic.start("ClickBug")
			elif type == 3:
				dialog = Dialogic.start("Spider")
			elif type == 4:
				dialog = Dialogic.start("MuseumBeetle")
			elif type == 20:
				dialog = Dialogic.start("Moth1")
			elif type == 21:
				dialog = Dialogic.start("Moth2")
			elif type == 22:
				dialog = Dialogic.start("Moth3")
			elif type == 23:
				dialog = Dialogic.start("Moth4")
			get_tree().root.add_child(dialog)
			in_body = false
	else:
		interact_label.hide()
		
func _on_interact_area_body_entered(body: CharacterBody2D) -> void:
	in_body = true

func _on_interact_area_body_exited(body: CharacterBody2D) -> void:
	in_body = false

func move_label(delta):
	pass
	
