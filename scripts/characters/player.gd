extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -400.0
var is_facing_right
var is_facing_left

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	print(direction)
	if direction:
		velocity.x = direction * SPEED
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.play()
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimatedSprite2D.animation = "default"
		
	#Chaning Sprite Direction
	if Input.is_action_pressed("ui_left"):
		if not is_facing_right:
			is_facing_right = true
			scale.x = -abs(scale.x) 

	if Input.is_action_pressed("ui_right"):
		if is_facing_right:
			is_facing_right = false
			scale.x = -abs(scale.x)

	move_and_slide()
