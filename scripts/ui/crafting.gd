extends CanvasLayer

@onready var icon = $PictureIcon
@onready var label = $NameLabel

@onready var stone_label = $StoneLabel
@onready var log_label = $LogLabel

@onready var sword = $SwordButton
@onready var shield = $ShieldButton
@onready var sword2 = $Sword2Button
@onready var shield2 = $Shield2Button
@onready var helmet = $HelmetButton
@onready var boots = $BootsButton
@onready var craft = $CraftButton

var sword_logs = 10
var sword_stones = 5

var shield_logs = 10
var shield_stones = 5

var helmet_logs = 5
var helmet_stones = 10

var boots_logs = 5
var boots_stones = 10

var sword2_logs = 5
var sword2_stones = 15

var shield2_logs = 15
var shield2_stones = 5


var previous_node
var node_focused

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	icon.play("default")
	label.text = " "
	log_label.text = " "
	stone_label.text = " "
	craft.disabled = true
	previous_node = sword

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	node_focused = get_viewport().gui_get_focus_owner()
	
	if not Globals.has_sword_recipe:
		sword.hide()
	else:
		sword.show()
	
	if Globals.has_sword:
		sword.disabled = true
	else:
		sword.disabled = false
	
	
	if not Globals.has_shield_recipe:
		shield.hide()
	else:
		shield.show()
	
	if Globals.has_shield:
		shield.disabled = true
	else:
		shield.disabled = false
	
	if not Globals.has_sword2_recipe:
		sword2.hide()
	else:
		sword2.show()
	
	if Globals.has_sword2:
		sword2.disabled = true
	else:
		sword2.disabled = false
	
	
	if not Globals.has_shield2_recipe:
		shield2.hide()
	else:
		shield2.show()
	
	if Globals.has_shield2:
		shield2.disabled = true
	else:
		shield2.disabled = false
	
	
	if not Globals.has_helmet_recipe:
		helmet.hide()
	else:
		helmet.show()
	
	if Globals.has_helmet:
		helmet.disabled = true
	else:
		helmet.disabled = false
		
	
	if not Globals.has_boots_recipe:
		boots.hide()
	else:
		boots.show()
	
	if Globals.has_boots:
		boots.disabled = true
	else:
		boots.disabled = false
	
	if Input.is_action_just_pressed("crafting") and Globals.crafting:
		Flip.play()
		var new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
		visible = new_pause_state
		if sword.visible:
			sword.grab_focus()
		else:
			$Empty1.grab_focus()
		
	if Input.is_action_just_pressed("ui_accept"):
		if node_focused == sword:
			Click.play()
			icon.play("sword")
			previous_node.button_pressed = false
			sword.button_pressed = true
			previous_node = sword
			label.text = "Sword"
			log_label.text = str(sword_logs)
			stone_label.text = str(sword_stones)
			if Globals.logs >= sword_logs and Globals.stones >= sword_stones and not Globals.has_sword:
				craft.disabled = false
			else:
				craft.disabled = true
				
		elif node_focused == shield:
			Click.play()
			icon.play("shield")
			previous_node.button_pressed = false
			shield.button_pressed = true
			previous_node = shield
			label.text = "Shield"
			log_label.text = str(shield_logs)
			stone_label.text = str(shield_stones)
			if Globals.logs >= shield_logs and Globals.stones >= shield_stones and not Globals.has_shield:
				craft.disabled = false
			else:
				craft.disabled = true
				
		
		elif node_focused == sword2:
			Click.play()
			icon.play("sword2")
			previous_node.button_pressed = false
			sword2.button_pressed = true
			previous_node = sword2
			label.text = "Sword 2"
			log_label.text = str(sword2_logs)
			stone_label.text = str(sword2_stones)
			if Globals.logs >= sword2_logs and Globals.stones >= sword2_stones and not Globals.has_sword:
				craft.disabled = false
			else:
				craft.disabled = true
				
		elif node_focused == shield2:
			Click.play()
			icon.play("shield2")
			previous_node.button_pressed = false
			shield2.button_pressed = true
			previous_node = shield2
			label.text = "Shield 2"
			log_label.text = str(shield2_logs)
			stone_label.text = str(shield2_stones)
			if Globals.logs >= shield2_logs and Globals.stones >= shield2_stones and not Globals.has_shield:
				craft.disabled = false
			else:
				craft.disabled = true
				
		elif node_focused == helmet:
			Click.play()
			icon.play("helmet")
			previous_node.button_pressed = false
			helmet.button_pressed = true
			previous_node = helmet
			label.text = "Helmet"
			log_label.text = str(helmet_logs)
			stone_label.text = str(helmet_stones)
			if Globals.logs >= helmet_logs and Globals.stones >= helmet_stones and not Globals.has_helmet:
				craft.disabled = false
			else:
				craft.disabled = true
				
		elif node_focused == boots:
			Click.play()
			icon.play("boots")
			previous_node.button_pressed = false
			boots.button_pressed = true
			previous_node = boots
			label.text = "Boots"
			log_label.text = str(boots_logs)
			stone_label.text = str(boots_stones)
			if Globals.logs >= boots_logs and Globals.stones >= boots_stones and not Globals.has_boots:
				craft.disabled = false
			else:
				craft.disabled = true
				
			
			
	if sword.visible == false:
		shield.focus_neighbor_left = $Empty1.get_path()
		boots.focus_neighbor_top = $Empty1.get_path()
		$Empty4.focus_neighbor_top = $Empty1.get_path()
		$Empty2.focus_neighbor_left = $Empty1.get_path()
	else: 
		shield.focus_neighbor_left = sword.get_path()
		boots.focus_neighbor_top = sword.get_path()
		$Empty4.focus_neighbor_top = sword.get_path()
		$Empty2.focus_neighbor_left = sword.get_path()
		
	if shield.visible == false:
		sword.focus_neighbor_right = $Empty2.get_path()
		helmet.focus_neighbor_left = $Empty2.get_path()
		sword2.focus_neighbor_top = $Empty2.get_path()
		$Empty5.focus_neighbor_top = $Empty2.get_path()
		$Empty3.focus_neighbor_left = $Empty2.get_path()
		$Empty1.focus_neighbor_right = $Empty2.get_path()
	else: 
		sword.focus_neighbor_right = shield.get_path()
		helmet.focus_neighbor_left = shield.get_path()
		sword2.focus_neighbor_top = shield.get_path()
		$Empty5.focus_neighbor_top = shield.get_path()
		$Empty3.focus_neighbor_left = shield.get_path()
		$Empty1.focus_neighbor_right = shield.get_path()
	
	if helmet.visible == false:
		shield.focus_neighbor_right = $Empty3.get_path()
		craft.focus_neighbor_left = $Empty3.get_path()
		shield2.focus_neighbor_top = $Empty3.get_path()
		$Empty6.focus_neighbor_top = $Empty3.get_path()
		$Empty2.focus_neighbor_right = $Empty3.get_path()
	else: 
		shield.focus_neighbor_right = helmet.get_path()
		craft.focus_neighbor_left = helmet.get_path()
		shield2.focus_neighbor_top = helmet.get_path()
		$Empty6.focus_neighbor_top = helmet.get_path()
		$Empty2.focus_neighbor_right = helmet.get_path()
		
	
	if boots.visible == false:
		sword2.focus_neighbor_left = $Empty4.get_path()
		sword.focus_neighbor_bottom = $Empty4.get_path()
		$Empty1.focus_neighbor_bottom = $Empty4.get_path()
		$Empty5.focus_neighbor_left = $Empty4.get_path()
	else: 
		sword2.focus_neighbor_left = boots.get_path()
		sword.focus_neighbor_bottom = boots.get_path()
		$Empty1.focus_neighbor_bottom = boots.get_path()
		$Empty5.focus_neighbor_left = boots.get_path()
		
	
	if sword2.visible == false:
		shield.focus_neighbor_bottom = $Empty5.get_path()
		boots.focus_neighbor_right = $Empty5.get_path()
		shield2.focus_neighbor_left = $Empty5.get_path()
		$Empty2.focus_neighbor_bottom = $Empty5.get_path()
		$Empty4.focus_neighbor_right = $Empty5.get_path()
		$Empty6.focus_neighbor_left = $Empty5.get_path()
	else: 
		shield.focus_neighbor_bottom = sword2.get_path()
		boots.focus_neighbor_right = sword2.get_path()
		shield2.focus_neighbor_left = sword2.get_path()
		$Empty2.focus_neighbor_bottom = sword2.get_path()
		$Empty4.focus_neighbor_right = sword2.get_path()
		$Empty6.focus_neighbor_left = sword2.get_path()
		
	
	if shield2.visible == false:
		helmet.focus_neighbor_bottom = $Empty6.get_path()
		sword2.focus_neighbor_right = $Empty6.get_path()
		$Empty3.focus_neighbor_bottom = $Empty6.get_path()
		$Empty5.focus_neighbor_right = $Empty6.get_path()
	else: 
		helmet.focus_neighbor_bottom = shield2.get_path()
		sword2.focus_neighbor_right = shield2.get_path()
		$Empty3.focus_neighbor_bottom = shield2.get_path()
		$Empty5.focus_neighbor_right = shield2.get_path()
	

func _on_craft_button_pressed() -> void:
	Advance.play()
	craft.disabled = true
	if previous_node == sword:
		Globals.has_sword = true
		Globals.stones -= sword_stones
		Globals.logs -= sword_logs
	elif previous_node == shield:
		Globals.has_shield = true
		Globals.stones -= shield_stones
		Globals.logs -= shield_logs
	elif previous_node == helmet:
		Globals.has_helmet = true
		Globals.stones -= helmet_stones
		Globals.logs -= helmet_logs
	elif previous_node == boots:
		Globals.has_boots = true
		Globals.stones -= boots_stones
		Globals.logs -= boots_logs
	if previous_node == sword2:
		Globals.has_sword2 = true
		Globals.stones -= sword2_stones
		Globals.logs -= sword2_logs
	elif previous_node == shield2:
		Globals.has_shield2 = true
		Globals.stones -= shield2_stones
		Globals.logs -= shield2_logs
