buildroot external tree
=======================

This directory contains a buildroot external tree for the OtterCast family of devices.
Clone this repo next to your buildroot tree.

Use this tree by specifying it in the buildroot build command:

`make BR2_EXTERNAL=../buildroot-ottercast-audio/buildroot/ ottercast_s3_defconfig`
