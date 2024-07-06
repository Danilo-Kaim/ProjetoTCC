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
func _physics_process(_delta):
	crazy()
	move_and_slide()
		
func setter():
	match directionInicial:
		1:
			rotation = deg_to_rad(270)
		2:
			rotation = deg_to_rad(0)
		3:
			rotation = deg_to_rad(90)
		4:
			rotation = deg_to_rad(180)
	repairRotation(rotation)
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
	var aux1 = gunTurnAngle
	if aux1 < 0:
		aux1 = 180 + aux1
		aux1 = 180 + aux1		
	var aux2 = rotation_degrees
	if aux2 < 0:
		aux2 = 180 + aux2
		aux2 = 180 + aux2
	if abs(aux1 - aux2) < 3:
		tiro.atirar(aux2,self)
func tomarDano():
	pass




func _on_bateu_parede_body_entered(_body):
	speed *= -1


func _on_resete_tween_timeout():
	turn()


func _on_hurtbox_area_entered(area):
	if area.has_method("getParent"):
		if area.getParent() != self:
			print("Crazy Tomou Dano")
	tomarDano()
