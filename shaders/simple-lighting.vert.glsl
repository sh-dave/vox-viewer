#version 450

in vec3 pos;
in vec3 nor;
in vec3 col;

uniform mat3 N;
uniform mat4 W;
uniform mat4 V;
uniform mat4 P;

out vec3 vfragpos;
out vec3 vcolor;
out vec3 vnormal;

void main() {
	gl_Position = P * V * W * vec4(pos, 1.0);
	vfragpos = vec3(N * pos);//W * vec4(pos, 1.0));
	vcolor = col;
	vnormal = nor;
}