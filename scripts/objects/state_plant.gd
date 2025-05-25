extends StaticBody2D

@onready var sprite = $AnimatedSprite2D
@onready var collision = $CollisionShape2D

@export var min_wait_time: float = 1.0  
@export var max_wait_time: float = 3.0  

var state: int = 1  # 1 = collision enabled, 0 = disabled

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	switch_state()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if state == 1:
		collision.disabled = false
		#$Label.text = "Closed"
		sprite.play("closed")
	else:
		collision.disabled = true
		#$Label.text = "Open"
		sprite.play("open")
	
	
func switch_state():
	state = 1 - state
	var wait_time = randf_range(min_wait_time, max_wait_time)
	await get_tree().create_timer(wait_time).timeout
	switch_state()
