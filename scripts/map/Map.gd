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


func get_road_to(st: Settlement, from: Settlement = null):
	for i in $Roads.get_child_count():
		var r = $Roads.get_child(i)
		
		if from == null:
			if r.s_node_a == st or r.s_node_b == st:
				return r
		else:
			if (r.s_node_a == st or r.s_node_b == st) and (r.s_node_a == from or r.s_node_b == from):
				return r
	return null


func get_road_by_unit(unit: Unit, st : Settlement):
	for i in $Roads.get_child_count():
		var r = $Roads.get_child(i)
		if (r.s_node_a.unit == unit or r.s_node_b.unit == unit) and (r.s_node_a == st or r.s_node_b == st):
			return r
	return null


func disable_settlement(st: Settlement):
	for i in settlements.get_child_count():
		var s = settlements.get_child(i)
		
		if s == st:
			System.game.UI.disable_settlement(i)
			break

func settlement_unit_at(u: Unit):
	for i in settlements.get_child_count():
		var s = settlements.get_child(i)
		
		if s.unit == u:
			return u
	return null
