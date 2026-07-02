#!/bin/bash

# 제안 방법론 실험을 위한 스크립트: 4사분면 디커플링 보상 전략 (decouple)
# Task: robosuite_door

# 공통 인자 설정
COMMON_ARGS="--domain_name robosuite_door \
  --reward_type sparse --cameras 0 1 --frame_stack 1 --num_updates 1 \
  --observation_type pixel --encoder_type pixel \
  --pre_transform_image_size 128 --image_size 112 --agent dino_e2c_sac \
  --critic_lr 0.001 --actor_lr 0.001 --eval_freq 2000 --batch_size 128 \
  --num_train_steps 100000 --save_tb --save_video --replay_buffer_load_dir ./demo/robosuite_door/10 \
  --replay_buffer_keep_loaded --init_steps 0 --save_sac --conv_layer_norm \
  --v_clip_low -100 --v_clip_high 100 --seed 1 --num_eval_episodes 20 --encoder_feature_dim 32 \
  --final_demo_density 0.15"

echo "=== 제안 방법론(decouple) 실험 시작 (door) ==="
python train.py $COMMON_ARGS --work_dir ./data/robosuite_door/lane_dino_decouple --reward_camera decouple

echo "실험이 완료되었습니다. tensorboard --logdir ./data/robosuite_door/lane_dino_decouple 로 결과를 확인하세요."
