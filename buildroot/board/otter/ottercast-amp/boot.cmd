setenv dtb_loadaddr 0x41800000
setenv kernel_loadaddr 0x41000000

led led:usr on
led led:pwr on

setexpr rootpart ${distro_bootpart} + 1 || rootpart=4
part uuid ${devtype} ${devnum}:${rootpart} rootuuid
setenv bootargs initcall_debug root=PARTUUID=${rootuuid} rw rootwait earlycon
load ${devtype} ${devnum}:${distro_bootpart} ${kernel_loadaddr} zImage
load ${devtype} ${devnum}:${distro_bootpart} ${dtb_loadaddr} ${fdtfile}
bootz ${kernel_loadaddr} - ${dtb_loadaddr}
