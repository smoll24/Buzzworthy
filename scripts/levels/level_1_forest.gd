extends Node2D

@onready var player = $Player
@onready var name_group = $Name
@onready var name_box = $Name/NameBox
@onready var fade_box = $Fade
@onready var fade = $Fade/ColorRect
@onready var dark_box = $Darkness
@onready var dark = $Darkness/ColorRect
@onready var vignette = $Darkness/TextureRect
@onready var heartbeat = $CaveTheshold/Heartbeat
@onready var rain = $Rain
var tween : Tween
var tween2 : Tween
var dialog

var playing = true
var debried = false
var totemed = false
var fallen = false
var caved = false
var spidered = false

var name_timer = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)
	Globals.current_dialog = 3
	MiniBossMusic.stream_paused = true
	ForestAmbiance.stream_paused = true
	VillageMusic.stream_paused = true
	Level1Music.play()
	ready()
	
func ready() -> void:
	playing = true
	if not Globals.fallen:
		Globals.can_move = false
	else:
		Globals.can_move = true
	
	Globals.crafting = false
	if Globals.save_pos != Vector2(0, 0):
		player.position = Globals.save_pos
	
	dark_box.visible = true
	dark.visible = true
	vignette.visible = true
	dark.modulate = Color(1,1,1,0)
	vignette.modulate = Color(1,1,1,0)
	Level1Music.volume_db = -50
	
	name_group.visible = true
	name_box.visible = true
	name_box.modulate.a = 0
	$Name/NameBox/Box.self_modulate = Color(1.5,1.5,1.5,1)
	
	fade_box.visible = true
	fade.visible = true
	tween = create_tween()
	tween.tween_property(fade, "modulate:a", 0, 5)
	tween.parallel().tween_property(Level1Music, "volume_db", 0, 2)
	await get_tree().create_timer(5).timeout
	fade.visible = false

func _on_dialogic_signal(argument:String):
	if argument == "exit_forest":
		exit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if name_timer >= 1:
		name_timer += delta
	
	if name_timer >= 4 and name_timer <= 5:
		tween = create_tween()
		tween.tween_property(name_box, "modulate:a", 1, 1)
		
	if name_timer >= 7:
		tween2 = create_tween()
		tween2.tween_property(name_box, "modulate:a", 0, 1)
		
	if name_timer >= 8:
		if not Globals.fallen:
			dialog = Dialogic.start("Lost")
			get_tree().root.add_child(dialog)
			Dialogic.timeline_ended.connect(dialog_end)
			Globals.fallen = true
		name_timer = 0
	
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
	
func dialog_end_spider():
	Globals.can_move = true
	heartbeat.stop()
	tween = create_tween()
	tween.tween_property(Level1Music, "volume_db", 0, 2)
	tween.parallel().tween_property(vignette, "modulate:a", 0, 0.5)
	tween.parallel().tween_property(dark, "modulate:a", 0, 0.5)

func respawn():
	Globals.can_move = false
	playing = false
	Lose.play()
	fade_box.visible = true
	fade.visible = true
	fade.modulate.a = 0
	tween = create_tween()
	tween.tween_property(fade, "modulate:a", 1, 2)
	#tween.parallel().tween_property(Level1Music, "volume_db", -50, 2)
	await get_tree().create_timer(3).timeout
	Globals.current_health = Globals.max_health
	Globals.current_wet = 0
	#get_tree().reload_current_scene() 
	ready()


func _on_cave_theshold_body_entered(body: CharacterBody2D) -> void:
	if not Globals.spider_met:
		heartbeat.play()
		tween = create_tween()
		tween.tween_property(Level1Music, "volume_db", -50, 3)
		tween.parallel().tween_property(dark, "modulate:a", 1, 2)
		tween.parallel().tween_property(vignette, "modulate:a", 1, 2)


#func _on_cave_theshold_body_exited(body: Node2D) -> void:
	#heartbeat.stop()
	#tween = create_tween()
	#tween.tween_property(Level1Music, "volume_db", 0, 2)
	#tween.parallel().tween_property(vignette, "modulate:a", 0, 0.5)
	#tween.parallel().tween_property(dark, "modulate:a", 0, 0.5)


func _on_debris_dialog_body_entered(body: Node2D) -> void:
	if not debried:
		Globals.can_move = false
		dialog = Dialogic.start("Debris")
		get_tree().root.add_child(dialog)
		Dialogic.timeline_ended.connect(dialog_end)
		debried = true

func _on_totem_dialog_body_entered(body: Node2D) -> void:
	if not totemed:
		Globals.can_move = false
		dialog = Dialogic.start("Totem")
		get_tree().root.add_child(dialog)
		Dialogic.timeline_ended.connect(dialog_end)
		totemed = true


func _on_exit_entrance_body_entered(body: CharacterBody2D) -> void:
	Globals.can_move = false
	dialog = Dialogic.start("Exit_Forest")
	get_tree().root.add_child(dialog)
	Dialogic.timeline_ended.connect(dialog_end)
	
	
func exit():
	Globals.can_move = false
	Globals.save_pos = Vector2(0, 0)
	Globals.spawn = 0
	fade.modulate.a = 0
	fade_box.visible = true
	fade.visible = true
	tween = create_tween()
	tween.tween_property(fade, "modulate:a", 1, 0.5)
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://scenes/cutscenes/Exposition.tscn")


func _on_fall_dialogue_body_entered(body: Node2D) -> void:
	if not fallen:
		Globals.can_move = false
		dialog = Dialogic.start("Fall")
		get_tree().root.add_child(dialog)
		Dialogic.timeline_ended.connect(dialog_end)
		fallen = true


func _on_cave_dialogue_body_entered(body: Node2D) -> void:
	if not caved:
		Globals.can_move = false
		dialog = Dialogic.start("Scared")
		get_tree().root.add_child(dialog)
		Dialogic.timeline_ended.connect(dialog_end)
		caved = true


func _on_spider_dialogue_body_entered(body: Node2D) -> void:
	if not spidered:
		Globals.can_move = false
		dialog = Dialogic.start("SpiderIntro")
		get_tree().root.add_child(dialog)
		Dialogic.timeline_ended.connect(dialog_end_spider)
		spidered = true
