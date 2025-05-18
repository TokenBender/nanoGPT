# Learning Flow for nanoGPT

Welcome to this mini curriculum on exploring **nanoGPT**.

## 1. Start With the README

The [`README.md`](README.md) is your first stop. It explains how this repo reproduces GPT‑2 results with a relatively small codebase. You’ll see that `train.py` (~300 lines) implements the main training loop, while `model.py` (~300 lines) defines the model.

Consider skimming the sections on [training Shakespeare models](README.md) and the more serious [OpenWebText training](README.md) to get a feel for what resources you'll need.

## 2. Data Preparation

The `data/` directory contains small utilities to download and tokenize datasets. For instance, `data/shakespeare/prepare.py` and `data/openwebtext/prepare.py` will generate `train.bin` and `val.bin` files. These scripts rely on the same tokenizer as OpenAI’s GPT‑2.

## 3. Training Scripts and Configs

- `train.py` — the core training loop. It supports running on a single GPU as well as multi‑GPU setups via PyTorch DDP. 

- `config/` — houses example config files like `train_shakespeare_char.py` for quick experiments and `train_gpt2.py` for heavier runs. Open one of these files and trace through the hyperparameters. 

Feel free to tweak a config and run `python train.py config/your_config.py` to see the effects.

## 4. Sampling and Evaluation

After training, use `sample.py` to generate text. The script can load either your own checkpoints (`--out_dir=...`) or an OpenAI GPT‑2 model with `--init_from=gpt2` options.

For baseline numbers, note the evaluation configs such as `eval_gpt2_medium.py`. These replicate published GPT‑2 models on OpenWebText.

## 5. Understanding the Model

`model.py` defines the GPT architecture with optional support for loading GPT‑2 weights.

## 6. Benchmarks and Efficiency

Check out `bench.py` for lightweight benchmarking. The README also talks about using PyTorch 2.0’s `torch.compile` to cut iteration time nearly in half.

