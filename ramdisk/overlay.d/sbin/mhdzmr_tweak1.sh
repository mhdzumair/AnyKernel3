#!/system/bin/sh

# (c) 2020 MhDzMR-Kernel

#set charging led enable
echo "battery-charging" > /sys/class/leds/red/trigger;

# Enable usb fast charge
echo 1 > /sys/kernel/fast_charge/force_fast_charge

# Set min cpu freq
echo 576000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq

# Set TCP congestion algorithm
echo "westwood" > /proc/sys/net/ipv4/tcp_congestion_control

# vm tweaks
echo 2884 > /proc/sys/vm/min_free_kbytes;
echo 0 > /proc/sys/vm/swappiness;

# fs tweaks
echo 10 > /proc/sys/fs/lease_break_time;

# entropy tweaks
echo 128 > /proc/sys/kernel/random/read_wakeup_threshold;
echo 256 > /proc/sys/kernel/random/write_wakeup_threshold;
 
