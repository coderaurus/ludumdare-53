extends Panel

class_name Unit_Selector_Window


func init(company : Company):
	for i in get_child_count():
		var unit_button : Unit_Toolbar_Button = get_child(i)
		var unit = company.units.get_child(i)
		unit_button.unit = unit
		unit_button.init(unit)
	
func hide():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "rect_position", Vector2.DOWN * 100, 0.1).as_relative()
	
func show():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "rect_position", Vector2.UP * 100, 0.1).as_relative()
