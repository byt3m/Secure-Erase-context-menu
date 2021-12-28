# SDelete-context-menu
Powershell script that uses SDelete to securely remove files and directories directly from the windows context menu.

Default path for the files is C:\SCRIPTS\SDelete.
Default erasure passes are 35. 

NOTE: it uses registry keys for the creation of the context menu entries. These keys especifiy the name and path of the .bat file that starts the powershell script, feel free to edit the .reg files so you can place the script wherever you want. You will have to edit the SDelete.ps1 file too if you changed the default path or if you want to change the number of erasure passes.

This repository is licensed under the GNU General Public License v3.0.
