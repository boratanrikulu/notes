# Arch Linux Installation Notes
I am not a archlinux (or linux) expert so use codes if you know	what you're doing

[Source](https://wiki.archlinux.org/index.php/Installation_guide) wiki.archlinux.org


```
$ loadkeys trq (turkish keyboard layout)
$ ping archlinux.org
$ timedatectl set-ntp true
$ lsblk (or fdisk -l) (to see disks)
$ cfdisk /dev/sdx (to partite the disk)
		* /dev/sdx1 -> /
$ mkfs.ext4 /dev/sdx1
$ mount /dev/sdx1 /mnt
$ mkdir /mnt/boot (may be not needed)
$ less /etc/pacman.d/mirrorlist (to see current mirrors)
$ pacman -S reflector
$ reflector --country "United States" --age 12 --completion-percent 100 --sort rate --save /etc/pacman.d/mirrorlist
$ pacman -Syy (the second 'y' to force a refresh even if up to date)
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
		* 127.0.0.1	localhost.localdomain	localhost
		  ::1		localhost.localdomain	localhost
		  127.0.1.1	PcNAME.localdomain	PcNAME
~ systemctl enable dhcpcd
~ pacman -S iw wpa_supplicant
~ passwd
~ pacman -S grub
~ grub-install --target=i386-pc /dev/sdx
~ add the paremeter "pci=nomsi" > /etc/default/grub
~ grub-mkconfig -o /boot/grub/grub.cfg
~ exit
$ umount -R /mnt
$ reboot
```

```
$ useradd -m -g users -G wheel -s /bin/bash username
$ passwd username
$ EDITOR=nano visudo
		* remove '%' from '%wheel ALL=(ALL) ALL'
$ su username
$ pacman -S bash-completion (to auto-complete commands)
$ pacman -Syy
--
$ pacman -S pulseaudio pulseaudio-alsa
$ pacman -S xorg xorg-xinit
$ pacman -S mesa
$ pacman -S xf86-video-intel
$ nano /usr/share/X11/xorg.conf.d/20-intel.conf
		* Section "Device"
  			Identifier      "Intel Graphics"
          		Driver          "intel"
          		Option  "AccelMethod"   "sna"
          		Option  "DRI"   "3"
          		Option  "TearFree"      "true"
		  EndSection
--
$ pacman -S xfce4
$ echo "exec startxfce4" > /home/username/.xinitrc
$ pacman -S xfce4-terminal firefox gedit gnome-logs
$ pacman -S xfce4-pulseaudio-plugin pavucontrol xfce4-taskmanager
--
$ pacman -S lightdm lightdm-gtk-greeter
$ pacman -S lightdm-gtk-greeter-settings
$ systemctl enable lightdm.service
--
$ pacman -S networkmanager networkmanager-applet
$ pacman -S gnome-keyring
$ pacman -S openvpn openssh(may be needed networkmanager-openvpn) [2]
$ systemctl enable NetworkManager.service
--
$ pacman -S intel-ucode
$ grub-mkconfig -o /boot/grub/grub.cfg
--
$ localectl --no-convert set-x11-keymap tr
$ less /etc/X11/xorg.conf.d/00-keyboard.conf (to see changed)
$ echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf
$ pacman -S gvfs ntfs-3g
$ nano /etc/pacman.conf
		* remove '#' from '#[multilib]' section
$ pacman -S xdg-user-dirs
$ xdg-user-dirs-update
$ systemctl enable fstrim.timer
--
$ sudo pacman -S ufw gufw
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
```
[1]TRIZEN : https://github.com/trizen/trizen

   https://www.reddit.com/r/archlinux/comments/4azqyb/whats_so_bad_with_yaourt/

   https://wiki.archlinux.org/index.php/AUR_helpers

[2]nogroup: https://bbs.archlinux.org/viewtopic.php?id=75693
