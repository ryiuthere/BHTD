extends CharacterBody2D

class_name entity

@export var moveSpeed = 200

func _physics_process(_delta):
	move_and_slide()
