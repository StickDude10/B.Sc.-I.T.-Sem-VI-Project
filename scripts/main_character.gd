extends CharacterBody2D

@export var SPEED = 400.0
@export var JUMP_VELOCITY = -900.0
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@export var particle : PackedScene

var character_texture = Global.character + "_"

var jump_count = 0

func jump():
	velocity.y = JUMP_VELOCITY
	spawn_particle()

func jump_side(x):
	velocity.y = JUMP_VELOCITY
	velocity.x = x

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if is_on_floor():
		jump_count = 0
		
		if abs(velocity.x) > 1:
			sprite_2d.play(character_texture + "run")
		else:
			sprite_2d.play(character_texture + "idle")
	else:
		velocity += get_gravity() * delta
		
		if jump_count == 2:
			sprite_2d.play(character_texture + "double_jump")
		elif velocity.y < 0:
			sprite_2d.play(character_texture + "jump")
		elif velocity.y > 0:
			sprite_2d.play(character_texture + "fall")

	# Handle jump.
	if Input.is_action_just_pressed("jump") and jump_count < 2:
		velocity.y = JUMP_VELOCITY
		jump_count += 1
		if (jump_count == 2):
			spawn_particle()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 100)

	move_and_slide()
	
	if Input.is_action_just_pressed('left'):
		sprite_2d.flip_h = true
	if Input.is_action_just_pressed('right'):
		sprite_2d.flip_h = false

func spawn_particle():
	var partical_node = particle.instantiate()
	partical_node.position = position
	get_parent().add_child(partical_node)
	await get_tree().create_timer(0.3).timeout
	partical_node.queue_free()
