layout(triangles_adjacency) in; // hack to pass in a patch of 6 inputs to the GS
layout(triangle_strip, max_vertices = 3) out;


layout(location = 0) uniform mat4 ModelViewMatrix;
layout(location = 4) uniform mat4 ProjectionMatrix;
layout(location = 8) uniform mat4 MVPMatrix;


in vec3 assembly[];

out vec3 outVertexPosition;
out vec3 outVertexNormal;

out gl_PerVertex
{
    vec4 gl_Position;
};

void main()
{
    for (int i = 0; i < 3; i++)
    {
        outVertexPosition = assembly[i * 2 + 0];
        outVertexNormal = assembly[i * 2 + 1];
        gl_Position = ProjectionMatrix * vec4(outVertexPosition, 1);
        EmitVertex();
    }

    EndPrimitive();
}
