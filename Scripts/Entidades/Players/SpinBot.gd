extends CharacterBody2D

signal morreu

@export var speed: int = 300
@export var hp: int = 10
@export var enemy: CharacterBody2D
@onready var tiro = $TiroPos as Marker2D
var center = Vector2(0,0)

var  input_vector = Vector2.ZERO
var anglePlayer = 0
var angle = 0

func _ready():
	center = Vector2(global_position.x-100,global_position.y)

func _physics_process(_delta):
	if angle >= 360:
		angle = angle - 360
	Spin()
	moveTiro()	
	attAngle()
	
	
func Spin():
	angle += 1.5
	var raio  = 100
	global_position.x = center.x + raio * cos(deg_to_rad(angle)) 
	global_position.y = center.y + raio * sin(deg_to_rad(angle))
	
	
		
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
		tiro.atirar(aux,self)

func tomarDano(dano):
	hp -= dano
	if hp < 1:
		print("SpinBot perdeu")
		morreu.emit()


func _on_hurtbox_area_entered(area):
	if area.has_method("getParent"):
		if area.getParent() != self and area.has_method("getDano"):
			print("SpinBot Tomou " + str(area.getDano()) + " de Dano!")
			tomarDano(area.getDano())









