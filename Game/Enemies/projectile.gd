extends CharacterBody2D

@export var angle = 0.0
@export var projectile_velocity = 1
var direction = Vector2(1,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	angle = deg_to_rad(angle)
	direction = Vector2(cos(angle), sin(angle))
	rotate(angle)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var collision = move_and_collide(direction*projectile_velocity*delta)
	check_collision(collision)

func check_collision(collision):
	if collision and collision.get_collider().is_in_group("player"):
		collision.get_collider().damage()
		queue_free()
	elif collision and collision.get_collider().is_in_group("boundry"):
		queue_free()
	
