extends KinematicBody

var speed = 10
var gravity = 9.81
var jump = 7

var cameraAccel = 50
var sense = .1

var snap

var direction = Vector3()
var velocity = Vector3()
var gravityVector = Vector3()
var movement = Vector3()

onready var head = $Head
onready var camera = $Head/Camera

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * sense))
		head.rotate_x(deg2rad(-event.relative.y * sense))
		
		head.rotation.x = clamp(head.rotation.x, deg2rad(-90), deg2rad(90))	
		
	pass
	
func _physics_process(delta: float) -> void:
	direction = Vector3.ZERO
	var horizontalRot = global_transform.basis.get_euler().y
	var forwardInput = Input.get_action_strength()
	pass

