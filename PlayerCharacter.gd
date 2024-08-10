extends CharacterBody2D


const SPEED = 300.0

var player_disabled = false

signal damaged

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _process(delta):
	if !player_disabled:
		check_beam()

func _physics_process(delta):

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if !player_disabled:
		var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		if input_dir.x == -1: 
			$Sprite2D.flip_h=false
		elif input_dir.x == 1:
			$Sprite2D.flip_h=true
		velocity = input_dir * SPEED
		
		var collision = move_and_collide(velocity*delta)
		check_collision(collision)
	
func check_beam():
	if Input.is_action_just_pressed("ui_death_beam"):
		$Beam.set_beam($Beam.BEAM_TYPE.DEATH)
	elif Input.is_action_just_pressed("ui_tractor_beam"):
		$Beam.set_beam($Beam.BEAM_TYPE.TRACTOR)
		
func set_score(value):
	$Camera2D/HUD/MarginContainer/HBoxContainer/LeftContainer/ScoreContainer/ScoreValue.text = str(value)

func set_lives(value):
	if value == 3:
		$Camera2D/HUD/MarginContainer/HBoxContainer/LeftContainer/LifeContainer/Life1.visible = true
		$CCamera2D/HUD/MarginContainer/HBoxContainer/LeftContainer/LifeContainer/Life2.visible = true
	if value == 2:
		$Camera2D/HUD/MarginContainer/HBoxContainer/LeftContainer/LifeContainer/Life1.visible = true
		$Camera2D/HUD/MarginContainer/HBoxContainer/LeftContainer/LifeContainer/Life2.visible = false
	if value == 1:
		$Camera2D/HUD/MarginContainer/HBoxContainer/LeftContainer/LifeContainer/Life1.visible = false
		$Camera2D/HUD/MarginContainer/HBoxContainer/LeftContainer/LifeContainer/Life2.visible = false
		

func set_timer(value):
	$Camera2D/HUD/MarginContainer/HBoxContainer/RightContainer/TimerLabel.text = str(value)

func check_collision(collision):
	if collision and collision.get_collider().is_in_group("hazard"):
		damaged.emit()

func damage():
	damaged.emit()

func disable_player(disabled):
	player_disabled = disabled
	collision_layer = 4 if disabled else 3
	$Sprite2D.visible = !disabled

