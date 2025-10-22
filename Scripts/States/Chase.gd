extends BossState
class_name Chase


var count: int = 5

func randomizer_wander():
	if count <= 0:
		Transitioned.emit(self,"Dash")
	if boss and boss is CharacterBody2D:
		boss.direction = (boss.player.position - boss.position).normalized()
		await (Engine.get_main_loop() as SceneTree).process_frame
		boss.tiro.position = GL.moveTiro(GL.getAngleToRight(boss.direction,boss.angle))
	wander_time = randf_range(1,2)
	count -= 1
	
func Enter():
	randomizer_wander()
	
func Update(delta: float):
	if wander_time > 0:
		wander_time -= delta
	else:
		randomizer_wander()
		
func PhysicsUpdate(_delta: float):
	if boss and boss is CharacterBody2D:
		boss.velocity = boss.direction * boss.speed

func Exit():
	count = 5
