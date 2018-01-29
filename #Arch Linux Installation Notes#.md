# Arch Linux Installation Notes
I am not a archlinux (or linux) expert so use codes if you know	what you're doing

Some steps have solutions for my PC. You won’t need to do these steps if your PC has no issues with linux.

[Source](https://wiki.archlinux.org/index.php/Installation_guide) wiki.archlinux.org


	! add parameter pci=nomsi (if you have rtl8723be)
	$ loadkeys trq (turkish keyboard layout)
	$ wifi-menu
	$ ping archlinux.org
	$ timedatectl set-ntp true
	$ lsblk (or fdisk -l) (to see disks)
	$ cfdisk /dev/sdx (to partite the disk)
			* /dev/sdx1 -> /		[30G]
			* /dev/sdx2 -> /boot/efi	[500M]
			* /dev/sdx3 -> /home		[~]
	$ mkfs.ext4 /dev/sdx1
	$ mkfs.fat -F32 /dev/sdx2
	$ mkfs.ext4 /dev/sdx3
	$ mount /dev/sdx1 /mnt
	$ mkdir /mnt/boot && mkdir /mnt/boot/efi
	$ mount /dev/sdx2 /mnt/boot/efi
	$ mkdir /mnt/home
	$ mount /dev/sdx3 /mnt/home
	$ less /etc/pacman.d/mirrorlist (to see current mirrors)
	$ pacman -Syy
	$ pacman -S reflector
	$ reflector --country "United States" --age 12 --completion-percent 100 --sort rate --save /etc/pacman.d/mirrorlist
	$ pacman -Syy
	$ less /etc/pacman.d/mirrorlist (to see mirrors changed)
	$ pacstrap /mnt base base-devel
	$ genfstab -U /mnt >> /mnt/etc/fstab
	$ less /mnt/etc/fstab (to see fstab changed)
	$ arch-chroot /mnt
	~ ln -sf /usr/share/zoneinfo/Turkey /etc/localtime
	~ hwclock --systohc
	~ nano /etc/locale.gen
			*  remove '#' from '#en_GB.UTF-8 UTF-8'
	~ locale-gen
	~ echo "LANG=en_GB.UTF-8" > /etc/locale.conf
	~ echo "KEYMAP=trq" > /etc/vconsole.conf
	~ echo "PcNAME" > /etc/hostname
	~ nano /etc/hosts
			* 127.0.0.1	localhost
			  ::1		localhost
			  127.0.1.1	PcNAME.localdomain	PcNAME
	~ pacman -S iw wpa_supplicant dialog
	~ passwd
	~ pacman -S grub efibootmgr
	~ grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=archgrub
	~ add the paremeter "pci=nomsi" > /etc/default/grub
	~ grub-mkconfig -o /boot/grub/grub.cfg
	~ exit
	$ umount -R /mnt/home && umount -R /mnt/boot/efi && umount -R /mnt
	$ reboot


	$ useradd -m -g users -G wheel -s /bin/bash username
	$ passwd username
	$ EDITOR=nano visudo
			* remove '%' from '%wheel ALL=(ALL) ALL'
	$ su username
	$ pacman -S bash-completion (to auto-complete commands)
	$ pacman -Syy
	--
	$ pacman -S xorg xorg-xinit
	$ pacman -S pulseaudio pulseaudio-alsa
**************
$ pacman -S xf86-video-intel
$ nano /etc/X11/xorg.conf.d/20-intel.conf
* Section "Device"
Identifier      "Intel Graphics"
Driver          "intel"
Option  "AccelMethod"   "sna"
Option  "DRI"   "3"
Option  "TearFree"      "true"
EndSection
$ pacman -S xf86-video-nouveau
$ nano /etc/X11/xorg.conf.d/20-nouveau.conf [3]
* Section "Device"
Identifier      "Nvidia Open Source"
Driver		"nouveau"
EndSection
	$ nano /etc/pacman.conf
	* remove '#' from '#[multilib]' section
$ pacman -S lib32-mesa
**************
	--
	$ pacman -S xfce4
	$ echo "exec startxfce4" > /home/username/.xinitrc
	$ pacman -S firefox mousepad gnome-logs gnome-system-log
	$ pacman -S libva-intel-driver libva-vdpau-driver qt5-base ladspa speech-dispatcher
	$ pacman -S xfce4-terminal xfce4-taskmanager xfce4-pulseaudio-plugin pavucontrol
	--
	$ pacman -S lightdm lightdm-gtk-greeter
	$ pacman -S lightdm-gtk-greeter-settings
	$ systemctl enable lightdm.service
	--
	$ pacman -S xscreensaver
	--
	$ pacman -S networkmanager network-manager-applet
**************
$ pacman -S gnome-keyring
**************
	$ pacman -S openssh networkmanager-openvpn
	$ systemctl enable NetworkManager.service
	--
	$ pacman -S intel-ucode
	$ grub-mkconfig -o /boot/grub/grub.cfg
	--
	$ localectl --no-convert set-x11-keymap tr
	$ less /etc/X11/xorg.conf.d/00-keyboard.conf (to see changed)
	$ echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf
	$ pacman -S gvfs ntfs-3g
	$ pacman -S xdg-user-dirs
	$ xdg-user-dirs-update
	$ systemctl enable fstrim.timer
	--
	$ sudo pacman -S ufw
	$ sudo systemctl enable ufw.service
	$ sudo ufw enable
	$ sudo ufw status verbose
	--
	$ pacman -S git
	$ cd Downloads
	$ git clone https://aur.archlinux.org/trizen.git [1]
	$ cd trizen && less PKGBUILD
	$ makepkg -si
	--
	$ reboot

[1]TRIZEN : https://github.com/trizen/trizen

   https://www.reddit.com/r/archlinux/comments/4azqyb/whats_so_bad_with_yaourt/

   https://wiki.archlinux.org/index.php/AUR_helpers

[2]nogroup : https://bbs.archlinux.org/viewtopic.php?id=75693

[3]nouveau : https://wiki.archlinux.org/index.php/nouveau#Keep_NVIDIA_driver_installed

   https://wiki.archlinux.org/index.php/xorg#Driver_installation
