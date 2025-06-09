extends Node

var level = 0
var max_health = 5
var current_health = max_health
var current_dialog = 0
var slow = false
var logs = 0
var stones = 0
var crafting = true
var spawn = 0
var village_fixed = false
var can_move = true
var woken = false
var fallen = false
var shut_up = false
var bell1 = false
var bell2 = false
var bell3 = false
var spider_met = false

var save_pos = Vector2(0, 0)

var current_wet = 0
var max_wet = 3

var current_level = 1

var has_sword_recipe = true
var has_sword = true
var has_shield_recipe = true
var has_shield = true
var has_helmet_recipe = false
var has_helmet = true
var has_boots_recipe = false
var has_boots = true
var has_sword2_recipe = false
var has_sword2 = true
var has_shield2_recipe = false
var has_shield2 = true

var helped_stinkbug = false
var helped_clickbug = false
var helped_spider = false
var helped_museum = false
var helped_cockroach = false
var helped_weevil = false
var bugs_helped = 0


var stinkbug = false
var clickbug = false
var spider = false
var museum = false

var cockroach = false
var pillbug = false
var weevil1 = false
var weevil2 = false

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
