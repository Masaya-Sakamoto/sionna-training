#!/bin/bash

# Install nbstripout to clean notebook outputs on commit
nbstripout --install --attributes .gitattributes

# Install Nvidia OptiX SDK
chmod +x .devcontainer/NVIDIA-OptiX-SDK-9.0.0-linux64-x86_64.sh
.devcontainer/NVIDIA-OptiX-SDK-9.0.0-linux64-x86_64.sh ----skip-license

# Initialize repository as an astral-uv project if not already initialized
if [ ! -f "./pyproject.toml" ]; then
    uv init
fi

# Create an astral-uv virtual environment if the virtual environment does not exist
if [ ! -d "./.venv" ]; then
    uv venv --python 3.12
fi

# Activate the virtual environment and install dependencies
source ./.venv/bin/activate
uv sync
uv add numpy pandas matplotlib jupyterlab sionna

# add astral-uv venv activation to bashrc
echo 'source ./.venv/bin/activate' >> ~/.bashrc

# check nvidia-smi
echo $(nvidia-smi) > nvidia-smi.out.txt