extends StaticBody2D

@onready var sprite = $AnimatedSprite2D
@onready var collision_0 = $CollisionShape2D_0
@onready var collision_1 = $CollisionShape2D_1
@onready var collision_2 = $CollisionShape2D_2
@onready var collision_3 = $CollisionShape2D_3
@onready var collision_4 = $CollisionShape2D_4
@onready var area = $Area2D

@export var stand_time: float = 0.5 

var timer: float = 0.0
var timer_closed: float = 0.0
var player_on_platform: bool = false
var sensitive: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.play("open")

func _process(delta):
	#$Timer.text = str(timer)
	#$TimerClosed.text = str(timer_closed)
	
	#If Player is on Plant and plant is open, add to Timer
	if player_on_platform:
		if sensitive:
			timer += delta
		if timer >= stand_time:
			sensitive = false
			sprite.play("closing")
			timer = 0
	else:
		timer = 0
	
	#If the Plant is open and it is closing, change Collision boxes
	if sprite.animation == "closing":
		if sprite.frame == 1:
			collision_0.disabled = true
			collision_1.disabled = false
		if sprite.frame == 2:
			collision_1.disabled = true
			collision_2.disabled = false
		if sprite.frame == 3:
			collision_2.disabled = true
			collision_3.disabled = false
		if sprite.frame == 4:
			collision_3.disabled = true
			collision_4.disabled = false
		if sprite.frame == 5:
			sprite.play("closed")
			collision_4.disabled = true
	
	#Adds to the timer_closed Timer if the Plant is Closed
	if sprite.animation == "closed":
			timer_closed += delta
		
	#If the Plant is Closed for too long, it opens again
	if timer_closed >= stand_time:
		sprite.play("opening")
		timer_closed = 0
		
	if sprite.animation == "opening":
		if sprite.frame == 1:
			collision_4.disabled = false
		if sprite.frame == 2:
			collision_4.disabled = true
			collision_3.disabled = false
		if sprite.frame == 3:
			collision_3.disabled = true
			collision_2.disabled = false
		if sprite.frame == 4:
			collision_2.disabled = true
			collision_1.disabled = false
		if sprite.frame == 5:
			collision_1.disabled = true
			collision_0.disabled = false
			sprite.play("open")
			sensitive = true

func _on_area_2d_body_entered(_body: Node2D) -> void:
	player_on_platform = true

func _on_area_2d_body_exited(_body: Node2D) -> void:
	player_on_platform = false
