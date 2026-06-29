# UniVLA LIBERO Reproduction

This repository records my local reproduction of the UniVLA LIBERO evaluation

## 1. Setup Environment

I set up the UniVLA codebase together with the LIBERO benchmark environment.

```bash
conda create -n univla python=3.10 -y
conda activate univla

pip install torch torchvision
pip install -e .

pip install packaging ninja
pip install "flash-attn==2.5.5" --no-build-isolation

cd LIBERO
pip install -r requirements.txt
pip install -e .
cd ..
```

For evaluation, I used the local LIBERO package by setting `PYTHONPATH` in [vla-scripts/evaluate.sh](vla-scripts/evaluate.sh).

## 2. Download Model

I downloaded the UniVLA LIBERO checkpoint from Hugging Face and placed it under:

```text
univla-7b-224-sft-libero/univla-libero-10
```

The downloaded checkpoint contains the model weights, tokenizer/config files, dataset statistics, and action decoder:

```text
univla-7b-224-sft-libero/univla-libero-10/action_decoder.pt
univla-7b-224-sft-libero/univla-libero-10/model-00001-of-00004.safetensors
univla-7b-224-sft-libero/univla-libero-10/model-00002-of-00004.safetensors
univla-7b-224-sft-libero/univla-libero-10/model-00003-of-00004.safetensors
univla-7b-224-sft-libero/univla-libero-10/model-00004-of-00004.safetensors
```

## 3. Run Experiment

I evaluated the LIBERO-10 task suite with 50 trials per task and saved rollout videos.

```bash
bash vla-scripts/evaluate.sh
```

The evaluation command used was:

```bash
export PYTHONPATH=/mnt/hdd/Linh/philo/code/UniVLA/LIBERO:$PYTHONPATH
python experiments/robot/libero/run_libero_eval.py \
    --task_suite_name libero_10 \
    --action_decoder_path univla-7b-224-sft-libero/univla-libero-10/action_decoder.pt \
    --pretrained_checkpoint univla-7b-224-sft-libero/univla-libero-10 \
    --save_video true \
    --num_trials_per_task 50 \
    --seed 7
```

The rollout videos were saved in:

```text
rollouts/2026_06_29
```

## 4. Results

The evaluation produced 500 rollouts across 10 LIBERO-10 tasks. The overall success rate was:

```text
442 / 500 = 0.884
```

### Rollout Videos

Two successful and two failed rollout examples are shown below.

<table>
  <tr>
    <td align="center"><b>Success 1</b></td>
    <td align="center"><b>Success 2</b></td>
  </tr>
  <tr>
    <td>
      <video src="https://github.com/user-attachments/assets/cdc159d2-96aa-4484-a4b3-bd917ce86c1d" style="object-fit:cover;" autoplay loop muted></video></video>
    </td>
    <td>
      <video src="https://github.com/user-attachments/assets/1daac795-cbc7-49bb-8ed5-8f99c7d39195" style="object-fit:cover;" autoplay loop muted></video></video>
    </td>
  </tr>
  <tr>
    <td align="center"><b>Failure 1</b></td>
    <td align="center"><b>Failure 2</b></td>
  </tr>
  <tr>
    <td>
      <video src="https://github.com/user-attachments/assets/55091bac-4a3c-483b-87a3-46d16d9cd54a" style="object-fit:cover;" autoplay loop muted></video></video>
    </td>
    <td>
      <video src="https://github.com/user-attachments/assets/81a19594-4e92-4c13-bc4d-f82478930af2" style="object-fit:cover;" autoplay loop muted></video></video>
    </td>
  </tr>
</table>

### Success Rate

| Task | Successes | Failures | Total | Success Rate |
| --- | ---: | ---: | ---: | ---: |
| pick_up_the_book_and_place_it_in_the_back_compartm | 43 | 7 | 50 | 86.0% |
| put_both_moka_pots_on_the_stove | 34 | 16 | 50 | 68.0% |
| put_both_the_alphabet_soup_and_the_cream_cheese_bo | 46 | 4 | 50 | 92.0% |
| put_both_the_alphabet_soup_and_the_tomato_sauce_in | 47 | 3 | 50 | 94.0% |
| put_both_the_cream_cheese_box_and_the_butter_in_th | 50 | 0 | 50 | 100.0% |
| put_the_black_bowl_in_the_bottom_drawer_of_the_cab | 49 | 1 | 50 | 98.0% |
| put_the_white_mug_on_the_left_plate_and_put_the_ye | 37 | 13 | 50 | 74.0% |
| put_the_white_mug_on_the_plate_and_put_the_chocola | 42 | 8 | 50 | 84.0% |
| put_the_yellow_and_white_mug_in_the_microwave_and_ | 44 | 6 | 50 | 88.0% |
| turn_on_the_stove_and_put_the_moka_pot_on_it | 50 | 0 | 50 | 100.0% |
| **Overall** | **442** | **58** | **500** | **88.4%** |

The full CSV result is available at [rollouts/2026_06_29/success_rates.csv](rollouts/2026_06_29/success_rates.csv).
