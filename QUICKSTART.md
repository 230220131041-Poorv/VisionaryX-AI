# 🚀 Quick Start Guide - VisionaryX AI

## For the Impatient (5 minutes)

### Step 1: Install Dependencies
```bash
pip install -r requirements.txt
```

### Step 2: Train Model (if needed)
```bash
python model/train_model.py
```

### Step 3: Run Server
```bash
python server.py
```

### Step 4: Open Browser
```
http://localhost:5000
```

**Done!** 🎉

---

## Complete Setup (10 minutes)

### Windows Users
```bash
# 1. Run automated setup
setup.bat

# 2. Run server (inside venv)
python server.py

# 3. Open http://localhost:5000
```

### Mac/Linux Users
```bash
# 1. Run automated setup
bash setup.sh

# 2. Run server (inside venv)
python server.py

# 3. Open http://localhost:5000
```

---

## Using Docker

```bash
# 1. Build image
docker build -t visionaryx-ai .

# 2. Run container
docker run -p 5000:5000 visionaryx-ai

# 3. Open http://localhost:5000
```

Or use Docker Compose:
```bash
docker-compose up
```

---

## Deploy to Heroku (5 minutes)

```bash
# 1. Install Heroku CLI
# https://devcenter.heroku.com/articles/heroku-cli

# 2. Login
heroku login

# 3. Create app
heroku create your-app-name

# 4. Deploy
git push heroku main

# 5. Open your app
heroku open
```

Your app will be live at: `https://your-app-name.herokuapp.com`

---

## Deploy to Docker Hub

```bash
# 1. Login to Docker
docker login

# 2. Build image
docker build -t yourusername/visionaryx-ai .

# 3. Push to Docker Hub
docker push yourusername/visionaryx-ai
```

---

## Still Having Issues?

1. **Check Python version**: `python --version` (need 3.8+)
2. **Check virtual environment**: `which python` or `where python`
3. **Update pip**: `pip install --upgrade pip`
4. **Reinstall dependencies**: `pip install --force-reinstall -r requirements.txt`
5. **Check port 5000**: Make sure it's not already in use
6. **Check logs**: Look at terminal output for error messages

---

## What Just Happened?

You now have:
- ✅ A professional web interface at localhost:5000
- ✅ A REST API for disease prediction
- ✅ Real-time symptom analysis
- ✅ Connected to your ML model and dataset
- ✅ Ready to deploy anywhere

---

## Common Commands

```bash
# Run Flask server
python server.py

# Run Streamlit alternative
streamlit run app.py

# Train the ML model
python model/train_model.py

# Production server
gunicorn --workers 4 --bind 0.0.0.0:5000 server:app

# Docker local development
docker-compose up

# Check if port 5000 is available (Linux/Mac)
lsof -i :5000

# Kill process on port 5000 (Linux/Mac)
lsof -ti:5000 | xargs kill -9

# Check port usage (Windows)
netstat -ano | findstr :5000
```

---

## API Endpoint

```bash
# Test the API
curl -X POST http://localhost:5000/api/predict \
  -H "Content-Type: application/json" \
  -d '{"symptoms": "fever, headache"}'
```

---

## Deployment Checklist

- [ ] All files committed to GitHub
- [ ] `requirements.txt` up to date
- [ ] `disease_model.pkl` and `vectorizer.pkl` in root
- [ ] `.gitignore` includes venv and pycache
- [ ] Tested locally on localhost:5000
- [ ] Ready to deploy!

---

## Need More Help?

📖 **Detailed Guides**:
- See `DEPLOYMENT.md` for full deployment options
- See `API_DOCUMENTATION.md` for API reference
- See `README.md` for project overview

---

## What's Running

When you run `python server.py`:

```
Flask Web Server
    ↓
    ├─→ Serves HTML/CSS/JS at http://localhost:5000
    ├─→ API endpoint at /api/predict
    ├─→ Health check at /api/health
    └─→ Connects to ML model for predictions
```

---

**That's it! You're all set! 🎉**

Questions? Check the documentation files or open an issue on GitHub.
