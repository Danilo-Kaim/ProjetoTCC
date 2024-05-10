extends CharacterBody2D


@export var speed: int
@export var player: CharacterBody2D
@onready var navegador = $NavigationAgent2D as NavigationAgent2D

func _physics_process(_delta):
	navegador.setPlayer(player)
	var dir = to_local(navegador.get_next_path_position()).normalized()
	velocity = dir * speed
	move_and_slide()
	


func _on_hitbox_body_entered(body):
	if body.is_in_group('Player'):
		print("Boss deu dano!")
	





func _on_hurtbox_area_entered(area):
	if area.is_in_group('Bala'):
		print("Boss foi baleado!")


func _on_barreira_vento_area_entered(area):
	if area.is_in_group('Bala'):
		print("Bloqueio da Bala")
		
		
