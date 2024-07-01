extends CharacterBody2D

@export var speed: int = 0
@export var hp: int = 10
@export_range(1,4) var directionInicial: int = 2
@export var enemy: CharacterBody2D
@onready var tiro = $TiroPos as Marker2D
@onready var timer = $Timer
var up = true
var angle = 0
var loked = false
func _ready():
	setter()

func _physics_process(_delta):
	if !loked:
		angle += 1.6
		if angle >= 360:
			angle = angle - 360
		moveTiro()		
	attAngle()

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
	
func fire(rot):
	speed = 8000
	var dir = rot + 90
	rotation_degrees = dir
	if up:
		velocity = transform.x  * speed
	else:
		velocity = transform.x  * -speed	
	timer.start()
	move_and_slide()
	
func moveTiro():
	var raio = 50
	tiro.position.x = raio * cos(deg_to_rad(angle)) 
	tiro.position.y = raio * sin(deg_to_rad(angle))
	
func getAngleEnemy() -> float:
	var directionEnemy = enemy.position - position
	var bearingRadians = atan2(directionEnemy.y,directionEnemy.x)
	return bearingRadians
 
func attAngle():
	var absoluteBearing = deg_to_rad(angle) + getAngleEnemy()
	var gunTurnAngle = rad_to_deg(absoluteBearing) - angle
	var aux1 = gunTurnAngle
	if aux1 < 0:
		aux1 = 180 + aux1
		aux1 = 180 + aux1
	if abs(aux1 - angle) < 2:
		loked = true
		angle = aux1
		moveTiro()
		tiro.atirar(angle,self)
	else:
		loked = false	


func _on_timer_timeout():
	if up:
		up = false
	else:
		up = true	
	rotation_degrees = 0
	speed = 0


func _on_hurtbox_area_entered(area):
	if area.has_method("getParent"):
		if area.getParent() != self:
			fire(area.rotation_degrees)
			print("Fire Tomou Dano")
