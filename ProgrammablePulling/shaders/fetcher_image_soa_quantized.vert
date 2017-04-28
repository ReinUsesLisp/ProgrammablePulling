#version 430 core

layout(std140, binding = 0) uniform transform {
	mat4 ModelViewMatrix;
	mat4 ProjectionMatrix;
	mat4 MVPMatrix;
} Transform;

layout(r32f, binding = 0) restrict readonly uniform imageBuffer posXbuffer;
layout(r32f, binding = 1) restrict readonly uniform imageBuffer posYbuffer;
layout(r32f, binding = 2) restrict readonly uniform imageBuffer posZbuffer;
layout(r8, binding = 3) restrict readonly uniform imageBuffer normalXbuffer;
layout(r8, binding = 4) restrict readonly uniform imageBuffer normalYbuffer;
layout(r8, binding = 5) restrict readonly uniform imageBuffer normalZbuffer;

out vec3 outVertexPosition;
out vec3 outVertexNormal;

out gl_PerVertex {
	vec4 gl_Position;
};

void main(void) {

	/* fetch attributes from image buffer */
	vec3 inVertexPosition;
	inVertexPosition.x = imageLoad(posXbuffer, gl_VertexID).x; 
	inVertexPosition.y = imageLoad(posYbuffer, gl_VertexID).x; 
	inVertexPosition.z = imageLoad(posZbuffer, gl_VertexID).x; 
	
	// buffer textures don't support SNORM? :(
	vec3 inVertexNormal;
	inVertexNormal.x   = imageLoad(normalXbuffer, gl_VertexID).x * 2.0 - 1.0;
	inVertexNormal.y   = imageLoad(normalYbuffer, gl_VertexID).x * 2.0 - 1.0;
	inVertexNormal.z   = imageLoad(normalZbuffer, gl_VertexID).x * 2.0 - 1.0;
	
	/* transform vertex and normal */
	outVertexPosition = (Transform.ModelViewMatrix * vec4(inVertexPosition, 1)).xyz;
	outVertexNormal = mat3(Transform.ModelViewMatrix) * inVertexNormal;
	gl_Position = Transform.MVPMatrix * vec4(inVertexPosition, 1);
	
}
