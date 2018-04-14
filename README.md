![Picture](https://raw.githubusercontent.com/2ex/FSWBU/master/spectre.png)

*Fix for Spectre vulnerability without BIOS update based on VMware CPU microcode update driver.*

> This method should work on Windows 7+ / Windows Server 2003+
### Keep in mind that this is intended for those who:

- **Have not yet** received BIOS update from its vendor.
- **Will never** receive BIOS update from its vendor.

### Before you start make sure your system is up-to-date then:

> You are doing it at your own risk, I'm not responsible for any potencial damage!

1. [Download the latest version of InSpectre](https://www.grc.com/inspectre.htm) and run it.
2. If microcode update is available, go to *step 3*
 - If not, [find out](https://newsroom.intel.com/wp-content/uploads/sites/11/2018/04/microcode-update-guidance.pdf) what's your CPU status and get back here once it's in *production* stage.
3. [Download & install KB4090007](https://www.catalog.update.microsoft.com/Search.aspx?q=KB4090007) **if you're running Windows 10 (version 1709)** and your *CPUID* is on [this list.](https://support.microsoft.com/en-us/help/4090007/intel-microcode-updates)
4. Download this repo, unpack it and **execute install.bat with admin privileges.**
 - It already has [(20180312)](https://downloadcenter.intel.com/download/27591/Linux-Processor-Microcode-Data-File?v=t) file with updated microcodes from Intel but you're free to check for newer version.
* If installation was a success reboot your PC.
* Done! Run InSpectre again and check if you're vulnerable.

Additionally, you can use tool like [HWiNFO](https://www.hwinfo.com/download.php) to check if your *CPU microcode update revision* have really changed.

These changes are **not permanent** and you have to **repeat this process** every time you re-install your Windows system!

### Credits:

- [VMware and contributors who created this driver](https://labs.vmware.com/flings/vmware-cpu-microcode-update-driver#summary)
- Gibson Research for amazing InSpectre tool
- Intel for updates, obviously
- AMD for some files of which VMware driver wouldn't work
-  Martin Brinkmann from ghacks.net for info about Windows 10

VMware CPU Microcode Update Driver [Technical Preview License](https://labs.vmware.com/flings/vmware-cpu-microcode-update-driver/license)
