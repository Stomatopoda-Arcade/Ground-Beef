extends Node2D

const ProjectileResource = preload("res://Game/Enemies/projectile.tscn")

signal game_over()
signal level_complete()

@export var abducted_score = 100
@export var jet_score = 50
@export var tank_score = 25

# Called when the node enters the scene tree for the first time.
func _ready():
	$PlayerCharacter/Beam.object_abducted.connect(handle_abducted)
	$PlayerCharacter/Beam.object_destroyed.connect(handle_destroyed)
	$PlayerCharacter.set_timer(Global.time_remaining)
	add_projectile_handlers()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#checking for win condition
	check_for_enemies()
	pass
	

func check_for_enemies():
	var more_enemies = false
	var children = self.get_children()
	
	for child in children:
		# check if any enemies left
		if child.is_in_group("enemy"):
			# if there is at least 1 enemy return
			more_enemies = true
			return
			
	# if no more enemies then level completed
	if !more_enemies:
		level_complete.emit()
		

func add_projectile_handlers():
	var children = self.get_children()
	for child in children:
		if child.is_in_group("shoots"):
			child.fire_projectile.connect(_on_fire_projectile)

func handle_abducted(groups):
	if groups.has("cow"):
		Global.score += abducted_score
		Global.scored_objects.append("cow")
	$PlayerCharacter.set_score(Global.score)
	
func handle_destroyed(groups):
	if groups.has("cow"):
		Global.score -= abducted_score
	elif groups.has("tank"):
		Global.score += tank_score
		Global.scored_objects.append("tank")
	elif groups.has("jet"):
		Global.score += jet_score
		Global.scored_objects.append("jet")
	$PlayerCharacter.set_score(Global.score)


func _on_game_timer_timeout():
	if Global.time_remaining > 0:
		Global.time_remaining -= 1
		$PlayerCharacter.set_timer(Global.time_remaining)
	else:
		level_complete.emit()

func _on_screen_wrap_body_exited(body):
	if body.is_in_group("projectile"):
		body.queue_free()
	# only teleport player if they arent disabled
	elif !body.is_in_group("player") or !$PlayerCharacter.player_disabled:
		# get left and right edge of screen wrap collision area
		var left_edge = $ScreenWrap.position.x - ($ScreenWrap/CollisionShape2D.shape.get_rect().size.x/2)
		var right_edge = $ScreenWrap.position.x + ($ScreenWrap/CollisionShape2D.shape.get_rect().size.x/2)
		var buffer = 150
		# teleport player to left or right edge + buffer
		if sign(body.position.x) == -1:
			body.position = Vector2(right_edge-buffer,body.position.y)
		else:
			body.position = Vector2(left_edge+buffer,body.position.y)


func _on_player_character_damaged():
	if !$PlayerCharacter.player_disabled:
		Global.lives -= 1
		$PlayerCharacter.set_lives(Global.lives)
		$PlayerCharacter.disable_player(true)
		$PlayerResetTimer.start()


func _on_player_reset_timer_timeout():
	if Global.lives > 0:
		$PlayerCharacter.position = Vector2(0,0)
		$PlayerCharacter.disable_player(false)
	else:
		$GameTimer.stop()
		game_over.emit()
		
func _on_fire_projectile(projectile_angle, projectile_velocity, projectile_position):
	var projectile_instance = ProjectileResource.instantiate()
	projectile_instance.projectile_velocity = projectile_velocity
	projectile_instance.angle = projectile_angle
	projectile_instance.position = projectile_position
	self.add_child(projectile_instance)
	self.move_child(projectile_instance,0)
