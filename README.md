# network-setup-mode-trigger-os


## Usage

1. Downaload the provided ISO
2. Copy it onto an USB Stick (for example https://etcher.balena.io/ could be used)
3. Interrupt your normal Boot and instead boot from the USB
4. once booted type `sudo send-network-request eth0` to start sending the reset packages on the specified interface
5. connect the wired Network Port of your PC to the unpowered side of an PoE Injector (please do at least a tripple check)
6. connect your AP to the powered side of the PoE Injector, wait a few seconds
7. press Ctrl+C to abort sending the packages
8. (optional) after a while you should be able to ssh into your device with `ssh root@192.168.1.1`. You can terminate the connection with `exit`
9. type "sudo systemctl poweroff" to turn your PC off
10. remove the USB stick and start your PC as you normaly would
11. until the AP loses power it's in the Setup/Config Mode and can be accessed as any other Freifunk Router via 192.168.1.1

