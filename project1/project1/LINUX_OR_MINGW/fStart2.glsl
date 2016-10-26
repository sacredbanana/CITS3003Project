#version 150

in  vec2 texCoord;  // The third coordinate is always 0.0 and is discarded
in vec3 fN;
in vec3 fE;
in vec3 fL;
in vec3 fL2;

uniform sampler2D texture;
uniform vec4 AmbientProduct, DiffuseProduct, SpecularProduct;
uniform float Shininess;
uniform vec4 LightPosition;
uniform mat4 ModelView;
uniform vec4 Light2Position;
uniform float time;

void
main()
{
       float angle = 0.01*time;
	   
    // Transform fragment position into eye coordinates
    vec3 pos = (ModelView * vec4(fE, 1.0)).xyz;
    vec3 pos2 = (ModelView * vec4(0.0,0.0,0.0,1.0)).xyz;
	

    // The vector to the light from the fragment    
    vec3 Lvec = LightPosition.xyz - pos.xyz;
	vec3 L2vec = Light2Position.xyz - pos2.xyz;

   float distanceToLight = length(Lvec);
   float distanceToLight2 = length(L2vec);
   
   // Normalize the input lighting vectors
	
	vec3 N = normalize((ModelView*vec4(fN, 0.0)).xyz);
	vec3 E = normalize(-pos);
	vec3 L = normalize(Lvec);
	vec3 L2 = normalize(L2vec);
	
	vec3 H = normalize( L + E );
	vec4 ambient = AmbientProduct;
	
	vec3 H2 = normalize( L2 + E );
	
	
	float Kd = max(dot(L, N), 0.0);
	vec4 diffuse = Kd*DiffuseProduct;
	
	float Kd2 = max(dot(L2, N), 0.0);
	vec4 diffuse2 = Kd2*DiffuseProduct;
	
	float Ks = pow(max(dot(N, H), 0.0), Shininess);
	vec4 specular = Ks*SpecularProduct;

	float Ks2 = pow(max(dot(N, H2), 0.0), Shininess);
	vec4 specular2 = Ks2*SpecularProduct;
	
	// remove specular if light behind vertex
	if( dot(L, N) < 0.0 )
		specular = vec4(0.0, 0.0, 0.0, 1.0);

    // globalAmbient is independent of distance from the light source
    vec4 globalAmbient = vec4(0.1, 0.1, 0.1, 1.0);
		
  // fColor =  globalAmbient + ambient + diffuse + specular; // distanceToLight;
    gl_FragColor = globalAmbient + ambient + vec4(sin(0.5*angle), sin(angle), sin(angle*angle), 1.0) + ((diffuse + specular ) / distanceToLight) + (diffuse2) / distanceToLight2;
   gl_FragColor.a = 1.0;
	gl_FragColor *=  texture2D( texture, texCoord * 2.0 );

}
