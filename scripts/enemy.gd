extends CharacterBody2D

var speed = -100.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var game_manager: Node = %GameManager
@onready var sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


var facing_right = false

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
		sprite_2d.animation = "run"
	
	if (!$RayCast2D.is_colliding() || $RayCast2D2.is_colliding()) && is_on_floor():
		flip()
	
	velocity.x = speed
	move_and_slide()

func flip():
	facing_right = !facing_right
	
	scale.x = abs(scale.x) * -1
	if facing_right:
		speed = abs(speed)
	else:
		speed = abs(speed) * -1

func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body.name == "CharacterBody2D"):
		var y_delta = position.y - body.position.y
		var x_delta = body.position.x - position.x
		if (y_delta > 30):
			sprite_2d.animation = "hit"
			speed = 0
			await get_tree().create_timer(0.3).timeout
			queue_free()
			body.jump()
			game_manager.add_point()

		else:
			game_manager.decrease_health()
			if (x_delta > 0):
				body.jump_side(500)
			else:
				body.jump_side(-500)
