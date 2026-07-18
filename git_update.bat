@echo off
title SW-LASSI-SAMRAT Git Update Tool
color 0B
echo ====================================================
echo             SW-LASSI-SAMRAT Git Updater             
echo ====================================================
echo.

:: Check if git is installed
where git >nul 2>nul
if %errorlevel% neq 0 (
    color 0C
    echo [ERROR] Git is not installed or not in PATH!
    echo Please install Git and try again.
    pause
    exit /b
)

echo [1/4] Checking repository status...
git status
echo.

echo ====================================================
set "commit_msg="
set /p commit_msg="Enter commit message (Press Enter for default): "

if "%commit_msg%"=="" (
    :: Extract date and time in a safe format
    set commit_msg=Update %date% %time%
)
echo.

echo [2/4] Staging all files...
git add .
echo.

echo [3/4] Committing changes...
git commit -m "%commit_msg%"
echo.

echo [4/4] Pushing to GitHub...
:: Get current branch name
for /f "tokens=*" %%i in ('git branch --show-current') do set BRANCH=%%i
if "%BRANCH%"=="" set BRANCH=main

git push origin %BRANCH%

if %errorlevel% equ 0 (
    color 0A
    echo.
    echo ====================================================
    echo SUCCESS: Changes have been successfully pushed!
    echo ====================================================
) else (
    color 0C
    echo.
    echo ====================================================
    echo ERROR: Failed to push changes to remote repository.
    echo Please check your internet connection or git login credentials.
    echo ====================================================
)

echo.
pause
