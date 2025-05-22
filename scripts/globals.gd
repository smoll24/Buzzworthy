extends Node

var level = 0
var max_health = 10
var current_health = max_health


func get_health():
	return current_health
	
func set_health(health):
	current_health = health
