extends CharacterBody2D

signal morreu

@export var speed: int = 0
@export var hp: int = 10
@export_range(1,4) var directionInicial: int = 2
@export var enemy: CharacterBody2D
@onready var tiro = $TiroPos as Marker2D
@onready var timer = $Timer
var tween
func _ready():
	#setter()
	rotacionar()


func _physics_process(_delta):
	attAngle()

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
func Tracker(spd):	
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
	

func rotacionar():
	tween = get_tree().create_tween()
	tween.tween_property(self,"rotation",rotation+deg_to_rad(360),1.5)
	tween.finished.connect(_on_tween_finished)
	
	
func getAngleEnemy() -> float:
	var directionEnemy = enemy.position - position
	var bearingRadians = atan2(directionEnemy.y,directionEnemy.x)
	return bearingRadians
 
func attAngle():
	var aux2 = rotation_degrees
	if aux2 >= 360:
		aux2 = fmod(aux2,360.0)		
	var absoluteBearing = deg_to_rad(aux2) + getAngleEnemy()
	var gunTurnAngle = rad_to_deg(absoluteBearing) - aux2
	var aux = gunTurnAngle
	if aux < 0:
		aux = 180 + aux
		aux = 180 + aux
	if abs(aux - aux2) < 3:
		tween.pause()
		timer.start()
	if !tween.is_running():
		if calcDistance() < 180:
			Tracker(-speed)
		elif calcDistance() < 250:
			tiro.atirar(aux2,self)	
		else:		
			Tracker(speed)				

func calcDistance():
	var x = enemy.global_position.x - global_position.x
	var y = enemy.global_position.y - global_position.y
	var distance = sqrt((x*x) + (y*y))
	return distance

func tomarDano(dano):
	hp -= dano
	if hp < 1:
		print("Tracker perdeu")
		morreu.emit()


func _on_hurtbox_area_entered(area):
	if area.has_method("getParent"):
		if area.getParent() != self and area.has_method("getDano"):
			print("Tracker Tomou " + str(area.getDano()) + " de Dano!")
			tomarDano(area.getDano())


func _on_tween_finished():
	tween.stop()
	rotacionar()

func _on_timer_timeout():
	velocity = Vector2.ZERO
	tween.play()
	
