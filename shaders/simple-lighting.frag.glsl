#version 450

in vec3 vcolor;
in vec3 vfragpos;
in vec3 vnormal;

out vec4 fragColor;

void main() {
    float ambientStrength = 0.3;
    vec3 lightColor = vec3(1.0, 1.0, 1.0);
    vec3 ambient = ambientStrength * lightColor;
	vec3 norm = normalize(vnormal);
	vec3 lightpos = vec3(0.5, 0.5, 0.75);
	vec3 lightdir = normalize(lightpos - vfragpos);
    float diff = max(dot(norm, lightdir), 0.0);
    vec3 diffuse = diff * lightColor;    
    vec3 result = (ambient + diffuse) * vcolor;
    fragColor = vec4(result, 1.0);
}
