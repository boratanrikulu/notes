source : https://cubethethird.wordpress.com/2016/06/14/eliminate-screen-tearing-with-amd-gpu-on-ubuntu/

path : /usr/share/X11/xorg.conf.d/


```
Section "Device"
    Identifier "Radeon"
    Driver "radeon"
    Option "TearFree" "on"
    Option "DRI" "3"
    Option "AccelMethod" "glamor"
EndSection
```
