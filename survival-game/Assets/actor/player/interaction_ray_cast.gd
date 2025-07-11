extends RayCast3D
var is_hitting := false

# Called when the node enters the scene tree for the first time.
func check_interaction() -> void:
	print("Checking interaction...")

	if is_colliding():
		var collider := get_collider()
		print("Ray is colliding!")
		if not collider is Interactable:
			return
				
		

		if Input.is_action_just_pressed("interact"):
			
			print("E pressed!")
			
			collider.start_interaction()
		if not is_hitting:
			is_hitting = true
			EventSystem.BUL_create_bulletin.emit(BulletinConfig.Keys.InteractionPrompt,collider.prompt)
		
	elif is_hitting:
		is_hitting = false
		EventSystem.BUL_destroy_bulletin.emit(BulletinConfig.Keys.InteractionPrompt)
		
			
		
			
				
	
