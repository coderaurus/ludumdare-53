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

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init():
	title.text = c_node.company_name
	reputation_bar.value = c_node.reputation
	reputation_tier.text = c_node.get_reputation_title()
	gold.text = "Gold: %s" % c_node.gold
	days.text = "Day %s" % c_node.active_days
	

func _process(delta):
	if c_node.gold != int(gold.text):
		gold.text = str(c_node.gold)
	
	
