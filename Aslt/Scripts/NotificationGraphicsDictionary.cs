using System;
using System.Collections.Generic;
using UnityEngine;

namespace Aslt.UI
{
    [CreateAssetMenu]
    public class NotificationGraphicsDictionary : ScriptableObject
    {
        public List<NoticeTypeImage> NoticeTypes;

        public NotificationGraphicsDictionary()
        {
            NoticeTypes = new List<NoticeTypeImage>();
            for (var i = 0; i < Enum.GetNames(typeof(NoticeType)).Length; ++i)
            {
                NoticeTypes.Add(new NoticeTypeImage() {noticeType = (NoticeType) i});
            }
        }
    }

    [Serializable]
    public class NoticeTypeImage
    {
        public NoticeType noticeType;
        public Sprite sprite;
    }
}