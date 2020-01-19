using System.Linq;
using UnityEngine;
using UnityEngine.UI;

namespace Aslt.UI
{
    public class SampleDisplay : MonoBehaviour
    {
        public FrameIntegrationController controller;
        
        public InputField inputField0;
        public InputField inputField1;
        public InputField inputField2;
        public InputField inputField3;
        public InputField inputField4;
        public InputField time;
        
        public Button display;
        public Button clear;

        private void Start()
        {
            display.onClick.AddListener(delegate
            {
                float.TryParse(time.text, out var remain);
                var arr = new[]
                    {inputField0.text, inputField1.text, inputField2.text, inputField3.text, inputField4.text};
               controller.SetColumn(arr.Where(item => !string.IsNullOrEmpty(item)).ToArray(), remain);
            });
            
            clear.onClick.AddListener(delegate
            {
                float.TryParse(time.text, out var remain);
                controller.Clear(remain);
            });
            
            controller.Clear();
        }
    }
}