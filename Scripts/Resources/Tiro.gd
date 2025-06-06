extends Hitbox

@export var speed: int = 200
@export var dano : int = 5

var vetor = Vector2.RIGHT

func _ready():
	damage = dano

func _process(delta):
	var mover = vetor.rotated(rotation) * speed * delta
	global_position += mover

func destruirBala():
	queue_free()	


func _on_area_entered(_area: Area2D):
	destruirBala()


func _on_body_entered(_body):
	destruirBala()
