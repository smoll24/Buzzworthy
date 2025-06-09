extends Node2D

@onready var name_group = $Name
@onready var name_box = $Name/NameBox
@onready var fade = $Name/Fade
@onready var player = $Player
@onready var wasp = $MudDauber
@onready var wasp2 = $MudDauber2
@onready var queen = $Queen
@onready var overlay = $Overlay
@onready var vignette = $WaspHealth/TextureRect2
@onready var wasp_health = $WaspHealth


var tween : Tween
var tween2 : Tween
var bossed = false
var dialog
var name_timer = 1
var helped = false
var wasp_show
var music_started = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	Globals.current_dialog = 5
	
	wasp_health.hide()
	Globals.can_move = false
	overlay.craft_hide()
	
	if VillageMusic.playing:
		VillageMusic.stream_paused = true
	if Level2Music.playing:
		Level2Music.stream_paused = true
	ForestAmbiance.play()
		
	$Name/NameBox/Box.self_modulate = Color(1,1,1,1)
	name_group.visible = true
	name_box.visible = true
	name_box.modulate.a = 0
	fade.modulate.a = 1
	fade.visible = true
	tween = create_tween()
	tween.tween_property(fade, "modulate:a", 0, 5)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	wasp_show = Dialogic.VAR.wasp_show
	if wasp_show and not music_started:
		BossMusic.play()
		music_started = true
	
	if not wasp_show:
		queen.hide()
		wasp.hide()
		wasp2.hide()
	else:
		queen.show()
		wasp.show()
		wasp2.show()
	
	if Globals.current_health == 5:
		vignette.modulate.a = 0.0
	elif Globals.current_health == 4:
		vignette.modulate.a = 0.2
	elif Globals.current_health == 3:
		vignette.modulate.a = 0.25
	elif Globals.current_health == 2:
		vignette.modulate.a = 0.3
	elif Globals.current_health == 1:
		vignette.modulate.a = 0.4
	
	if name_timer >= 1:
		name_timer += delta
	
	if name_timer >= 4 and name_timer <= 5:
		tween = create_tween()
		tween.tween_property(name_box, "modulate:a", 1, 1)
		
	if name_timer >= 6:
		tween2 = create_tween()
		tween2.tween_property(name_box, "modulate:a", 0, 1)

	if name_timer >= 7:
		dialog = Dialogic.start("BossEntrance")
		get_tree().root.add_child(dialog)
		Dialogic.timeline_ended.connect(entrance_end)
		name_timer = 0
		
	
	if Globals.current_health <= 2:
		#queen.stop_move()
		queen.stop_chase()
		if not helped:
			Globals.can_move = false
			if Globals.bugs_helped >= 4:
				dialog = Dialogic.start("FullBugs")
			elif Globals.bugs_helped == 0:
				dialog = Dialogic.start("NoBugs")
			else:
				dialog = Dialogic.start("MidBugs")
			
			get_tree().root.add_child(dialog)
			Dialogic.timeline_ended.connect(nest_end)
			
			helped = true
		
	if Globals.current_health == 0:
		Globals.can_move = false
		name_box.visible = true
		fade.visible = true
		tween = create_tween()
		tween.tween_property(fade, "modulate:a", 1, 0.5)
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file("res://scenes/cutscenes/Exposition.tscn")

#func _on_dialog_npc_entrance_body_entered(body: Node2D) -> void:
	#if not entered:
		#Globals.can_move = false
		#dialog = Dialogic.start("MiniBossEntrance")
		#get_tree().root.add_child(dialog)
		#Dialogic.timeline_ended.connect(entrance_end)
		#entered = true

func _on_dialog_wasp_entrance_body_entered(body: Node2D) -> void:
	if not bossed:
		Globals.can_move = false
		dialog = Dialogic.start("BossIntro")
		get_tree().root.add_child(dialog)
		Dialogic.timeline_ended.connect(nest_end)
		bossed = true


func entrance_end():
	Globals.can_move = true
	
func nest_end():
	Globals.can_move = true
	queen.set_move()
	queen.set_chase()
	wasp_health.show()
