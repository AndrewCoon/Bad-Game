extends KinematicBody

var speed = 10
var gravity = 9.81 * 2
var jump = 7

var cameraAccel = 50
var sense = .1
var frick = 0.61
var snap

var direction = Vector3()
var vel = Vector3()
var gravityVector = Vector3()
var movement = Vector3()

onready var head = $Head
onready var camera = $Head/Camera
onready var gun = $barel

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * sense))
		head.rotate_x(deg2rad(-event.relative.y * sense))
		
		head.rotation.x = clamp(head.rotation.x, deg2rad(-90), deg2rad(90))	
		gun.rotation.x = head.rotation.x * -1
	if event is InputEventMouseButton:
		#gun.rotate_x(0.3)
		pass
		#boi._integrate_forces(set_angular_velocity(value))
	pass
	
func _physics_process(delta: float) -> void:
	direction = Vector3.ZERO
	var horizontalRot = global_transform.basis.get_euler().y
	
	var forwardInput = Input.get_action_strength("moveBack") - Input.get_action_strength("moveForward")
	var horizontalInput = Input.get_action_strength("moveRight") - Input.get_action_strength("moveLeft")
	direction = Vector3(horizontalInput, 0, forwardInput).rotated(Vector3.UP, horizontalRot).normalized()
	if(forwardInput != 0 or horizontalInput != 0):
		if is_on_floor():
			snap = -get_floor_normal()
			gravityVector = Vector3.ZERO
			
		else:
			snap = Vector3.DOWN
			gravityVector += Vector3.DOWN * gravity * delta
		
		if Input.is_action_just_pressed("jump") and is_on_floor():
			snap = Vector3.ZERO
			gravityVector = Vector3.UP * jump
		
		vel = vel.linear_interpolate(direction*speed, delta)
		movement = vel + gravityVector
		move_and_slide_with_snap(movement, snap, Vector3.UP)
	pass

