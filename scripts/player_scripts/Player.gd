extends KinematicBody2D

onready var animPlayer = $AnimationPlayer
onready var animTree = $AnimationTree
onready var animState = animTree.get("parameters/playback")

enum {
	MOVE_STATE,
	ATTACK_STATE,
	ROLL_STATE
}

const acceleration_rate = 300
const max_speed = 80
const roll_speed = 100
const friction_rate = 300

var current_state = MOVE_STATE
var velocity = Vector2.ZERO
var roll_vector = Vector2.ZERO

func _ready():
	animTree.active = true
	
	# -- end of _ready -- #

func _physics_process(delta):
	match current_state:
		MOVE_STATE:
			move_state(delta)
		ATTACK_STATE:
			attack_state(delta)
		ROLL_STATE:
			roll_state(delta)
	
	# -- end of _physics_process -- #

func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		roll_vector = input_vector
		animTree.set("parameters/Idle/blend_position", input_vector)
		animTree.set("parameters/Run/blend_position", input_vector)
		animTree.set("parameters/Attack/blend_position", input_vector)
		animTree.set("parameters/Roll/blend_position", input_vector)
		
		animState.travel("Run")
		velocity = velocity.move_toward(input_vector * max_speed, acceleration_rate * delta)
	else:
		animState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, friction_rate * delta)
	
	move_slide()
	
	if Input.is_action_just_pressed("player_attack"):
		current_state = ATTACK_STATE
	
	if Input.is_action_just_pressed("player_roll"):
		current_state = ROLL_STATE
	
	# -- end of move_state -- #

func move_slide():
	velocity = move_and_slide(velocity)

func attack_state(delta):
	velocity = Vector2.ZERO
	animState.travel("Attack")
	
	# -- end of attack_state -- #

func roll_state(delta):
	velocity = roll_vector * roll_speed
	animState.travel("Roll")
	move_slide()
	
	# -- end of roll_state -- #

# temp functions
func attack_anim_end():
	current_state = MOVE_STATE
	
	# --  end of attack_anim_end -- #

func roll_anim_end():
	velocity = Vector2.ZERO
	current_state = MOVE_STATE
	
	# --  end of roll_anim_end -- #
