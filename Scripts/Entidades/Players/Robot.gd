extends CharacterBody2D
class_name Robot

@export_range(1,4) var directionInicial: int = 2

@export var health: int = 10
@export var speed: int = 300
@onready var tiro = $TiroPos as Marker2D

var enemy: CharacterBody2D
var angle: float = 0

func _ready():
	targetingEnemy(get_parent())

func _physics_process(delta):
	move(delta)
	
func targetingEnemy(node: Node):
	for child in node.get_children():
		if child.is_in_group("enemy"):
			enemy = child
			
func move(_delta):
	pass

