@echo off
REM VisionaryX AI - Setup Script for Windows
REM This script automates the setup and deployment process

echo.
echo 🧠 VisionaryX AI - Setup Script
echo ==================================
echo.

REM Check if Python is installed
echo Checking Python installation...
python --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Python is not installed. Please install Python 3.8 or higher.
    pause
    exit /b 1
)
for /f "tokens=*" %%i in ('python --version') do set PYTHON_VERSION=%%i
echo ✓ Python found: %PYTHON_VERSION%
echo.

REM Create virtual environment
echo Creating virtual environment...
if not exist "venv" (
    python -m venv venv
    echo ✓ Virtual environment created
) else (
    echo ✓ Virtual environment already exists
)
echo.

REM Activate virtual environment
echo Activating virtual environment...
call venv\Scripts\activate.bat
echo ✓ Virtual environment activated
echo.

REM Upgrade pip
echo Upgrading pip...
python -m pip install --upgrade pip setuptools wheel >nul 2>&1
echo ✓ Pip upgraded
echo.

REM Install dependencies
echo Installing dependencies...
pip install -r requirements.txt
echo ✓ Dependencies installed
echo.

REM Train model if needed
echo Checking for trained model...
if not exist "disease_model.pkl" (
    if not exist "vectorizer.pkl" (
        echo Training model...
        python model\train_model.py
        echo ✓ Model trained
    ) else (
        echo ✓ Model already trained
    )
) else (
    echo ✓ Model already trained
)
echo.

REM Summary
echo ==================================
echo Setup completed successfully!
echo ==================================
echo.
echo Next steps:
echo.
echo 1. For Flask (recommended):
echo    python server.py
echo    Then open: http://localhost:5000
echo.
echo 2. For Streamlit (alternative):
echo    streamlit run app.py
echo    Then open: http://localhost:8501
echo.
echo 3. For production deployment:
echo    gunicorn --workers 4 --bind 0.0.0.0:5000 server:app
echo.
echo For deployment guides, see: DEPLOYMENT.md
echo.
pause
