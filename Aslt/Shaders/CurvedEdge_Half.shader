// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Aslt/UI/CurvedEdge_Half"
{
	Properties
	{
		[PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
		_Color ("Tint", Color) = (1,1,1,1)
		
		_StencilComp ("Stencil Comparison", Float) = 8
		_Stencil ("Stencil ID", Float) = 0
		_StencilOp ("Stencil Operation", Float) = 0
		_StencilWriteMask ("Stencil Write Mask", Float) = 255
		_StencilReadMask ("Stencil Read Mask", Float) = 255

		_ColorMask ("Color Mask", Float) = 15

		[Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("Use Alpha Clip", Float) = 0
		_Width("Width", Float) = 100
		_Height("Height", Float) = 100
		_EdgeSize("Edge Size", Float) = 10
		_EdgeBold("Edge Bold", Float) = 10
		_TextAreaColor("Text Area Color", Color) = (0,0,0,0)
		_EdgeColor("Edge Color", Color) = (0,0,0,0.6784314)

	}

	SubShader
	{
		Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" "PreviewType"="Plane" "CanUseSpriteAtlas"="True" }
		
		Stencil
		{
			Ref [_Stencil]
			ReadMask [_StencilReadMask]
			WriteMask [_StencilWriteMask]
			CompFront [_StencilComp]
			PassFront [_StencilOp]
			FailFront Keep
			ZFailFront Keep
			CompBack Always
			PassBack Keep
			FailBack Keep
			ZFailBack Keep
		}


		Cull Off
		Lighting Off
		ZWrite Off
		ZTest [unity_GUIZTestMode]
		Blend SrcAlpha OneMinusSrcAlpha
		ColorMask [_ColorMask]

		
		Pass
		{
			Name "Default"
		CGPROGRAM
			
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0

			#include "UnityCG.cginc"
			#include "UnityUI.cginc"

			#pragma multi_compile __ UNITY_UI_CLIP_RECT
			#pragma multi_compile __ UNITY_UI_ALPHACLIP
			
			
			
			struct appdata_t
			{
				float4 vertex   : POSITION;
				float4 color    : COLOR;
				float2 texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				
			};

			struct v2f
			{
				float4 vertex   : SV_POSITION;
				fixed4 color    : COLOR;
				half2 texcoord  : TEXCOORD0;
				float4 worldPosition : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				
			};
			
			uniform fixed4 _Color;
			uniform fixed4 _TextureSampleAdd;
			uniform float4 _ClipRect;
			uniform sampler2D _MainTex;
			uniform float4 _TextAreaColor;
			uniform float _Width;
			uniform float _Height;
			uniform float _EdgeSize;
			uniform float _EdgeBold;
			uniform float4 _EdgeColor;

			
			v2f vert( appdata_t IN  )
			{
				v2f OUT;
				UNITY_SETUP_INSTANCE_ID( IN );
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(OUT);
				UNITY_TRANSFER_INSTANCE_ID(IN, OUT);
				OUT.worldPosition = IN.vertex;
				
				
				OUT.worldPosition.xyz +=  float3( 0, 0, 0 ) ;
				OUT.vertex = UnityObjectToClipPos(OUT.worldPosition);

				OUT.texcoord = IN.texcoord;
				
				OUT.color = IN.color * _Color;
				return OUT;
			}

			fixed4 frag(v2f IN  ) : SV_Target
			{
				float2 uv09 = IN.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
				float temp_output_17_0 = ( uv09.y / ( _Width / _Height ) );
				float2 appendResult27 = (float2(uv09.x , temp_output_17_0));
				float ifLocalVar76 = 0;
				if( _Width <= _Height )
				ifLocalVar76 = _Width;
				else
				ifLocalVar76 = _Height;
				float temp_output_78_0 = ( ifLocalVar76 / 2 );
				float ifLocalVar77 = 0;
				if( _EdgeSize <= temp_output_78_0 )
				ifLocalVar77 = _EdgeSize;
				else
				ifLocalVar77 = temp_output_78_0;
				float temp_output_6_0 = ( ifLocalVar77 / _Width );
				float temp_output_13_0 = ( 1.0 - temp_output_6_0 );
				float2 appendResult21 = (float2(temp_output_13_0 , temp_output_6_0));
				float temp_output_44_0 = distance( appendResult27 , appendResult21 );
				float ifLocalVar80 = 0;
				if( _EdgeBold <= ifLocalVar77 )
				ifLocalVar80 = _EdgeBold;
				else
				ifLocalVar80 = ifLocalVar77;
				float temp_output_14_0 = ( ifLocalVar80 / _Width );
				float temp_output_37_0 = ( temp_output_6_0 - temp_output_14_0 );
				float temp_output_4_0 = ( _Height / _Width );
				float temp_output_12_0 = ( temp_output_4_0 - temp_output_6_0 );
				float2 appendResult20 = (float2(temp_output_13_0 , temp_output_12_0));
				float temp_output_40_0 = distance( appendResult27 , appendResult20 );
				float clampResult67 = clamp( ( ( step( temp_output_44_0 , temp_output_37_0 ) + step( temp_output_40_0 , temp_output_37_0 ) ) + ( ( step( uv09.x , ( temp_output_13_0 - temp_output_14_0 ) ) + ( step( ( temp_output_14_0 + temp_output_6_0 ) , temp_output_17_0 ) * step( temp_output_17_0 , ( temp_output_12_0 - temp_output_14_0 ) ) ) ) * ( step( uv09.x , ( 1.0 - temp_output_14_0 ) ) * step( temp_output_14_0 , uv09.x ) * step( temp_output_14_0 , temp_output_17_0 ) * step( temp_output_17_0 , ( temp_output_4_0 - temp_output_14_0 ) ) ) ) ) , 0.0 , 1.0 );
				float clampResult66 = clamp( ( ( step( temp_output_44_0 , temp_output_6_0 ) + step( temp_output_40_0 , temp_output_6_0 ) ) + ( step( uv09.x , temp_output_13_0 ) + ( step( temp_output_6_0 , temp_output_17_0 ) * step( temp_output_17_0 , temp_output_12_0 ) ) ) ) , 0.0 , 1.0 );
				
				half4 color = ( ( _TextAreaColor * clampResult67 ) + ( _EdgeColor * ( 1.0 - step( clampResult66 , clampResult67 ) ) ) );
				
				#ifdef UNITY_UI_CLIP_RECT
                color.a *= UnityGet2DClipping(IN.worldPosition.xy, _ClipRect);
                #endif
				
				#ifdef UNITY_UI_ALPHACLIP
				clip (color.a - 0.001);
				#endif

				return color;
			}
		ENDCG
		}
	}
}
/*ASEBEGIN
Version=17200
266;72;989;712;2693.82;-31.48381;2.199518;False;False
Node;AmplifyShaderEditor.RangedFloatNode;2;-3294.243,101.1376;Inherit;False;Property;_Width;Width;0;0;Create;True;0;0;False;0;100;254.7;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1;-3296.241,171.7973;Inherit;False;Property;_Height;Height;1;0;Create;True;0;0;False;0;100;131.8;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;79;-3033.234,7.129321;Inherit;False;Constant;_Int0;Int 0;6;0;Create;True;0;0;False;0;2;0;0;1;INT;0
Node;AmplifyShaderEditor.ConditionalIfNode;76;-3062.858,89.25919;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-3290.424,-101.7994;Inherit;False;Property;_EdgeSize;Edge Size;2;0;Create;True;0;0;False;0;10;50;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;78;-2869.611,8.770061;Inherit;False;2;0;FLOAT;0;False;1;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-3296.752,-198.9511;Inherit;False;Property;_EdgeBold;Edge Bold;3;0;Create;True;0;0;False;0;10;3.9;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode;77;-2713.415,-96.28194;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode;80;-2540.626,-230.682;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;4;-2275.965,118.8848;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;6;-2312.078,-102.816;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;5;-2522.958,273.5206;Inherit;False;615.6818;304.6273;Get corrected Uv coordinate;4;27;17;10;9;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;14;-2349.883,-243.1108;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;11;-1649.605,622.7946;Inherit;False;948.3282;880.101;Inner Text Area;15;61;56;48;42;38;35;32;29;26;25;23;22;19;18;15;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-2287.879,-7.566895;Inherit;False;Constant;_Float0;Float 0;3;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;12;-2074.422,118.4751;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;10;-2373.063,445.9476;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;9;-2472.958,323.5206;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;13;-2076.664,-4.162537;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;19;-1570.43,960.8546;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;17;-2209.241,428.8866;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;18;-1579.769,820.7916;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;16;-1526.504,-675.0718;Inherit;False;722.5657;746.0459;Edge;7;63;52;50;44;40;21;20;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;30;-1395.509,101.86;Inherit;False;515.0283;484.4122;Text Area;5;62;55;45;43;33;;1,1,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;20;-1454.708,-61.22595;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StepOpNode;25;-1346.865,975.0066;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;21;-1470.726,-385.3517;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;29;-1577.61,1080.907;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;26;-1594.149,1314.013;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;23;-1349.426,875.1216;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;15;-1585.054,692.5746;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;27;-2075.676,373.3625;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StepOpNode;42;-1357.722,1073.426;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;32;-1341.963,1270.811;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;45;-1340.386,454.0726;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;33;-1342.947,354.1876;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;22;-1351.987,672.7946;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;37;-2175.596,-239.6698;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;35;-1211.126,916.0996;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;38;-1339.402,1370.695;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;83;-1350.094,1170.597;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;44;-1325.159,-446.003;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;40;-1309.141,-121.8772;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;36;-963.8048,-1156.201;Inherit;False;397.5055;473.874;Inner Edge;3;60;58;54;;1,1,1,1;0;0
Node;AmplifyShaderEditor.StepOpNode;58;-913.7952,-1008.277;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;54;-913.7906,-814.5266;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;50;-1153.532,-435.8073;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;56;-1178.891,1190.886;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;48;-1041.759,770.4675;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;43;-1345.509,151.86;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;52;-1137.515,-111.6814;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;55;-1204.647,395.1655;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;61;-872.0762,941.5865;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;63;-959.9379,-373.596;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;62;-1035.281,261.0926;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;60;-722.2994,-1005.942;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;65;-660.2578,-179.1525;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;64;-483.9454,-335.7497;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;66;-432.7507,-197.6173;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;67;-296.6083,-402.7386;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;68;-251.2278,-250.2588;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;69;-536.3647,59.95709;Inherit;False;Property;_EdgeColor;Edge Color;5;0;Create;True;0;0;False;0;0,0,0,0.6784314;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;71;-467.1463,-678.6601;Inherit;False;Property;_TextAreaColor;Text Area Color;4;0;Create;True;0;0;False;0;0,0,0,0;0.6981132,0.6981132,0.6981132,0.6705883;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;70;-116.9005,-241.1824;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;73;-80.59573,-511.6524;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;72;85.56079,-166.4479;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;74;382.2889,-330.1291;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;75;582.1401,-330.5936;Float;False;True;2;ASEMaterialInspector;0;4;Aslt/UI/CurvedEdge_Half;5056123faa0c79b47ab6ad7e8bf059a4;True;Default;0;0;Default;2;True;2;5;False;-1;10;False;-1;0;1;False;-1;0;False;-1;False;False;True;2;False;-1;True;True;True;True;True;0;True;-9;True;True;0;True;-5;255;True;-8;255;True;-7;0;True;-4;0;True;-6;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;2;False;-1;True;0;True;-11;False;True;5;Queue=Transparent=Queue=0;IgnoreProjector=True;RenderType=Transparent=RenderType;PreviewType=Plane;CanUseSpriteAtlas=True;False;0;False;False;False;False;False;False;False;False;False;False;True;2;0;;0;0;Standard;0;0;1;True;False;0
WireConnection;76;0;2;0
WireConnection;76;1;1;0
WireConnection;76;2;1;0
WireConnection;76;3;2;0
WireConnection;76;4;2;0
WireConnection;78;0;76;0
WireConnection;78;1;79;0
WireConnection;77;0;3;0
WireConnection;77;1;78;0
WireConnection;77;2;78;0
WireConnection;77;3;3;0
WireConnection;77;4;3;0
WireConnection;80;0;7;0
WireConnection;80;1;77;0
WireConnection;80;2;77;0
WireConnection;80;3;7;0
WireConnection;80;4;7;0
WireConnection;4;0;1;0
WireConnection;4;1;2;0
WireConnection;6;0;77;0
WireConnection;6;1;2;0
WireConnection;14;0;80;0
WireConnection;14;1;2;0
WireConnection;12;0;4;0
WireConnection;12;1;6;0
WireConnection;10;0;2;0
WireConnection;10;1;1;0
WireConnection;13;0;8;0
WireConnection;13;1;6;0
WireConnection;19;0;12;0
WireConnection;19;1;14;0
WireConnection;17;0;9;2
WireConnection;17;1;10;0
WireConnection;18;0;14;0
WireConnection;18;1;6;0
WireConnection;20;0;13;0
WireConnection;20;1;12;0
WireConnection;25;0;17;0
WireConnection;25;1;19;0
WireConnection;21;0;13;0
WireConnection;21;1;6;0
WireConnection;29;0;8;0
WireConnection;29;1;14;0
WireConnection;26;0;4;0
WireConnection;26;1;14;0
WireConnection;23;0;18;0
WireConnection;23;1;17;0
WireConnection;15;0;13;0
WireConnection;15;1;14;0
WireConnection;27;0;9;1
WireConnection;27;1;17;0
WireConnection;42;0;9;1
WireConnection;42;1;29;0
WireConnection;32;0;14;0
WireConnection;32;1;17;0
WireConnection;45;0;17;0
WireConnection;45;1;12;0
WireConnection;33;0;6;0
WireConnection;33;1;17;0
WireConnection;22;0;9;1
WireConnection;22;1;15;0
WireConnection;37;0;6;0
WireConnection;37;1;14;0
WireConnection;35;0;23;0
WireConnection;35;1;25;0
WireConnection;38;0;17;0
WireConnection;38;1;26;0
WireConnection;83;0;14;0
WireConnection;83;1;9;1
WireConnection;44;0;27;0
WireConnection;44;1;21;0
WireConnection;40;0;27;0
WireConnection;40;1;20;0
WireConnection;58;0;44;0
WireConnection;58;1;37;0
WireConnection;54;0;40;0
WireConnection;54;1;37;0
WireConnection;50;0;44;0
WireConnection;50;1;6;0
WireConnection;56;0;42;0
WireConnection;56;1;83;0
WireConnection;56;2;32;0
WireConnection;56;3;38;0
WireConnection;48;0;22;0
WireConnection;48;1;35;0
WireConnection;43;0;9;1
WireConnection;43;1;13;0
WireConnection;52;0;40;0
WireConnection;52;1;6;0
WireConnection;55;0;33;0
WireConnection;55;1;45;0
WireConnection;61;0;48;0
WireConnection;61;1;56;0
WireConnection;63;0;50;0
WireConnection;63;1;52;0
WireConnection;62;0;43;0
WireConnection;62;1;55;0
WireConnection;60;0;58;0
WireConnection;60;1;54;0
WireConnection;65;0;63;0
WireConnection;65;1;62;0
WireConnection;64;0;60;0
WireConnection;64;1;61;0
WireConnection;66;0;65;0
WireConnection;67;0;64;0
WireConnection;68;0;66;0
WireConnection;68;1;67;0
WireConnection;70;0;68;0
WireConnection;73;0;71;0
WireConnection;73;1;67;0
WireConnection;72;0;69;0
WireConnection;72;1;70;0
WireConnection;74;0;73;0
WireConnection;74;1;72;0
WireConnection;75;0;74;0
ASEEND*/
//CHKSM=872113F1ADA01583A9F28BC0D8219C38A05E5CDA