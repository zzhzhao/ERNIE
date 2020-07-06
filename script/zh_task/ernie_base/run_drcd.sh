set -eux

export FLAGS_eager_delete_tensor_gb=0
export FLAGS_sync_nccl_allreduce=1
export CUDA_VISIBLE_DEVICES=0,1,2,3,4,5,6,7

export PYTHONPATH=./ernie:${PYTHONPATH:-}
python ./ernie/run_mrc.py --use_cuda true\
                    --batch_size 16 \
                    --in_tokens false\
                    --use_fast_executor true \
                    --checkpoints ./checkpoints \
                    --vocab_path /ERNIE_model/vocab.txt  \
                    --ernie_config_path /ERNIE_model/ernie_config.json \
                    --do_train true \
                    --do_val false \
                    --do_test true \
                    --verbose true \
                    --save_steps 1000 \
                    --validation_steps 100 \
                    --warmup_proportion 0.0 \
                    --weight_decay  0.01 \
                    --epoch 1 \
                    --max_seq_len 512 \
                    --max_query_length 80 \
                    --max_answer_length 80 \
                    --do_lower_case true \
                    --doc_stride 128 \
                  	--train_set ./dataset/score_1000/train_single_1000.json \
                    --dev_set ./dataset/origin/no.json \
                  	--test_set ./dataset/score_1000/simp_train_test_second_answer.json \
                    --learning_rate 5e-5 \
                    --num_iteration_per_drop_scope 1 \
                    --init_pretraining_params /ERNIE_model/params \
                    --skip_steps 10
