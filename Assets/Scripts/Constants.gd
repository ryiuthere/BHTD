extends Node

enum STATE_NAME {NONE, IDLE, CROUCH, WALK, RUN, JUMP, DOUBLEJUMP, AIR, ATTACK, AIRATTACK}
enum ATTACK_STATE_NAME {NONE, L5, L2, L8, L6, M5, M2, M8, M6, H5, H2, H8, H6}
enum ATTACK_STATUS {STARTUP, ACTIVE, RECOVERY}
enum INPUT {Jump, Light, Mid, Heavy, Surge, Burst, Parry}

var WALK_RUN_SENSITIVITY := 10.0 # The lower, the easier to switch from idle/walking to running
var RUN_WALK_SENSITIVITY := 0.01 # The lower, the harder to switch from running to walking
var FRICTION := 5 # The higher, the more friction
var GRAVITY := 1600
var FLOAT_DEADZONE := 0.02
var CROUCH_ANGLE_MIN := PI / 4 - FLOAT_DEADZONE
var CROUCH_ANGLE_MAX := 3 * PI / 4 + FLOAT_DEADZONE
var UP_ANGLE_MIN := 5 * PI / 4 - FLOAT_DEADZONE
var UP_ANGLE_MAX := 7 * PI / 4 + FLOAT_DEADZONE
var FRAME_BUFFER := 3
