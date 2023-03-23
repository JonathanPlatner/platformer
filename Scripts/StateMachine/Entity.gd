class_name Entity
extends CharacterBody2D

@onready var animator = $Animator
@onready var state_manager = $StateManager

func _ready() -> void:
	state_manager.init(self)

func _input(event: InputEvent) -> void:
	state_manager.input(event)

func _process(delta: float) -> void:
	state_manager.process(delta)
	
func _physics_process(delta: float) -> void:
	state_manager.physics_process(delta)
