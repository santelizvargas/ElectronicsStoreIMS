# IOS Backend project

## Installation

Configure the repository environment and clone the repository (Recommended):

```bash
PATH="~/Developer/pplam/"
mkdir -p "$PATH" && cd "$PATH"

git clone https://github.com/pplam/ElectronicsStoreIMS
cd ElectronicsStoreIMS
```

### Setup (Recommended)

Run the `docker compose` command to initialize the FastAPI server:

```bash
cd ims-backend
docker compose up --build -d
```

### Setup (Manual)

Create the python venv (virtual environment) to install the dependencies:

```bash
python3 -m venv venv

# Or

python -m venv venv
```

Active the venv using the following command:

```bash
. ./venv/bin/activate
```

Install the python dependencies:

```bash
pip install -r requirements.txt
```

Run the server

```bash
cd app
python3 -m uvicorn main:app --reload
```

> © 2024 PPLAM S.A. All Rights Reserved
