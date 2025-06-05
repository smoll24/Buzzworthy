extends Node2D

@onready var name_group = $Name
@onready var name_box = $Name/NameBox
@onready var fade = $Name/Fade
@onready var player = $Player
@onready var wasp = $MudDauber
@onready var overlay = $Overlay
@onready var vignette = $WaspHealth/TextureRect2
@onready var wasp_health = $WaspHealth
@onready var tilemap = $Ground

var texture

@onready var red = "res://assets/tilemaps/forest_red.png"

var tween : Tween
var tween2 : Tween
var entered = false
var mid = false
var nested = false
var dialog
var name_timer = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture = load(red)
	tilemap.tile_set.get_source(0).texture = texture
	tilemap.tile_set.get_source(1).texture = texture
	
	wasp_health.hide()
	Globals.can_move = false
	overlay.craft_hide()
	
	if VillageMusic.playing:
		VillageMusic.stream_paused = true
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
		dialog = Dialogic.start("MiniBossEntrance")
		get_tree().root.add_child(dialog)
		Dialogic.timeline_ended.connect(entrance_end)
		name_timer = 0
		
	if Globals.current_health == 0:
		Globals.can_move = false
		name_box.visible = true
		fade.visible = true
		tween = create_tween()
		tween.tween_property(fade, "modulate:a", 1, 0.5)
		await get_tree().create_timer(0.5).timeout
		Globals.current_dialog = 2
		get_tree().change_scene_to_file("res://scenes/cutscenes/Exposition.tscn")

#func _on_dialog_npc_entrance_body_entered(body: Node2D) -> void:
	#if not entered:
		#Globals.can_move = false
		#dialog = Dialogic.start("MiniBossEntrance")
		#get_tree().root.add_child(dialog)
		#Dialogic.timeline_ended.connect(entrance_end)
		#entered = true

func _on_dialog_wasp_entrance_body_entered(body: Node2D) -> void:
	if not nested:
		Globals.can_move = false
		dialog = Dialogic.start("Nest")
		get_tree().root.add_child(dialog)
		Dialogic.timeline_ended.connect(nest_end)
		nested = true


func entrance_end():
	Globals.can_move = true
	
func nest_end():
	MiniBossMusic.play()
	Globals.can_move = true
	wasp.set_move()
	wasp.set_chase()
	wasp_health.show()

#
#func _on_dialog_npc_mid_body_entered(body: Node2D) -> void:
	#if not mid:
		#Globals.can_move = false
		#dialog = Dialogic.start("MiniBossEntrance")
		#get_tree().root.add_child(dialog)
		#Dialogic.timeline_ended.connect(entrance_end)
		#mid = true
