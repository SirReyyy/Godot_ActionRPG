extends Node2D

onready var animSprite = $AnimatedSprite

func _ready():
	animSprite.frame = 0
	animSprite.play("Grass_Animate")
	
	# -- end of _ready -- #


func _on_AnimatedSprite_animation_finished():
	queue_free()
	
	# -- end of _on_AnimatedSprite_animation_finished -- #
