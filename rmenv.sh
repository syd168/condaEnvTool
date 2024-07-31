#!/bin/bash

# Set parameters
ENV_NAME=$1
CONDA_PATH=~/workspace/anaconda3  # Adjust the Conda path according to your setup

# Check if the environment name is provided
if [ -z "$ENV_NAME" ]; then
  echo "Usage: $0 <env_name>"
  exit 1
fi

# Check if the environment exists
EXISTING_ENV=$($CONDA_PATH/bin/conda env list | grep "^$ENV_NAME\s" | wc -l)
if [ "$EXISTING_ENV" -eq 0 ]; then
  echo "Environment '$ENV_NAME' does not exist."
  exit 1
fi

# Remove the Conda environment
$CONDA_PATH/bin/conda env remove -n $ENV_NAME
if [ $? -ne 0 ]; then
  echo "Failed to remove environment '$ENV_NAME'."
  exit 1
fi
echo "Conda environment '$ENV_NAME' removed successfully."

# Remove the Jupyter kernel
KERNEL_PATH=~/.local/share/jupyter/kernels/$ENV_NAME
if [ -d "$KERNEL_PATH" ]; then
  rm -rf "$KERNEL_PATH"
  if [ $? -ne 0 ]; then
    echo "Failed to remove Jupyter kernel for environment '$ENV_NAME'."
    exit 1
  fi
  echo "Jupyter kernel for environment '$ENV_NAME' removed successfully."
else
  echo "No Jupyter kernel found for environment '$ENV_NAME'."
fi

echo "Environment and Jupyter kernel cleanup completed."
