extends Node
class_name State

signal Transitioned
@export var nextState: String

func Enter():
	pass
	
func Exit():
	pass
	
func Update(_delta: float):
	pass

func PhysicsUpdate(_delta: float):
	pass
