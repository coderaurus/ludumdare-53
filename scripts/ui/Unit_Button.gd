extends Control

class_name Unit_Button

export var s_path : NodePath # settlement node
onready var s_node = get_node(s_path)


func _process(delta):
	if rect_position != s_node.position:
		rect_position = s_node.position
		if !visible:
			rect_scale = Vector2.ONE * 0.1
			visible = true
			var tween = get_tree().create_tween()
			tween.tween_property(self, "rect_scale", Vector2.ONE, 0.1)
	elif visible: 
		var tween = get_tree().create_tween()
		tween.tween_property(self, "rect_scale", Vector2.ONE * 0.1, 0.1)
		tween.tween_property(self, "visible", false, 0)


func _on_inspect():
	s_node.emit_signal("on_inspect")
