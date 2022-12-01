extends Node2D

func create_grasseffect():
	var GrassEffect_Scene = load("res://scenes/effect/Grass_Effect.tscn")
	var grassEffect_Inst = GrassEffect_Scene.instance() 
		
	var World_Scene = get_tree().current_scene
	World_Scene.add_child(grassEffect_Inst)
	grassEffect_Inst.global_position = global_position
	
	# -- end of create_grasseffect -- #

func _on_Hurtbox_area_entered(area):
	create_grasseffect()
	queue_free()
	
	# -- end of _on_Hurtbox_area_entered -- #
