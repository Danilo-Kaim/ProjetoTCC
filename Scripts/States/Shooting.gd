extends BossState
class_name Shooting

func Enter():
	boss = get_parent().get_parent()
	await (Engine.get_main_loop() as SceneTree).process_frame
	boss.angle = GL.getAngleEnemy(boss.player,boss,boss.angle)
	boss.tiro.position = GL.moveTiro(boss.angle)
	boss.tiro.multiTiro([boss.angle, boss.angle + 10, boss.angle - 10], boss)
	Transitioned.emit(self,"Idle")
