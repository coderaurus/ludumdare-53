extends Node2D
class_name Event

export var event_name = "Cool event"
export var description = "It's a Cool event"
export var question = "R-right?"
export var options = ["Yes", "No"]
export var challenges = ["",""]
export var banner : Resource
export(String, "Conflict", "Trade", "Urgency", "Other") var event_type
export var event_type_names = ["Conflict", "Trade", "Urgency", "Other"]
export var spawn_chance = 0.2
export var unit_modifiers = [0, 0.1] # [unit type, modifier]
export var reward = 25



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
