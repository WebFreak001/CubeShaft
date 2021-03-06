/*#version 130

out vec4 shadowCoord;
out vec3 color;
out float br;
out vec4 texCoord;
out vec3 lpos, normal;

void main() {
	vec4 vPos = gl_ModelViewMatrix * gl_Vertex;
	shadowCoord = gl_TextureMatrix[7] * vPos;
	
	color = vec3(1, 1, 1);
	
	vec3 vnormal = gl_Normal;
	br = ((dot(vnormal, normalize(vec3(0.5, 1.0, 0.3))) * 0.5 + 0.5) * 0.4 + 0.6) * 0.5;
	
	lpos = (gl_LightSource[0].position.xyz - vPos.xyz).xyz;
	normal = gl_NormalMatrix * gl_Normal;
	
	texCoord = gl_MultiTexCoord0;
	gl_Position = ftransform();
}*/
#version 130

out vec4 texCoord;

void main()
{
	vec3 normal, lightDir;
	vec4 diffuse, ambient, globalAmbient;
	float NdotL;

	normal = normalize(gl_NormalMatrix * gl_Normal);
	lightDir = normalize(vec3(gl_LightSource[0].position));
	NdotL = max(dot(normal, lightDir), 0.0);
	diffuse = gl_FrontMaterial.diffuse * gl_LightSource[0].diffuse;
	/* Compute the ambient and globalAmbient terms */

	ambient = gl_FrontMaterial.ambient * gl_LightSource[0].ambient;
	globalAmbient = gl_LightModel.ambient * gl_FrontMaterial.ambient;
	gl_FrontColor =  NdotL * diffuse + globalAmbient + ambient;
	texCoord = gl_MultiTexCoord0;
	gl_Position = ftransform();
}