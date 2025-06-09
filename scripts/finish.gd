extends Area2D

@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@export var target_level : PackedScene
@onready var game_manager: Node = %GameManager

func _on_body_entered(body: Node2D) -> void:
	if (body.name == "CharacterBody2D") && game_manager.points >=1:
		sprite_2d.animation = "tapped"
		await get_tree().create_timer(1).timeout
		
		# Save points to the database now
		game_manager._update_points_in_db()
		
		call_deferred("_change_scene")

func _change_scene() -> void:
	get_tree().change_scene_to_packed(target_level)
