# Tool for Conda Environment and  jupyter auto Setup

This script automates the creation of a Conda virtual environment, installs the necessary packages, and registers the environment with Jupyter.

## Features
- Create Conda Environment: Automatically create a new Conda environment with a specified name and Python version.
- Install ipykernel: Install the ipykernel package in the environment to enable Jupyter integration.
- Jupyter Integration: Register the newly created environment as a kernel in Jupyter with a custom display name.
- Safety Checks: Ensures that the specified Python version is available and that the environment does not already exist.


## Usage

### Clone the Repository:
```
git clone https://github.com/syd168/condaEnvTool.git
cd condaEnvTool
```
### Prerequisites

- **Conda**: Ensure Conda is installed and properly configured. The script assumes Conda is located at `~/workspace/anaconda3`. Modify the `CONDA_PATH` variable if necessary.

### Running the Script

1. **Make the Script Executable**:
    ```bash
    chmod +x mkenv.sh  rmenv.sh
    ```

2. **Execute the Script**:
    ```bash
    ./mkenv.sh <env_name> <python_version>
    ```
    - `<env_name>`: The name of the Conda environment to create.
    - `<python_version>`: The Python version for the environment (e.g., 3.8, 3.9).
3. **Remove the Conda environment and its corresponding Jupyter Notebook kernel.**:
    ```bash
    ./rmenv.sh <env_name> 
    ```
    - `<env_name>`: The name of the Conda environment to create.
### Example --create env

```bash
./mkenv.sh myenv 3.9
```
!["create env"]("create.png")

### Example --remove env

```bash
./rmenv.sh myenv
```
!["create env"]("remove.png")


