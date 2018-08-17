#pragma target 3.0
#include "UnityCG.cginc"

fixed4 _Color;
sampler2D _MainTex;
sampler2D _FurLevelTex;
half _Glossiness;
half _Metallic;

uniform float _FurLength;
uniform float _Cutoff;
uniform float _CutoffEnd;
uniform float _EdgeFade;
uniform fixed3 _Gravity;
uniform fixed _GravityStrength;


struct v2f
{
	float2 uv : TEXCOORD0; // texture coordinate
	float4 vertex : SV_POSITION; // clip space position
};

void vert(inout appdata_full v)
{

	fixed3 direction = lerp(v.normal, _Gravity * _GravityStrength + v.normal * (1 - _GravityStrength), FUR_MULTIPLIER);
	v.vertex.xyz += direction * _FurLength * FUR_MULTIPLIER * v.color.a;

}

struct Input {
	float2 uv_MainTex;
	float3 viewDir;
};

void surf(Input IN, inout SurfaceOutputStandard o) {
	fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
	fixed4 d = tex2D(_FurLevelTex, IN.uv_MainTex);
	o.Albedo = c.rgb;
	o.Metallic = _Metallic;
	o.Smoothness = _Glossiness;
	
	o.Alpha = step(lerp(_Cutoff, _CutoffEnd, FUR_MULTIPLIER), d.a);
	float alpha = 1 - (FUR_MULTIPLIER * FUR_MULTIPLIER);
	alpha += dot(IN.viewDir, o.Normal) - _EdgeFade;
	o.Alpha *= alpha;
}