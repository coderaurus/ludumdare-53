extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var profile = $Profile
onready var type =  $Type
onready var unit_name = $Name
onready var stats = $Stats

var inspected_unit = null
var is_open = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func open(unit: Unit):
	inspected_unit = unit
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
	
	if !is_open:
		var tween = get_tree().create_tween()
		tween.tween_property(self, "rect_position", Vector2.UP * 240, 0.1).as_relative()
		is_open = true

func _close():
	is_open = false
	inspected_unit = null
	var tween = get_tree().create_tween()
	tween.tween_property(self, "rect_position", Vector2.DOWN * 240, 0.1).as_relative()
	System.game.UI.clear_unit_selector()


func _hire():
	print("Hiring %s" % inspected_unit.unit_name)
	# reduce company funds
	# tap unit to hired
	System.game.company.gold -= inspected_unit.pay
	System.game.new_quest()
	inspected_unit.hired = true
	$"Hire Button".visible = false
