extends Panel

class_name Unit_Selector_Window


func init(company : Company):
	for i in get_child_count():
		var unit_button : Unit_Toolbar_Button = get_child(i)
		var unit = company.units.get_child(i)
		unit_button.unit = unit
		unit_button.init(unit)
	
