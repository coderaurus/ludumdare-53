extends Control


func open():
	visible = true
	var tween = get_tree().create_tween()
	tween.tween_property(self, "rect_position", Vector2.UP * 200, 0.1).as_relative()
	
	
func _close(cancelled = true):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "rect_position", Vector2.DOWN * 200, 0.1).as_relative()
	visible = false
	System.game.map.enable_settlement(System.game.routing_unit.at)
	if cancelled:
		System.game.cancel_routing()
		$Confirm.visible = false


func _confirm():
	_close(false)
	$Confirm.visible = false
	System.game.close_routing(true)
	System.game.map.move_quest_unit(System.game.routing_quest.unit, System.game.routing_roads_selected)
