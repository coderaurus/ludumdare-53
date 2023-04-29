extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var header = $Name
onready var visited = $Visited
onready var info = $Info
onready var close_button = $Button


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func open(settlement : Settlement, event = null):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position/x", 250, 0.2)
	
	_set_fields(settlement)

func _set_fields(settlement : Settlement):
	header.text = settlement.settlement_name
	if settlement.visited:
		visited.text = "Visited"
	else:
		visited.text = "Not visited yet"
	info.text = _get_settlement_info()


func _get_settlement_info():
	pass

func _close():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position/x", 645, 0.2)
