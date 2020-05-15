
layout(location = 0) uniform mat4 ModelViewMatrix;
layout(location = 4) uniform mat4 ProjectionMatrix;
layout(location = 8) uniform mat4 MVPMatrix;


layout(std430, binding = 0) restrict readonly buffer IndexBuffer { uint Indices[]; };
layout(std430, binding = 1) restrict readonly buffer PositionBuffer { float PositionXYZs[]; };
layout(std430, binding = 2) restrict readonly buffer NormalBuffer{ float NormalXYZs[]; };

out vec3 outVertexPosition;
out vec3 outVertexNormal;

out gl_PerVertex{
    vec4 gl_Position;
};

void main(void) {

    /* fetch index from storage buffer */
    uint inIndex = Indices[gl_VertexID];

    /* fetch attributes from storage buffer */
    vec3 inVertexPosition;
    inVertexPosition.x = PositionXYZs[inIndex * 3 + 0];
    inVertexPosition.y = PositionXYZs[inIndex * 3 + 1];
    inVertexPosition.z = PositionXYZs[inIndex * 3 + 2];

    vec3 inVertexNormal;
    inVertexNormal.x = NormalXYZs[inIndex * 3 + 0];
    inVertexNormal.y = NormalXYZs[inIndex * 3 + 1];
    inVertexNormal.z = NormalXYZs[inIndex * 3 + 2];

    /* transform vertex and normal */
    outVertexPosition = (ModelViewMatrix * vec4(inVertexPosition, 1)).xyz;
    outVertexNormal = mat3(ModelViewMatrix) * inVertexNormal;
    gl_Position = MVPMatrix * vec4(inVertexPosition, 1);

}
