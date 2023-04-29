extends Node2D

var events = get_children()

onready var event_scene = preload("res://scenes/map/Event.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func generate_initial_event(st : Settlement):
	var e = event_scene.instance()
	add_child(e)
	st.set_event(e)
