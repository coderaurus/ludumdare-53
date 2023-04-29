extends Control


func open():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "rect_position", Vector2.UP * 200, 0.1).as_relative()
	
	
func _close():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "rect_position", Vector2.DOWN * 200, 0.1).as_relative()
	System.game.cancel_routing()
