extends State

@export var idle_node: NodePath
@export var jump_node: NodePath
@export var fall_node: NodePath

@export var speed: float = 100.0
@export var acceleration: float = 800.0

@onready var _idle_state: State = get_node(idle_node)
@onready var _jump_state: State = get_node(jump_node)
@onready var _fall_state: State = get_node(fall_node)

func input(_event: InputEvent) -> State:
	if Input.is_action_just_pressed("jump"):
		return _jump_state
	return null
	
func physics_process(delta: float) -> State:
	var target_velocity = 0.0
	var velocity = _entity.velocity
	
	target_velocity = (
			Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
			) * speed
	
	velocity.x = move_horizontal(delta, velocity.x, target_velocity, acceleration)
	
	if velocity.x > 0:
		_entity.animator.flip_h = true
	elif velocity.x < 0:
		_entity.animator.flip_h = false
	
	_entity.velocity = velocity
	_entity.move_and_slide()
	
	if !_entity.is_on_floor():
		return _fall_state
	
	if _entity.velocity.x == 0 and target_velocity == 0:
		return _idle_state
	
	return null
