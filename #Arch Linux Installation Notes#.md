# Arch Linux Installation Notes
I am not a archlinux (or linux) expert so use codes if you know	what you're doing

Some steps have solutions for my PC. You won’t need to do these steps if your PC has no issues with linux. These steps are marked with "**!"

[Source](https://wiki.archlinux.org/index.php/Installation_guide) wiki.archlinux.org


	**! add parameter pci=nomsi (if you have pci error issue)
	$ loadkeys trq
	$ ping archlinux.org (if you want to use wireless connection use this -> wifi-menu)
	$ timedatectl set-ntp true
	$ lsblk (or fdisk -l) (to see disks)
	$ cfdisk /dev/sdx (to partite the disk)
			* /dev/sdx1 -> /		[30G]
			* /dev/sdx2 -> /boot/efi		[500M]
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
	$ less /etc/pacman.d/mirrorlist (to see mirrors changed)
	$ pacman -Syy
	$ pacstrap /mnt base base-devel
	$ genfstab -U /mnt >> /mnt/etc/fstab
	$ less /mnt/etc/fstab (to see fstab changed)
	$ arch-chroot /mnt
	~ ln -sf /usr/share/zoneinfo/Turkey /etc/localtime
	~ hwclock --systohc
	~ nano /etc/locale.gen
			*  remove '#' from '#en_GB.UTF-8 UTF-8' (or what you want)
	~ locale-gen
	~ echo "LANG=en_GB.UTF-8" > /etc/locale.conf
	~ echo "KEYMAP=trq" > /etc/vconsole.conf
	~ echo "PcNAME" > /etc/hostname
	~ nano /etc/hosts
			* 127.0.0.1	localhost
			  ::1		localhost
			  127.0.1.1	PcNAME.localdomain	PcNAME
	~ pacman -S iw wpa_supplicant dialog
	~ systemctl enable dhcpcd
	~ passwd
	~ pacman -S grub efibootmgr
	~ grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=archgrub
	**! add the paremeter "pci=nomsi" > /etc/default/grub (if you have pci error issue)
	~ grub-mkconfig -o /boot/grub/grub.cfg
	~ exit
	$ umount -R /mnt/home && umount -R /mnt/boot/efi && umount -R /mnt
	$ reboot


	$! login as "root" user
	--
	$ useradd -m -g users -G wheel -s /bin/bash username
	$ passwd username
	$ EDITOR=nano visudo
			* remove '%' from '%wheel ALL=(ALL) ALL'
	$ su username
	$ sudo pacman -S bash-completion (to auto-complete commands)
	$ sudo pacman -Syy
	$ exit
	$ reboot
	--
	$! login as "username" user
	--
	$ sudo pacman -S xorg xorg-xinit
	$ sudo pacman -S pulseaudio pulseaudio-alsa
	$ sudo pacman -S xf86-video-intel xf86-video-nouveau
	$ sudo pacman -S libva-vdpau-driver libvdpau-va-gl libva-intel-driver 
	--
	$ sudo pacman -S xfce4
	$ echo "exec startxfce4" > .xinitrc
	$ sudo pacman -S firefox
	$ sudo pacman -S xfce4-pulseaudio-plugin pavucontrol
	$ sudo pacman -S xfce4-notifyd xfce4-notes-plugin xfce4-screenshooter xfce4-clipman-plugin xfce4-taskmanager
	$ sudo pacman -S gedit gnome-system-log gnome-logs gnome-calculator gnome-disk-utility evince
	$ sudo pacman -S  viewnior unrar p7zip file-roller htop
	$ sudo pacman -S screenfetch
	$ sudo pacman -S arc-gtk-theme arc-icon-theme gtk-engine-murrine 
	$ sudo pacman -S conky plank
	--
	$ sudo pacman -S lightdm
	$ sudo pacman -S lightdm-gtk-greeter
	$ sudo pacman -S lightdm-gtk-greeter-settings
	$ sudo systemctl enable lightdm.service
	--
	$ sudo pacman -S networkmanager network-manager-applet gnome-keyring
	$ sudo pacman -S openvpn openssh (if needed, install networkmanager-openvpn)
	$ sudo systemctl enable NetworkManager.service
	--
	$ sudo pacman -S intel-ucode
	$ sudo grub-mkconfig -o /boot/grub/grub.cfg
	--
	$ sudo localectl --no-convert set-x11-keymap tr
	$ less /etc/X11/xorg.conf.d/00-keyboard.conf (to see changed)
	$ echo "blacklist pcspkr" | sudo tee /etc/modprobe.d/nobeep.conf (if you dont want to hear "beep sound" from your PC)
	**! echo "options rtl8723be ant_sel=2" | sudo tee /etc/modprobe.d/50-rtl8723be.conf[4]
	$ sudo pacman -S gvfs gvfs-mtp ntfs-3g
	$ sudo pacman -S xdg-user-dirs
	$ xdg-user-dirs-update
	$ sudo systemctl enable fstrim.timer
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

[4]rtl8723be : https://github.com/boratanrikulu/notes/blob/master/rtl8723be.md
