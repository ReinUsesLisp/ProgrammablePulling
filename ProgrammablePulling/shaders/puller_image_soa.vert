
	layout(location = 0) uniform mat4 ModelViewMatrix;
	layout(location = 4) uniform mat4 ProjectionMatrix;
	layout(location = 8) uniform mat4 MVPMatrix;


layout(r32i, binding = 0) restrict readonly uniform iimageBuffer indexBuffer;
layout(r32f, binding = 1) restrict readonly uniform imageBuffer posXBuffer;
layout(r32f, binding = 2) restrict readonly uniform imageBuffer posYBuffer;
layout(r32f, binding = 3) restrict readonly uniform imageBuffer posZBuffer;
layout(r32f, binding = 4) restrict readonly uniform imageBuffer normalXBuffer;
layout(r32f, binding = 5) restrict readonly uniform imageBuffer normalYBuffer;
layout(r32f, binding = 6) restrict readonly uniform imageBuffer normalZBuffer;

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
	inVertexPosition.x = imageLoad(posXBuffer, inIndex).x; 
	inVertexPosition.y = imageLoad(posYBuffer, inIndex).x; 
	inVertexPosition.z = imageLoad(posZBuffer, inIndex).x; 
	
	vec3 inVertexNormal;
	inVertexNormal.x   = imageLoad(normalXBuffer, inIndex).x; 
	inVertexNormal.y   = imageLoad(normalYBuffer, inIndex).x; 
	inVertexNormal.z   = imageLoad(normalZBuffer, inIndex).x; 
	
	/* transform vertex and normal */
	outVertexPosition = (ModelViewMatrix * vec4(inVertexPosition, 1)).xyz;
	outVertexNormal = mat3(ModelViewMatrix) * inVertexNormal;
	gl_Position = MVPMatrix * vec4(inVertexPosition, 1);
	
}
