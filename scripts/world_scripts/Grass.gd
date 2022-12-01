extends Node2D


func _process(delta):
	if Input.is_action_just_pressed("player_attack"):
		var GrassEffect_Scene = load("res://scenes/effect/Grass_Effect.tscn")
		var grassEffect_Inst = GrassEffect_Scene.instance() 
		
		var World_Scene = get_tree().current_scene
		World_Scene.add_child(grassEffect_Inst)
		grassEffect_Inst.global_position = global_position
		
		queue_free()
	
	# -- end of _process -- #
