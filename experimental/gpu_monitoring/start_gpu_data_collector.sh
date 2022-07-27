#!/bin/bash

HOSTLIST=hostlist
INTERVAL_SECS=10
DCGM_FIELD_IDS="203,252,1004"
#FORCE_GPU_MONITORING="-fgm"
#IB_METRICS='-ibm'
#ETH_METRICS='-ethm'
#NFS_METRICS='-nfsm'
LOG_ANALYTICS_CUSTOMER_ID=''
LOG_ANALYTICS_SHARED_KEY=''
export PDSH_RCMD_TYPE=ssh
CWD=`pwd`
EXE_PATH="${CWD}/gpu_data_collector.py $FORCE_GPU_MONITORING $IB_METRICS $ETH_METRICS $NFS_METRICS -tis $INTERVAL_SECS -dfi $DCGM_FIELD_IDS >> /tmp/gpu_data_collector.log"

cat << EOF > ${CWD}/run_gpu_monitor.sh
#!/bin/bash
export LOG_ANALYTICS_CUSTOMER_ID="$LOG_ANALYTICS_CUSTOMER_ID"
export LOG_ANALYTICS_SHARED_KEY="$LOG_ANALYTICS_SHARED_KEY"
$EXE_PATH
EOF

chmod 777 ${CWD}/run_gpu_monitor.sh

WCOLL=$HOSTLIST pdsh "sudo nohup ${CWD}/run_gpu_monitor.sh &"
