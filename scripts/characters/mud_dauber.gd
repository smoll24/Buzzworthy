extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D
@onready var wings1 = $AnimatedSprite2D2
@onready var wings2 = $AnimatedSprite2D3
var tween

@export var hover_speed: float = 100.0
@export var lunge_speed: float = 200.0
@export var retreat_speed: float = 200.0
@export var lunge_distance: float = 400.0
@export var hover_height: float = -120.0 
@export var lunge_cooldown: float = 15.0

var player: CharacterBody2D
var current_state = "hover"
var lunge_timer = 0.0
var lunge_target_pos: Vector2
var retreat_start_pos: Vector2
var to_player
var lunging_cooldown = true
var in_body = false
var last_state = ""
var chasing = false
var moving = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_parent().get_node("Player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	to_player = player.global_position.x - global_position.x
	sprite.flip_h = to_player > 0
	wings1.flip_h = to_player > 0
	wings2.flip_h = to_player > 0
	
	if current_state != last_state:
		if current_state == "hover":
			start_hover_tween()
		else:
			if tween and tween.is_running():
				tween.kill()
		last_state = current_state
	
	if lunging_cooldown:
		lunge_timer += delta
	if lunge_timer > lunge_cooldown:
		lunging_cooldown = false
		lunge_timer = 0.0
	
	match current_state:
		"hover":
			if moving:
				move_toward_player(delta)
			if chasing:
				check_lunge()
		
		"lunge":
			do_lunge(delta)
		
		"retreat":
			do_retreat(delta)
		
	move_and_slide()


func start_hover_tween():
	if tween and tween.is_running():
		tween.kill() 

	tween = create_tween().set_loops()
	tween.tween_property(self, "position:y", self.position.y + 8, 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "position:y", self.position.y - 8, 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)


func move_toward_player(delta):
	#sprite.modulate = Color(1,1,1,1)
	var target_pos = player.global_position + Vector2(0, hover_height)
	var direction = (target_pos - global_position).normalized()
	
	if global_position.y < target_pos.y:
		velocity = Vector2(direction.x, 0) * hover_speed
	else:
		velocity = direction * hover_speed 


func check_lunge():
	var distance = global_position.distance_to(player.global_position)
	if distance < lunge_distance and not lunging_cooldown:
		lunge_target_pos = player.global_position
		lunge_timer = 0
		current_state = "lunge"
		

func do_lunge(delta):
	#sprite.modulate = Color(3,1,1,1)
	#var direction = (lunge_target_pos - global_position).normalized()
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * lunge_speed * (lunge_timer * 5)
	
	lunging_cooldown = true
	if lunge_timer > 1.0 or in_body:
		retreat_start_pos = global_position
		current_state = "retreat"


func do_retreat(delta):
	#sprite.modulate = Color(1,2,1,1)
	var target = retreat_start_pos + Vector2(0, hover_height)
	var direction = (target - global_position).normalized()
	velocity = direction * retreat_speed
	in_body = false
	
	lunge_cooldown = randf_range(3.0,5.0)
	
	if global_position.distance_to(target) < 10:
		current_state = "hover"

func set_chase():
	chasing = true
	
func set_move():
	moving = true

func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	in_body = true
	if current_state == "lunge":
		player.apply_hitup_effect()
	
