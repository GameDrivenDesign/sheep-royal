extends RigidBody

var maxTorque = 200
var maxForce = 200

var stillRolling = true

signal finished(num)

var can_read = false

func _ready():
	randomize()
	rotation = Vector3(randf() * PI * 2, randf() * PI * 2, randf() * PI * 2)
	add_torque(Vector3(randi()%maxTorque - maxTorque/2, randi()%maxTorque - maxTorque/2, randi()%maxTorque - maxTorque/2))
	add_central_force(Vector3(randi()%maxForce - maxForce/2, randi()%maxForce - maxForce/2, randi()%maxForce - maxForce/2))
	yield(get_tree().create_timer(0.5), "timeout")
	can_read = true

func _process(delta):
	if stillRolling == true and can_read:
		if linear_velocity.length() <= 0.1 && angular_velocity.length() <= 0.1:
			stillRolling = false
			print_debug(currentlyUp())
			emit_signal("finished", currentlyUp())

#x = 6
#y = 2
#z = 4

func currentlyUp():
	var basis = transform.basis
	
	var bestNum = 6
	var bestAngle = basis.x.angle_to(Vector3.UP)
	if ((-basis.x).angle_to(Vector3.UP) < bestAngle):
		bestAngle = (-basis.x).angle_to(Vector3.UP)
		bestNum = 1
	if (basis.y.angle_to(Vector3.UP) < bestAngle):
		basis.y.angle_to(Vector3.UP)
		bestNum = 2
	if ((-basis.y).angle_to(Vector3.UP) < bestAngle):
		(-basis.y).angle_to(Vector3.UP) 
		bestNum = 5
	if (basis.z.angle_to(Vector3.UP) < bestAngle):
		basis.z.angle_to(Vector3.UP)
		bestNum = 4
	if ((-basis.z).angle_to(Vector3.UP) < bestAngle):
		(-basis.z).angle_to(Vector3.UP)
		bestNum = 3
	return bestNum
