#version 450

in vec3 pos;
in vec3 nor;
in vec3 col;

uniform mat3 N;
uniform mat4 WVP;

out vec3 vcolor;
// out vec3 wnormal;

void main() {
    vec4 spos = vec4(pos, 1.0);
	// vec4 wnormal = normalize(N * nor);
	gl_Position = WVP * spos;
	vcolor = col;
}
