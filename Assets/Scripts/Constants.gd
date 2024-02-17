extends Node

enum STATE_NAME {IDLE, CROUCH, WALK, RUN, JUMP, AIRBORNE}

var WALK_RUN_SENSITIVITY := 20 # The lower, the easier to switch from idle/walking to running
var RUN_WALK_SENSITIVITY := 5 # The lower, the harder to switch from running to walking
var FRICTION := 20 # The higher, the more friction
var GRAVITY := 600
