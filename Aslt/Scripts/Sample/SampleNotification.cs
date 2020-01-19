using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace Aslt.UI.Sample
{
    public class SampleNotification : MonoBehaviour
    {
        [SerializeField] private Dropdown dropdown; 
        [SerializeField] InputField inputField;
        [SerializeField] private Button displayButton;
        [SerializeField] private Button clearButton;

        private void Start()
        {
            SetEnumOption(ref dropdown, typeof(NoticeType));

            displayButton.onClick.AddListener(delegate
                {
                    NotificationController.Instance.Display(inputField.text,
                        (NoticeType) Enum.Parse(typeof(NoticeType), dropdown.captionText.text));
                });
            
            clearButton.onClick.AddListener(delegate
            {
                NotificationController.Instance.Clear();
            });
        }
        
        public static void SetEnumOption(ref Dropdown dropdown,Type category)
        {
            dropdown.AddOptions(new List<string>(Enum.GetNames(category)));
        }
    }
}