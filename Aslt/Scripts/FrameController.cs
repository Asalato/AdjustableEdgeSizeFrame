using System;
using DG.Tweening;
using UnityEngine;
using UnityEngine.UI;

namespace Aslt.UI
{
    /// <summary>
    /// フレームの移動とテキストの内容の反映を行う
    /// </summary>
    [RequireComponent(typeof(LayoutElement))]
    [ExecuteInEditMode]
    [DefaultExecutionOrder(-1)]
    public class FrameController : MonoBehaviour
    {
        public Text Text;
        public RectTransform Frame;

        private LayoutElement _layoutElement;
        
        private void Awake()
        {
            _layoutElement = this.GetComponent<LayoutElement>();
        }
        
        /// <summary>
        /// フレームをフェードインさせる
        /// </summary>
        /// <param name="text">表示させたい文字列</param>
        /// <param name="time">フェードインにかける時間</param>
        /// <param name="action">フェードイン後に実行したい動作(任意)</param>
        public void Display(string text, float time = 0, Action action = null)
        {
            Text.text = text;
            SetActive(true);

            Frame.DOLocalMoveX(-Frame.rect.width, 0);
            Frame.DOLocalMoveX(0, time).OnComplete(() =>
            {
                SetActive(true);
                action?.Invoke();
            });
        }

        /// <summary>
        /// フレームをフェードアウトする
        /// </summary>
        /// <param name="time">フェードアウトにかける時間</param>
        /// <param name="action">フェードアウト後に実行したい動作(任意)</param>
        public void FadeOut(float time = 0, Action action = null)
        {
            Frame.DOLocalMoveX(-Frame.rect.width, time).OnComplete(() =>
            {
                action?.Invoke();
            });
        }

        /// <summary>
        /// 表示・非表示を切り替える
        /// </summary>
        /// <param name="param"></param>
        /// <remarks>
        /// 画面に表示されているときに非表示にすると多分ガクガクする
        /// </remarks>
        public void SetActive(bool param)
        {
            _layoutElement.ignoreLayout = !param;
            Frame.gameObject.SetActive(param);
        }
    }
}
