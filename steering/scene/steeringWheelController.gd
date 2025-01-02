extends Control

var steeRot = 0
var prevSteeDotValue = 0
var currentSteeDotValue = 0
#Cstr for steering controller Estr for steering gdengine
var Cstrmax; var Estrmax
var Cstrvalue; var Estrvalue

# Called when the node enters the scene tree for the first time.
func _ready():
	Cstrmax = 8
	Estrmax = 0.6


func _process(delta):
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pass

func _steer_controler():
	var  steerRotUpdateVal=0
	var mouseVector = get_viewport().get_mouse_position() - $mobileWheel.position - Vector2(64,64)

	currentSteeDotValue =calc_dot_product(Vector2.UP,mouseVector)
	steerRotUpdateVal = currentSteeDotValue-prevSteeDotValue
	if get_mouse_quarant(mouseVector) ==1 or get_mouse_quarant(mouseVector) ==4:
		steeRot -=steerRotUpdateVal*.025
	else:
		steeRot +=steerRotUpdateVal*.025
	$mobileWheel/Wheel.rotation = steeRot
	#print(rad_to_deg(steeRot))
	
	steeRot =clamp(steeRot,-Cstrmax,Cstrmax)
	Cstrvalue = steeRot
	Estrvalue = (Estrmax*Cstrvalue)/Cstrmax
	print(Estrvalue)
	get_parent().get_node("galinderwagon_eport").steering = Estrvalue*-1
	prevSteeDotValue= currentSteeDotValue
func calc_dot_product(cadinalVec:Vector2,positionalVec:Vector2):
	cadinalVec.normalized();positionalVec.normalized()
	return cadinalVec.dot(positionalVec)

func get_mouse_quarant(mouse_vector:Vector2):
	
	if mouse_vector.x > 0 and mouse_vector.y < 0:
		return 1
	elif mouse_vector.x < 0 and mouse_vector.y < 0:
		return 2
	elif mouse_vector.x < 0 and mouse_vector.y > 0:
		return 3
	else:
		return 4
	

func _on_wheel_pressed():
	print("on wheel node pressed")
func _on_wheel_released():
	print("on wheel node relesed")
	pass # Replace with function body.
func _input(event):
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		if $mobileWheel.is_pressed():
			_steer_controler()

func _on_mobile_wheel_pressed():
	var mouseVector = get_viewport().get_mouse_position() - $mobileWheel.position - Vector2(64,64)
	prevSteeDotValue =calc_dot_product(Vector2.UP,mouseVector)
