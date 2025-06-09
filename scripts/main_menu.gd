extends Node

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level1.tscn")

func _on_character_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/character_selection.tscn")

func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/credits.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()
