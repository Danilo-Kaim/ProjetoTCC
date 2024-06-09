extends CharacterBody2D


@export var speed: int = 300
@export var hp: int = 10
@export_range(1,4) var corner = 1
@export var enemy: CharacterBody2D
@onready var tiro = $TiroPos as Marker2D
@onready var bateuParede = $BateuParede as RayCast2D
var  input_vector = Vector2.ZERO
var angle = 0
var nCollision = 0
var canShoot = false
var canMove = true

func _ready():
	setter()

func _physics_process(_delta):
	if canMove:
		goCorners()
	else:
		input_vector = Vector2.ZERO	
	velocity =  speed * input_vector 
	move_and_slide()

func setter():
	match corner:
		1:
			bateuParede.target_position = Vector2(0,-20)
			bateuParede.position = Vector2(0,-37)
			angle = -90
		2:
			bateuParede.target_position = Vector2(20,0)
			bateuParede.position = Vector2(37,0)
			angle = 0
		3:
			bateuParede.target_position = Vector2(0,20)
			bateuParede.position = Vector2(0,37)
			angle = 90
		4:
			bateuParede.target_position = Vector2(-20,0)
			bateuParede.position = Vector2(-37,0)
			angle = 180
	moveTiro()

func goCorners():
	if bateuParede.is_colliding():
		nCollision += 1
	if nCollision == 1:
		corner -= 1
		if corner == 0:
			corner = 4	
		setter()
		nCollision += 1
	if nCollision > 2:
		canShoot = true	
	match corner:
		1:
			input_vector = Vector2.UP
		2:
			input_vector = Vector2.RIGHT
		3:
			input_vector = Vector2.DOWN
		4:
			input_vector = Vector2.LEFT				
	

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
	if abs(gunTurnAngle - angle) < 10 and nCollision < 3:
		canMove = false
		canShoot = true
		angle = gunTurnAngle 	
	else:
		if nCollision > 2:
			canMove = false
			angle = gunTurnAngle
			moveTiro()		
		else:
			canMove = true
			canShoot = false

func _on_hurtbox_area_entered(area):
	if area.is_in_group('Enemy'):
		print("Player tomou dano!")


func _on_tempo_tiro_timeout():
	attAngle()
	if canShoot:
		tiro.atirar(angle)
	if nCollision < 3:
		setter()	
