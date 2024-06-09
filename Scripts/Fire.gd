extends CharacterBody2D

@export var speed: int = 300
@export var hp: int = 10
@export var dist:int = 50
@export_range(1,4) var directionInicial: int = 2
@export var enemy: CharacterBody2D
@onready var tiro = $TiroPos as Marker2D

var angle = 0

func _ready():
	setter()

func _physics_process(delta):
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
	
func fire():
	var angleDiference = 90 - (deg_to_rad(angle) - getAngleEnemy())	

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
