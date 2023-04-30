extends Node
class_name Game

export var in_menu = false
onready var UI = $UI
onready var map = $Map
onready var company = $Company

var routing_quest
var routing_unit
var routing_roads_selected = []
var last_st_added
var last_r_added
var route_finished = false

# Called when the node enters the scene tree for the first time.
func _ready():
	System.game = self
	var st: Settlement = map.get_settlement(0)
	st.set_quest($Quests.generate_first_quest())
	
	UI.init()


func start_routing(quest: Quest, unit: Unit):
	UI.start_routing()
	routing_quest = quest
	routing_quest.unit = unit
	routing_unit = unit

func cancel_routing():
	routing_quest.unit = null
	UI.cancel_routing(routing_unit, routing_quest)

func select_road(st : Settlement):
	var last = null
	var unit_at_r = map.get_road_by_unit(routing_unit, st)
	
	# You have entries on the list
	print("Routing has %s routes" % routing_roads_selected.size())
	if routing_roads_selected.size() > 0:
		last = routing_roads_selected.size() - 1
		var lr = routing_roads_selected[last]
		var nr = map.get_road_to(st, last_st_added)
		# cannot find next road and last road has no connection to selected road
		if nr == null and last > 0 and lr.s_node_a != st and lr.s_node_b != st:
			return false
		# determine if st is going to be removed
		elif lr.s_node_a == st or lr.s_node_b == st:
			var index = routing_roads_selected.find(lr)
			lr.deselect()
			routing_roads_selected.pop_at(index)
			close_neighbouring_settlements(st)
			print("Road %s removed" % lr)
			if routing_roads_selected.size() == 0:
				last_r_added = null
				last_st_added = null
			check_destination(st)
			return false
		else:
			lr = map.get_road_to(st, last_st_added)
			
			lr.select()
			lr.enable()
			routing_roads_selected.append(lr)
			open_neighboring_settlements(st)
			print("Road %s added" % lr)
			last_st_added = st
			last_r_added = lr
			check_destination(st)
			return true
	# No entries on the list, add the one player is 
	else:
		var index = routing_roads_selected.find(unit_at_r)
		routing_roads_selected.append(unit_at_r)
		unit_at_r.select()
		unit_at_r.enable()
		print("Road %s added from unit" % unit_at_r)
		open_neighboring_settlements(st)
		last_st_added = st
		last_r_added = unit_at_r
		check_destination(st)
		return true


func check_destination(st):
	if st == routing_quest.to:
		UI.show_route_confirmation()
	else:
		UI.hide_route_confirmation()


func open_neighboring_settlements(for_st: Settlement):
	var roads = map.get_roads_from(for_st)
	var valid_roads = []
	
	for r in roads:
		if !routing_roads_selected.has(r):
			valid_roads.append(r)
	
	map.enable_roads(valid_roads)
	

func close_neighbouring_settlements(for_st: Settlement):
	var roads = map.get_roads_from(for_st)
	map.disable_roads(roads)

func close_routing(completed=true):
	if completed:
		routing_unit.quest = routing_quest
		routing_quest.active = true
		routing_unit.at.quest = routing_quest
		routing_unit.at.unit = routing_unit
		UI.routing = false
		UI.unit_selector.show()
		map.disable_roads()
	else:
		routing_quest.unit = null


func quest_complete(q: Quest, rwd):
	var reputation = 5
	
	# late?
	if q.reward > rwd:
		reputation -= 1
	
	company.reward(reputation, rwd)
	UI.company.update()
	q.from.quest = null
	q.queue_free()

func quest_aborted(q: Quest):
	var reputation = -4
	company.reward(reputation)
	UI.company.update()
