extends CanvasLayer


@onready var healthbar = $ProgressBar
@onready var wetbar = $MoistureBar
@onready var label_frames = $Label
@onready var log_label = $CraftBar/Log_Label
@onready var stone_label = $CraftBar/Stone_Label
@onready var craft_bar = $CraftBar


@onready var sword = $Equipment/Sword
@onready var sword2 = $Equipment/Sword2
@onready var shield2 = $Equipment/Shield2
@onready var shield = $Equipment/Shield
@onready var helmet = $Equipment/Helmet
@onready var boots = $Equipment/Boots

var timer = 0
var timer_on = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Globals.has_sword and not Globals.has_sword2:
		sword.show()
	else:
		sword.hide()
	if Globals.has_shield and not Globals.has_shield2:
		shield.show()
	else:
		shield.hide()
	if Globals.has_helmet:
		helmet.show()
	else:
		helmet.hide()
	if Globals.has_boots:
		boots.show()
	else:
		boots.hide()
	if Globals.has_sword2:
		sword2.show()
	else:
		sword2.hide()
	if Globals.has_shield2:
		shield2.show()
	else:
		shield2.hide()
	
	
	timer += delta
	
	if timer_on and timer > 2:
		var wet = Globals.get_wet()
		if wet > 0:
			wet -= 1
			Globals.set_wet(wet) 
		timer_on = false
	
	healthbar.frame = Globals.get_health()
	wetbar.frame = Globals.get_wet()
	label_frames.text = str(Engine.get_frames_per_second())
	log_label.text = str(Globals.logs)
	stone_label.text = str(Globals.stones)

func craft_hide():
	craft_bar.hide()

func _on_moisture_bar_frame_changed() -> void:
	timer_on = true
	timer = 0
