extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var state_manager = $StateManager



func _ready() -> void:
	var move_player_reference = Callable(self, "move_player")
	var play_animation_reference = Callable(self, "play_animation")
	state_manager.init(move_player_reference, play_animation_reference)

func move_player(input: Vector2) -> void:
	velocity = input
	move_and_slide()

func play_animation(animation_name: String, 
		flip_h: bool = false, 
		flip_v: bool = false, 
		speed_scale: float = 1.0):
	
	animated_sprite.play(animation_name)
	animated_sprite.flip_h = flip_h
	animated_sprite.flip_v = flip_v
	animated_sprite.speed_scale = speed_scale

func _input(event: InputEvent) -> void:
	state_manager.input(event)

func _process(delta: float) -> void:
	state_manager.process(delta)
	
func _physics_process(delta: float) -> void:
	state_manager.physics_process(delta, velocity)
