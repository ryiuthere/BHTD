extends Node

enum STATE_NAME {NONE, IDLE, CROUCH, WALK, RUN, JUMP, DOUBLEJUMP, AIR, ATTACK, AIRATTACK
	, HITSTUN, TECH}
enum ATTACK_STATE_NAME {NONE, L5, L2, L8, L6, M5, M2, M8, M6, H5, H2, H8, H6, SP,
	AL5, AL2, AL8, AL6, AL4, AM5, AM2, AM8, AM6, ASP,
	JUMP, SURGE, BURST, CONTINUE}
enum ATTACK_STATUS {NONE, STARTUP, ACTIVE, RECOVERY, HITSTOP}

var WALK_RUN_SENSITIVITY := 10.0 # The lower, the easier to switch from idle/walking to running
var RUN_WALK_SENSITIVITY := 0.01 # The lower, the harder to switch from running to walking
var FRICTION := 5 # The higher, the more friction
var GRAVITY := 1600
var FLOAT_DEADZONE := 0.02
var DOWN_ANGLE_MIN := PI / 4 - FLOAT_DEADZONE
var DOWN_ANGLE_MAX := 3 * PI / 4 + FLOAT_DEADZONE
var UP_ANGLE_MIN := -3 * PI / 4 - FLOAT_DEADZONE
var UP_ANGLE_MAX := -PI / 4 + FLOAT_DEADZONE
var FRAME_BUFFER := 3
var HITBOX_REAPPLY_FRAMES := 30
var HITBOX_KNOCKBACK_MULTIPLIER := 10.0
var HURTBOX_PUSH_FORCE := 10000.0
var ATTACK_CANCEL_WINDOW := 15 # Frames after hitstop for cancelling

var IDLE := "Idle"
var JUMP := "Jump"
var DOUBLEJUMP := "DoubleJump"
var WALK := "Walk"
var RUN := "Run"
var AIR := "Air"
var CROUCH := "Crouch"
var HITSTUN := "Hitstun"
var SURGE := "Surge"
var BURST := "Burst"
var PARRY := "Parry"
var LIGHT := "Light"
var MID := "Mid"
var HEAVY := "Heavy"
var LEFT := "Left"
var RIGHT := "Right"
var UP := "Up"
var DOWN := "Down"

var _id := -1

func next_hitbox_controller_id() -> int:
	_id += 1
	return _id

var _hitbox_id := -1

func next_hitbox_id() -> int:
	_hitbox_id += 1
	return _hitbox_id
