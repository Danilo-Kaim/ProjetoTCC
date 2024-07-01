extends CharacterBody2D


@export var speed: int = 300
@export var hp: int = 10
@export_range(1,4) var wall = 1
@export var enemy: CharacterBody2D
@onready var tiro = $TiroPos as Marker2D
@onready var bateuParede = $BateuParede as RayCast2D
var  input_vector = Vector2.ZERO
var angle = 0
var angleAux = 0 
var rotacionando = false
var primeiraRot = true

func _ready():
	match wall:
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

func _physics_process(_delta):
	if angle < 0:
		angle = 360 - angle
	if rotacionando and angle != angleAux:
		input_vector = Vector2.ZERO
		rotacionar()
	if angle == angleAux:
		rotacionando = false
		setter()
	goWall()
	attAngle()
	velocity =  speed * input_vector 
	move_and_slide()
func rotacionar():
	angle -= 1
	moveTiro()

func setter():
	match wall:
		1:
			bateuParede.target_position = Vector2(0,-20)
			bateuParede.position = Vector2(0,-40)
			input_vector = Vector2.UP
		2:
			bateuParede.target_position = Vector2(20,0)
			bateuParede.position = Vector2(40,0)
			input_vector = Vector2.RIGHT
		3:
			bateuParede.target_position = Vector2(0,20)
			bateuParede.position = Vector2(0,40)
			input_vector = Vector2.DOWN
		4:
			bateuParede.target_position = Vector2(-20,0)
			bateuParede.position = Vector2(-40,0)
			input_vector = Vector2.LEFT	
	bateuParede.enabled = true

func goWall():
	if bateuParede.is_colliding():
		wall -= 1
		if wall == 0:
			wall = 4
		bateuParede.enabled = false
		if primeiraRot:
			angleAux = angle - 180
			primeiraRot = false
			if angleAux < 0:
				angleAux = 180 
		else:	
			angleAux = angle - 90
		if angleAux < 0:
			angleAux = 270
		rotacionando = true				
	

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
	if abs(aux - angle) < 2:
		tiro.atirar(angle,self)	

func _on_hurtbox_area_entered(area):
	if area.has_method("getParent"):
		if area.getParent() != self:
			print("Wall Tomou Dano")


