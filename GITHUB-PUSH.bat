@echo off
REM ERSENBOX SPIELE - WINDOWS GIT PUSH SCRIPT
REM Run this in ersenbox-spiele-READY folder

echo.
echo ============================================
echo ERSENBOX SPIELE - GitHub Push (Windows)
echo ============================================
echo.

REM Check if git is installed
where git >nul 2>nul
if errorlevel 1 (
    echo ERROR: Git nicht installiert!
    echo Download: https://git-scm.com/download/win
    pause
    exit /b 1
)

REM Initialize git
echo [1/5] Initializing Git...
git init
git config user.name "Sari"
git config user.email "sari@ersenbox.com"
echo OK
echo.

REM Add files
echo [2/5] Adding all files...
git add .
echo OK
echo.

REM Create commit
echo [3/5] Creating commit...
git commit -m "Initial: Ersenbox Spiele mit 42 optimierten Bildern"
if errorlevel 1 (
    echo ERROR: Commit failed
    pause
    exit /b 1
)
echo OK
echo.

REM Set remote
echo [4/5] Setting up GitHub...
echo.
echo GitHub Username eingeben:
set /p github_user=">>> "

if "%github_user%"=="" (
    echo ERROR: Username erforderlich!
    pause
    exit /b 1
)

git remote add origin "https://github.com/%github_user%/ersenbox-spiele.git"
echo OK
echo.

REM Push
echo [5/5] Pushing to GitHub...
echo.
echo GitHub Token eingeben (wird nicht angezeigt):
setlocal enabledelayedexpansion
REM This will be a simple approach - the user will need to input
git push -u "https://%github_user%@github.com/%github_user%/ersenbox-spiele.git" main

if errorlevel 1 (
    echo.
    echo ERROR: Push failed!
    echo Check: Username, Token, Repository exists
    pause
    exit /b 1
) else (
    echo.
    echo ============================================
    echo SUCCESS! 42 Dateien pushed!
    echo ============================================
    echo.
    echo NEXT: Cloudflare Pages
    echo 1. https://dash.cloudflare.com/
    echo 2. Pages ^> Create Project
    echo 3. Connect Repo: %github_user%/ersenbox-spiele
    echo 4. Deploy!
    echo.
    echo Live in 2-3 Min: https://ersenbox-spiele.pages.dev/
    echo.
    pause
)
