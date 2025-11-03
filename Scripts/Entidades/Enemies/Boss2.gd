extends CharacterBody2D
class_name Boss2

@export var speed: int = 150
@export var dashSpeed: int = 750
@export var health: int = 10
@export var fric: int = 60
var tiro: Tiro = null

var player: CharacterBody2D
var direction: Vector2
var angle = 0
var isDashing = false

func _ready():
	targetingPlayer(get_parent())

func _physics_process(_delta: float):
	move_and_slide()

func targetingPlayer(node: Node):
	for child in node.get_children():
		if child.is_in_group("player"):
			player = child
