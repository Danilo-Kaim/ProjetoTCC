extends Node
class_name HealthComponent

func tomarDano(dano: int):
	print(get_parent().name + " Tomou dano")
	get_parent().health -= dano
	if get_parent().health < 1:
		SceneManager.call_deferred("reload")
