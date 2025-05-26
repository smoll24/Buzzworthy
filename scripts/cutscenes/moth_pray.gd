extends Node2D

@onready var moth = $Moth

var timer = 0
var count = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	moth.position.y = moth.position.y + 90
	moth.self_modulate.r = 1.25
	moth.self_modulate.a = 0
	moth.scale.x = 0
	moth.scale.y = 0
	moth.frame = 0
	Globals.swap = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer += delta
	if count <= 50:
		if timer >= 0.25:
			moth.position.y -= 1.8
			#moth.self_modulate.r += 0.025
			moth.self_modulate.a += 0.025
			moth.scale.x += 0.02
			moth.scale.y += 0.02
			timer = 0
			count += 1
		if count == 50:
			Globals.swap = true
