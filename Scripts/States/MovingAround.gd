extends BossState
class_name MovingAround

var count: int = 5


func randomizer_wander():
	if count <= 0:
		Change()
	boss.direction = Vector2(randf_range(-1,1),randf_range(-1,1)).normalized()
	wander_time = randf_range(1,2)
	count -= 1
	
func Change():
	var random = randi_range(0,101)
	if random <= 60:
		Transitioned.emit(self,"Chase")
	else:
		count = 5
	
func Enter():
	randomizer_wander()

func Update(delta: float):
	if wander_time > 0:
		wander_time -= delta
	else:
		randomizer_wander()
	boss.tiro.position = GL.moveTiro(GL.getAngleToRight(boss.direction,boss.angle))
		
func PhysicsUpdate(_delta: float):
	if boss and boss is CharacterBody2D:
		boss.velocity = boss.direction * boss.speed
		for i in range(boss.get_slide_collision_count()):
			var collision = boss.get_slide_collision(i)
			var collider = collision.get_collider()
			if collider.name == "AreaTemplate":
				boss.direction = Vector2(randf_range(-1,1),randf_range(-1,1)).normalized()

