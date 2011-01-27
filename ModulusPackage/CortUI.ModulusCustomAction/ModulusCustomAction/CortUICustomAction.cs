using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Windows.Forms;
using System.Reflection;
using Allegiance.Modulus.Library.Interface;
using ICSharpCode.SharpZipLib.Zip;

namespace CortUI.ModulusCustomAction
{
    public class CortUICustomAction : ICustomAction
    {
        private const string SETTINGS_MDL_RESOURCE_NAME = "CortUI.ModulusCustomAction.cortui_settings.mdl";

        private const string CORTUI_VERSION_NUMBER = "1.80";

        public bool Cancelled { get; set; }

        public string Message { get; set; }

        private string InsertParameter(string source, string parameterName, string value, bool isString = false)
        {
            string mask = parameterName + " = "
                                        + (isString ? "\"" : "")
                                        + "?"
                                        + (isString ? "\"" : "")
                                        + ";";
            string replacement = parameterName
                                        + " = "
                                        + (isString ? "\"" : "")
                                        + value
                                        + (isString ? "\"" : "")
                                        + ";";

            return source.Replace(mask, replacement);
        }

        public bool Install(string destinationPath, string backupPath, ZipFile archive, IEnumerable<ZipEntry> entries)
        {
            CustomizationForm customizationForm = new CustomizationForm();
            DialogResult result = customizationForm.ShowDialog();

            if (result == DialogResult.OK)
            {
                string pathToCortUiSettingsMdl = Path.Combine(destinationPath, "artwork", "cortui_settings.mdl");

                string settingsMdl;
                try
                {
                    Assembly assembly = Assembly.GetExecutingAssembly();
                    StreamReader settingsMdlTemplateStream = new StreamReader(assembly.GetManifestResourceStream(SETTINGS_MDL_RESOURCE_NAME));
                    settingsMdl = settingsMdlTemplateStream.ReadToEnd();
                    settingsMdlTemplateStream.Close();
                }
                catch
                {
                    MessageBox.Show("Failed to read cortui_settings.mdl template, installation aborted.");
                    Message = "Failed to read cortui_settings.mdl template, installation aborted.";
                    return false;
                }

                settingsMdl = InsertParameter(settingsMdl, "cortUIVersionString", "CortUI v" + CORTUI_VERSION_NUMBER, true);
                settingsMdl = InsertParameter(settingsMdl, "NumChatLinesLobby", "10");
                settingsMdl = InsertParameter(settingsMdl, "NumChatLinesGlobal", customizationForm.SelectedNumChatLinesGlobal);
                settingsMdl = InsertParameter(settingsMdl, "NumChatLinesLoadout", customizationForm.SelectedNumChatLinesLoadout);
                settingsMdl = InsertParameter(settingsMdl, "AlwaysShowLoadoutWindow", customizationForm.SelectedAlwaysShowLoadoutWindow);
                settingsMdl = InsertParameter(settingsMdl, "ShowMinimapAtLoadoutScreen", customizationForm.SelectedShowMinimapAtLoadoutScreen);
                settingsMdl = InsertParameter(settingsMdl, "ShowLastOrders", customizationForm.SelectedShowLastOrders);
                settingsMdl = InsertParameter(settingsMdl, "ShowScrollbarOnCockpitChat", customizationForm.SelectedShowScrollbarOnCockpitChat);
                settingsMdl = InsertParameter(settingsMdl, "NormalHUDMode", customizationForm.SelectedNormalHUDMode);
                settingsMdl = InsertParameter(settingsMdl, "SoftwareHUDMode", customizationForm.SelectedSoftwareHUDMode);

                try
                {
                    StreamWriter writer = new StreamWriter(pathToCortUiSettingsMdl);
                    writer.Write(settingsMdl);
                    writer.Close();
                }
                catch
                {
                    MessageBox.Show("Failed to write cortui_settings.mdl.");
                    Message = "Failed to write cortui_settings.mdl, installation aborted.";
                    Cancelled = true;
                    return false;
                }

                return true;
            }
            else
            {
                Message = "Installation aborted by user.";
                Cancelled = true;
                return false;
            }
        }

        public bool Uninstall(string destinationPath, string backupPath, IEnumerable<string> backedUpFiles)
        {
            string pathToCortUiSettingsMdl = Path.Combine(destinationPath, "artwork", "cortui_settings.mdl");

            if (!File.Exists(pathToCortUiSettingsMdl))
            {
                //Message = "Could not find " + pathToCortUiSettingsMdl;
            }
            else
            {
                File.Delete(pathToCortUiSettingsMdl);
            }

            return true; // proceed uninstallation even if cortui_settings.mdl has not been found
        }
    }
}
