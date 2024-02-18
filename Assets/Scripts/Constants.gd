extends Node

enum STATE_NAME {IDLE, CROUCH, WALK, RUN, JUMP, AIR}
enum INPUT {Jump, Light, Mid, Heavy, Surge, Burst, Parry}

var WALK_RUN_SENSITIVITY := 20 # The lower, the easier to switch from idle/walking to running
var RUN_WALK_SENSITIVITY := 5 # The lower, the harder to switch from running to walking
var FRICTION := 20 # The higher, the more friction
var GRAVITY := 1600
var FLOAT_DEADZONE := 0.02
var CROUCH_ANGLE_MIN: = PI / 4 - FLOAT_DEADZONE
var CROUCH_ANGLE_MAX := 3 * PI / 4 + FLOAT_DEADZONE
var FRAME_BUFFER := 3
