extends State

@export var fall_node: NodePath

@export var speed: float = 100.0
@export var acceleration: float = 200.0
@export var gravity: float = 600.0
@export var jump_strength: float = 250.0

@onready var _fall_state: State = get_node(fall_node)

func enter(previous_state: State):
	super(previous_state)
	_entity.velocity.y = -jump_strength
	
func physics_process(delta: float) -> State:
	var target_velocity = 0.0
	var velocity = _entity.velocity
	
	target_velocity = (
			Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
			) * speed
	
	velocity.x = move_horizontal(delta, velocity.x, target_velocity, acceleration)
	
	velocity.y = apply_gravity(delta, velocity.y, gravity)
	
	_entity.velocity = velocity
	_entity.move_and_slide()	
	
	if _entity.velocity.y > 0:
		return _fall_state
	return null
