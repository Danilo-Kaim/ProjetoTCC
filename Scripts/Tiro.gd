extends Area2D

@export var speed: int

var vetor = Vector2.RIGHT


func _process(delta):
	var mover = vetor.rotated(rotation) * speed * delta
	global_position += mover
	


func setPos(pos):
	position = pos

func setRotation(rot):
	rotation = deg_to_rad(rot)
	

func _on_body_entered(_body):
	queue_free()
	
