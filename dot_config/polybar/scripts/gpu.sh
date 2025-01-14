#!/usr/bin/env bash
gpu_usage=`nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits`
printf "  🎮 ${gpu_usage}%%  "
