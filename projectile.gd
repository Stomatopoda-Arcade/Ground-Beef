extends StaticBody2D

@export var angle = 0.0
@export var velocity = 1
var direction = Vector2(1,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	angle = deg_to_rad(angle)
	direction = Vector2(cos(angle), sin(angle))
	rotate(angle)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction*velocity*delta
	
