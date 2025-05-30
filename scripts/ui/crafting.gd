extends CanvasLayer


@onready var sword = $SwordButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Globals.crafting:
		self.show()
	else:
		self.hide()
	
	if Input.is_action_just_pressed("crafting"):
		Globals.crafting = !Globals.crafting
		sword.grab_focus()
