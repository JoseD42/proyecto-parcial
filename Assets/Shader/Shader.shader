Shader "Custom/Parcial"
{
    Properties
    {
        //Color
        _Albedo("Albedo Color", Color) = (1, 1, 1, 1)
        //Phong
        _SpecularColor("Specular Color", Color) = (1, 1, 1, 1)
        _SpecularPower("Specular Power", Range(1.0, 10.0)) = 5.0 
        _SpecularGloss("Specular Gloss", Range(1.0, 5.0)) = 1.0
        _GlossSteps("GlossSteps", Range(1, 8)) = 4
        //Wrap
        _FallOff("FallOff", Range(0.1, 0.5)) = 0.1
        //Textura
        _MainTex("Main Texture", 2D) = "white" {}
        //Normal
        _NormalTex("Normal Text", 2D) = "bump" {}
        _NormalStrength("Normal Stregth", Range(-5.0, 5.0)) = 1.0
        //Rim
        [HDR] _RimColor("Rim Color", Color) = (1, 0, 0, 1)
        _RimPower("Rim Power", Range(0.0, 8.0)) = 1.0
        //Banded
        _Steps("Banded Steps", Range(1, 100)) = 20
    }

    SubShader
    {
        Tags
        {
            "Queue" = "Geometry"
            "RenderType" = "Opaque"
        }

        CGPROGRAM

            #pragma surface surf ShaderProyecto

            //Textura
            sampler2D _MainTex;
            //Normal
            sampler2D _NormalTex;
            float _NormalStrength;
            //Rim
            half4 _RimColor;
            float _RimPower;
            //Color
            half4 _Albedo;
            //Wrap
            half _FallOff;
            //Phong
            half4 _SpecularColor;
            half _SpecularPower;
            half _SpecularGloss;
            int _GlossSteps;
            //Banded
            fixed _Steps;

            half4 LightingShaderProyecto(SurfaceOutput s, half3 lightDir, half3 viewDir, half atten)
            {
                //Phong
                half NdotL = max(0, dot(s.Normal, lightDir));
                half3 reflectedLight = reflect(-lightDir, s.Normal);
                half RdotV = max(0, dot(reflectedLight, viewDir));
                half3 specularity = pow(RdotV, _SpecularGloss / _GlossSteps) * _SpecularPower * _SpecularColor.rgb;
                //Wrap
                half diff = NdotL * _FallOff + _FallOff;
                //Banded
                half lightBandsMultiplier = _Steps / 256;
                half lightBandsAdditive = _Steps / 2;
                fixed bandedLightModel = (floor((NdotL * 256  + lightBandsAdditive) / _Steps)) * lightBandsMultiplier;

                half4 c;

                c.rgb = (NdotL * s.Albedo + specularity) * _LightColor0.rgb * atten * bandedLightModel;
                
                c.a = s.Alpha;
                return c;
            }

            struct Input
            {
                float2 uv_MainTex;

                float2 uv_NormalTex;

                float3 viewDir;

                float a;
            };

            void surf(Input IN, inout SurfaceOutput o)
            {
                //Textura
                half4 mainTexColor = tex2D(_MainTex, IN.uv_MainTex);
                //Color
                o.Albedo = mainTexColor * _Albedo;

                //Normal
                half4 normalColor = tex2D(_NormalTex, IN.uv_NormalTex);
                half3 normal = UnpackNormal(normalColor);
                normal.z = normal.z / _NormalStrength;
                o.Normal = normalize(normal);
                //Rim
                float3 nVwd = normalize(IN.viewDir);
                float3 NdotV = dot(nVwd, o.Normal);
                half rim = 1 - saturate(NdotV);
                o.Emission = _RimColor.rgb * rim * pow(rim, _RimPower);
            }

        ENDCG
    }
}
