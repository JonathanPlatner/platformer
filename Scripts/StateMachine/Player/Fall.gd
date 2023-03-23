extends State

@export var idle_node: NodePath
@export var move_node: NodePath
@export var jump_node: NodePath

@export var speed: float = 100.0
@export var acceleration: float = 200.0
@export var gravity: float = 1100.0
@export var max_fall_speed: float = 400
@export var coyote_time: float = 0.15
@export var jump_buffer_time: float = 0.1

@onready var _idle_state: State = get_node(idle_node)
@onready var _move_state: State = get_node(move_node)
@onready var _jump_state: State = get_node(jump_node)

var buffering_jump: bool = false
var jump_buffer_elapsed: float = 0.0

func enter(previous_state: State):
	super(previous_state)
	jump_buffer_elapsed = 0.0

func input(event: InputEvent) -> State:
	if Input.is_action_just_pressed("jump"):
		if _previous_state is Move and _state_timer <= coyote_time:
			return _jump_state
		else:
			buffering_jump = true
			jump_buffer_elapsed = 0.0
	return null

func physics_process(delta: float) -> State:
	var target_velocity = 0.0
	var velocity = _entity.velocity
	
	target_velocity = (
			Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
			) * speed
	
	velocity.x = move_horizontal(delta, velocity.x, target_velocity, acceleration)
	
	velocity.y = apply_gravity(delta, velocity.y, gravity, max_fall_speed)
	
	_entity.velocity = velocity
	_entity.move_and_slide()
	
	if buffering_jump:
		jump_buffer_elapsed += delta
		if jump_buffer_elapsed >= jump_buffer_time:
			buffering_jump = false
	
	if _entity.is_on_floor():
		if buffering_jump:
			return _jump_state
		if _entity.velocity.x == 0 and target_velocity == 0:
			return _idle_state
		else:
			return _move_state

	return null


