namespace CortUI.ModulusCustomAction
{
    partial class CustomizationForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(CustomizationForm));
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.NumChatLinesGlobal = new System.Windows.Forms.ComboBox();
            this.NumChatLinesLoadout = new System.Windows.Forms.ComboBox();
            this.AlwaysShowLoadoutWindow = new System.Windows.Forms.CheckBox();
            this.ShowMinimapAtLoadoutScreen = new System.Windows.Forms.CheckBox();
            this.ShowLastOrders = new System.Windows.Forms.CheckBox();
            this.ShowScrollbarOnCockpitChat = new System.Windows.Forms.CheckBox();
            this.NormalHUDMode = new System.Windows.Forms.ComboBox();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.groupBox3 = new System.Windows.Forms.GroupBox();
            this.label4 = new System.Windows.Forms.Label();
            this.SoftwareHUDMode = new System.Windows.Forms.ComboBox();
            this.label1 = new System.Windows.Forms.Label();
            this.ButtonCancel = new System.Windows.Forms.Button();
            this.ButtonOK = new System.Windows.Forms.Button();
            this.groupBox1.SuspendLayout();
            this.groupBox2.SuspendLayout();
            this.groupBox3.SuspendLayout();
            this.SuspendLayout();
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(6, 22);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(40, 13);
            this.label2.TabIndex = 1;
            this.label2.Text = "Global:";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(6, 49);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(49, 13);
            this.label3.TabIndex = 2;
            this.label3.Text = "Loadout:";
            // 
            // NumChatLinesGlobal
            // 
            this.NumChatLinesGlobal.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.NumChatLinesGlobal.FormattingEnabled = true;
            this.NumChatLinesGlobal.Items.AddRange(new object[] {
            "1",
            "2",
            "3",
            "4",
            "5",
            "6",
            "7",
            "8",
            "9",
            "10"});
            this.NumChatLinesGlobal.Location = new System.Drawing.Point(69, 19);
            this.NumChatLinesGlobal.MaxDropDownItems = 10;
            this.NumChatLinesGlobal.Name = "NumChatLinesGlobal";
            this.NumChatLinesGlobal.Size = new System.Drawing.Size(66, 21);
            this.NumChatLinesGlobal.TabIndex = 3;
            // 
            // NumChatLinesLoadout
            // 
            this.NumChatLinesLoadout.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.NumChatLinesLoadout.FormattingEnabled = true;
            this.NumChatLinesLoadout.Items.AddRange(new object[] {
            "1",
            "2",
            "3",
            "4",
            "5",
            "6"});
            this.NumChatLinesLoadout.Location = new System.Drawing.Point(69, 46);
            this.NumChatLinesLoadout.MaxDropDownItems = 10;
            this.NumChatLinesLoadout.Name = "NumChatLinesLoadout";
            this.NumChatLinesLoadout.Size = new System.Drawing.Size(66, 21);
            this.NumChatLinesLoadout.TabIndex = 4;
            // 
            // AlwaysShowLoadoutWindow
            // 
            this.AlwaysShowLoadoutWindow.AutoSize = true;
            this.AlwaysShowLoadoutWindow.Checked = true;
            this.AlwaysShowLoadoutWindow.CheckState = System.Windows.Forms.CheckState.Checked;
            this.AlwaysShowLoadoutWindow.Location = new System.Drawing.Point(9, 21);
            this.AlwaysShowLoadoutWindow.Name = "AlwaysShowLoadoutWindow";
            this.AlwaysShowLoadoutWindow.Size = new System.Drawing.Size(344, 17);
            this.AlwaysShowLoadoutWindow.TabIndex = 5;
            this.AlwaysShowLoadoutWindow.Text = "Always show loadout window in cockpit (disabled = can be toggled)";
            this.AlwaysShowLoadoutWindow.UseVisualStyleBackColor = true;
            // 
            // ShowMinimapAtLoadoutScreen
            // 
            this.ShowMinimapAtLoadoutScreen.AutoSize = true;
            this.ShowMinimapAtLoadoutScreen.Checked = true;
            this.ShowMinimapAtLoadoutScreen.CheckState = System.Windows.Forms.CheckState.Checked;
            this.ShowMinimapAtLoadoutScreen.Location = new System.Drawing.Point(9, 44);
            this.ShowMinimapAtLoadoutScreen.Name = "ShowMinimapAtLoadoutScreen";
            this.ShowMinimapAtLoadoutScreen.Size = new System.Drawing.Size(436, 17);
            this.ShowMinimapAtLoadoutScreen.TabIndex = 6;
            this.ShowMinimapAtLoadoutScreen.Text = "Show minimap at loadout screen (disabled = minimap is never shown at loadout scre" +
                "en)";
            this.ShowMinimapAtLoadoutScreen.UseVisualStyleBackColor = true;
            // 
            // ShowLastOrders
            // 
            this.ShowLastOrders.AutoSize = true;
            this.ShowLastOrders.Checked = true;
            this.ShowLastOrders.CheckState = System.Windows.Forms.CheckState.Checked;
            this.ShowLastOrders.Location = new System.Drawing.Point(9, 67);
            this.ShowLastOrders.Name = "ShowLastOrders";
            this.ShowLastOrders.Size = new System.Drawing.Size(335, 17);
            this.ShowLastOrders.TabIndex = 7;
            this.ShowLastOrders.Text = "Show last orders in cockpit, hangar and on the map when in base";
            this.ShowLastOrders.UseVisualStyleBackColor = true;
            // 
            // ShowScrollbarOnCockpitChat
            // 
            this.ShowScrollbarOnCockpitChat.AutoSize = true;
            this.ShowScrollbarOnCockpitChat.Checked = true;
            this.ShowScrollbarOnCockpitChat.CheckState = System.Windows.Forms.CheckState.Checked;
            this.ShowScrollbarOnCockpitChat.Location = new System.Drawing.Point(9, 90);
            this.ShowScrollbarOnCockpitChat.Name = "ShowScrollbarOnCockpitChat";
            this.ShowScrollbarOnCockpitChat.Size = new System.Drawing.Size(218, 17);
            this.ShowScrollbarOnCockpitChat.TabIndex = 8;
            this.ShowScrollbarOnCockpitChat.Text = "Show scrollbar for chat display in cockpit";
            this.ShowScrollbarOnCockpitChat.UseVisualStyleBackColor = true;
            // 
            // NormalHUDMode
            // 
            this.NormalHUDMode.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.NormalHUDMode.FormattingEnabled = true;
            this.NormalHUDMode.Items.AddRange(new object[] {
            "Classic CortUI",
            "lessHUD - by FlingPu",
            "JelloShot - by FlingPu",
            "GlassHUD - by Bunnywabbit"});
            this.NormalHUDMode.Location = new System.Drawing.Point(121, 19);
            this.NormalHUDMode.Name = "NormalHUDMode";
            this.NormalHUDMode.Size = new System.Drawing.Size(241, 21);
            this.NormalHUDMode.TabIndex = 9;
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.NumChatLinesGlobal);
            this.groupBox1.Controls.Add(this.label2);
            this.groupBox1.Controls.Add(this.NumChatLinesLoadout);
            this.groupBox1.Controls.Add(this.label3);
            this.groupBox1.Location = new System.Drawing.Point(12, 12);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(484, 78);
            this.groupBox1.TabIndex = 10;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Number of chat lines";
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.ShowScrollbarOnCockpitChat);
            this.groupBox2.Controls.Add(this.AlwaysShowLoadoutWindow);
            this.groupBox2.Controls.Add(this.ShowMinimapAtLoadoutScreen);
            this.groupBox2.Controls.Add(this.ShowLastOrders);
            this.groupBox2.Location = new System.Drawing.Point(12, 96);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(484, 116);
            this.groupBox2.TabIndex = 11;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "General options";
            // 
            // groupBox3
            // 
            this.groupBox3.Controls.Add(this.label4);
            this.groupBox3.Controls.Add(this.SoftwareHUDMode);
            this.groupBox3.Controls.Add(this.label1);
            this.groupBox3.Controls.Add(this.NormalHUDMode);
            this.groupBox3.Location = new System.Drawing.Point(12, 218);
            this.groupBox3.Name = "groupBox3";
            this.groupBox3.Size = new System.Drawing.Size(484, 80);
            this.groupBox3.TabIndex = 12;
            this.groupBox3.TabStop = false;
            this.groupBox3.Text = "HUD styles";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(6, 49);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(103, 13);
            this.label4.TabIndex = 12;
            this.label4.Text = "Software HUD style:";
            // 
            // SoftwareHUDMode
            // 
            this.SoftwareHUDMode.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.SoftwareHUDMode.FormattingEnabled = true;
            this.SoftwareHUDMode.Items.AddRange(new object[] {
            "Default software HUD",
            "Software HUD with targeting view",
            "Modified software HUD, Raveen-style",
            "Modified software HUD, Parci-style"});
            this.SoftwareHUDMode.Location = new System.Drawing.Point(121, 46);
            this.SoftwareHUDMode.Name = "SoftwareHUDMode";
            this.SoftwareHUDMode.Size = new System.Drawing.Size(241, 21);
            this.SoftwareHUDMode.TabIndex = 11;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(6, 22);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(94, 13);
            this.label1.TabIndex = 10;
            this.label1.Text = "Normal HUD style:";
            // 
            // ButtonCancel
            // 
            this.ButtonCancel.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.ButtonCancel.Location = new System.Drawing.Point(421, 309);
            this.ButtonCancel.Name = "ButtonCancel";
            this.ButtonCancel.Size = new System.Drawing.Size(75, 23);
            this.ButtonCancel.TabIndex = 13;
            this.ButtonCancel.Text = "Cancel";
            this.ButtonCancel.UseVisualStyleBackColor = true;
            // 
            // ButtonOK
            // 
            this.ButtonOK.DialogResult = System.Windows.Forms.DialogResult.OK;
            this.ButtonOK.Location = new System.Drawing.Point(340, 309);
            this.ButtonOK.Name = "ButtonOK";
            this.ButtonOK.Size = new System.Drawing.Size(75, 23);
            this.ButtonOK.TabIndex = 14;
            this.ButtonOK.Text = "OK";
            this.ButtonOK.UseVisualStyleBackColor = true;
            this.ButtonOK.Click += new System.EventHandler(this.ButtonOK_Click);
            // 
            // CustomizationForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(508, 339);
            this.Controls.Add(this.ButtonOK);
            this.Controls.Add(this.ButtonCancel);
            this.Controls.Add(this.groupBox3);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.groupBox1);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "CustomizationForm";
            this.Text = "Customize CortUI Options";
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            this.groupBox3.ResumeLayout(false);
            this.groupBox3.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.ComboBox NumChatLinesGlobal;
        private System.Windows.Forms.ComboBox NumChatLinesLoadout;
        private System.Windows.Forms.CheckBox AlwaysShowLoadoutWindow;
        private System.Windows.Forms.CheckBox ShowMinimapAtLoadoutScreen;
        private System.Windows.Forms.CheckBox ShowLastOrders;
        private System.Windows.Forms.CheckBox ShowScrollbarOnCockpitChat;
        private System.Windows.Forms.ComboBox NormalHUDMode;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.GroupBox groupBox3;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.ComboBox SoftwareHUDMode;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button ButtonCancel;
        private System.Windows.Forms.Button ButtonOK;
    }
}