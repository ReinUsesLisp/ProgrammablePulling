
	layout(location = 0) uniform mat4 ModelViewMatrix;
	layout(location = 4) uniform mat4 ProjectionMatrix;
	layout(location = 8) uniform mat4 MVPMatrix;


layout(r32i, binding = 0) restrict readonly uniform iimageBuffer indexBuffer;
layout(r32f, binding = 1) restrict readonly uniform imageBuffer positionBuffer;
layout(r32f, binding = 2) restrict readonly uniform imageBuffer normalBuffer;

out vec3 outVertexPosition;
out vec3 outVertexNormal;

out gl_PerVertex {
	vec4 gl_Position;
};

void main(void) {

	/* fetch index from texture buffer */
	int inIndex = imageLoad(indexBuffer, gl_VertexID).x;

	/* fetch attributes from texture buffer */
	vec3 inVertexPosition;
	inVertexPosition.x = imageLoad(positionBuffer, inIndex * 3 + 0).x; 
	inVertexPosition.y = imageLoad(positionBuffer, inIndex * 3 + 1).x; 
	inVertexPosition.z = imageLoad(positionBuffer, inIndex * 3 + 2).x; 
	
	vec3 inVertexNormal;
	inVertexNormal.x   = imageLoad(normalBuffer, inIndex * 3 + 0).x; 
	inVertexNormal.y   = imageLoad(normalBuffer, inIndex * 3 + 1).x; 
	inVertexNormal.z   = imageLoad(normalBuffer, inIndex * 3 + 2).x; 
	
	/* transform vertex and normal */
	outVertexPosition = (ModelViewMatrix * vec4(inVertexPosition, 1)).xyz;
	outVertexNormal = mat3(ModelViewMatrix) * inVertexNormal;
	gl_Position = MVPMatrix * vec4(inVertexPosition, 1);
	
}
