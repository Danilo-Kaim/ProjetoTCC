extends CharacterBody2D

@export var speed: int = 300
@export var hp: int = 10
@export_range(1,4) var directionInicial: int = 2
@export var enemy: CharacterBody2D
@onready var collision = $Collision as CollisionShape2D
@onready var texture = $Texture as Sprite2D
@onready var tiro = $TiroPos as Marker2D
@onready var hurtbox = $Hurtbox as Area2D
@onready var bateuParede = $BateuParede as Area2D

var rotationDirection = 0
var angle = 0

func _ready():
	turn()
	setter()
func _physics_process(_delta):
	crazy()
	move_and_slide()
		
func setter():
	match directionInicial:
		1:
			angle = -90
		2:
			angle = 0
		3:
			angle = 90
		4:
			angle = 180
	moveTiro()
func crazy():	
	attAngle()
	match directionInicial:
		1:
			velocity = transform.y * -speed
			
		2:
			velocity = transform.x * speed
			
		3:
			velocity = transform.y * speed
			
		4:
			velocity = transform.x * -speed	
	repairRotation(rotation)

func turn():
	var tween = get_tree().create_tween()
	angle = rotation
	angle -= deg_to_rad(90)
	tween.tween_property(self,"rotation",angle,1.5).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_LINEAR)
	angle += deg_to_rad(180)
	tween.tween_property(self,"rotation",angle,1.5).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_LINEAR)
	angle -= deg_to_rad(180)
	tween.tween_property(self,"rotation",angle,1.5).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_LINEAR)
	
func repairRotation(rot):
	"""for i in get_children():
		if i in get_tree().get_nodes_in_group("timer"):
			i.rotation = -rot
	"""					
	collision.rotation = -rot
	texture.rotation = -rot
	tiro.rotation = -rot
	hurtbox.rotation = -rot
	bateuParede.rotation = -rot
	
func moveTiro():
	var raio = 50
	tiro.position.x = raio * cos(deg_to_rad(angle)) 
	tiro.position.y = raio * sin(deg_to_rad(angle))
	
func getAngleEnemy() -> float:
	var directionEnemy = enemy.position - position
	var bearingRadians = atan2(directionEnemy.y,directionEnemy.x)

	return bearingRadians
 
func attAngle():
	var absoluteBearing = rotation + getAngleEnemy()
	var gunTurnAngle = rad_to_deg(absoluteBearing) - rotation_degrees		
	if abs(gunTurnAngle - rotation_degrees) < 3:
		tiro.atirar(rotation_degrees)





func _on_bateu_parede_body_entered(_body):
	speed *= -1


func _on_resete_tween_timeout():
	turn()
