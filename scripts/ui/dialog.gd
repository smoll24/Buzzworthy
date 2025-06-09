extends CanvasLayer

const READ_RATE = 0.08
@onready var dialogbox = $Box
@onready var text = $RichTextLabel
@onready var end = $end
@onready var fade = $ColorRect

var tween : Tween
var tween2 : Tween
var tween3 : Tween

enum State {
	READY,
	READING,
	FINISHED
}

var current_state = State.READY
var text_queue = []

var current

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fade.visible = true
	dialogbox.visible = false
	text.visible = false
	end.visible = false
	await get_tree().create_timer(1).timeout
	tween2 = create_tween()
	tween2.tween_property(fade, "modulate:a", 0, 2)
	await get_tree().create_timer(2).timeout
	
	#dialogbox.self_modulate.a = 1
	dialogbox.modulate = Color(0,0,0,1)
	current = Globals.current_dialog
	dialogbox.hide()


	if current == 0:
			queue_text(["Isolated deep in the forest, there lives a quiet people...                            "])
			queue_text(["A village of mothfolk, hidden away from the rest of the woods...                       "])
			queue_text(["Afraid of the insects that roam the forest, they hide away in their bubble of safety.                  "])
			queue_text(["And yet, they face a terrible danger they cannot stop.                             "])
			queue_text(["Now you will live their story as a prayer from a certain Actias is whispered...                  "])
			queue_text(['A'])
			Globals.current_dialog = 1

	if current == 1:
			queue_text(["If anyone hears this... please listen.                "])
			queue_text(["Our village is fading. The soil that once nourished us has turned brittle and bare.               "])
			queue_text(["We’ve tried everything but... it just keeps on dying.                         "])
			queue_text(["Please, if anyone hears this prayer, please help us.                         "])
			queue_text(['E'])
			Globals.current_dialog = 2

	if current == 2:
			queue_text(["And so the poor moths, out of their depth against the wasp, scattered in fear ...                    "])
			queue_text(["Alone in the wilderness amongst all that they fear, will they be able to survive ...?                         "])
			queue_text(['B'])
			Globals.current_dialog = 3

	if current == 3:
			queue_text(["And so the little moth continues on its journey towards the Wasp Queen ...                   "])
			queue_text(["... as the biome transforms into something they've never seen before ...                        "])
			queue_text(['C'])
			Globals.current_dialog = 4
			

	if current == 4:
			queue_text(["The moth continues to journey on endlessly...              "])
			queue_text(["... until it finally reaches its destination once and for all ...                        "])
			queue_text(['D'])
			Globals.current_dialog = 5
			
	#Win & travel home
	if current == 5:
			queue_text(["After a long discussion with the Vespula Queen and her wasps, the mothfolk open up their village to the outside world.                     "])
			queue_text(["The plants that had been previously deprived of any pollinators suddenly found themselves thriving ...                      "])
			queue_text(["...and the mothfolk were able to return to their peaceful way of life, now with a newly changed view of the forest.                    "])
			queue_text(["Thank you so much for playing!                        "])
			queue_text(['E'])
			Globals.current_dialog = 6
			
	#Lose & travel home
	if current == 6:
			queue_text(["And so, having failed their mission and journey, the mothfolk return home, despondent ...                 "])
			queue_text(["Thank you so much for playing!                        "])
			queue_text(['E'])
			Globals.current_dialog = 7

func _process(delta):
	match current_state:
		State.READY:
			if text_queue != []:
				display_text()
		State.READING:
			pass
			#if Input.is_action_just_pressed('ui_accept'):
				#if tween:
					#tween.kill()
				#text.visible_ratio = 1.0 
				#change_state(State.FINISHED)
		State.FINISHED:
			#end.text = 'v'
			#if Input.is_action_just_pressed('ui_accept'):
			change_state(State.READY)
			#dialogbox.hide()
		
		
func queue_text(next_text):
	text_queue.push_back(next_text)
		
func display_text():
	dialogbox.visible = true
	text.visible = true
	end.visible = true
	var next_queue = text_queue.pop_front()
	var next_text = next_queue[0]
	
	
	if next_text == 'A':
		tween2 = create_tween()
		tween2.tween_property(fade, "modulate:a", 1, 0.5)
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file("res://scenes/cutscenes/MothPray.tscn")
	
	if next_text == 'B':
		tween2 = create_tween()
		tween2.tween_property(fade, "modulate:a", 1, 0.5)
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file("res://scenes/levels/level1_forest.tscn")
	
	if next_text == 'C':
		tween2 = create_tween()
		tween2.tween_property(fade, "modulate:a", 1, 0.5)
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file("res://scenes/levels/level2_wetland.tscn")
		
		
	if next_text == 'D':
		tween2 = create_tween()
		tween2.tween_property(fade, "modulate:a", 1, 0.5)
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file("res://scenes/levels/Boss.tscn")
		
	
	if next_text == 'E':
		tween2 = create_tween()
		tween2.tween_property(fade, "modulate:a", 1, 2)
		await get_tree().create_timer(2).timeout
		get_tree().change_scene_to_file("res://scenes/levels/MothHome.tscn")
		
		
	end.text = '  '
	text.text = next_text
	change_state(State.READING)
	text.visible_ratio = 0
	dialogbox.show()
	
	tween = create_tween()
	tween.tween_property(text, 'visible_ratio', 1.0, len(next_text) * READ_RATE).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.connect("finished", on_tween_finished)

func on_tween_finished():
	change_state(State.FINISHED)

func change_state(next_state):
	current_state = next_state
	match current_state:
		State.READY:
			pass
		State.READING:
			pass
		State.FINISHED:
			pass
