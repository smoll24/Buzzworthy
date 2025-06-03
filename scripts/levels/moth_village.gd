extends Node2D

@onready var name_group = $Name
@onready var name_box = $Name/NameBox
@onready var fade = $Name/Fade

var tween : Tween
var tween2 : Tween

var name_timer = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	name_group.visible = true
	name_box.visible = true
	name_box.modulate.a = 0
	fade.visible = true
	tween = create_tween()
	tween.tween_property(fade, "modulate:a", 0, 2)


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
		
		
