#!/bin/bash

# VisionaryX AI - Setup & Deployment Script
# This script automates the setup and deployment process

set -e  # Exit on error

echo "🧠 VisionaryX AI - Setup Script"
echo "=================================="
echo ""

# Color codes for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if Python is installed
echo -e "${BLUE}Checking Python installation...${NC}"
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 is not installed. Please install Python 3.8 or higher."
    exit 1
fi
echo -e "${GREEN}✓ Python found: $(python3 --version)${NC}"
echo ""

# Create virtual environment
echo -e "${BLUE}Creating virtual environment...${NC}"
if [ ! -d "venv" ]; then
    python3 -m venv venv
    echo -e "${GREEN}✓ Virtual environment created${NC}"
else
    echo -e "${GREEN}✓ Virtual environment already exists${NC}"
fi
echo ""

# Activate virtual environment
echo -e "${BLUE}Activating virtual environment...${NC}"
source venv/bin/activate
echo -e "${GREEN}✓ Virtual environment activated${NC}"
echo ""

# Upgrade pip
echo -e "${BLUE}Upgrading pip...${NC}"
pip install --upgrade pip setuptools wheel > /dev/null 2>&1
echo -e "${GREEN}✓ Pip upgraded${NC}"
echo ""

# Install dependencies
echo -e "${BLUE}Installing dependencies...${NC}"
pip install -r requirements.txt
echo -e "${GREEN}✓ Dependencies installed${NC}"
echo ""

# Train model if needed
echo -e "${BLUE}Checking for trained model...${NC}"
if [ ! -f "disease_model.pkl" ] || [ ! -f "vectorizer.pkl" ]; then
    echo -e "${YELLOW}Training model...${NC}"
    python model/train_model.py
    echo -e "${GREEN}✓ Model trained${NC}"
else
    echo -e "${GREEN}✓ Model already trained${NC}"
fi
echo ""

# Summary
echo -e "${GREEN}=================================="
echo "Setup completed successfully!"
echo "==================================${NC}"
echo ""
echo -e "${BLUE}Next steps:${NC}"
echo ""
echo "1. For Flask (recommended):"
echo -e "   ${YELLOW}python server.py${NC}"
echo "   Then open: http://localhost:5000"
echo ""
echo "2. For Streamlit (alternative):"
echo -e "   ${YELLOW}streamlit run app.py${NC}"
echo "   Then open: http://localhost:8501"
echo ""
echo "3. For production deployment:"
echo -e "   ${YELLOW}gunicorn --workers 4 --bind 0.0.0.0:5000 server:app${NC}"
echo ""
echo -e "${BLUE}For deployment guides, see: DEPLOYMENT.md${NC}"
echo ""
