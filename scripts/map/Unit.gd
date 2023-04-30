extends Area2D

class_name Unit

export var portrait : Resource
export var unit_name = "Bob"
export(int, "Goblin", "Centaur", "Hydra", "Dragon") var unit_type = 0
export var unit_type_names = ["Goblin", "Centaur", "Hydra", "Dragon"]
export var flies = false
export var speed = 3
export var defense = 2
export var charsima = 1
export(String, "Shun", "Questinoable", "Neutral", "Well Known", "Legendary") var reputation = 0
export var reputation_names = ["Shun", "Questinoable", "Neutral", "Well Known", "Legendary"]
export var hired = false
export var pay = 100

var quest = null
var at
var path

signal on_inspect

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_inspect():
	print("Inspecting me, %s" % self)
	System.game.UI.open_unit(self)


func get_stats():
	return "Reputation: %s\nSpeed: %s\nDefense: %s\nCharisma: %s\n" % \
	[reputation_names[reputation], speed, defense, charsima]


func is_hirable():
	return System.game.company.gold >= pay


func start_moving(roads):
	path = roads
	move()


func move():
	var tween = get_tree().create_tween()
	var travel_time
	var target
	var distance
	if path[0].s_node_a == at:
		target = path[0].s_node_b
		distance = (at.position as Vector2).distance_to(target.position)
		travel_time = distance / speed * 0.7
		tween.tween_property(self, "position", target.position, travel_time).from(at.position)
	else:
		target = path[0].s_node_a
		distance = (at.position as Vector2).distance_to(target.position)
		travel_time = distance / speed * 0.7
		tween.tween_property(self, "position", target.position, travel_time)
	# check events after movement
	yield(tween, "finished")
	at = target
	path.pop_at(0)
	#
	# check events!
	#
	if path.size() > 0:
		move()
	else:
		# quest complete!
		if quest.complete():
			quest = null
		
		pass
	
