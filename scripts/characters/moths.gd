extends CharacterBody2D

@export var speed = 100
@export var distance = 100
@export var type = 1

@onready var sprite = $AnimatedSprite2D
var player: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_parent().get_node("Player")
	sprite.animation = str(type)
	
func _physics_process(delta: float) -> void:
	# Apply gravity if not on floor
	if not is_on_floor():
		velocity.y += get_gravity().y * delta
	else:
		velocity.y = 0

	if velocity.x == 0:
		sprite.pause()
	else:
		sprite.play()

	var to_player = player.global_position.x - global_position.x
	sprite.flip_h = to_player < 0
	var horizontal_distance = abs(to_player)

	if horizontal_distance > distance:
		var direction = sign(to_player)
		velocity.x = direction * speed
	else:
		velocity.x = 0 
	
	move_and_slide()
