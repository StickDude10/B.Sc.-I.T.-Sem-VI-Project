extends Area2D

@onready var timer: Timer = $Timer
@onready var game_manager: Node = %GameManager

func _on_body_entered(body: Node2D) -> void:
	if (body.name == "CharacterBody2D"):
		var y_delta = position.y - body.position.y
		var x_delta = body.position.x - position.x
		if (y_delta > 30):
			queue_free()
			body.jump()

		else:
			game_manager.decrease_health()
			if (x_delta > 0):
				body.jump_side(500)
			else:
				body.jump_side(-500)

func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
