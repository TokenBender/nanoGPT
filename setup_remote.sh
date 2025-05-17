#!/usr/bin/env bash
# Setup script for nanoGPT on a fresh machine
# Creates a virtual environment, installs dependencies, and prepares sample data.
# Usage: bash setup_remote.sh
set -e

# create virtual environment
if [ ! -d ".venv" ]; then
    python3 -m venv .venv
fi
source .venv/bin/activate

# upgrade pip and install required packages
pip install --upgrade pip
pip install torch numpy transformers datasets tiktoken wandb tqdm jupyter

# fetch the small Shakespeare dataset as a quick test
python data/shakespeare_char/prepare.py

echo "\nSetup complete. Activate with 'source .venv/bin/activate' and run 'jupyter notebook repo_overview.ipynb' to explore the tutorial."
