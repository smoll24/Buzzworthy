extends Node

var level = 0
var max_health = 5
var current_health = max_health
var current_dialog = 1
var slow = false
var logs = 0
var stones = 0
var crafting = false

var current_wet = 0
var max_wet = 5

var current_level = 1

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
