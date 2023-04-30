extends Node2D

class_name Map

onready var settlements = $Settlements

var last_randomized_st

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
		if (r.s_node_a == unit.at or r.s_node_b == unit.at) and (r.s_node_a == st or r.s_node_b == st):
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

func get_settlement_for_quest():
	for s in settlements.get_children():
		if s.quest == null:
			return s
	return null


func get_random_settlement(exclude_st = null):
	var failsafe = 500
	var rand_st
	var index
	while failsafe > 0:
		var rng = int(rand_range(0, settlements.get_child_count()))
		index = clamp(rng, 0, settlements.get_child_count() - 1)
		rand_st = settlements.get_child(index)
		if last_randomized_st != rand_st and !rand_st.quest and (exclude_st == null or rand_st != exclude_st):
			last_randomized_st = rand_st
			return rand_st
		failsafe -= 1
	if settlements.get_child_count() < index + 1:
		rand_st = settlements.get_child(index+1)
	elif 0 <= index - 1:
		rand_st = settlements.get_child(index-1)
	last_randomized_st = rand_st
	return rand_st


func settlements_empty():
	var empty = 0
	for s in settlements.get_children():
		if s.quest == null:
			empty += 1
	return empty
