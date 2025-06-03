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

var playing = true

var name_timer = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
	tween.tween_property(fade, "modulate:a", 0, 2)
	tween.parallel().tween_property(Level1Music, "volume_db", 0, 2)
	await get_tree().create_timer(2).timeout
	fade.visible = false
	Level1Music.play()


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
		

func respawn():
	playing = false
	Lose.play()
	fade_box.visible = true
	fade.visible = true
	tween = create_tween()
	tween.tween_property(fade, "modulate:a", 1, 2)
	tween.parallel().tween_property(Level1Music, "volume_db", -50, 2)
	rain.queue_free()
	await get_tree().create_timer(3).timeout
	Globals.current_health = Globals.max_health
	Globals.current_wet = 0
	get_tree().reload_current_scene() 


func _on_cave_theshold_body_entered(body: CharacterBody2D) -> void:
	heartbeat.play()
	tween = create_tween()
	tween.tween_property(Level1Music, "volume_db", -50, 3)
	tween.parallel().tween_property(dark, "modulate:a", 1, 2)
	tween.parallel().tween_property(vignette, "modulate:a", 1, 2)


func _on_cave_theshold_body_exited(body: Node2D) -> void:
	heartbeat.stop()
	tween = create_tween()
	tween.tween_property(Level1Music, "volume_db", 0, 2)
	tween.parallel().tween_property(vignette, "modulate:a", 0, 0.5)
	tween.parallel().tween_property(dark, "modulate:a", 0, 0.5)
