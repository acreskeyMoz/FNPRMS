#!/usr/bin/env bash

iamhere=${BASH_SOURCE%/*}
iwashere=`pwd`
iamhere=${iamhere/./${iwashere}}
cd ${iamhere}

. common.sh

log_dir=/home/hawkinsw/run_logs/
test_date=`date +"%Y.%m.%d"`
log_base=${test_date}
run_log="${log_dir}/${log_base}.log"

maybe_create_file ${run_log}


{
  ./times.py --input_dir ${log_dir} --output_dir ${log_dir}
} >> ${run_log} 2>&1

cwd=`pwd`
cd ${log_dir}
git add *.csv
git add *.log
git commit -m "${log_base} update stats"
git push fenix-mobile master -q
cd ${cwd}

cd ${iwashere}
