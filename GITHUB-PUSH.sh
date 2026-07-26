#!/bin/bash
# ERSENBOX SPIELE - GIT + GITHUB PUSH SCRIPT
# Run this in /home/claude/ersenbox-final folder

echo "🚀 ERSENBOX SPIELE - GitHub Push Script"
echo "=========================================="
echo ""

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "❌ Git nicht installiert!"
    echo "   Windows: https://git-scm.com/download/win"
    echo "   Mac: brew install git"
    echo "   Linux: sudo apt install git"
    exit 1
fi

# Initialize git
echo "📁 Initializing Git Repository..."
git init
git config user.name "Sari"
git config user.email "sari@ersenbox.com"
echo "✓ Git initialized"
echo ""

# Add all files
echo "📝 Adding all files..."
git add .
echo "✓ All files staged"
echo ""

# First commit
echo "💾 Creating first commit..."
git commit -m "Initial commit: Ersenbox Spiele App with 42 optimized assets

- 16 Character images (Numbers 1-6, Letters A-F, Animals)
- 14 Background images (Menu, Gameplay, Dark/Light mode, etc)
- 10 Logo/Badge/Mascot images
- 2 Pattern images (NavBar, Card pattern)
- HTML5 PWA with full German/Turkish/English support
- Dark/Light mode toggle
- Star reward system
- Canvas drawing mode
- Responsive design (Mobile/Tablet/Desktop)
"

echo "✓ Commit created"
echo ""

# Add remote
echo "🔗 Connecting to GitHub..."
echo ""
echo "SCHRITT 1: GitHub Token generieren"
echo "   1. Gehe zu: https://github.com/settings/tokens"
echo "   2. Klick: Generate new token (classic)"
echo "   3. Permissions: repo (vollständig), workflow"
echo "   4. Copy Token (sicher speichern!)"
echo ""
echo "SCHRITT 2: GitHub Repo erstellen"
echo "   1. Gehe zu: https://github.com/new"
echo "   2. Repository name: ersenbox-spiele"
echo "   3. Beschreibung: Kinder Bildungs-App (Educational app for kids)"
echo "   4. Public: YES"
echo "   5. Create Repository"
echo ""

read -p "Fertig? (y/n): " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Abgebrochen"
    exit 1
fi

echo ""
echo "GitHub Username eingeben (z.B. 'Ersenbox'):"
read -p "> " github_user

if [ -z "$github_user" ]; then
    echo "❌ Username erforderlich!"
    exit 1
fi

github_url="https://github.com/${github_user}/ersenbox-spiele.git"
echo ""
echo "Remote URL: $github_url"
echo ""

git remote add origin "$github_url"

echo "🔑 GitHub Token eingeben (wird nicht angezeigt):"
read -sp "> " github_token
echo ""

if [ -z "$github_token" ]; then
    echo "❌ Token erforderlich!"
    exit 1
fi

# Push mit Token
echo ""
echo "📤 Pushing to GitHub..."
git push -u "https://${github_user}:${github_token}@github.com/${github_user}/ersenbox-spiele.git" main 2>&1 | grep -v "$github_token"

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Push erfolgreich!"
    echo ""
    echo "=========================================="
    echo "NÄCHSTER SCHRITT: Cloudflare Pages"
    echo "=========================================="
    echo ""
    echo "1. Gehe zu: https://dash.cloudflare.com/"
    echo "2. Klick: Pages (links)"
    echo "3. Klick: Create a project"
    echo "4. Klick: Connect to Git"
    echo "5. Authorisiere GitHub"
    echo "6. Wähle: ${github_user}/ersenbox-spiele"
    echo "7. Build-Einstellungen:"
    echo "   - Build command: (LEER lassen)"
    echo "   - Build output directory: /"
    echo "8. Klick: Save and Deploy"
    echo ""
    echo "🎉 In 2-3 Minuten LIVE: https://ersenbox-spiele.pages.dev/"
    echo ""
else
    echo "❌ Push fehlgeschlagen!"
    echo "   Überprüfe: Username, Token, Repo-URL"
    exit 1
fi
