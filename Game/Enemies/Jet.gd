extends CharacterBody2D
const ProjectileResource = preload("res://Game/Enemies/projectile.tscn")
enum JET_FACING {JET_LEFT,JET_RIGHT}
enum DIFFICULTY {EASY,MEDIUM,HARD}

@export var projectile_velocity = 250 
@export var jet_velocity = 50
@export var starting_facing = JET_FACING.JET_RIGHT
@export var starting_difficulty = DIFFICULTY.EASY
var projectile_angle = 0
var direction = Vector2(1,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	if starting_facing == JET_FACING.JET_RIGHT:
		direction = Vector2(1,0)
		projectile_angle = 0
		$JetSprite.flip_h = false
	elif starting_facing == JET_FACING.JET_LEFT:
		direction = Vector2(-1,0)
		projectile_angle = 180
		$JetSprite.flip_h = true

	if starting_difficulty == DIFFICULTY.EASY:
		pass
	elif starting_difficulty == DIFFICULTY.MEDIUM:
		pass
	elif starting_difficulty == DIFFICULTY.HARD:
		$Timer.wait_time = 2
		$Timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var collision = move_and_collide(direction*jet_velocity*delta)
	check_collision(collision)

func check_collision(collision):
	if collision and collision.get_collider().is_in_group("player"):
		collision.get_collider().damage()
		queue_free()

func _on_timer_timeout():
	var projectile_instance = ProjectileResource.instantiate()
	projectile_instance.projectile_velocity = projectile_velocity
	projectile_instance.angle = projectile_angle
	self.add_child(projectile_instance)
	self.move_child(projectile_instance,0)
