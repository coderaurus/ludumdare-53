extends Control

class_name Settlement_Button
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var s_path : NodePath # settlement node
onready var s_node = get_node(s_path)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


#func _process(delta):
#	if s_node != null:
#		rect_position = s_node.position


func _open():
	print("Its a me")
#	s_node.on_enter()
	s_node.emit_signal("on_enter")



func _on_Icon_Button_pressed():
	pass # Replace with function body.