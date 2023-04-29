extends Node2D

class_name Map

onready var settlements = $Settlements


# Called when the node enters the scene tree for the first time.
func _ready():
	_init_roads()
	pass # Replace with function body.

func get_settlement(index):
	return settlements.get_child(index)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _init_roads():
	print("Init roads")
	for i in $Roads.get_child_count():
		var r : Road = $Roads.get_child(i)
		r.init()


func get_road_to(st: Settlement):
	for i in $Roads.get_child_count():
		var r = $Roads.get_child(i)
		if r.from == st or r.to == st:
			return r
	return null
