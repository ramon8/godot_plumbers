extends Node2D

@onready var follow_path: PathFollow2D = $PathFollow2D

@export var speed :float = 60.0
@export var playerBounce :float = -350
	
func _physics_process(delta):
	follow_path.set_progress(follow_path.get_progress() + speed * delta)

func _on_enemie_body_entered(body):
	if "kill" in body:
		body.kill()


func _on_area_2d_body_entered(body):
	body.set_velocity(Vector2(0, playerBounce))
	queue_free()
