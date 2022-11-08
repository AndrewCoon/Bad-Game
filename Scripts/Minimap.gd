# Need to figure out how to find the position of a kinematicbody
# Why does it not just have a position property
# IDK 
# GODOT IS BAD
#
#
#
#
#

extends MarginContainer

export (NodePath) var player
export var zoom = 1.5

onready var back = $MarginContainer/Background
onready var player_icon = $MarginContainer/Background/PlayerIcon
onready var enemy_icon = $MarginContainer/Background/EnemyIcon
onready var alert_icon = $MarginContainer/Background/AlertIcon

onready var icons = {"enemy": enemy_icon, "player": player_icon, "alert": alert_icon}

var back_scale
var markers = {}


func _ready():
	player_icon.position = back.rect_size / 2
	back_scale = back.rect_size / (get_viewport_rect().size * zoom)
	var map_objects = get_tree().get_nodes_in_group("minimap_objects")
	for item in map_objects:
		var new_marker = icons[item.minimap_icon].duplicate()
		back.add_child(new_marker)
		new_marker.show()
		markers[item] = new_marker
	
func _process(delta):
	if !player:
		print("player not found")
		return
	player_icon.rotation = get_node(player).rotation.y + PI/2
	for item in markers:
		var obj_pos = (vec3To2(item.positon) - vec3To2(get_node(player).position)) * back_scale * back.rect_size / 2
		obj_pos.x = clamp(obj_pos.x, 0, back.rect_size.x)
		obj_pos.y = clamp(obj_pos.y, 0, back.rect_size.y)
		markers[item].position = obj_pos 

func vec3To2(vec3):
	return Vector2(vec3.x, vec3.z)
	
