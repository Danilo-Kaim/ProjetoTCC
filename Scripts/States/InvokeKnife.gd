extends BossState
class_name InvokeKnife

@onready var knife_manager = $"../../KnifeManager"

func Enter():
	knife_manager.InvokeKnife()
	print("Invocou facas")
	await (Engine.get_main_loop() as SceneTree).process_frame
	Transitioned.emit(self,nextState)
	
	
