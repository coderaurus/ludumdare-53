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
var settlement

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func open(st: Settlement, q:Quest, u: Unit = null):
	quest = q
	settlement = st
	
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
	
	System.game.UI.selecting_quest = false


func select_unit(u : Unit):
	unit = u
	unit_profile.texture = u.portrait
	unit_name.text = u.unit_name
	unit_stats.text = u.get_stats()
	unit_type = u.unit_type_names[u.unit_type]
	
	accept_button.disabled = false


func _on_accept():
	_close()
	settlement.unit = unit
	unit.at = settlement
	System.game.map.disable_settlement(settlement)
	System.game.start_routing(quest, unit)
	System.game.open_neighboring_settlements(settlement)
	
