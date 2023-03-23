extends State

@export var move_node: NodePath
@export var jump_node: NodePath
@export var fall_node: NodePath

@onready var _move_state: State = get_node(move_node)
@onready var _jump_state: State = get_node(jump_node)
@onready var _fall_state: State = get_node(fall_node)

func enter(previous_state: State):
	super(previous_state)
	_entity.velocity = Vector2.ZERO
	_entity.move_and_slide()

func input(_event: InputEvent) -> State:
	if Input.get_action_strength("move_left") or Input.get_action_strength("move_right"):
		return _move_state
	
	if Input.is_action_just_pressed("jump"):
		return _jump_state
	return null

func physics_process(delta: float) -> State:
	if !_entity.is_on_floor():
		return _fall_state
	return null
	
