Shader "Custom/GaboFur" {
	Properties {
		_Color("Color", Color) = (1,1,1,1)
		_MainTex("Albedo (RGB)", 2D) = "white" {}
		_FurLevelTex("Fur Level", 2D) = "white" {}
		_Occlusion("Occlusion Map", 2D) = "white" {}
		_BumpMap("Normal", 2D) = "bump" {}
		_BumpScale("Normal Intensity", Range(-7,7)) = 1.0
		_Glossiness("Smoothness", Range(0,1)) = 0.5
		_Metallic("Metallic", Range(0,1)) = 0.0
		_FurLength("Fur Length", Range(0.00002, 0.0021)) = .25
		_Cutoff("Alpha cutoff", Range(0,1)) = 0.5
		_CutoffEnd("Alpha cutoff end", Range(0,1)) = 0.5
		_EdgeFade("Edge Fade", Range(0,1)) = 0.4
		_Gravity("Gravity direction", Vector) = (0,0,1,0)
		_GravityStrength("G Strength", Range(0,1)) = 0.25
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows
		//#pragma surface surf BlinnPhong alphatest:_Cutoff2
		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;
		sampler2D _FurLevelTex;
		sampler2D _Occlusion;
		sampler2D _BumpMap;

		struct Input {
			float2 uv_MainTex;
		};
		float _BumpScale;
		half _Glossiness;
		half _Metallic;
		fixed4 _Color;

		
		UNITY_INSTANCING_BUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_BUFFER_END(Props)

		void surf (Input IN, inout SurfaceOutputStandard o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			fixed4 d = tex2D(_FurLevelTex, IN.uv_MainTex);
			fixed4 Occ = tex2D(_Occlusion, IN.uv_MainTex);
			o.Albedo = c.rgb;
			//o.Specular = Occ.rgb;
			fixed3 normal = UnpackNormal(tex2D(_BumpMap, IN.uv_MainTex));
			normal.z = normal.z / _BumpScale;
			o.Normal = normalize(normal);
			o.Metallic = _Metallic - Occ.rgb;
			o.Smoothness = _Glossiness - Occ.rgb;
			o.Alpha = d.a;
			
		}
		ENDCG

		CGPROGRAM
			#pragma surface surf Standard fullforwardshadows alpha:blend
			#pragma vertex vert
			#define FUR_MULTIPLIER 0.05
			#include "FurPass.cginc"
		ENDCG

		CGPROGRAM
			#pragma surface surf Standard fullforwardshadows alpha:blend
			#pragma vertex vert
			#define FUR_MULTIPLIER 0.1
			#include "FurPass.cginc"
		ENDCG

		CGPROGRAM
			#pragma surface surf Standard fullforwardshadows alpha:blend
			#pragma vertex vert
			#define FUR_MULTIPLIER 0.15
			#include "FurPass.cginc"
		ENDCG

		CGPROGRAM
			#pragma surface surf Standard fullforwardshadows alpha:blend
			#pragma vertex vert
			#define FUR_MULTIPLIER 0.2
			#include "FurPass.cginc"
		ENDCG
		CGPROGRAM
			#pragma surface surf Standard fullforwardshadows alpha:blend
			#pragma vertex vert
			#define FUR_MULTIPLIER 0.25
			#include "FurPass.cginc"
		ENDCG
		CGPROGRAM
			#pragma surface surf Standard fullforwardshadows alpha:blend
			#pragma vertex vert
			#define FUR_MULTIPLIER 0.3
			#include "FurPass.cginc"
		ENDCG
		CGPROGRAM
			#pragma surface surf Standard fullforwardshadows alpha:blend
			#pragma vertex vert
			#define FUR_MULTIPLIER 0.35
			#include "FurPass.cginc"
		ENDCG
		CGPROGRAM
			#pragma surface surf Standard fullforwardshadows alpha:blend
			#pragma vertex vert
			#define FUR_MULTIPLIER 0.4
			#include "FurPass.cginc"
		ENDCG
		CGPROGRAM
			#pragma surface surf Standard fullforwardshadows alpha:blend
			#pragma vertex vert
			#define FUR_MULTIPLIER 0.45
			#include "FurPass.cginc"
		ENDCG
	}
	FallBack "Diffuse"
}
