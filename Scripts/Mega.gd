extends CharacterBody2D
@onready var _animated_sprite = $AnimatedSprite2D


const SPEED = 500.0
const JUMP_VELOCITY = -3000
const CUSTOM_GRAVITY = 8000





# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = CUSTOM_GRAVITY

func virar(direction):
	if direction:
		velocity.x = direction * SPEED
		if direction > 0 and is_on_floor():
				_animated_sprite.flip_h = true
				_animated_sprite.play("Run")

		elif direction < 0 and is_on_floor():
			_animated_sprite.flip_h = false
			_animated_sprite.play("Run")

	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor():
			_animated_sprite.play("Idle")
		else:
			_animated_sprite.play("Jump")
			if Input.is_action_pressed("ui_left"):
				_animated_sprite.flip_h = true
			elif Input.is_action_pressed("ui_left"):
				_animated_sprite.flip_h = false


func _physics_process(delta):
	# Add the gravity.
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
		


	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY



	var direction = Input.get_axis("ui_left", "ui_right")
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	virar(direction)

	move_and_slide()
