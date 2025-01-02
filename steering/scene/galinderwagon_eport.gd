extends VehicleBody3D

@export var MAXSTR =0.6
@export var ENGINEFORCE = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	
	#steering =move_toward(steering,Input.get_axis("ui_right","ui_left")*MAXSTR,delta*2)
	#print(steering)
	
	engine_force = Input.get_axis("ui_down","ui_up")*ENGINEFORCE
	
