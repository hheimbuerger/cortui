using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using CortUI.ModulusCustomAction;
using ICSharpCode.SharpZipLib.Zip;
using Allegiance.Modulus.Library.Interface;

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
