#version 450

in vec3 vcolor;
// in vec3 wnormal;
out vec4 fragColor;

void main() {
    fragColor = vec4(vcolor, 1.0);
}
