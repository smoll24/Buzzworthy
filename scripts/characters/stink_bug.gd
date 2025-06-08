extends StaticBody2D

var in_body = false
var tween

@onready var interact_area = $Interact_Area
@onready var interact_label = $Interact_Label
@export var type = 1

var dialog = null
var can_talk = true

#Stinkbug = 1
#Clickbug = 2
#Spider = 3
#Museum beetle = 4
#Cockroach = 5
#Weevil1 = 6
#Weevil2 = 7
#Pillbug = 8
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
	
	if type == 2:
		$AnimatedSprite2D.scale.y = Dialogic.VAR.flipped
	
	if in_body:
		if can_talk:
			if type == 1 and not Globals.stinkbug:
				interact_label.show()
			elif type == 1 and Globals.stinkbug and Globals.has_shield:
				interact_label.show()
			elif type == 2 and not Globals.clickbug:
				interact_label.show()
			elif type == 2 and Globals.clickbug and Globals.has_helmet:
				interact_label.show()
			elif type == 3 and not Globals.spider:
				interact_label.show()
			elif type == 3 and Globals.spider and Globals.has_sword:
				interact_label.show()
			elif type == 4 and not Globals.museum:
				interact_label.show()
			elif type == 4 and Globals.museum and Globals.has_boots:
				interact_label.show()
			elif type == 5 and not Globals.cockroach:
				interact_label.show()
			elif type == 5 and Globals.cockroach and Globals.has_sword2:
				interact_label.show()
			elif type == 8 and not Globals.pillbug:
				interact_label.show()
			elif type == 6 and Globals.weevil1 and Globals.has_shield2:
				interact_label.show()
			elif type == 6 and not Globals.weevil1:
				interact_label.show()
			elif type == 7 and not Globals.weevil2:
				interact_label.show()
			else:
				interact_label.hide()
		else:
			interact_label.hide()
			
		if Input.is_action_just_pressed("ui_accept") and can_talk and interact_label.visible:
			if type == 1 and not Globals.stinkbug:
				dialog = Dialogic.start("StinkBug1")
			elif type == 1 and Globals.stinkbug and Globals.has_shield:
				dialog = Dialogic.start("GiveShield")
			elif type == 2 and not Globals.clickbug:
				dialog = Dialogic.start("ClickBug")
			elif type == 2 and Globals.clickbug and Globals.has_helmet:
				dialog = Dialogic.start("GiveHelmet")
			elif type == 3 and not Globals.spider:
				Globals.spider_met = true
				dialog = Dialogic.start("Spider")
			elif type == 3 and Globals.spider and Globals.has_sword:
				dialog = Dialogic.start("GiveSword")
			elif type == 4 and not Globals.museum:
				dialog = Dialogic.start("MuseumBeetle")
			elif type == 4 and Globals.museum and Globals.has_boots:
				dialog = Dialogic.start("GiveBoots")
			elif type == 5 and not Globals.cockroach:
				dialog = Dialogic.start("Cockroach")
			elif type == 5 and Globals.cockroach and Globals.has_sword2:
				dialog = Dialogic.start("GiveSword2")
			elif type == 6 and not Globals.weevil1:
				dialog = Dialogic.start("Weevil1")
			elif type == 6 and Globals.weevil1 and Globals.has_shield2:
				dialog = Dialogic.start("GiveShield2")
			elif type == 7 and not Globals.weevil2:
				dialog = Dialogic.start("Weevil2")
			elif type == 8 and not Globals.pillbug:
				dialog = Dialogic.start("PillBug")
			elif type == 20:
				dialog = Dialogic.start("Moth1")
			elif type == 21:
				dialog = Dialogic.start("Moth2")
			elif type == 22:
				dialog = Dialogic.start("Moth3")
			elif type == 23:
				dialog = Dialogic.start("Moth4")
			get_tree().root.add_child(dialog)
			Dialogic.timeline_ended.connect(dialog_end)
			can_talk = false
			Globals.can_move = false
	else:
		interact_label.hide()
		
func _on_interact_area_body_entered(body: CharacterBody2D) -> void:
	in_body = true

func _on_interact_area_body_exited(body: CharacterBody2D) -> void:
	in_body = false

func dialog_end():
	await get_tree().create_timer(0.5).timeout
	if type == 5:
		Globals.cockroach = true
	elif type == 8:
		Globals.pillbug = true
	elif type == 6:
		Globals.weevil1 = true
	elif type == 7:
		Globals.weevil2 = true
	elif type == 1:
		Globals.stinkbug = true
	elif type == 2:
		Globals.clickbug = true
	elif type == 3:
		Globals.spider = true
	elif type == 4:
		Globals.museum = true
	
	can_talk = true
	Globals.can_move = true

func move_label(delta):
	pass
	
