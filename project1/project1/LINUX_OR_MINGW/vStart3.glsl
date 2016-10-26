#version 150

in  vec4 vPosition;
in  vec4 vNormal;
//in  vec2 vTexCoord;

//out vec2 texCoord;
out vec3 fN;
out vec3 fL;
out vec3 fE;

uniform mat4 ModelView;
uniform mat4 Projection;
uniform vec4 LightPosition;


void main()
{

    // The vector to the light from the vertex    
    vec3 fL = LightPosition.xyz - vPosition.xyz;

	if (LightPosition.w == 0.0) 
		fL = LightPosition.xyz;
		
    // Transform vertex normal into eye coordinates (assumes scaling is uniform across dimensions)
    vec3 fN = vNormal.xyz;

	vec3 fE = vPosition.xyz;
	
    gl_Position = Projection * ModelView * vPosition;
  //  texCoord = vTexCoord;
}
