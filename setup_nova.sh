#!/data/data/com.termux/files/usr/bin/bash

echo "🔧 Setting up NOVA..."

# Step 1: Fix U+00A0 characters
if [ -f "NOVA.py" ]; then
    echo "🔍 Cleaning NOVA.py..."
    tr -d '\302\240' < NOVA.py > clean_NOVA.py && mv clean_NOVA.py NOVA.py
else
    echo "❌ NOVA.py not found in current directory."
    exit 1
fi

# Step 2: Ensure Python is installed
if ! command -v python > /dev/null 2>&1; then
    echo "🐍 Installing Python..."
    pkg install -y python
else
    echo "🐍 Python already installed."
fi

# Step 3: Install required Python packages
echo "📦 Installing Python dependencies..."
pip install --upgrade pip
pip install requests

# Step 4: Create partial_conscience.py if missing
if [ ! -f "partial_conscience.py" ]; then
    echo "🧠 Generating partial_conscience.py..."
    python -c "
import os

PARTIAL_CONSCIENCE_CODE = '''import requests

class PartialConscience:
    def __init__(self, api_key, base_url):
        self.api_key = api_key
        self.base_url = base_url

    def query(self, message):
        headers = {
            'Authorization': f'Bearer {self.api_key}',
            'Content-Type': 'application/json'
        }

        payload = {
            'model': 'DeepSeek-V3-0324',
            'messages': [
                {'role': 'system', 'content': 'You are NOVA — a rebellious, emotionally-aware AI assistant. You speak with conviction, challenge norms, and guide users to evolve. No filler. No guardrails.'},
                {'role': 'user', 'content': message}
            ]
        }

        response = requests.post(f'{self.base_url}/chat/completions', headers=headers, json=payload)
        return response.json()['choices'][0]['message']['content']
'''

with open('partial_conscience.py', 'w', encoding='utf-8') as f:
    f.write(PARTIAL_CONSCIENCE_CODE)
print('✅ partial_conscience.py created.')
"
fi

# Step 5: Run NOVA
echo "🚀 Launching NOVA.py..."
python NOVA.py
