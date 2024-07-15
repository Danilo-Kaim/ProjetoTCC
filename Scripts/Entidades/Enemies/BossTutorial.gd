extends CharacterBody2D

signal morreu

@export var speed : float =  300.0
@export var hp : int = 50
@export var dano : int = 5
@export var player: CharacterBody2D
@onready var nav = $Navigation as NavigationAgent2D
@onready var collision = $Hitbox/Collision
@onready var animation = $Animation


func _physics_process(_delta):
	var dir = to_local(nav.get_next_path_position()).normalized()
	velocity = dir * speed 
	move_and_slide()
	
func makePath():
	nav.target_position = player.global_position
	
			
func tomarDano(damage):
	hp -= damage
	if hp < 1:
		print("Boss perdeu")
		morreu.emit()
func getDano():
	return dano		

func _on_timer_timeout():
	makePath()




func _on_hurtbox_area_entered(area):
	if area.has_method("getParent"):
		if area.getParent() != self and area.has_method("getDano"):
			print("Boss Tomou " + str(area.getDano())+ " de Dano!")
			tomarDano(area.getDano())





func _on_hitbox_area_entered(_area):
	collision.set_disabled(true)
