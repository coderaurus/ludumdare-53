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

func open(unit: Unit):
	profile.texture = unit.portrait
	type.text = unit.unit_type_names[unit.unit_type]
	unit_name.text = unit.unit_name
	stats.text = unit.get_stats()
	
	if !unit.hired:
		$"Hire Button".text = "Hire for %sG" % unit.pay
		$"Hire Button".visible = true
		$"Hire Button".disabled = true
		if unit.is_hirable():
			$"Hire Button".disabled = false
		
	else:
		$"Hire Button".visible = false
	
	var tween = get_tree().create_tween()
	tween.tween_property(self, "rect_position", Vector2.UP * 220, 0.1).as_relative()

func _close():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "rect_position", Vector2.DOWN * 220, 0.1).as_relative()
	System.game.UI.clear_unit_selector()
