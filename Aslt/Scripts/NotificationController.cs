using System.Linq;
using DG.Tweening;
using UnityEngine;
using UnityEngine.UI;

namespace Aslt.UI
{
    /// <summary>
    /// 通知を表示するためのクラス
    /// </summary>
    /// <remarks>
    /// シングルトンな実装
    /// </remarks>
    public class NotificationController : MonoBehaviour
    {
        /// <summary>
        /// シングルトンなインスタンス
        /// </summary>
        public static NotificationController Instance;

        [SerializeField] private RectTransform Frame;
        [SerializeField] private Image image;
        [SerializeField] private Text text;

        [SerializeField] private NotificationGraphicsDictionary notificationGraphicsDictionary;

        private const float DURATION = 0.5f;
        private const float DISPLAY_TIME = 2.5f;

        private float _displayTime = -1;
        private float _elapsedTime = 0;
        private float _duration;

        private void Awake()
        {
            if (Instance == null) Instance = this;
            else
            {
                Destroy(this);
                Debug.LogWarning("[NotificationController] Deleted duplicate class.");
            }
            
            if(notificationGraphicsDictionary == null)
                Debug.LogError("[NotificationController] Couldn't load NotificationGraphicsDictionary.");

            Frame.gameObject.SetActive(false);
            Clear();
        }

        private void Update()
        {
            if (_displayTime == -1) return;

            _elapsedTime += Time.deltaTime;
            if (_elapsedTime >= _displayTime)
            {
                _displayTime = -1;
                _elapsedTime = 0;
                Clear(_duration);
            }
        }

        /// <summary>
        /// 通知を表示する
        /// </summary>
        /// <param name="message">表示したいメッセージ</param>
        /// <param name="type">表示するアイコンの種類</param>
        /// <param name="duration">表示にかかる時間(-1の時デフォルトの値を使用する)</param>
        /// <param name="displayTime">表示している時間(-1の時デフォルトの値を使用する)</param>
        public void Display(string message, NoticeType type = NoticeType.Default, float duration = -1, float displayTime = -1)
        {
            text.text = message;
            image.sprite = notificationGraphicsDictionary.NoticeTypes.First(item => item.noticeType == type).sprite;
            
            if(duration != 0)
                Frame.DOLocalMoveY(Frame.rect.height + 10, 0);
            
            Frame.gameObject.SetActive(true);

            _duration = duration == -1 ? DURATION : duration;
            Frame.DOLocalMoveY(0, _duration).OnComplete(() =>
            {
                _elapsedTime = 0;
                _displayTime = displayTime == -1 ? DISPLAY_TIME : displayTime;
            });
        }

        /// <summary>
        /// 表示をやめる
        /// </summary>
        /// <param name="duration">消えるのにかかる時間(-1の時デフォルトの値を使用する)</param>
        public void Clear(float duration = -1)
        {
            _duration = duration == -1 ? DURATION : duration;
            Frame.DOLocalMoveY(Frame.rect.height + 10, _duration).OnComplete(() =>
            {
                _duration = DURATION;
                Frame.gameObject.SetActive(false);
            });
        }

        /// <summary>
        /// デフォルトの表示遷移時間を取得する
        /// </summary>
        /// <returns></returns>
        public float GetDefaultDuration() => DURATION;

        /// <summary>
        /// デフォルトの表示時間を取得する
        /// </summary>
        /// <returns></returns>
        public float GetDefaultDisplayTime() => DISPLAY_TIME;
    }

    public enum NoticeType
    {
        Timer,
        Error,
        Default
    }
}