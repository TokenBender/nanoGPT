# Learning Flow for nanoGPT

Welcome to this mini curriculum on exploring **nanoGPT**. The goal is to walk through the repository as if we're in a lively graduate class—annotating, questioning, and challenging each step. Feel free to treat this guide like a conversation with your instructors and peers.

## 1. Start With the README

The [`README.md`](README.md) is your first stop. It explains how this repo reproduces GPT‑2 results with a relatively small codebase. You’ll see that `train.py` (~300 lines) implements the main training loop, while `model.py` (~300 lines) defines the model. **Ask yourself:**

- *Why keep things so compact?* 
- *What are the trade‑offs of minimalism versus feature completeness?* 

Consider skimming the sections on [training Shakespeare models](README.md) and the more serious [OpenWebText training](README.md) to get a feel for what resources you'll need.

## 2. Data Preparation

The `data/` directory contains small utilities to download and tokenize datasets. For instance, `data/shakespeare/prepare.py` and `data/openwebtext/prepare.py` will generate `train.bin` and `val.bin` files. These scripts rely on the same tokenizer as OpenAI’s GPT‑2. **Questions to ponder:**

- *Why does the repo choose GPT‑2’s tokenizer over a more modern one?*
- *What might be the pros and cons of preprocessing the entire dataset upfront?*

Try running one of these prep scripts yourself to see how much disk space and time they require. Notice how the code comments discuss dataset size and expected runtime.

## 3. Training Scripts and Configs

- `train.py` — the core training loop. It supports running on a single GPU as well as multi‑GPU setups via PyTorch DDP. **Skeptical thought:** *How readable is the distributed code path? Could we further simplify it?*

- `config/` — houses example config files like `train_shakespeare_char.py` for quick experiments and `train_gpt2.py` for heavier runs. Open one of these files and trace through the hyperparameters. Ask your peers:
    - *Why these particular defaults?* 
    - *How sensitive is training to each value?* 

Feel free to tweak a config and run `python train.py config/your_config.py` to see the effects.

## 4. Sampling and Evaluation

After training, use `sample.py` to generate text. The script can load either your own checkpoints (`--out_dir=...`) or an OpenAI GPT‑2 model with `--init_from=gpt2` options. **Potential experiment:** Compare qualitative samples from a freshly trained model versus a finetuned GPT‑2 checkpoint. Which looks more coherent?

For baseline numbers, note the evaluation configs such as `eval_gpt2_medium.py`. These replicate published GPT‑2 models on OpenWebText. Ask:

- *Does our small codebase faithfully reproduce OpenAI’s numbers?* 
- *Where might training diverge or degrade?*

## 5. Understanding the Model

`model.py` defines the GPT architecture with optional support for loading GPT‑2 weights. It’s worth reading line by line to understand self‑attention, positional embeddings, and residual blocks. **Challenge:** Pick a section you find confusing and explain it back to the class. Be ready to poke holes in any assumptions you notice.

## 6. Benchmarks and Efficiency

Check out `bench.py` for lightweight benchmarking. The README also talks about using PyTorch 2.0’s `torch.compile` to cut iteration time nearly in half. Skeptical question: *Is `torch.compile` always beneficial, or are there cases where it backfires?* Try toggling the `--compile` flag to see for yourself.

## 7. Extensions and Open Problems

The repository lists several **todos**, ranging from investigating FSDP to incorporating alternative embeddings. Treat these as open research prompts. Which one would you prioritize? Why? Discuss in small groups and see which ideas spark the most interest.

## 8. Troubleshooting and Community

The README links to a Discord channel and references Andrej Karpathy’s "Zero to Hero" series. If you run into issues or want to deepen your understanding, those resources can help. **A final question to keep in mind:**

- *How does nanoGPT’s simplicity influence its usability for both newcomers and experts?*

Feel free to document your experiments and share insights with others. Happy hacking!
