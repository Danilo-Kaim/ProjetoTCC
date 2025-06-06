extends Boss

@export var damage : int = 5

@onready var naviagation: Navigation = $Naviagation as Navigation


func _ready():
	super._ready()
	naviagation.target = player


func move(delta):
	naviagation.chase(delta)

