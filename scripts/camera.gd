extends Node3D

@export var sensitivity := 0.2
@export var aceleration := 10

const MIN := -300
const MAX := 250 

#var control
var cam_hor := 0.0
var cam_ver := 0.0


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		cam_hor -= event.relative.x * sensitivity
		cam_ver -= event.relative.y * sensitivity
		
		if Input.is_action_just_pressed("ui_cancel"):
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
func _physics_process(delta: float) -> void:
	cam_ver = clamp(cam_ver, MIN, MAX)
	$horizontal.rotation_degrees.y = lerp($horizontal.rotation_degrees.y, cam_hor, aceleration * delta)
	$horizontal/vertical.rotation_degrees.x = lerp($horizontal.rotation_degrees.x, cam_ver, aceleration * delta)		
