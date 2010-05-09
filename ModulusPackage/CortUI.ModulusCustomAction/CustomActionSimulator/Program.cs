using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Allegiance.Modulus.CustomAction;
using ICSharpCode.SharpZipLib.Zip;
using CortUI.ModulusCustomAction;
using System.IO;

namespace CortUI.CustomActionSimulator
{
    class Program
    {
        static void Main(string[] args)
        {
            ICustomAction action = new CortUICustomAction();

            Directory.CreateDirectory(@"testInstall\artwork");
            Directory.CreateDirectory(@"testBackup\artwork");

            string destinationPath = @"testInstall";
            string backupPath = @"testBackup";
            ZipFile archive = null; // new ZipFile(@"..\..\..\..\CortUI-1.77.mdz");
            IEnumerable<ZipEntry> entries = new List<ZipEntry>();
            IEnumerable<string> backedUpFiles = new List<string>();

            action.Install(destinationPath, backupPath, archive, entries);
            action.Uninstall(destinationPath, backupPath, backedUpFiles);
        }
    }
}
