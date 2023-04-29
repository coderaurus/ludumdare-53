extends Control


func open():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "rect_position", Vector2.UP * 200, 0.1).as_relative()
	
	
func _close(cancelled = true):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "rect_position", Vector2.DOWN * 200, 0.1).as_relative()
	if cancelled:
		System.game.cancel_routing()


func _confirm():
	_close(false)
	$Confirm.visible = false
	System.game.map.move_quest_unit(System.game.routing_quest.unit, System.game.routing_roads_selected)
