#!/bin/bash

# Set parameters
ENV_NAME=$1
PYTHON_VERSION=$2
CONDA_PATH=~/workspace/anaconda3  # Adjust the Conda path according to your setup

echo "===========================tools for creating  conda envirement==========================="


echo "Checking if the parameters are valid..."

# Check if parameters are provided
if [ -z "$ENV_NAME" ] || [ -z "$PYTHON_VERSION" ]; then
  echo "Error: Missing parameters! Usage: $0 <env_name> <python_version>"
  exit 1
fi
echo "Parameters are valid: Environment name to create: $ENV_NAME, Python version: $PYTHON_VERSION"

# Update conda and all packages (commented out for now)
# $CONDA_PATH/bin/conda update -n base -c defaults conda -y
# $CONDA_PATH/bin/conda update --all -y

# Check if the environment already exists
echo "Checking if the environment '$ENV_NAME' already exists..."
EXISTING_ENV=$($CONDA_PATH/bin/conda env list | grep "^$ENV_NAME\s" | wc -l)
if [ "$EXISTING_ENV" -gt 0 ]; then
  echo "The environment '$ENV_NAME' already exists!"
  exit 1
fi
echo "Environment does not exist."

# Check if the specified Python version is available
echo "Checking if Python $PYTHON_VERSION is available..."
# Use dry-run to check if the Python version is available
$CONDA_PATH/bin/conda create -n $ENV_NAME python=$PYTHON_VERSION --dry-run -y > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "Specified Python version '$PYTHON_VERSION' is not available or compatible."
  echo "Please specify a different Python version and try again."
  exit 1
fi
echo "Python $PYTHON_VERSION is available!"

# Create the virtual environment
$CONDA_PATH/bin/conda create -n $ENV_NAME python=$PYTHON_VERSION -y
if [ $? -ne 0 ]; then
  echo "Failed to create the environment '$ENV_NAME' with Python version '$PYTHON_VERSION'."
  exit 1
fi

# Activate the virtual environment and install ipykernel
echo "Activating the environment '$ENV_NAME'..."
source $CONDA_PATH/bin/activate $ENV_NAME

echo "Installing ipykernel..."
conda install ipykernel -y


# Deactivate the current environment and activate the base environment
source $CONDA_PATH/bin/deactivate
source $CONDA_PATH/bin/activate base
python -m ipykernel install --user --name=$ENV_NAME --display-name="$ENV_NAME-python$PYTHON_VERSION"

# Modify the kernel.json file
KERNEL_PATH=~/.local/share/jupyter/kernels/$ENV_NAME/kernel.json

# Use sed to modify the kernel.json file
sed -i "3s|.*|\"${CONDA_PATH}/envs/${ENV_NAME}/bin/python\",|" $KERNEL_PATH
sed -i "s|\"display_name\": \".*\"|\"display_name\": \"${ENV_NAME}_python${PYTHON_VERSION}\"|" $KERNEL_PATH

echo "Conda environment '$ENV_NAME' with Python $PYTHON_VERSION has been successfully created and registered in Jupyter."

