#!/bin/bash

# 비교 실험을 위한 스크립트: 기존 방식(both) vs 손목 카메라 전용(wrist)
# Task: robosuite_pick_place_can

# 공통 인자 설정
COMMON_ARGS="--domain_name robosuite_pick_place_can \
  --reward_type sparse --cameras 0 1 --frame_stack 1 --num_updates 1 \
  --observation_type pixel --encoder_type pixel \
  --pre_transform_image_size 128 --image_size 112 --agent dino_e2c_sac \
  --critic_lr 0.001 --actor_lr 0.001 --eval_freq 2000 --batch_size 128 \
  --num_train_steps 250000 --save_tb --save_video --replay_buffer_load_dir ./demo/robosuite_pick_place_can/20 \
  --replay_buffer_keep_loaded --init_steps 0 --save_sac --conv_layer_norm \
  --v_clip_low -100 --v_clip_high 100 --seed 1 --num_eval_episodes 20 --encoder_feature_dim 32 \
  --final_demo_density 0.2"

echo "=== [1/2] 손목 카메라(wrist) 전용 실험 시작 (pick_place_can) ==="
# GPU 자원 경합 및 연산 비결정성 문제 방지를 위해 순차 실행합니다.
python train.py $COMMON_ARGS --work_dir ./data/robosuite_pick_place_can/lane_dino_wrist --reward_camera wrist

echo "=== [2/2] 기존 방식(both) 실험 시작 (pick_place_can) ==="
python train.py $COMMON_ARGS --work_dir ./data/robosuite_pick_place_can/lane_dino_both --reward_camera both

echo "모든 실험이 완료되었습니다. tensorboard --logdir ./data/robosuite_pick_place_can 로 결과를 확인하세요."
