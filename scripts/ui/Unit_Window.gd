extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var profile = $Profile
onready var type =  $Type
onready var unit_name = $Name
onready var stats = $Stats

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func open(unit : Unit):
	profile.texture = unit.portrait
	type.text = unit.unit_type_names[unit.unit_type]
	unit_name.text = unit.unit_name
	stats.text = _get_unit_stats(unit)
	
	var tween = get_tree().create_tween()
	tween.tween_property(self, "rect_position", Vector2.UP * 220, 0.1).as_relative()

func _close():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "rect_position", Vector2.DOWN * 220, 0.1).as_relative()


func _get_unit_stats(unit : Unit):
	return "Reputation: %s\nSpeed: %s\nDefense: %s\nCharisma: %s\n" % \
	[unit.reputation_names[unit.reputation], unit.speed, unit.defense, unit.charsima]
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
