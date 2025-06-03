extends Node

var level = 0
var max_health = 5
var current_health = max_health
var current_dialog = 1
var slow = false
var logs = 10
var stones = 10
var crafting = true

var save_pos = Vector2(0, 0)

var current_wet = 0
var max_wet = 5

var current_level = 1

var has_sword_recipe = true
var has_sword = false
var has_shield_recipe = true
var has_shield = false
var has_helmet_recipe = true
var has_helmet = false
var has_boots_recipe = true
var has_boots = false

#Trigger to exit cutscene
var swap = false

func get_health():
	return current_health
	
func set_health(health):
	current_health = health
	

func get_wet():
	return current_wet
	
func set_wet(wet):
	current_wet = wet
