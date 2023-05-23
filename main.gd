#TODO:
#	-Plumber koyote jump
#	-properly restart level not the whole main scene
#	-Gumbas collider must be reworked
#	-Gumba animation dead
#	-Gumba animation walk
#	-Animation on finish level
#	-Level selector between levels?
#	-Level transition between levels?
#	-Green button green wall
#	-Fire ball enemy
#	-Splash screen

extends Node2D

@export var current_level = 1;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var characters = get_tree().get_nodes_in_group("Characters").size() - 1
	$Label.set_text("Characters: " + str(characters))
	if Input.is_action_just_released("wheel_up"):
		next_scene()
	if Input.is_action_just_released("wheel_down"):
		prev_scene()
	if characters <= 0 or Input.is_action_just_pressed("reload"):
		get_tree().reload_current_scene()

 
func _on_dead_zone_body_entered(body):
	body.queue_free()

func next_scene():
	var nextNode = load("res://Scenes/Levels/Level_"+ str(current_level + 1) +".tscn").instantiate()
	get_node("/root/Main/Levels/").add_child(nextNode)
	get_node("/root/Main/Levels/Level_" + str(current_level)).free()
	current_level += 1
	
func prev_scene():
	var nextNode = load("res://Scenes/Levels/Level_"+ str(current_level - 1) +".tscn").instantiate()
	get_node("/root/Main/Levels/").add_child(nextNode)
	get_node("/root/Main/Levels/Level_" + str(current_level)).free()
	current_level -= 1
