extends Node

func _ready() -> void:
	_update_button_states()

func _on_character_button_pressed(character: String) -> void:
	Global.character = character
	_update_button_states()
	print("Selected character:", Global.character)

func _update_button_states() -> void:
	var button_map = {
		"ch1": "b1",
		"ch2": "b2",
		"ch3": "b3",
		"ch4": "b4"
	}

	var selected_button = button_map.get(Global.character, "")

	var button_names = ["b1", "b2", "b3", "b4"]
	for btn_name in button_names:
		var button = $Control/buttons.get_node(btn_name)
		if btn_name == selected_button:
			button.disabled = true
			button.text = "Selected"
		else:
			button.disabled = false
			button.text = "Select"

func _on_b_1_pressed() -> void:
	_on_character_button_pressed("ch1")

func _on_b_2_pressed() -> void:
	_on_character_button_pressed("ch2")

func _on_b_3_pressed() -> void:
	_on_character_button_pressed("ch3")

func _on_b_4_pressed() -> void:
	_on_character_button_pressed("ch4")

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")
