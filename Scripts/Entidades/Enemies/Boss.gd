extends CharacterBody2D
class_name Boss

@export var health: int = 10
@export var speed: int = 6000

var player: CharacterBody2D

func _ready():
	targetingPlayer(get_parent())

func _physics_process(delta):
	move(delta)

func targetingPlayer(node: Node):
	for child in node.get_children():
		if child.is_in_group("player"):
			player = child
			
func move(_delta):
	pass
