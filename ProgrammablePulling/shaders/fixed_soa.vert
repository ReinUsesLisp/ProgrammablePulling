
	layout(location = 0) uniform mat4 ModelViewMatrix;
	layout(location = 4) uniform mat4 ProjectionMatrix;
	layout(location = 8) uniform mat4 MVPMatrix;


layout(location = 0) in float inPositionX;
layout(location = 1) in float inPositionY;
layout(location = 2) in float inPositionZ;
layout(location = 3) in float inNormalX;
layout(location = 4) in float inNormalY;
layout(location = 5) in float inNormalZ;

out vec3 outVertexPosition;
out vec3 outVertexNormal;

out gl_PerVertex {
	vec4 gl_Position;
};

void main(void)
{
	vec3 inVertexPosition = vec3(inPositionX, inPositionY, inPositionZ);
	vec3 inVertexNormal = vec3(inNormalX, inNormalY, inNormalZ);

	/* transform vertex and normal */
	outVertexPosition = (ModelViewMatrix * vec4(inVertexPosition, 1)).xyz;
	outVertexNormal = mat3(ModelViewMatrix) * inVertexNormal;
	gl_Position = MVPMatrix * vec4(inVertexPosition, 1);
	
}
