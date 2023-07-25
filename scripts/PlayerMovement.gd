extends CharacterBody3D

@export var movementSpeed: float = 10;
@export var jumpVelocity: float = 50;
@export var gravitySpeed: float = 4;
@export var mouseSensitivity: float = 0.5;
@export var terminalVelocity: float = 2000;

var movementInputVector:Vector2 = Vector2(0,0);
var currentYVelocity: float = 0;

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate(Vector3.UP, deg_to_rad(-event.relative.x * mouseSensitivity));

func  _physics_process(_delta: float) -> void:
	movementInputVector = Input.get_vector("move_left", "move_right","move_forward","move_back") * movementSpeed;
	if is_on_floor():
		currentYVelocity = 0;
		if Input.is_action_just_pressed("jump"):
			currentYVelocity = jumpVelocity;
	else:
		currentYVelocity = max(currentYVelocity - gravitySpeed, -terminalVelocity);
	
	velocity = transform.basis * Vector3(movementInputVector.x, currentYVelocity, movementInputVector.y);
	move_and_slide();
