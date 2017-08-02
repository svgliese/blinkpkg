Running package blinkpkg on Raspberry Pi 3b
1a. Download buildroot branch 2017.02
wget https://buildroot.org/downloads/buildroot-2017.02.4.tar.bz2
tar xvjf buildroot-2017.02.4.tar.bz2
cd buildroot-2017.02.4
1b. Or get the source from busybox.net
git clone https://git.busybox.net/buildroot
git checkout -b buildrootlabs 2017.02
cd buildroot
don't forget sudo apt-get install libncurses5-dev before using make menuconfig

3. Select 'Raspberry Pi 3b' config by
make raspberrypi_defconfig3
4. Run build
make
(Recommended to ensure that problems are not in blinkpkg)
5. Download package blinkpkg to buildroot/package/blinkpkg
git clone https://github.com/svgliese/blinkpkg buildroot/package/blinkpkg

6. In 'buildroot/package/Config.in' find the line
menu "Hardware handling"
and in the end of this block (before 'endmenu' line) add line
source "package/blinkpkg/Config.in"

7. Run buildroot setup:
make menuconfig
Press '/' key and enter blinkpkg to find out if package is registered successfully
and where it is located:
Typical Location:
-> Target packages         │
 -> Libraries
  -> Hardware handling
Find and select (*) package blinkpkg in the buildroot tree.
Save config

7. Run 'make' for buildroot
If you see the lines like the following below
>>> blinkpkg 221b942355ada6b598db3d63c94c697b73433545 Downloading
--2017-08-02 04:02:40--  https://github.com/svgliese/blink/archive/221b942355ada6b598db3d63c94c697b73433545/blinkpkg-221b942355ada6b598db3d63c94c697b73433545.tar.gz
Resolving github.com (github.com)... 192.30.253.112, 192.30.253.113
Connecting to github.com (github.com)|192.30.253.112|:443... connected.
HTTP request sent, awaiting response... 302 Found
Location: https://codeload.github.com/svgliese/blink/tar.gz/221b942355ada6b598db3d63c94c697b73433545 [following]
...
>>> blinkpkg 221b942355ada6b598db3d63c94c697b73433545 Installing to target
/usr/bin/install -m 0755 -D /home/ae/testpkg2/buildroot/output/build/blinkpkg-221b942355ada6b598db3d63c94c697b73433545/blink /home/ae/testpkg2/buildroot/output/target/usr/bin/blink
/usr/bin/install -m 0755 -D /home/ae/testpkg2/buildroot/output/build/blinkpkg-221b942355ada6b598db3d63c94c697b73433545/S50blink /home/ae/testpkg2/buildroot/output/target/etc/init.d

Then the 'blink' project ( https://github.com/svgliese/blink ) downloaded, compiled  and installed on the target directory.

8. Write image ('ls -al output/images/sdcard.img -h')
to the flash card (do not forget unmount 'sudo umount /dev/sdb1' before)
sudo dd if=output/images/sdcard.img of=/dev/sdb status=progress
