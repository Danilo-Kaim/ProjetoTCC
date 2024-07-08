extends CharacterBody2D


signal morreu

@export var speed: int = 0
@export var hp: int = 10
@export_range(1,4) var directionInicial: int = 1
@export var enemy: CharacterBody2D
@onready var tiro = $TiroPos as Marker2D
@onready var timer = $Timer
var rotacionando = false
var angle : float = 0.0
var angleAux : float = 360.0
func _ready():
	timer.start()
	setter()


func _physics_process(_delta):
	if !rotacionando:
		myFirstRobot()
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
	await tween.tween_property(self,"angle",angle+360,1).finished
	rotacionando = false
	timer.start()
		
		
	
	

func myFirstRobot():
	match directionInicial:
		1:
			velocity = transform.y * -speed
			
		2:
			velocity = transform.x * speed
			
		3:
			velocity = transform.y * speed
			
		4:
			velocity = transform.x * -speed
	
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
		tiro.atirar(aux,self)	


func tomarDano(dano):
	hp -= dano
	if hp < 1:
		print("MyFirstRobot perdeu")
		morreu.emit()
		
				
func _on_hurtbox_area_entered(area):
	if area.has_method("getParent"):
		if area.getParent() != self and area.has_method("getDano"):
			var x = area.rotation_degrees
			if x < 0:
				x = 180 + x
				x = 180 + x
			rotation = deg_to_rad(x+90)
			print("MyFirstRobot Tomou " + str(area.getDano()) + " de Dano!")
			tomarDano(area.getDano())

func _on_timer_timeout():
	velocity = Vector2.ZERO
	speed = -speed
	rotacionando = true
	rotacionar()
	
