extends Control

@onready var fade = $Fade
@onready var start = $VBoxContainer/Start
var tween : Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	fade.visible = true
	tween = create_tween()
	tween.tween_property(fade, "modulate:a", 0, 1)
	start.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	tween = create_tween()
	tween.tween_property(fade, "modulate:a", 1, 0.5)
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://scenes/cutscenes/MothPray.tscn")


func _on_settings_pressed() -> void:
	tween = create_tween()
	tween.tween_property(fade, "modulate:a", 1, 0.5)
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://scenes/ui/settings.tscn")


func _on_quit_pressed() -> void:
	tween = create_tween()
	tween.tween_property(fade, "modulate:a", 1, 0.5)
	await get_tree().create_timer(0.5).timeout
	get_tree().quit()
