extends Node2D

@export var jump_velocity: int = -350
var plumber = load("res://Objects/plumber.tscn")
@onready var parent: Node = get_parent();
@onready var coin_sound = get_node("/root/Main/coin");

func _on_body_entered(body):
	$Sprite2D/AnimationPlayer.play("collect")
	

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "collect":			
		var instance = plumber.instantiate();
		instance.position = position
		get_parent().add_child(instance)
		instance.set_velocity(Vector2(0, jump_velocity))
#		instance.handle_single_jump()
		queue_free()
