extends Node2D

@onready var fade_box = $Fade
@onready var fade = $Fade/ColorRect
@onready var dark_box = $Darkness
@onready var dark = $Darkness/ColorRect
@onready var vignette = $Darkness/TextureRect
@onready var music = $ForestPiano
@onready var heartbeat = $CaveTheshold/Heartbeat
@onready var rain = $Rain
var tween : Tween

var playing = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dark_box.visible = true
	dark.visible = true
	vignette.visible = true
	dark.modulate = Color(1,1,1,0)
	vignette.modulate = Color(1,1,1,0)
	Level1Music.volume_db = -50
	
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
