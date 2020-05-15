layout(triangles) in;


layout(location = 0) uniform mat4 ModelViewMatrix;
layout(location = 4) uniform mat4 ProjectionMatrix;
layout(location = 8) uniform mat4 MVPMatrix;


patch in vec3 PatchAssembly[6];

out vec3 outVertexPosition;
out vec3 outVertexNormal;

out gl_PerVertex
{
    vec4 gl_Position;
};

void main()
{
    outVertexPosition = gl_TessCoord.x * PatchAssembly[0] + gl_TessCoord.y * PatchAssembly[2] + gl_TessCoord.z * PatchAssembly[4];
    outVertexNormal   = gl_TessCoord.x * PatchAssembly[1] + gl_TessCoord.y * PatchAssembly[3] + gl_TessCoord.z * PatchAssembly[5];
    gl_Position = ProjectionMatrix * vec4(outVertexPosition, 1);
}
