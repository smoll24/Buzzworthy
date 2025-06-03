extends CanvasLayer


@onready var icon = $PictureIcon
@onready var label = $NameLabel

@onready var sword = $SwordButton
@onready var shield = $ShieldButton
@onready var helmet = $HelmetButton
@onready var boots = $BootsButton

var previous_node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	previous_node = sword

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var node_focused = get_viewport().gui_get_focus_owner()
	
	if Input.is_action_just_pressed("crafting"):
		var new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
		visible = new_pause_state
		sword.grab_focus()
	
	if Input.is_action_just_pressed("select"):
		if node_focused == sword:
			icon.play("sword")
			previous_node.button_pressed = false
			sword.button_pressed = true
			previous_node = sword
			label.text = "Sword"
		elif node_focused == shield:
			icon.play("shield")
			previous_node.button_pressed = false
			shield.button_pressed = true
			previous_node = shield
			label.text = "Shield"
		elif node_focused == helmet:
			icon.play("helmet")
			previous_node.button_pressed = false
			helmet.button_pressed = true
			previous_node = helmet
			label.text = "Helmet"
		elif node_focused == boots:
			icon.play("boots")
			previous_node.button_pressed = false
			boots.button_pressed = true
			previous_node = boots
			label.text = "Boots"
			
		
	
