extends Node2D

class_name Company

export var company_name = "Goblins 'r' Us"
export var gold = 100
export var reputation = 0.0 # percent
export var reputation_titles = ["Infamous", "Known", "Acknowledged", "Revered"]

onready var units = $Units

var active_days = 1 # get this from a separate component

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func get_reputation_title():
	var title
	if reputation > 0.99:
		title = reputation_titles[3]
	elif reputation > 0.5:
		title = reputation_titles[2]
	elif reputation > 0.25:
		title = reputation_titles[1]
	else:
		title = reputation_titles[0]
	
	return title
