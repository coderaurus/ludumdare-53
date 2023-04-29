extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var settlements = $Settlements


# Called when the node enters the scene tree for the first time.
func _ready():
	_init_roads()
	pass # Replace with function body.

func get_settlement(index):
	return settlements.get_child(index).get_script()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _init_roads():
	print("Init roads")
	for i in $Roads.get_child_count():
		var r : Road = $Roads.get_child(i)
		r.init()
