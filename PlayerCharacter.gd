extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _process(delta):
	check_beam()

func _physics_process(delta):

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var x_direction = Input.get_axis("ui_left", "ui_right")
	var y_direction = Input.get_axis("ui_up", "ui_down")
	
	if x_direction == -1: 
		$Sprite2D.flip_h=false
	elif x_direction == 1:
		$Sprite2D.flip_h=true
		
	
	if x_direction:
		velocity.x = x_direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if y_direction:
		velocity.y = y_direction * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
	
func check_beam():
	if Input.is_action_just_pressed("ui_death_beam"):
		$Beam.set_beam($Beam.BEAM_TYPE.DEATH)
	elif Input.is_action_just_pressed("ui_tractor_beam"):
		$Beam.set_beam($Beam.BEAM_TYPE.TRACTOR)
		
func set_score(value):
	$Camera2D/ScoreValue.text = str(value)
		

