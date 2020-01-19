using System;
using UnityEngine;
using UnityEngine.UI;

namespace Aslt.UI
{
    /// <summary>
    /// UI描画用シェーダにUI情報を送る
    /// </summary>
    [RequireComponent(typeof(RectTransform))]
    [RequireComponent(typeof(Image))]
    [ExecuteInEditMode]
    public class SetRectParameterForMaterial : MonoBehaviour
    {
        private RectTransform _rectTransform;
        private Material _targetUiMaterial;
        private static readonly int _Width = Shader.PropertyToID("_Width");
        private static readonly int _Height = Shader.PropertyToID("_Height");

        [SerializeField] private FrameType frameType;
        
        [SerializeField] private Color textAreaColor;
        [SerializeField] private Color edgeColor;
        [SerializeField] private float edgeSize;
        [SerializeField] private float edgeBold;
        
        private static readonly int _TextAreaColor = Shader.PropertyToID("_TextAreaColor");
        private static readonly int _EdgeColor = Shader.PropertyToID("_EdgeColor");
        private static readonly int _EdgeSize = Shader.PropertyToID("_EdgeSize");
        private static readonly int _EdgeBold = Shader.PropertyToID("_EdgeBold");

        private void Awake()
        {
            _rectTransform = this.GetComponent<RectTransform>();

            Shader shader;
            switch (frameType)
            {
                case FrameType.DoubleEdge:
                    shader = Shader.Find("Aslt/UI/CurvedEdge");
                    break;
                case FrameType.HalfEdge:
                    shader = Shader.Find("Aslt/UI/CurvedEdge_Half");
                    break;
                default:
                    throw new ArgumentOutOfRangeException();
            }
            
            _targetUiMaterial = new Material(shader) {name = Guid.NewGuid().ToString()};
            _targetUiMaterial.SetColor(_TextAreaColor, textAreaColor);
            _targetUiMaterial.SetColor(_EdgeColor, edgeColor);
            _targetUiMaterial.SetFloat(_EdgeSize, edgeSize);
            _targetUiMaterial.SetFloat(_EdgeBold, edgeBold);
            
            this.GetComponent<Image>().material = _targetUiMaterial;
        }

        private void LateUpdate()
        {
            _targetUiMaterial.SetFloat(_Width, _rectTransform.sizeDelta.x);
            _targetUiMaterial.SetFloat(_Height, _rectTransform.sizeDelta.y);
        }
    }
}