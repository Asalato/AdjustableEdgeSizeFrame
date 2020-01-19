using System;
using UniRx;
using UnityEngine;
using UnityEngine.UI;

namespace Aslt.UI
{
    /// <summary>
    /// AdjustableEdgeSizeFrameの集合を一括して制御するクラス
    /// </summary>
    [ExecuteInEditMode]
    public class FrameIntegrationController : MonoBehaviour
    {
        [SerializeField] private FrameController[] elements;
        [SerializeField] private RectTransform root;

        private string[] _contents = new string[0];
        [SerializeField] private float defaultDuration;

        private void Start()
        {
            foreach (var element in elements)
            {
                element.SetActive(false);
            }
        }

        private void OnGUI()
        {
            LayoutRebuilder.ForceRebuildLayoutImmediate(root);
        }

        /// <summary>
        /// 指定した要素を表示する
        /// </summary>
        /// <param name="texts">表示する文字列</param>
        /// <param name="time">要素の表示にかかる時間(-1の時デフォルトの値を使用する)</param>
        public virtual void SetColumn(string[] texts, float time = -1)
        {
            time = time == -1 ? defaultDuration : time;
            
            for (var i = elements.Length; i > 0; --i)
            {
                elements[elements.Length - i].SetActive(false);
            }

            var refreshRate = time / 2 / elements.Length;
            for (var i = 0; i < Mathf.Min(texts.Length, elements.Length); ++i)
            {
                // i番目のフレームは i * refreshRate (s) 遅れて表示が開始される
                var i1 = i;
                elements[i1].FadeOut(0);
                Observable.Return(Unit.Default).Delay(TimeSpan.FromSeconds(refreshRate * i))
                    .Subscribe(_ => elements[i1].Display(texts[i1], time));
            }
        
            _contents = new string[Mathf.Min(texts.Length, elements.Length)];
            Array.Copy(texts, _contents, _contents.Length);
            LayoutRebuilder.ForceRebuildLayoutImmediate(root);
        }

        /// <summary>
        /// 表示済みの要素を消す
        /// </summary>
        /// <param name="time">完全に消すまでにかかる時間(-1の時デフォルトの値を使用する)</param>
        public virtual void Clear(float time = -1)
        {
            time = time == -1 ? defaultDuration : time;
            
            var refreshRate = time / 2 / elements.Length;
            for (var i = 0; i < elements.Length; ++i)
            {
                var i1 = i;
                Observable.Return(Unit.Default).Delay(TimeSpan.FromSeconds(refreshRate * i))
                    .Subscribe(_ => elements[i1].FadeOut(time, delegate
                    {
                        elements[i1].Text.text = "";
                        if (i1 != elements.Length - 1) return;
                        foreach (var element in elements)
                        {
                            element.SetActive(false);
                        }
                    }));
            }

            _contents = new string[0];
        }

        /// <summary>
        /// 表示可能な要素数を取得
        /// </summary>
        /// <returns></returns>
        public int GetFrameLength() => elements.Length;
        
        /// <summary>
        /// 現在表示されている要素数を取得
        /// </summary>
        /// <returns></returns>
        public int GetContentsLength() => _contents.Length;
        
        /// <summary>
        /// 現在表示されている要素をインデックスから参照
        /// </summary>
        /// <param name="index"></param>
        /// <returns></returns>
        /// <exception cref="IndexOutOfRangeException">指定したインデックス番号に要素が存在しない</exception>
        public string GetValueFromIndex(int index) => _contents[index];
    }
}