extends KinematicBody2D

const acceleration_rate = 300
const max_speed = 80
const friction = 300

var velocity = Vector2.ZERO

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * max_speed, acceleration_rate * delta)
		# velocity += input_vector * acceleration_rate * delta
		# velocity = velocity.clamped(max_speed)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	
	velocity = move_and_slide(velocity)
	
	# -- end of _physics_process -- #

# --  end of Player.gd -- #
