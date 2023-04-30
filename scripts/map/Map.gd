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
	var reverse_roads = $Roads.get_children()
	reverse_roads.invert()
	for i in $Roads.get_child_count():
		var r = reverse_roads[i] as Road
		
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

func enable_settlement(st: Settlement):
	for i in settlements.get_child_count():
		var s = settlements.get_child(i)
		
		if s == st:
			System.game.UI.enable_settlement(i)
			break

func settlement_unit_at(u: Unit):
	for i in settlements.get_child_count():
		var s = settlements.get_child(i)
		
		if s.unit == u:
			return u
	return null


func get_roads_from(st: Settlement):
	var connected = []
	for r in $Roads.get_children():
		r = r as Road
		if (r.s_node_a == st or r.s_node_b == st):
			connected.append(r)
	return connected


func disable_roads(roads = null):
	if roads == null:
		roads = $Roads.get_children()
	
	for r in roads:
		(r as Road).disable()
		(r as Road).deselect()


func enable_roads(roads):
	for r in roads:
		(r as Road).enable()


func move_quest_unit(u: Unit, roads):
	u.start_moving(roads)
