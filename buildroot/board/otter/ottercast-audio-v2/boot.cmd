setenv bootargs console=ttyS0,115200 panic=5 console=tty0 rootwait root=/dev/mmcblk0p2 initcall_debug earlyprintk earlycon rw
load mmc 0:1 0x41000000 zImage
load mmc 0:1 0x41800000 sun8i-s3-ottercast-audio-v2.dtb
bootz 0x41000000 - 0x41800000
