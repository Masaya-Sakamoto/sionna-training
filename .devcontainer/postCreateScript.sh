#!/bin/bash

WORKSPACE_DIR=$(pwd)

# Install nbstripout to clean notebook outputs on commit
nbstripout --install --attributes .gitattributes

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

# add astral-uv venv activation to bashrc
echo 'source ./.venv/bin/activate' >> ~/.bashrc