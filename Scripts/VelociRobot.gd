extends CharacterBody2D

@export var speed: float = 0
@export var hp: int = 10
@export_range(1,4) var directionInicial: int = 1
@export var enemy: CharacterBody2D
@onready var tiro = $TiroPos as Marker2D
var angle : float = 0.0
var tick : int = 0
var spdOption = true
var spd : float
var speed2 : float
func _ready():
	speed2 = -(speed + (speed/2))
	setter()


func _physics_process(_delta):
	if tick % 64 == 0:
		if spdOption:
			spd = speed
			spdOption = false
		else:
			spd = speed2
			spdOption = true
	rotacionar()
	velociRobot()
	moveTiro()
	
func setter():
	match directionInicial:
		1:
			angle = 270
		2:
			angle = 0
		3:
			angle = 90
		4:
			angle = 180
	moveTiro()
func rotacionar():
	var tween = get_tree().create_tween()
	await tween.tween_property(self,"angle",angle+15,0.1).finished
	tick += 1
func velociRobot():
	match directionInicial:
		1:
			velocity = transform.y * -spd
			
		2:
			velocity = transform.x * spd
			
		3:
			velocity = transform.y * spd
			
		4:
			velocity = transform.x * -spd
	
	move_and_slide()	

func moveTiro():
	var raio = 50
	tiro.position.x = raio * cos(deg_to_rad(angle)) 
	tiro.position.y = raio * sin(deg_to_rad(angle))
	attAngle()
	
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
	var rot : float = rotation_degrees
	if rot < 0:
		rot = 180 + rot
		rot = 180 + rot	
	var aux2 : float = angle + rot
	if aux2 >= 360.0:
		aux2 = fmod(aux2,360.0)	
	if abs(aux - aux2) < 5:
		tiro.atirar(aux2,self)	
		



func _on_hurtbox_area_entered(area):
	if area.has_method("getParent"):
		if area.getParent() != self:
			var x = rotation_degrees
			if x < 0:
				x = 180 + x
				x = 180 + x
			rotation = deg_to_rad(x+5)
			print("VelociRobot Tomou Dano")



func _on_hurtbox_body_entered(body):
	if body.is_in_group("Fundo"):
		spd = -spd
