extends Panel

class_name Quest_Window

onready var title = $Title
onready var description = $Description
onready var accept_button = $AcceptButton

onready var contact_profile = $Contact/Profile
onready var contact_name = $Contact/Name

onready var unit_profile = $Assignee/Profile
onready var unit_name = $Assignee/Name
onready var unit_stats = $Assignee/Stats
onready var unit_type = $Assignee/Type

var quest
var unit

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func open(st: Settlement, q:Quest, u: Unit = null):
	quest = q
	
	if u != null:
		unit = u
	
	title.text = q.quest_name
	description.text = q.get_description()
	accept_button.disabled = true
	contact_profile.texture = st.contact_profile
	contact_name.text = st.contact_name
	
	var tween = get_tree().create_tween()
	tween.tween_property(self, "rect_position", Vector2.RIGHT * 400 , 0.1).as_relative()

func _close():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "rect_position", Vector2.LEFT * 400 , 0.1).as_relative()
	
	unit_profile.texture = null
	unit_name.text = ""
	unit_stats.text = ""
	unit_type = ""
	
	accept_button.disabled = true


func select_unit(unit : Unit):
	unit_profile.texture = unit.portrait
	unit_name.text = unit.unit_name
	unit_stats.text = unit.get_stats()
	unit_type = unit.unit_type_names[unit.unit_type]
	
	accept_button.disabled = false


func _on_accept():
	_close()
	System.game.start_routing(quest, unit)
	
