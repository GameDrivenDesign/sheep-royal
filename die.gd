extends RigidBody

var maxTorque = 200
var maxForce = 200

var stillRolling = true

signal finished(num)

func _ready():
	randomize()
	rotation = Vector3(randf() * PI * 2, randf() * PI * 2, randf() * PI * 2)
	add_torque(Vector3(randi()%maxTorque - maxTorque/2, randi()%maxTorque - maxTorque/2, randi()%maxTorque - maxTorque/2))
	add_central_force(Vector3(randi()%maxForce - maxForce/2, randi()%maxForce - maxForce/2, randi()%maxForce - maxForce/2))


func _process(delta):
	if (stillRolling == true):
		if (linear_velocity.length() <= 0.1 && angular_velocity.length() <= 0.1):
			stillRolling = false
			print_debug(currentlyUp())
			emit_signal("finished", currentlyUp())

#x = 6
#y = 2
#z = 4

func currentlyUp():
	var basis = transform.basis
	if (basis.x.angle_to(Vector3.UP) < 0.5):
		return 6
	elif (basis.x.angle_to(Vector3.UP) > 2.5):
		return 1
	elif (basis.y.angle_to(Vector3.UP) < 0.5):
		return 2
	elif (basis.y.angle_to(Vector3.UP) > 2.5):
		return 5
	elif (basis.z.angle_to(Vector3.UP) < 0.5):
		return 4
	elif (basis.z.angle_to(Vector3.UP) > 2.5):
		return 3
	else:
		print_debug("Something went wrong!")
		return 0