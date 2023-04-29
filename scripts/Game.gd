extends Node
class_name Game

export var in_menu = false
onready var UI = $UI
onready var map = $Map
onready var company = $Company

var routing_quest
var routing_unit
var routing_roads_selected = []

# Called when the node enters the scene tree for the first time.
func _ready():
	System.game = self
	var st: Settlement = map.get_settlement(0)
	st.set_quest($Quests.generate_first_quest())
	
	UI.init()


func start_routing(quest: Quest, unit: Unit):
	UI.start_routing()
	routing_quest = quest
	routing_unit = unit

func cancel_routing():
	UI.cancel_routing(routing_unit, routing_quest)

func select_road(st : Settlement):
	var r = map.get_road_to(st)
	# add last road as an argument to connect
	if routing_roads_selected.size() > 0:
		var last = routing_roads_selected.size()-1
		r = map.get_road_to(st, routing_roads_selected[last])
	
	var unit_at_r = map.get_road_by_unit(routing_unit, st)
	
	if r == null:
		printerr("No road from/to %s" % st.settlement_name)
		return
	
	# You have entries on the list
	print("Routing has %s routes" % routing_roads_selected.size())
	if routing_roads_selected.size() > 0:
		var index = routing_roads_selected.find(r)
		if index > -1:
			routing_roads_selected.pop_at(index)
			print("Road %s removed" % r)
			return false
		else:
			routing_roads_selected.append(r)
			print("Road %s added" % r)
			return true
	# No entries on the list, add the one player is 
	else:
		var index = routing_roads_selected.find(unit_at_r)
		routing_roads_selected.append(unit_at_r)
		print("Road %s added from unit" % unit_at_r)
		return true
