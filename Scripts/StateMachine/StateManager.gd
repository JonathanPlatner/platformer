extends Node

@export var starting_state: NodePath

var _current_state: State
var _previous_state: State

func change_state(new_state: State) -> void:
	if _current_state:
		_current_state.exit()
	
	_previous_state = _current_state
	_current_state = new_state
	_current_state.enter(_previous_state)

func init(entity: Entity) -> void:
	for child in get_children():
		child._entity = entity
	
	change_state(get_node(starting_state))

func process(delta: float) -> void:
	var new_state = _current_state.process(delta)
	if new_state:
		change_state(new_state)

func physics_process(delta: float) -> void:
	var new_state = _current_state.physics_process(delta)
	if new_state:
		change_state(new_state)

func input(event: InputEvent) -> void:
	var new_state = _current_state.input(event)
	if new_state:
		change_state(new_state)
