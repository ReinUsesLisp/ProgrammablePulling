
	layout(location = 0) uniform mat4 ModelViewMatrix;
	layout(location = 4) uniform mat4 ProjectionMatrix;
	layout(location = 8) uniform mat4 MVPMatrix;


layout(binding = 0) uniform samplerBuffer positionBuffer;
layout(binding = 1) uniform samplerBuffer normalBuffer;

out vec3 outVertexPosition;
out vec3 outVertexNormal;

out gl_PerVertex {
	vec4 gl_Position;
};

void main(void) {

	/* fetch attributes from texture buffer */
	vec3 inVertexPosition;
	inVertexPosition.x = texelFetch(positionBuffer, gl_VertexID * 3 + 0).x;
	inVertexPosition.y = texelFetch(positionBuffer, gl_VertexID * 3 + 1).x; 
	inVertexPosition.z = texelFetch(positionBuffer, gl_VertexID * 3 + 2).x; 
	
	vec3 inVertexNormal;
	inVertexNormal.x   = texelFetch(normalBuffer,   gl_VertexID * 3 + 0).x; 
	inVertexNormal.y   = texelFetch(normalBuffer,   gl_VertexID * 3 + 1).x; 
	inVertexNormal.z   = texelFetch(normalBuffer,   gl_VertexID * 3 + 2).x; 
	
	/* transform vertex and normal */
	outVertexPosition = (ModelViewMatrix * vec4(inVertexPosition, 1)).xyz;
	outVertexNormal = mat3(ModelViewMatrix) * inVertexNormal;
	gl_Position = MVPMatrix * vec4(inVertexPosition, 1);
	
}
