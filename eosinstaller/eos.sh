#!/bin/bash
echo "Creating a conda environment"
conda create -n ersilia python=3.10 -y
echo "Activating ersilia"
conda activate ersilia
echo "Cloning ersilia repository"
git clone https://github.com/ersilia-os/ersilia.git
# change directory
cd ersilia
echo "install with pip"
pip install -e .
echo "Preparing to fetch the model"
#sleep 1m # Waits 1 minute
echo "Fetching the model"
ersilia fetch retrosynthetic-accessibility -y
echo "Generating example molecules"
ersilia example retrosynthetic-accessibility -n 5 -f my_molecules.csv
echo "Serving the model"
ersilia serve retrosynthetic-accessibility
echo "Running the model..."
ersilia run -i my_molecules.csv -o my_predictions.csv