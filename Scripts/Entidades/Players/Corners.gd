extends CharacterBody2D

signal morreu

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
			bateuParede.position = Vector2(0,-40)
			input_vector = Vector2.UP
			angle = 270
		2:
			bateuParede.target_position = Vector2(20,0)
			bateuParede.position = Vector2(40,0)
			input_vector = Vector2.RIGHT
			angle = 0
		3:
			bateuParede.target_position = Vector2(0,20)
			bateuParede.position = Vector2(0,40)
			input_vector = Vector2.DOWN
			angle = 90
		4:
			bateuParede.target_position = Vector2(-20,0)
			bateuParede.position = Vector2(-40,0)
			input_vector = Vector2.LEFT	
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
	var aux = gunTurnAngle
	if aux < 0:
		aux = 180 + aux
		aux = 180 + aux
	if abs(aux - angle) < 10 and nCollision < 3:
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

func tomarDano(dano):
	hp -= dano
	if hp < 1:
		print("Corners perdeu")
		morreu.emit()


func _on_hurtbox_area_entered(area):
	if area.has_method("getParent"):
		if area.getParent() != self and area.has_method("getDano"):
			print("Corners Tomou " + str(area.getDano()) + " de Dano!")
			tomarDano(area.getDano())


func _on_tempo_tiro_timeout():
	attAngle()
	if canShoot:
		tiro.atirar(angle,self)
	if nCollision < 3:
		setter()	
