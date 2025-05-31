extends Node2D

@onready var fade_box = $Fade
@onready var fade = $Fade/ColorRect
@onready var music = $ForestPiano
var tween : Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fade_box.visible = true
	fade.visible = true
	tween = create_tween()
	tween.tween_property(fade, "modulate:a", 0, 2)
	await get_tree().create_timer(2).timeout
	fade.visible = false
	Level1Music.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
