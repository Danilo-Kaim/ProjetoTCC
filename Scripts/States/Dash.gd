extends BossState
class_name Dash

var count: int = 3
var pauseTime: float = 2.0
var dashTime: float = 0.4
@onready var dash_aviso = $"../../DashAviso"


func Enter():
	var parent = get_parent()
	
	if parent:
		boss.velocity = Vector2.ZERO
		parent.set_process(false)
		dash_aviso.text = "Dash!"
		await (Engine.get_main_loop() as SceneTree).create_timer(2.0).timeout
		dash_aviso.text = ""
		parent.set_process(true)

func avanco(_delta: float):
	if count <= 0 and not boss.isDashing:
		Transitioned.emit(self, "Shooting")
		return
	
	# só executa se o boss não estiver dando dash
	if not boss.isDashing:
		# garante que o estado atual é o Dash
		if get_parent().current_state != self:
			return
		
		boss.isDashing = true
		count -= 1
		
		boss.direction = (boss.player.position - boss.position).normalized()
		var timer = 0.0

		# --- Fase 1: avanço ---
		while timer < dashTime:
			# interrompe se o estado mudar
			if get_parent().current_state != self:
				return
			boss.tiro.position = GL.moveTiro(GL.getAngleToRight(boss.direction,boss.angle))
			boss.velocity = boss.direction * boss.dashSpeed
			timer += get_process_delta_time()
			await (Engine.get_main_loop() as SceneTree).process_frame


		# --- Fase 2: desaceleração ---
		while boss.velocity.length() > 1:
			if get_parent().current_state != self:
				return
			boss.velocity = boss.velocity.move_toward(Vector2.ZERO, boss.fric * get_process_delta_time())
			await (Engine.get_main_loop() as SceneTree).process_frame
		
		boss.velocity = Vector2.ZERO
		boss.isDashing = false
		
		# --- Fase 3: pausa ---
		var pauseTimer = 0.0
		while pauseTimer < pauseTime:
			if get_parent().current_state != self:
				return
			pauseTimer += get_process_delta_time()
			await (Engine.get_main_loop() as SceneTree).process_frame


func Update(delta):
	avanco(delta)

func Exit():
	count = 2
