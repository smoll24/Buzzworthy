extends Node2D

@onready var fade_box = $Fade
@onready var fade = $Fade/ColorRect
@onready var dark_box = $Darkness
@onready var dark = $Darkness/ColorRect
@onready var vignette = $Darkness/TextureRect
@onready var music = $ForestPiano
@onready var heartbeat = $CaveTheshold/Heartbeat
var tween : Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dark_box.visible = true
	dark.visible = true
	vignette.visible = true
	dark.modulate = Color(1,1,1,0)
	vignette.modulate = Color(1,1,1,0)
	
	fade_box.visible = true
	fade.visible = true
	tween = create_tween()
	tween.tween_property(fade, "modulate:a", 0, 2)
	await get_tree().create_timer(2).timeout
	fade.visible = false
	#Level1Music.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_cave_theshold_body_entered(body: Node2D) -> void:
	heartbeat.play()
	tween = create_tween()
	tween.tween_property(dark, "modulate:a", 1, 2)
	tween.tween_property(vignette, "modulate:a", 1, 2)


func _on_cave_theshold_body_exited(body: Node2D) -> void:
	heartbeat.stop()
	tween = create_tween()
	tween.tween_property(vignette, "modulate:a", 1, 0.5)
	tween.tween_property(dark, "modulate:a", 0, 0.5)
