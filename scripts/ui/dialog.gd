extends CanvasLayer

const READ_RATE = 0.1
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
	tween2 = create_tween()
	tween2.tween_property(fade, "modulate:a", 0, 0.5)
	await get_tree().create_timer(0.5).timeout
	
	#dialogbox.self_modulate.a = 1
	dialogbox.modulate = Color(0,0,0,1)
	current = Globals.current_dialog
	dialogbox.hide()

	if current == 1:
			queue_text(["My village is under great peril.             "])
			queue_text(["Our vegetation refuses to blossom as once it used to long ago.                      "])
			queue_text(["The crops wither and the water spoils endlessly.                      "])
			queue_text(["Please, if anyone hears this prayer, please come to our aid.                      "])
			queue_text(["Help us, please, for we dearly need it to live on in peace.                 "])
			queue_text(['E'])
			Globals.current_dialog = 2


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
			end.text = 'v'
			#if Input.is_action_just_pressed('ui_accept'):
			change_state(State.READY)
			dialogbox.hide()
		
		
func queue_text(next_text):
	text_queue.push_back(next_text)
		
func display_text():
	dialogbox.visible = true
	text.visible = true
	end.visible = true
	var next_queue = text_queue.pop_front()
	var next_text = next_queue[0]
	
	if next_text == 'E':
		tween2 = create_tween()
		tween2.tween_property(fade, "modulate:a", 1, 0.5)
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file("res://scenes/levels/MothVillage.tscn")
		
		
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
