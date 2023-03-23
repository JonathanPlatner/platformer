class_name State
extends Node

@export var animation_name: String

var _previous_state: State
var _entity: Entity
var _state_timer: float = 0.0

func enter(previous_state: State) -> void:
	_previous_state = previous_state
	_entity.animator.play(animation_name)
	_state_timer = 0.0

func exit() -> void:
	pass
	
func input(_event: InputEvent) -> State:
	return null

func process(_delta: float) -> State:
	_state_timer += _delta
	return null
	
func physics_process(_delta: float) -> State:
	return null

func move_horizontal(delta: float, current_velocity: float, target_velocity: float, acceleration: float) -> float:
	if current_velocity < target_velocity:
		current_velocity += acceleration * delta
		if current_velocity > target_velocity:
			current_velocity = target_velocity
	if current_velocity > target_velocity:
		current_velocity -= acceleration * delta
		if current_velocity < target_velocity:
			current_velocity = target_velocity
	
	return current_velocity

func apply_gravity(delta: float, current_velocity: float, gravity: float, max_fall_speed: float = 0) -> float:
	current_velocity += gravity * delta
	if current_velocity > max_fall_speed and max_fall_speed > 0:
		current_velocity = max_fall_speed
	return current_velocity
