extends Node2D

@onready var name_group = $Name
@onready var name_box = $Name/NameBox
@onready var fade = $Name/Fade
@onready var player = $Player
@onready var left = $Left_Home_Entrance
@onready var right = $Right_Home_Entrance
var courted = false

var tween : Tween
var tween2 : Tween
var dialog

var name_timer = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.can_move = false
	if not VillageMusic.playing:
		VillageMusic.play()
	$Name/NameBox/Box.self_modulate = Color(1.5,1.5,1.5,1)
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
		Globals.can_move = false
		dialog = Dialogic.start("Courthouse")
		get_tree().root.add_child(dialog)
		Dialogic.timeline_ended.connect(dialog_end)
		courted = true
		name_timer = 0

func dialog_end():
	Globals.can_move = false
	Globals.spawn = 2
	name_box.visible = true
	fade.visible = true
	tween = create_tween()
	tween.tween_property(fade, "modulate:a", 1, 0.5)
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://scenes/levels/MiniBoss.tscn")
