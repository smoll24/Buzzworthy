extends Node2D

@onready var player = $Player
@onready var name_group = $Name
@onready var name_box = $Name/NameBox
@onready var fade_box = $Fade
@onready var fade = $Fade/ColorRect
var tween : Tween
var tween2 : Tween
var dialog

var in_water = false

var playing = true

var name_timer = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)
	Globals.current_dialog = 4
	Level1Music.stream_paused = true
	VillageMusic.stream_paused = true
	if not Level2Music.playing:
		Level2Music.play()
	if not WaterStream.playing:
		WaterStream.play()
	ready()

func _on_dialogic_signal(argument:String):
	if argument == "exit_wetlands":
		exit()


func ready() -> void:
	playing = true
	Globals.can_move = true
	
	Globals.crafting = false
	if Globals.save_pos != Vector2(0, 0):
		player.position = Globals.save_pos
	
	Level2Music.volume_db = -50
	
	name_group.visible = true
	name_box.visible = true
	name_box.modulate.a = 0
	$Name/NameBox/Box.self_modulate = Color(1.5,1.5,1.5,1)
	
	fade_box.visible = true
	fade.visible = true
	tween = create_tween()
	tween.tween_property(fade, "modulate:a", 0, 5)
	tween.parallel().tween_property(Level2Music, "volume_db", 0, 2)
	await get_tree().create_timer(5).timeout
	fade.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if in_water and Globals.current_health > 0:
		player.apply_hitup_effect()
	
	
	if name_timer >= 1:
		name_timer += delta
	
	if name_timer >= 4 and name_timer <= 5:
		tween = create_tween()
		tween.tween_property(name_box, "modulate:a", 1, 1)
		
	if name_timer >= 7:
		tween2 = create_tween()
		tween2.tween_property(name_box, "modulate:a", 0, 1)
		name_timer = 0
		
	#if name_timer >= 8:
		#if not Globals.fallen:
			#dialog = Dialogic.start("Lost")
			#get_tree().root.add_child(dialog)
			#Dialogic.timeline_ended.connect(dialog_end)
			#Globals.fallen = true
		#name_timer = 0
	
	#Reset tweens
	if name_timer == 0:
		if name_box.modulate.a == 0:
			name_box.visible = false
			fade.visible = false
			tween = create_tween()
			tween.tween_property(name_box, "modulate:a", 1, 0)
			tween.tween_property(fade, "modulate:a", 1, 0)
			Globals.crafting = true
	
	if Globals.current_health == 0 and playing:
		respawn()
		
	
func dialog_end():
	Globals.can_move = true

func respawn():
	Globals.can_move = false
	playing = false
	Lose.play()
	fade_box.visible = true
	fade.visible = true
	tween = create_tween()
	tween.tween_property(fade, "modulate:a", 1, 2)
	#tween.parallel().tween_property(Level1Music, "volume_db", -50, 2)
	await get_tree().create_timer(3).timeout
	Globals.current_health = Globals.max_health
	#get_tree().reload_current_scene() 
	ready()


func _on_water_body_entered(body: CharacterBody2D) -> void:
	WaterSplash.play()
	in_water = true


func _on_water_body_exited(body: Node2D) -> void:
	in_water = false


func _on_exit_entrance_body_entered(body: CharacterBody2D) -> void:
	Globals.can_move = false
	dialog = Dialogic.start("Exit_Wetland")
	get_tree().root.add_child(dialog)
	Dialogic.timeline_ended.connect(dialog_end)
	
func exit():
	Globals.can_move = false
	Globals.save_pos = Vector2(0, 0)
	Globals.spawn = 0
	fade.modulate.a = 0
	fade.visible = true
	tween = create_tween()
	tween.tween_property(fade, "modulate:a", 1, 0.5)
	await get_tree().create_timer(0.5).timeout
	WaterStream.stream_paused = true
	get_tree().change_scene_to_file("res://scenes/cutscenes/Exposition.tscn")
	
