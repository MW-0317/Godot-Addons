@tool
extends MeshInstance3D

@export var visual_shader : VisualShader

@export var Color1 : Color:
    set (new_color):
        Color1 = new_color
        self.set_instance_shader_parameter("Color1", Color1)
@export var Color2 : Color:
    set (new_color):
        Color2 = new_color
        self.set_instance_shader_parameter("Color2", Color2)
@export_range(0, 30, 1) var Division : float:
    set (new_division):
        Division = new_division
        self.set_instance_shader_parameter("Division", Division)


# Called when the node enters the scene tree for the first time.
func _enter_tree() -> void:
    self.set_instance_shader_parameter("Color1", Color1)
    self.set_instance_shader_parameter("Color2", Color2)
    self.set_instance_shader_parameter("Division", Division)


func property_item(parameter : VisualShaderNodeParameter) -> Dictionary:

    var base_type = [
        TYPE_BOOL,
        TYPE_COLOR,
        TYPE_FLOAT,
        TYPE_INT,
        Texture,
        null,
        TYPE_INT,
        TYPE_VECTOR2,
        TYPE_VECTOR3,
        TYPE_VECTOR4
    ]

    var types = [
        VisualShaderNodeBooleanParameter, 
        VisualShaderNodeColorParameter, 
        VisualShaderNodeFloatParameter, 
        VisualShaderNodeIntParameter,
        VisualShaderNodeTextureParameter, 
        VisualShaderNodeTransformParameter,
        VisualShaderNodeUIntParameter, 
        VisualShaderNodeVec2Parameter, 
        VisualShaderNodeVec3Parameter, 
        VisualShaderNodeVec4Parameter
    ]
    
    var boolean_func = func(boolean_parameter : VisualShaderNodeBooleanParameter):
        pass

    var lambdas = [
        boolean_func
    ]
    
    var index = 0
    for i in range(types.size):
        var type = types[i]
        if is_instance_of(parameter, type):
            index = i
            break

    return {
        "name" : parameter.parameter_name,
        "type" : types[index]
    }

func _get_property_list():
    var node_parameters : Array[VisualShaderNodeParameter] = []


    for i in range(VisualShader.TYPE_MAX):
        var node_list := visual_shader.get_node_list(i)
        for node_id in node_list:
            print("PlaceholderTexture.gd // _ready() // Getting node ", node_id, " of ", i)
            var node := visual_shader.get_node(i, node_id)
            if node is VisualShaderNodeParameter:
                var parameter_node : VisualShaderNodeParameter = node
                node_parameters.append(parameter_node)

    var properties = []

    for parameter in node_parameters:
        pass

    pass
    
