extends CharacterBody3D


@export var normal_speed:=3.0
@export var sprint_speed := 5.0
@export var jump_velocity := 4.0
@export var gravity := 0.2
@export var mouse_sensitivity := 0.005

@onready var head: Node3D = $Head
@onready var interaction_ray_cast: RayCast3D = $Head/InteractionRayCast


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta: float) -> void:
	interaction_ray_cast.check_interaction()
	


func _physics_process(delta: float) -> void:
	move()
	
func move() -> void :
	var is_sprinting : bool
	var input_dir:= Input.get_vector("move_left","move_right","move_forward","move_backward")
	if is_on_floor():
		is_sprinting=Input.is_action_pressed("sprint")
		
		if Input.is_action_just_pressed("jump"):
			velocity.y= jump_velocity
	else:
		velocity.y -= gravity
		is_sprinting = false
		
	var speed : float
	if is_sprinting:
		speed= sprint_speed
	else:
		speed=normal_speed
	
	var direction := transform.basis* Vector3(input_dir.x,0,input_dir.y)
	
	velocity.z= direction.z * speed
	velocity.x= direction.x * speed
	
	
	
	move_and_slide()
  
func _input(event: InputEvent)-> void:
	if event is InputEventMouseMotion:
		look_around(event.relative)
		
var vertical_look_angle := 0.0  # Store vertical angle manually

func look_around(relative: Vector2) -> void:
	# Horizontal: rotate player
	rotate_y(-relative.x * mouse_sensitivity)

	# Vertical: rotate head
	vertical_look_angle += -relative.y * mouse_sensitivity
	vertical_look_angle = clamp(vertical_look_angle, deg_to_rad(-80), deg_to_rad(80))
	head.rotation.x = vertical_look_angle

	
func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
