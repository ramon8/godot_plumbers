extends Node2D

var plumber = load("res://Objects/plumber.tscn")
@onready var parent: Node = get_parent();

func _on_body_entered(body):
	$Sprite2D/AnimationPlayer.play("collect")
	

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "collect":
		var instance = plumber.instantiate();
		instance.position = position
		parent.add_child(instance)
		instance.set_velocity(Vector2(0, -300))
		queue_free()
