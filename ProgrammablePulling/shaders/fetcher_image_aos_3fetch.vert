
layout(location = 0) uniform mat4 ModelViewMatrix;
layout(location = 4) uniform mat4 ProjectionMatrix;
layout(location = 8) uniform mat4 MVPMatrix;


layout(r32f, binding = 0) restrict readonly uniform imageBuffer positionBuffer;
layout(r32f, binding = 1) restrict readonly uniform imageBuffer normalBuffer;

out vec3 outVertexPosition;
out vec3 outVertexNormal;

out gl_PerVertex{
    vec4 gl_Position;
};

void main(void) {

    /* fetch attributes from image buffer */
    vec3 inVertexPosition;
    inVertexPosition.x = imageLoad(positionBuffer, gl_VertexID * 3 + 0).x;
    inVertexPosition.y = imageLoad(positionBuffer, gl_VertexID * 3 + 1).x;
    inVertexPosition.z = imageLoad(positionBuffer, gl_VertexID * 3 + 2).x;

    vec3 inVertexNormal;
    inVertexNormal.x = imageLoad(normalBuffer, gl_VertexID * 3 + 0).x;
    inVertexNormal.y = imageLoad(normalBuffer, gl_VertexID * 3 + 1).x;
    inVertexNormal.z = imageLoad(normalBuffer, gl_VertexID * 3 + 2).x;

    /* transform vertex and normal */
    outVertexPosition = (ModelViewMatrix * vec4(inVertexPosition, 1)).xyz;
    outVertexNormal = mat3(ModelViewMatrix) * inVertexNormal;
    gl_Position = MVPMatrix * vec4(inVertexPosition, 1);

}
