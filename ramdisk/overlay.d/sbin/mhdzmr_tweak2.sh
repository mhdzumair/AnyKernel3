#!/system/bin/sh
# 11-Jun-2013 by Franco's Dev Team
# malaroth, osm0sis, joaquinf, The Gingerbread Man, pkgnex, Khrushy, shreddintyres

# (c) 2020 MhDzMR-Kernel

# disable sysctl.conf to prevent ROM interference
if [ -e /system/etc/sysctl.conf ]; then
  mount -o remount,rw /system;
  mv /system/etc/sysctl.conf /system/etc/sysctl.conf.fkbak;
  mount -o remount,ro /system;
fi;

# general queue tweaks
for i in /sys/block/*/queue; do
  echo 512 > $i/nr_requests;
  echo 512 > $i/read_ahead_kb;
  echo 2 > $i/rq_affinity;
  echo 0 > $i/nomerges;
  echo 0 > $i/add_random;
  echo 0 > $i/rotational;
done;

# override scheduler defaults with tweaked values
scheduler=reset;
while sleep 1; do
  current=`cut -d\[ -f2 /sys/block/mmcblk0/queue/scheduler | cut -d\] -f1`;
  if [ $scheduler != $current ]; then
    scheduler=$current;
    if [ $scheduler == "deadline" ]; then

# deadline tweaks
echo 250 > /sys/block/mmcblk0/queue/iosched/read_expire;
echo 2500 > /sys/block/mmcblk0/queue/iosched/write_expire;
echo 1 > /sys/block/mmcblk0/queue/iosched/writes_starved;
echo 1 > /sys/block/mmcblk0/queue/iosched/front_merges;
echo 8 > /sys/block/mmcblk0/queue/iosched/fifo_batch;

    elif [ $scheduler == "row" ]; then

# row tweaks
echo 100 > /sys/block/mmcblk0/queue/iosched/hp_read_quantum;
echo 75 > /sys/block/mmcblk0/queue/iosched/rp_read_quantum;
echo 5 > /sys/block/mmcblk0/queue/iosched/hp_swrite_quantum;
echo 4 > /sys/block/mmcblk0/queue/iosched/rp_swrite_quantum;
echo 4 > /sys/block/mmcblk0/queue/iosched/rp_write_quantum;
echo 3 > /sys/block/mmcblk0/queue/iosched/lp_read_quantum;
echo 12 > /sys/block/mmcblk0/queue/iosched/lp_swrite_quantum;
echo 10 > /sys/block/mmcblk0/queue/iosched/read_idle;
echo 25 > /sys/block/mmcblk0/queue/iosched/read_idle_freq;
## N4 and N10 row adds lsl and rsl, which were hardcoded previously
echo 10000 > /sys/block/mmcblk0/queue/iosched/low_starv_limit;
echo 5000 > /sys/block/mmcblk0/queue/iosched/reg_starv_limit;
## N4 has a new version of row with corrected entry for lsq and renamed ri and rif
[ `cat /sys/block/mmcblk0/queue/iosched/lp_swrite_quantum` != "2" ] && echo 2 > /sys/block/mmcblk0/queue/iosched/lp_swrite_quantum;
echo 10 > /sys/block/mmcblk0/queue/iosched/rd_idle_data;
echo 25 > /sys/block/mmcblk0/queue/iosched/rd_idle_data_freq;

    elif [ $scheduler == "cfq" ]; then

# cfq tweaks
echo 4 > /sys/block/mmcblk0/queue/iosched/quantum;
echo 80 > /sys/block/mmcblk0/queue/iosched/fifo_expire_sync;
echo 330 > /sys/block/mmcblk0/queue/iosched/fifo_expire_async;
echo 12582912 > /sys/block/mmcblk0/queue/iosched/back_seek_max;
echo 1 > /sys/block/mmcblk0/queue/iosched/back_seek_penalty;
echo 60 > /sys/block/mmcblk0/queue/iosched/slice_sync;
echo 50 > /sys/block/mmcblk0/queue/iosched/slice_async;
echo 2 > /sys/block/mmcblk0/queue/iosched/slice_async_rq;
echo 0 > /sys/block/mmcblk0/queue/iosched/slice_idle;
echo 0 > /sys/block/mmcblk0/queue/iosched/group_idle;
echo 1 > /sys/block/mmcblk0/queue/iosched/low_latency;
## N4 and N10 cfq adds tl, which was hardcoded previously
echo 300 > /sys/block/mmcblk0/queue/iosched/target_latency;

    fi;
  fi;
# loop forever independently
done&
