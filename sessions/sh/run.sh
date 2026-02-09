```bash
#!/bin/bash

# Create project directory
mkdir -p aero_math_internship
cd aero_math_internship

# Create and activate virtual environment
python3 -m venv venv
source venv/bin/activate

# Create requirements.txt if not exists
if [ ! -f requirements.txt ]; then
    echo "numpy" > requirements.txt
    echo "matplotlib" >> requirements.txt
    echo "scipy" >> requirements.txt
fi

# Install requirements
pip install -r requirements.txt

# Instructions
echo "Setup complete! To proceed:"
echo "1. Open VS Code in this directory: code ."
echo "2. In VS Code terminal, activate venv if needed: source venv/bin/activate"
echo "3. Create or edit Python files (e.g., session1.py) and paste code."
echo "4. Run scripts: python session1.py (or whichever file)"
```