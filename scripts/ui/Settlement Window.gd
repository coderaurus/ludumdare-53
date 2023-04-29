extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var header = $Name
onready var visited = $Visited
onready var info = $Info
onready var close_button = $Button

export var to_center = 395
export var to_side = 195

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func open(settlement : Settlement, event = null):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "rect_position", Vector2.LEFT * to_center, 0.1).as_relative()
	
	_set_fields(settlement)

func _set_fields(settlement : Settlement):
	header.text = settlement.settlement_name
	if settlement.visited:
		visited.text = "Visited"
	else:
		visited.text = "Not visited yet"
	info.text = _get_settlement_info()


func _get_settlement_info():
	return ""

func _close():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "rect_position", Vector2.RIGHT * to_center, 0.1).as_relative()
