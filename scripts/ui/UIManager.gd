extends Control

export var menu_visible = true

onready var settlement_window = $"Settlement/Window"
onready var quest_window = $"Quest/Window"
onready var unit_selector = $"Unit Selector/Window"
onready var unit_window = $"Unit/Window"
onready var log_panel = $Log
onready var settlements = $Settlements

func _ready():
	_init_menu()
	


func _init_menu():
	$Menu.visible = false
	$Menu/Settings/Sound/Slider.max_value = SoundManager.MAX_DB
	$Menu/Settings/Sound/Slider.min_value = SoundManager.MUTE_DB
	
	$Menu/Settings/Music/Slider.max_value = MusicManager.MAX_DB
	$Menu/Settings/Music/Slider.min_value = MusicManager.MUTE_DB


func _process(delta):
	
	if Input.is_action_just_pressed("menu"):
		_toggle_menu()


func open_settlement(settlement, event = null):
	settlement_window.open(settlement, event)


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
