export PYTHONPATH=/mnt/hdd/Linh/philo/code/UniVLA/LIBERO:$PYTHONPATH
python experiments/robot/libero/run_libero_eval.py \
    --task_suite_name libero_10 \
    --action_decoder_path univla-7b-224-sft-libero/univla-libero-10/action_decoder.pt \
    --pretrained_checkpoint univla-7b-224-sft-libero/univla-libero-10 \
    --save_video true \
    --num_trials_per_task 50 \
    --seed 7