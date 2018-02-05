source: https://forum.ubuntu-tr.net/index.php?topic=57290.msg630470#msg630470


```
sudo modprobe  -rv rtl8723be
sudo modprobe -v rtl8723be ant_sel=1
echo "options rtl8723be ant_sel=1" | sudo tee /etc/modprobe.d/50-rtl8723be.conf
```