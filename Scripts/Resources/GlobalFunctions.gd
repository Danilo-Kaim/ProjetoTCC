extends Node

func getAngleEnemy(enemy: CharacterBody2D, robot: CharacterBody2D,angle: float) -> float:
	var directionEnemy = enemy.position - robot.position
	var bearingRadians = atan2(directionEnemy.y,directionEnemy.x)
	var absoluteBearing = deg_to_rad(angle) + bearingRadians
	var gunTurnAngle = rad_to_deg(absoluteBearing) - angle
	return gunTurnAngle
	
func moveTiro(angle: float):
	var raio = 50
	var x = raio * cos(deg_to_rad(angle)) 
	var y = raio * sin(deg_to_rad(angle))
	return Vector2(x,y)

func calcDistance(enemy: CharacterBody2D,robot: CharacterBody2D):
	var x = enemy.global_position.x - robot.global_position.x
	var y = enemy.global_position.y - robot.global_position.y
	var distance = sqrt((x*x) + (y*y))
	return distance
	
func createTimer(waitTimer: float,oneShot: bool,autoStart: bool):
	var timer = Timer.new()
	timer.wait_time = waitTimer
	timer.one_shot = oneShot
	timer.autostart = autoStart
	add_child(timer)
	return timer
	
func getAngleToRight(v: Vector2, angle: float) -> float:
	var bearingRadians = atan2(v.y,v.x)
	var absoluteBearing = deg_to_rad(angle) + bearingRadians
	var gunTurnAngle = rad_to_deg(absoluteBearing) - angle
	return gunTurnAngle
