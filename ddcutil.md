
```
echo "i2c-dev" > /etc/modules-load.d/i2c-dev.conf
```

```
sudo usermod -G i2c -a <username>
```

current brightness

```
ddcutil -d 1 getvcp 10
```

current contrast

```
ddcutil -d 1 getvcp 12
```

inc

```
ddcutil -d 1 setvcp 10 +5
```

dec


```
ddcutil -d 1 setvcp 10 - 5
```
