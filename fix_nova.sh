#!/data/data/com.termux/files/usr/bin/bash

FILE="NOVA.py"

# Step 1: Backup
cp "$FILE" "${FILE}.bak"
echo "🛡️ Backup created at ${FILE}.bak"

# Step 2: Clean with iconv
echo "🧹 Cleaning invalid UTF-8 characters using iconv..."
iconv -f utf-8 -t utf-8 -c "$FILE" -o "${FILE}.tmp"

# Step 3: Replace known bad print
echo "🔧 Replacing bad print line..."
sed -i 's/print("� partial_conscience.py installed.")/print("✅ partial_conscience.py installed.")/' "${FILE}.tmp"

# Step 4: Move cleaned version back
mv "${FILE}.tmp" "$FILE"
echo "✅ NOVA.py cleaned and fixed."

# Step 5: Run the script
echo "🚀 Running NOVA.py..."
python "$FILE"
