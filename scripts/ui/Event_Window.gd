extends Panel

class_name Event_Window

onready var event_name = $Name
onready var banner = $Banner
onready var description = $Description
onready var question = $Question
onready var option_a = $"Option A"
onready var option_b = $"Option B"

var is_open = false

func init(e: Event):
	event_name = e.event_name
	banner.texture = e.banner
	description.text = e.description
	question.text = e.question
	option_a.text = e.options[0]
	option_b.text = e.options[1]

func open(st: Settlement, e:Event, unit: Unit = null):
	if is_open:
		return
	
	init(e)
	
	var tween = get_tree().create_tween()
	tween.tween_property(self, "rect_position", Vector2.DOWN * 320, 0.1).as_relative()
	is_open = true
	# connect buttons?
	# do something here


func _close():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "rect_position", Vector2.UP * 320, 0.1).as_relative()
	is_open = false


func _on_option_a():
	print("Option A selected")


func _on_option_b():
	print("Option B selected")
