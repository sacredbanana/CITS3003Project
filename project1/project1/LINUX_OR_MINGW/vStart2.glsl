#version 150

in  vec4 vPosition;
in  vec3 vNormal;
in  vec2 vTexCoord;

out vec2 texCoord;
out vec3 fN;
out vec3 fE;
out vec3 fL;
out vec3 fL2;

uniform mat4 ModelView;
uniform mat4 Projection;
uniform vec4 LightPosition;
uniform vec4 Light2Position;
uniform float time;


void main()
{

	fN = vNormal;
	fE = vPosition.xyz;
	fL = LightPosition.xyz;
	fL2 = Light2Position.xyz;
	
	if( LightPosition.w != 0.0 ) {
		fL = LightPosition.xyz - vPosition.xyz;
	}
	
		if( Light2Position.w != 0.0 ) {
		fL2 = Light2Position.xyz - vPosition.xyz;
	}
	
	
    gl_Position = Projection * ModelView * vPosition;
    texCoord = vTexCoord;
}
