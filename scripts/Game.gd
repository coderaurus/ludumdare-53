extends Node
class_name Game

signal new_quest

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

var game_paused = true
var game_complete = false
var post_game = false

# Called when the node enters the scene tree for the first time.
func _ready():
	System.game = self
	var st: Settlement = map.get_settlement(0)
	$Quests.generate_first_quest()
		
	UI.init()
	UI.start.get_parent().visible = true


func start_game(company_name):
	company.company_name = company_name
	UI.company.init()
	$DayTimer.start()
	unpause_game()
	pass


func start_routing(quest, unit: Unit):
	routing_roads_selected = []
	routing_quest = quest
	routing_quest.unit = unit
	routing_unit = unit
	UI.start_routing()

func cancel_routing():
	routing_quest.unit = null
	UI.cancel_routing(routing_quest, routing_unit)

func select_road(st : Settlement):
	var last = null
	var unit_at_r = map.get_road_by_unit(routing_unit, st)
	var conns = settlement_connections(st)
	# You have entries on the list
	print("Routing has %s routes" % routing_roads_selected.size())
	if routing_roads_selected.size() > 0:
		last = routing_roads_selected.size() - 1
		var lr = routing_roads_selected[last]
		var nr = map.get_road_to(st, last_st_added)
		
		# cannot find next road and last road has no connection to selected road
		if nr == null and last > 0 and lr.s_node_a != st and lr.s_node_b != st \
		and conns <= 1:
			return false
		# determine if st is going to be removed
		elif (lr.s_node_a == st or lr.s_node_b == st) and conns <= 1:
			var index = routing_roads_selected.find(lr)
			lr.deselect()
			lr.disable()
			routing_roads_selected.pop_at(index)
			close_neighbouring_settlements(st)
			print("Road %s removed" % lr)
			if routing_roads_selected.size() == 0:
				last_r_added = null
				last_st_added = null
			else:
				# take a step back 
				last = routing_roads_selected.size() - 1
				last_r_added = routing_roads_selected[last]
				var not_st = lr.s_node_a
				if not_st == st:
					lr.s_node_b
				last_st_added = not_st
			check_destination(st, true)
			return false
		# new road
		elif conns == 0:
			if st != last_st_added:
				nr = map.get_road_to(st, last_st_added)
			
			nr.select()
			nr.enable()
			routing_roads_selected.append(nr)
			open_neighboring_settlements(st)
			print("Road %s added" % nr)
			last_st_added = st
			last_r_added = nr
			check_destination(st)
			return true
		else:
			return true
	# No entries on the list, add the one player is 
	# Unit is on road and st has connection to current unit st
	# OR st has connection to quest origin
	elif (unit_at_r != null and settlement_has_connection_to(st, routing_unit.at)) or \
		settlement_has_connection_to(st, routing_quest.from):
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
	else:
		return false


func settlement_has_connection_to(from, to):
	# get roads connecting "from"
	# does any road have "to"
	var roads = map.get_roads_from(from)
	for r in roads:
		if r.s_node_a == to or r.s_node_b == to:
			return true
	return false


func check_destination(st, st_removed = false):
	if st == routing_quest.to:
		if !st_removed:
			UI.show_route_confirmation()
		else:
			UI.hide_route_confirmation()
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
		UI.unit_selector.show()
		UI.hide_quest_at(routing_unit.at)
	else:
		routing_quest.unit = null
	map.disable_roads()
	UI.routing = false
	UI.enable_all_settlements()


func settlement_connections(st: Settlement):
	var c = 0
	for r in routing_roads_selected:
		if r.s_node_a == st or r.s_node_b == st:
			c += 1
	return c


func quest_complete(q, rwd):
	var reputation = 5
	
	# late?
	if q.reward > rwd:
		reputation -= -2
	
	company.reward(reputation, rwd)
	UI.company.update()
	q.from.quest = null
	if UI.quest_window.quest == q:
		UI.quest_window.quest = null
	$Quests.quests.erase(q)
	q.queue_free()
	
	
	var units_ready = company.units_ready() - $Quests.quests.size()
	var settlements_empty = map.settlements_empty() - $Quests.quests.size()
	var quests = units_ready
	if quests > settlements_empty:
		quests = settlements_empty
		
	for i in quests:
		$Quests.generate_quest()

func quest_aborted(q):
	var reputation = -4
	company.reward(reputation)
	UI.company.update()
	UI.pop_quest_at(q.from)
	q.unit = null
	q.active = false


func continue_playing():
	post_game = true
	unpause_game()


func pause_game():
	game_paused = true
	get_tree().paused = game_paused


func unpause_game():
	game_paused = false
	get_tree().paused = game_paused


func add_day():
	company.active_days += 1
	UI.company.update()
	$Quests.add_day()


func game_completed():
	yield(get_tree().create_timer(0.5), "timeout")
	UI.open_end()
	pause_game()


func new_quest():
	$Quests.generate_quest()
