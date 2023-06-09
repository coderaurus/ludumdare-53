extends Control

export var menu_visible = true

onready var settlement_window = $"Settlement/Window"
onready var quest_window = $"Quest/Window"
onready var unit_selector = $"Unit Selector/Window"
onready var unit_window = $"Unit/Window"
onready var event_window = $"Event/Window"
onready var log_panel = $Log
onready var settlements = $Settlements
onready var gold = $Gold
onready var company = $Company
onready var route_selction = $"Route Selection"
onready var start = $"Start/Window"
onready var end = $"End/Window"

var routing = false
var selecting_quest = false

func _ready():
	_init_menu()

func init():
	company.init()
	unit_selector.init(company.c_node)



func _init_menu():
	$Menu.visible = false
	$Menu/Settings/Sound/Slider.max_value = SoundManager.MAX_DB
	$Menu/Settings/Sound/Slider.min_value = SoundManager.MUTE_DB
	
	$Menu/Settings/Music/Slider.max_value = MusicManager.MAX_DB
	$Menu/Settings/Music/Slider.min_value = MusicManager.MUTE_DB


func _process(delta):
	
	if Input.is_action_just_pressed("menu"):
		_toggle_menu()


func open_event(st: Settlement, e:Event, unit: Unit):
	event_window.open(st, e, unit)

func open_settlement(settlement, event = null):
	if not routing:
		if event != null:
			event_window.open(settlement, event)
		else:
			settlement_window.open(settlement, event)
	else:
		System.game.select_road(settlement)

func open_unit(unit):
	unit_window.open(unit)


func select_unit(unit):
	quest_window.select_unit(unit)


func open_quest(st: Settlement, quest, u: Unit = null):
#	if quest == null:
#		quest = st.quest
	quest_window.open(st, quest, u)
	selecting_quest = true
	unit_selector.check_units()


func disable_settlement(index):
	settlements.get_child(index).disable()


func enable_settlement(index):
	settlements.get_child(index).enable()


func _toggle_sound():
	var slider = $Menu/Settings/Sound/Slider
	if slider.value == SoundManager.stored_db or (slider.value <= SoundManager.MAX_DB and slider.value > SoundManager.MUTE_DB):
		SoundManager.stored_db = slider.value
		slider.value = SoundManager.MUTE_DB
		$Menu/Settings/Sound/Button.text = "No Snd"
	else:
		slider.value = SoundManager.stored_db
		$Menu/Settings/Sound/Button.text = "Sound"


func _toggle_music():
	var slider = $Menu/Settings/Music/Slider
	if slider.value == MusicManager.stored_db or (slider.value <= MusicManager.MAX_DB and slider.value > MusicManager.MUTE_DB):
		MusicManager.stored_db = slider.value
		slider.value = MusicManager.MUTE_DB
		$Menu/Settings/Music/Button.text = "No Msc"
	else:
		slider.value = MusicManager.stored_db
		$Menu/Settings/Music/Button.text = "Music"



func _toggle_menu():
	if menu_visible:
		hide_menu()
	else:
		show_menu()


func _toggle_focus(node : Control , mode := 0):
	for elem in node.get_children():
		elem.focus_mode = mode
		if elem.get_child_count() > 0:
			_toggle_focus(elem, mode)


func hide_menu():
	_toggle_focus($Menu/Settings, Control.FOCUS_NONE)
	var tween = create_tween().set_parallel()
	tween.tween_property($Menu/Settings, "modulate", Color.transparent, 0.1)
	tween.tween_property($Menu, "visible", true, 0).set_delay(0.1)
	tween.chain().tween_property(self, "menu_visible", false, 0)
	get_parent().in_menu = false


func show_menu():
	if is_inside_tree():
		var tween = create_tween().set_parallel()
		tween.tween_property($Menu, "visible", true, 0)
		tween.tween_property($Menu/Settings, "modulate", Color.white, 0.5).set_delay(0.1)
		tween.chain().tween_property(self, "menu_visible", true, 0)
		
		_toggle_focus($Menu/Settings, Control.FOCUS_ALL)
		
		get_parent().in_menu = true


func _on_sound_changed(value):
	SoundManager._on_range_changed(value)


func _on_music_changed(value):
	MusicManager._on_range_change(value)


func _on_music_toggle_pressed():
	_toggle_music()
	SoundManager.sound("click")


func _on_sound_toggle_pressed():
	_toggle_sound()
	SoundManager.sound("click")


func start_routing():
	routing = true
	route_selction.open()
	unit_selector.hide()
	init_settlements_for_routing(System.game.routing_quest.from, System.game.routing_quest.to)


func cancel_routing(q, u: Unit):
	routing = false
	unit_selector.show()
	open_quest(q.from, q)
	enable_all_settlements()
	System.game.map.disable_roads()


func show_route_confirmation():
	route_selction.get_node("Confirm").visible = true


func hide_route_confirmation():
	route_selction.get_node("Confirm").visible = false


func clear_unit_selector():
	unit_selector.clear_units()


func open_end():
	end.open(System.game.company)


func pop_quest_at(st):
	for s in settlements.get_children():
		if s.s_node == st:
			s.pop_quest()


func hide_quest_at(st):
	for s in settlements.get_children():
		if s.s_node == st:
			s.hide_quest()


func pop_event_at(st):
	for s in settlements.get_children():
		if s.s_node == st:
			s.pop_event()


func hide_event_at(st):
	for s in settlements.get_children():
		if s.s_node == st:
			s.hide_event()


func init_settlements_for_routing(start_st, end_st):
	for s in settlements.get_children():
		if s.s_node == start_st:
			s.disable()
		else:
			s.enable()
			
			if s.s_node == end_st:
				s.mark_route_target()

func enable_all_settlements():
	for s in settlements.get_children():
		s.enable()
