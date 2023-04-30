extends Control

class_name Company_UI
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var c_path : NodePath # settlement node
onready var c_node : Company = get_node(c_path)


onready var title  = $Title
onready var reputation_bar  = $Reputation
onready var reputation_tier = $Reputation/Tier
onready var gold  = $"../Gold"
onready var days  = $"../Days"


func init():
	title.text = c_node.company_name
	reputation_bar.value = c_node.reputation
	reputation_tier.text = c_node.get_reputation_title()
	gold.text = "Gold: %s" % c_node.gold
	days.text = "Day %s" % c_node.active_days
	

func _process(delta):
	pass

func update():
	if c_node.gold != int(gold.text):
		change_gold(c_node.gold)
	
	print("%s != %s == %s" % [c_node.reputation, reputation_bar.value, c_node.reputation != reputation_bar.value])
	if c_node.reputation != reputation_bar.value:
		change_reputation(c_node.reputation)

func change_gold(to):
	var increase = to > int(gold.text)
	var decrease = to < int(gold.text)
	if increase:
		while increase:
			var current = int(gold.text)
			current = clamp(current + 5, 0, to)
			gold.text = str(current)
			yield(get_tree(), "idle_frame")
			increase = to > int(current)
	elif decrease:
		while decrease:
			var current = int(gold.text)
			current = clamp(current - 5, 0, to)
			gold.text = str(current)
			yield(get_tree(), "idle_frame")
			decrease = to > int(current)


func change_reputation(to):
	var tween = get_tree().create_tween()
	tween.tween_property(reputation_bar, "value", to, 0.2)
#	tween.tween_method(reputation_bar, "set_value", reputation_bar.value, to, 0.2).set_ease(Tween.EASE_OUT)
	reputation_tier.text = c_node.get_reputation_title()
