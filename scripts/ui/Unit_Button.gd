extends Control

class_name Unit_Button

export var s_path : NodePath # settlement node
onready var s_node = get_node(s_path)


func _process(delta):
	if rect_position != s_node.position:
		rect_position = s_node.position


func _on_inspect():
	s_node.emit_signal("on_inspect")
