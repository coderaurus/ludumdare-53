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


func select_road(st : Road):
	var r = map.get_road_to(st)
	if r == null:
		printerr("No road from/to %s" % st.settlement_name)
		return
	
	var index = routing_roads_selected.find(r)
	if index > -1:
		routing_roads_selected.pop_at(index)
	else:
		routing_roads_selected.append(index)
