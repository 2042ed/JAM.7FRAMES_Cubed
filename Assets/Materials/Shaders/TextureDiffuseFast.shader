// Simplified Diffuse shader. Differences from regular Diffuse one:
// - no Main Color
// - fully supports only 1 directional light. Other lights can affect it, but it will be per-vertex/SH.

Shader "ADVKIT/Texture Diffuse Fast" {
Properties {
	_Color ("Color", Color) = (1,1,1,.5)
	_MainTex ("Base (RGB)", 2D) = "white" {}
	_Detail("Detail", 2D) = "gray" {}
	_DetailLevel("DetailLevel", Color) = (0.5,0.5,0.5,.5)
		_DetailScale("DetailScale",float) = 10.0
}
SubShader {
	Tags { "RenderType"="Opaque" }
	LOD 150

CGPROGRAM
#pragma surface surf Lambert vertex:vert
		fixed4 _Color;
	fixed4 _DetailLevel;
sampler2D _MainTex;
sampler2D _Detail;
float _DetailScale;
struct Input {
	float2 uv_MainTex;
	float2 dmap;
};
void vert(inout appdata_full v, out Input o) {
	UNITY_INITIALIZE_OUTPUT(Input, o);
	//v.vertex.xyz += v.normal * _Amount;
	float3 n = abs(v.normal);
	float3 p = v.vertex.xyz/ _DetailScale;
	o.dmap = n.x==1?p.yz: n.y==1?p.xz: p.xy;// / 10.0;
}
void surf (Input IN, inout SurfaceOutput o) {
	fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
	fixed4 d = tex2D(_Detail, IN.dmap);
	o.Albedo = c.rgb*_Color.rgb *(d.rgb+ _DetailLevel);
//		o.Albedo=d.rrr;
	//o.Albedo.rg = IN.dmap;
	o.Alpha = c.a;
}
ENDCG
}

Fallback "Mobile/VertexLit"
}
