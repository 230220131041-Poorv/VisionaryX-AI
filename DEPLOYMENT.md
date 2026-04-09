# VisionaryX AI - Deployment Guide

This guide covers multiple deployment options for the VisionaryX AI application.

## Quick Start

### Local Development

```bash
# 1. Clone the repository
git clone https://github.com/230220131041-Poorv/VisionaryX-AI.git
cd VisionaryX-AI

# 2. Create and activate virtual environment
python -m venv venv
venv\Scripts\Activate.ps1  # Windows
source venv/bin/activate   # Mac/Linux

# 3. Install dependencies
pip install -r requirements.txt

# 4. Run Flask server
python server.py
```

Open browser to: **http://localhost:5000**

---

## Deployment Options

### 1. Heroku Deployment (Free Tier Available)

**Prerequisites:**
- Heroku account
- Heroku CLI installed

**Steps:**

```bash
# 1. Login to Heroku
heroku login

# 2. Create app
heroku create your-app-name

# 3. Set buildpack
heroku buildpacks:set heroku/python

# 4. Deploy
git push heroku main

# 5. Open app
heroku open
```

Your app will be live at: `https://your-app-name.herokuapp.com/`

---

### 2. Docker Deployment

**Build and Run Locally:**

```bash
# Build image
docker build -t visionaryx-ai .

# Run container
docker run -p 5000:5000 visionaryx-ai
```

**Using Docker Compose:**

```bash
docker-compose up
```

**Deploy to Docker Hub:**

```bash
# Tag image
docker tag visionaryx-ai username/visionaryx-ai

# Push to Docker Hub
docker push username/visionaryx-ai
```

---

### 3. PythonAnywhere Deployment

**Steps:**

1. Sign up at pythonanywhere.com
2. Upload project files
3. Create Python 3.11 web app
4. Edit WSGI configuration:

```python
# wsgi_file.py
import sys
path = '/home/yourusername/VisionaryX-AI'
if path not in sys.path:
    sys.path.append(path)

from server import app as application
```

5. Reload web app
6. Access your app at: `https://yourusername.pythonanywhere.com/`

---

### 4. AWS Deployment

**Option A: AWS Elastic Beanstalk**

```bash
# Install AWS CLI and EB CLI
pip install awsebcli

# Initialize EB
eb init

# Create environment
eb create visionaryx-env

# Deploy
eb deploy

# Open application
eb open
```

**Option B: AWS EC2**

1. Launch Ubuntu EC2 instance
2. Connect via SSH
3. Clone repository
4. Install Python and dependencies
5. Run with Gunicorn

```bash
gunicorn --bind 0.0.0.0:5000 server:app
```

6. Setup Nginx as reverse proxy

---

### 5. Google Cloud Platform (GCP)

**Using App Engine:**

Create `app.yaml`:
```yaml
runtime: python311

handlers:
- url: /.*
  script: auto

env_variables:
  FLASK_ENV: "production"
```

Deploy:
```bash
gcloud app deploy
```

---

### 6. Microsoft Azure

**Using App Service:**

1. Create Azure account
2. Create App Service for Python
3. Deploy from GitHub using GitHub Actions
4. App will be at: `https://your-app.azurewebsites.net`

---

### 7. DigitalOcean App Platform

**Steps:**

1. Create DigitalOcean account
2. Create App
3. Connect GitHub repository
4. Select Python runtime
5. Configure settings and deploy

App will be live in minutes!

---

## Production Configuration

### Environment Variables

Create `.env` file:
```
FLASK_ENV=production
DEBUG=False
```

### WSGI Server Configuration

For production, use Gunicorn with proper workers:

```bash
# For 4-core server
gunicorn --workers 4 --bind 0.0.0.0:5000 server:app

# With Nginx reverse proxy
gunicorn --workers 4 --bind 127.0.0.1:8000 server:app
```

### Nginx Configuration

```nginx
server {
    listen 80;
    server_name your-domain.com;

    location / {
        proxy_pass http://127.0.0.1:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    location /static/ {
        alias /var/www/visionaryx-ai/static/;
        expires 30d;
    }
}
```

---

## Continuous Integration/Deployment (CI/CD)

### GitHub Actions

Create `.github/workflows/deploy.yml`:

```yaml
name: Deploy to Heroku

on:
  push:
    branches: [ main ]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    
    - name: Deploy to Heroku
      uses: akhileshns/heroku-deploy@v3.12.14
      with:
        heroku_api_key: ${{ secrets.HEROKU_API_KEY }}
        heroku_app_name: your-app-name
        heroku_email: your-email@example.com
```

---

## Monitoring & Logging

### Heroku Logs
```bash
heroku logs --tail
```

### Application Monitoring

For production monitoring, integrate:
- **Sentry** for error tracking
- **New Relic** for performance monitoring
- **ELK Stack** for logging

---

## Security Best Practices

1. **HTTPS/SSL**: Always use SSL in production
2. **Environment Variables**: Store secrets in environment variables
3. **CORS**: Configure CORS carefully
4. **Input Validation**: Validate all user inputs
5. **Database**: Secure any database connections
6. **Dependencies**: Keep dependencies updated

Scan for vulnerabilities:
```bash
pip install safety
safety check
```

---

## Performance Optimization

1. **Caching**: Add Redis for caching predictions
2. **Database**: Use database for frequent queries
3. **CDN**: Serve static files via CDN
4. **Compression**: Enable gzip compression
5. **Async Tasks**: Use Celery for background jobs

---

## Troubleshooting

### Common Issues

**1. Model file not found**
```python
# Ensure disease_model.pkl and vectorizer.pkl are in root directory
```

**2. Port already in use**
```bash
# Kill process on port 5000
lsof -ti:5000 | xargs kill -9  # Mac/Linux
netstat -ano | findstr :5000   # Windows
```

**3. Memory issues**
- Reduce worker count in Gunicorn
- Implement model caching
- Use smaller batch sizes

**4. CORS Issues**
```python
# Already configured in server.py with flask-cors
CORS(app)
```

---

## Database Integration (Optional)

To add persistent data storage:

```python
from flask_sqlalchemy import SQLAlchemy

app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://user:password@localhost/dbname'
db = SQLAlchemy(app)
```

---

## Next Steps

1. Choose your preferred deployment platform
2. Follow the relevant guide above
3. Test your application thoroughly
4. Monitor logs and performance
5. Set up CI/CD pipeline for future updates

---

## Support & Resources

- Flask Documentation: https://flask.palletsprojects.com/
- Heroku Documentation: https://devcenter.heroku.com/
- Docker Documentation: https://docs.docker.com/
- GitHub Actions: https://github.com/features/actions

---

For more help, check the main README.md or open an issue on GitHub.
