using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ICSharpCode.SharpZipLib.Zip;

namespace Allegiance.Modulus.CustomAction
{
    public interface ICustomAction
    {
        /// <summary>
        /// Set to true if the operation should cancel altogether
        /// </summary>
        bool Cancelled { get; set; }

        /// <summary>
        /// Message presented to the user once the operation has completed (successfully or not)
        /// </summary>
        string Message { get; set; }

        /// <summary>
        /// Called before an installation
        /// </summary>
        /// <param name="destinationPath">The path files are being saved to</param>
        /// <param name="backupPath">The path replaced files are backed up to</param>
        /// <param name="archive">The ZipFile archive</param>
        /// <param name="entries">The relevant ZipFile entries for files being saved</param>
        /// <returns>True if the package should resume standard installation, or false if the installation process should cease.</returns>
        bool Install(string destinationPath, string backupPath, ZipFile archive, IEnumerable<ZipEntry> entries);

        /// <summary>
        /// Called before an uninstallation
        /// </summary>
        /// <param name="destinationPath">The path files are being saved to</param>
        /// <param name="backupPath">The path which backed up files are being restored from</param>
        /// <param name="backedUpFiles">The relevant backed up files from the store</param>
        /// <returns>True if the package should resume standard uninstallation, or false if the uninstallation should cease.</returns>
        bool Uninstall(string destinationPath, string backupPath, IEnumerable<string> backedUpFiles);
    }
}
