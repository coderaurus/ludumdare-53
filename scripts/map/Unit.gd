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

signal on_inspect

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_inspect():
	print("Inspecting me, %s" % self)
	System.game.UI.open_unit(self)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
