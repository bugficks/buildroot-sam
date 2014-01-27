#!/bin/sh

echo "network_init start"

# insmod net driver 
insmod /lib/modules/mdrv-emac.ko

# local loopback
ifconfig lo 127.0.0.1

#!/bin/sh

echo "network_init start"

# insmod net driver 
insmod /lib/modules/mdrv-emac.ko

# local loopback
ifconfig lo 127.0.0.1

