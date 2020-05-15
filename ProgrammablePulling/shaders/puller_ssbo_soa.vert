
layout(location = 0) uniform mat4 ModelViewMatrix;
layout(location = 4) uniform mat4 ProjectionMatrix;
layout(location = 8) uniform mat4 MVPMatrix;


layout(std430, binding = 0) restrict readonly buffer IndexBuffer { uint Indices[]; };
layout(std430, binding = 1) restrict readonly buffer PositionXBuffer { float PositionXs[]; };
layout(std430, binding = 2) restrict readonly buffer PositionYBuffer { float PositionYs[]; };
layout(std430, binding = 3) restrict readonly buffer PositionZBuffer { float PositionZs[]; };
layout(std430, binding = 4) restrict readonly buffer NormalXBuffer { float NormalXs[]; };
layout(std430, binding = 5) restrict readonly buffer NormalYBuffer { float NormalYs[]; };
layout(std430, binding = 6) restrict readonly buffer NormalZBuffer { float NormalZs[]; };

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
    inVertexPosition.x = PositionXs[inIndex];
    inVertexPosition.y = PositionYs[inIndex];
    inVertexPosition.z = PositionZs[inIndex];

    vec3 inVertexNormal;
    inVertexNormal.x = NormalXs[inIndex];
    inVertexNormal.y = NormalYs[inIndex];
    inVertexNormal.z = NormalZs[inIndex];

    /* transform vertex and normal */
    outVertexPosition = (ModelViewMatrix * vec4(inVertexPosition, 1)).xyz;
    outVertexNormal = mat3(ModelViewMatrix) * inVertexNormal;
    gl_Position = MVPMatrix * vec4(inVertexPosition, 1);

}
