extends Area2D

var speed = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if $Ray/CheckCollision.is_colliding() or not $Ray/CheckFall.is_colliding():
		speed *= -1
		$Sprite2D.flip_h = speed > 0
		$Ray.set_scale(Vector2(speed, 1))
	position.x = position.x + speed


func _on_body_entered(body):
	if body.position.y > position.y:
		body.queue_free()


func _on_kill_body_entered(body):
	body.set_velocity(Vector2(body.velocity.x, -300))
	queue_free()
