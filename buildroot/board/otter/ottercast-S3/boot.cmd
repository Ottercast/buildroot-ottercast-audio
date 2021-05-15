setenv dtb_loadaddr 0x41000000
setenv kernel_loadaddr 0x41100000

led led:usr on
led led:pwr on

# Initialize i2c bus 1
i2c dev 0

# Default to OtterCast Amp
setenv fdtfile sun8i-s3-ottercast-amp.dtb
# Switch to OtterCast Audio V2 if SSM2603 codec detected on i2c bus
if i2c probe 0x1b; then
	echo "SSM2603 codec detected, this is an OtterCast Audio V2"
	setenv fdtfile sun8i-s3-ottercast-audio-v2.dtb
fi

setexpr rootpart ${distro_bootpart} + 1 || rootpart=4
part uuid ${devtype} ${devnum}:${rootpart} rootuuid
setenv bootargs initcall_debug root=PARTUUID=${rootuuid} ro rootwait earlycon fbcon=rotate:3
load ${devtype} ${devnum}:${distro_bootpart} ${kernel_loadaddr} zImage
load ${devtype} ${devnum}:${distro_bootpart} ${dtb_loadaddr} ${fdtfile}

# Check for a MAC address extracted from efuse
if test -n ${ethaddr}; then
	# Parse MAC address, Linux expects an uint8_t array
	setexpr ethaddr_components gsub ':' ' 0x' [0x${ethaddr}]
	# Setup fdt modification
	fdt addr ${dtb_loadaddr}
	# Make some space for the extra property
	fdt resize 128
	# Insert MAC address into dtb
	fdt set /soc/ethernet@1c30000 local-mac-address ${ethaddr_components}
fi

bootz ${kernel_loadaddr} - ${dtb_loadaddr}
