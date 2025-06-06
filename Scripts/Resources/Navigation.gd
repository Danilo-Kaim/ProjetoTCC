extends Node2D
class_name Navigation

@onready var navigation: NavigationAgent2D = $NavigationAgent2D as NavigationAgent2D

var body: CharacterBody2D
var target: CharacterBody2D

func _ready():
	body = get_parent()
	var timer = GL.createTimer(0.5,false,true)
	timer.connect("timeout",_on_timer_timeout)

func chase(delta):
	var dir = body.to_local(navigation.get_next_path_position()).normalized()
	body.velocity = dir * body.speed * delta
	body.move_and_slide()
	
func makePath():
	if target:
		navigation.target_position = target.global_position
	else:
		print("Sem alvos")
	
	
func _on_timer_timeout():
	makePath()
