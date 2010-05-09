using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace CortUI.ModulusCustomAction
{
    public partial class CustomizationForm : Form
    {
        public string SelectedNumChatLinesGlobal { get; set; }
        public string SelectedNumChatLinesLoadout { get; set; }
        public string SelectedAlwaysShowLoadoutWindow { get; set; }
        public string SelectedShowMinimapAtLoadoutScreen { get; set; }
        public string SelectedShowLastOrders { get; set; }
        public string SelectedShowScrollbarOnCockpitChat { get; set; }
        public string SelectedNormalHUDMode { get; set; }
        public string SelectedSoftwareHUDMode { get; set; }

        public CustomizationForm()
        {
            InitializeComponent();

            NumChatLinesGlobal.SelectedIndex = 9;
            NumChatLinesLoadout.SelectedIndex = 5;
            NormalHUDMode.SelectedIndex = 0;
            SoftwareHUDMode.SelectedIndex = 0;
        }

        private void ButtonOK_Click(object sender, EventArgs e)
        {
            SelectedNumChatLinesGlobal = NumChatLinesGlobal.SelectedItem.ToString();
            SelectedNumChatLinesLoadout = NumChatLinesLoadout.SelectedItem.ToString();
            SelectedAlwaysShowLoadoutWindow = (AlwaysShowLoadoutWindow.Checked ? "1" : "0");
            SelectedShowMinimapAtLoadoutScreen = (ShowMinimapAtLoadoutScreen.Checked ? "1" : "0");
            SelectedShowLastOrders = (ShowLastOrders.Checked ? "1" : "0");
            SelectedShowScrollbarOnCockpitChat = (ShowScrollbarOnCockpitChat.Checked ? "1" : "0");
            SelectedNormalHUDMode = NormalHUDMode.SelectedIndex.ToString();
            SelectedSoftwareHUDMode = SoftwareHUDMode.SelectedIndex.ToString();
        }
    }
}
