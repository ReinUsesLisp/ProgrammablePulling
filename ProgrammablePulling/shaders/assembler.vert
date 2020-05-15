
layout(location = 0) uniform mat4 ModelViewMatrix;
layout(location = 4) uniform mat4 ProjectionMatrix;
layout(location = 8) uniform mat4 MVPMatrix;


layout(std430, binding = 0) restrict readonly buffer PositionBuffer { vec4 Positions[]; };
layout(std430, binding = 1) restrict readonly buffer NormalBuffer{ vec4 Normals[]; };

out vec3 assembly;

void main()
{
    if ((gl_VertexID & 0x80000000) == 0) // process position
    {
        /* fetch attributes from storage buffer */
        vec3 inVertexPosition;
        inVertexPosition.xyz = Positions[gl_VertexID & 0x7FFFFFFF].xyz;

        /* transform vertex */
        assembly = (ModelViewMatrix * vec4(inVertexPosition, 1)).xyz;
    }
    else // process normal
    {
        /* fetch attributes from storage buffer */
        vec3 inVertexNormal;
        inVertexNormal.xyz = Normals[gl_VertexID & 0x7FFFFFFF].xyz;

        /* transform normal */
        assembly = mat3(ModelViewMatrix) * inVertexNormal;
    }
}
