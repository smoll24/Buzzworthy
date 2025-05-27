extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D
var enemy : Area2D

const SPEED = 200.0
var current_speed
const JUMP_VELOCITY = -400.0
var is_facing_right = true

#To Use for Tweening Animations
var tween

#Dashing
var dash = false
var dash_time = 0

#Taking Damage
var hit = false
var hit_time = 0
var knockback_hit_distance = 50 
var knockback_hit_duration = 0.5 

#Healing
var heal = false
var heal_time = 0
var knockback_heal_distance = 5
var knockback_heal_duration = 0.5 

#Speed Boost
var speed = false
var speed_time = 0

var jumping = false
var jump_time = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_speed = SPEED


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if jumping:
		jump_time += delta
		if jump_time > 0.1:
			if is_on_floor():
				sprite.play_backwards("jump")
				if sprite.frame == 0:
					jumping = false

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jumping = true
		sprite.play("jump")
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * current_speed
		if not jumping:
			sprite.play("walk")
		sprite.scale.x = direction * abs(sprite.scale.x)
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		if not jumping:
			sprite.play("default")
	
	#Control Hit Cooldown
	if hit == true:
		hit_time += delta
		if hit_time > 0.1:
			sprite.modulate = Color(1,1,1,1)
		if hit_time > 0.5:
			hit = false
			hit_time = 0
			
	#Control Heal Cooldown
	if heal == true:
		heal_time += delta
		if heal_time > 0.6:
			sprite.modulate = Color(1,1,1,1)
		if heal_time > 1:
			heal = false
			heal_time = 0
			
	#Control Speed Cooldown
	if speed == true:
		speed_time += delta
		if speed_time > 0.3:
			sprite.modulate = Color(1,1,1,1)
		if speed_time > 3:
			speed = false
			speed_time = 0
			current_speed = SPEED
	
	move_and_slide()

func apply_hit_effect():
	if hit == false and dash == false:
		hit = true
		var hp = Globals.get_health()
		if hp != 0:
			hp = hp - 1
			Globals.set_health(hp)
		sprite.modulate = Color(10,10,10,10)
		tween = create_tween()
		if is_facing_right:
			knockback_hit_distance = -abs(knockback_hit_distance)
		else:
			knockback_hit_distance = abs(knockback_hit_distance)
		
		tween.tween_property(self, "position:x", self.global_position.x + knockback_hit_distance, knockback_hit_duration).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
		
func apply_heal_effect():
	if heal == false and dash == false:
		heal = true
		var hp = Globals.get_health()
		if hp != Globals.get("max_health"):
			hp = hp + 1
			Globals.set_health(hp)
		sprite.modulate = Color(0,1,0.5,10)
		tween = create_tween()
		if is_facing_right:
			knockback_heal_distance = -abs(knockback_heal_distance)
		else:
			knockback_heal_distance = abs(knockback_heal_distance)
		tween.tween_property(self, "position:x", self.global_position.x + knockback_heal_distance, knockback_heal_duration).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)

func apply_speed_effect():
	if speed == false and dash == false:
		speed = true
		current_speed = SPEED * 1.5
		sprite.modulate = Color(1,1,0,10)
		
		#tween = create_tween()
		#if is_facing_right:
			#knockback_heal_distance = -abs(knockback_heal_distance)
		#else:
			#knockback_heal_distance = abs(knockback_heal_distance)
		#tween.tween_property(self, "position:x", self.global_position.x + knockback_heal_distance, knockback_heal_duration).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
