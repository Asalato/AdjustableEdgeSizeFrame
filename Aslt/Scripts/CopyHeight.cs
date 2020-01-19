using UnityEngine;

/// <summary>
/// ContextSizeFitterのアタッチされたObjectのTransformを
/// LayoutElementが正常に読めてなかったのでそれを補うためのスクリプト
/// </summary>
[RequireComponent(typeof(RectTransform))]
[ExecuteInEditMode]
public class CopyHeight : MonoBehaviour
{
    public RectTransform target;
    private RectTransform current;
    
    private void Awake()
    {
        current = this.GetComponent<RectTransform>();
    }

    private void LateUpdate()
    {
        current.sizeDelta = new Vector2(current.sizeDelta.x, target.rect.height);
    }
}
