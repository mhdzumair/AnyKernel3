#!/system/bin/sh

# (c) 2020 MhDzMR-Kernel

#set charging led enable
echo "battery-charging" > /sys/class/leds/red/trigger;

# Set TCP congestion algorithm
#echo "westwood" > /proc/sys/net/ipv4/tcp_congestion_control

# Tweak IO performance after boot complete
echo "zen" > /sys/block/mmcblk0/queue/scheduler
echo 512 > /sys/block/mmcblk0/queue/read_ahead_kb

