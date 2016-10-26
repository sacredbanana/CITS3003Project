#version 150

//in  vec2 texCoord;  // The third coordinate is always 0.0 and is discarded
in vec3 fN;
in vec3 fL;
in vec3 fE;

//uniform sampler2D texture;
uniform vec4 AmbientProduct, DiffuseProduct, SpecularProduct;
uniform mat4 ModelView;
uniform vec4 LightPosition;
uniform float Shininess;

void
main()
{

	vec3 NN = normalize(fN);
	vec3 EE = normalize(fE);
	vec3 LL = normalize(fL);
	vec4 ambient, diffuse, specular;
	vec3 H = normalize(LL+EE);
	float Kd = max(dot(LL, NN), 0.0);
	float Ks = pow(max(dot(NN, H), 0.0), Shininess);
	ambient = AmbientProduct;
	diffuse = Kd*DiffuseProduct;
	if (dot(LL, NN) < 0.0)
		specular = vec4(0.0, 0.0, 0.0, 1.0);
	else specular = Ks*SpecularProduct;
	gl_FragColor = vec4((ambient + diffuse + specular).xyz, 1.0);

}
