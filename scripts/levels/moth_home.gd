extends Node2D

@onready var name_group = $Name
@onready var name_box = $Name/NameBox
@onready var fade = $Name/Fade
@onready var player = $Player
@onready var left = $Left_Home_Entrance
@onready var right = $Right_Home_Entrance

var tween : Tween
var tween2 : Tween
var dialog

var name_timer = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if Globals.shut_up:
		$Bell.queue_free()
	
	if not Globals.woken:
		$Interact_Label.hide()
		$Interact_Label2.hide()
		Globals.can_move = false
	else:
		Globals.can_move = true
	
	if not VillageMusic.playing:
		VillageMusic.play()
	$Name/NameBox/Box.self_modulate = Color(1.5,1.5,1.5,1)
	print(Globals.spawn)
	if Globals.spawn == 1:
		player.position.x = left.position.x + 30
		player.face_right()
	elif Globals.spawn == 2:
		player.position.x = right.position.x - 30
		player.face_left()
	name_group.visible = true
	name_box.visible = true
	name_box.modulate.a = 0
	fade.modulate.a = 1
	fade.visible = true
	tween = create_tween()
	tween.tween_property(fade, "modulate:a", 0, 0.5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if name_timer >= 1:
		name_timer += delta
	
	if name_timer >= 2 and name_timer <= 3:
		tween = create_tween()
		tween.tween_property(name_box, "modulate:a", 1, 1)
		
	if name_timer >= 4:
		tween2 = create_tween()
		tween2.tween_property(name_box, "modulate:a", 0, 1)
		
	if name_timer >= 6:
		dialog = Dialogic.start("Wake")
		get_tree().root.add_child(dialog)
		Dialogic.timeline_ended.connect(dialog_end)
		name_timer = 0

func dialog_end():
	Globals.woken = true
	Globals.can_move = true
	$Interact_Label.show()
	$Interact_Label2.show()

func _on_left_home_entrance_body_entered(body: Node2D) -> void:
	Globals.can_move = false
	Globals.spawn = 1
	name_box.visible = true
	fade.visible = true
	tween = create_tween()
	tween.tween_property(fade, "modulate:a", 1, 0.5)
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://scenes/levels/MothVillage.tscn")

func _on_right_home_entrance_2_body_entered(body: Node2D) -> void:
	Globals.can_move = false
	Globals.spawn = 2
	name_box.visible = true
	fade.visible = true
	tween = create_tween()
	tween.tween_property(fade, "modulate:a", 1, 0.5)
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://scenes/levels/MothVillage.tscn")
