extends Area2D

@export var speed: int = 200

var vetor = Vector2.RIGHT
var parent
func _process(delta):
	var mover = vetor.rotated(rotation) * speed * delta
	global_position += mover
	
func setParent(par):
	parent = par
	
func getParent():
	return parent	

func setPos(pos):
	position = pos

func setRotation(rot):
	rotation = deg_to_rad(rot)

func destruirBala():
	queue_free()	


func _on_area_entered(area):
	if area.get_parent() != parent:
		destruirBala()


func _on_body_entered(_body):
	destruirBala()
