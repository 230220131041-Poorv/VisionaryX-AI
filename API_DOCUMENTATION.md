# API Documentation - VisionaryX AI

## Base URL
```
http://localhost:5000  (Development)
https://your-deployed-app.com  (Production)
```

## Endpoints

### 1. Get Home Page
Return the main HTML interface.

**Request:**
```http
GET /
```

**Response:**
- Status: 200
- Content-Type: text/html
- Body: HTML page

---

### 2. Health Check
Check if the API is running and healthy.

**Request:**
```http
GET /api/health
```

**Response:**
```json
{
  "status": "ok"
}
```

**Status Codes:**
- 200: API is healthy

---

### 3. Predict Disease (Main Endpoint)
Analyze patient symptoms and predict disease information.

**Request:**
```http
POST /api/predict
Content-Type: application/json

{
  "symptoms": "fever, headache, cough"
}
```

**Request Body Parameters:**
- `symptoms` (string, required): Comma-separated list of symptoms

**Example Requests:**

**Single Symptom:**
```bash
curl -X POST http://localhost:5000/api/predict \
  -H "Content-Type: application/json" \
  -d '{"symptoms": "fever"}'
```

**Multiple Symptoms:**
```bash
curl -X POST http://localhost:5000/api/predict \
  -H "Content-Type: application/json" \
  -d '{"symptoms": "fever, headache, cough, sore throat"}'
```

**Response (Success):**
```json
{
  "disease": "Respiratory Infection",
  "severity": "Medium",
  "emergency": "No",
  "treatment": "Consult doctor",
  "description": "A respiratory infection is an infection of the lungs or airways...",
  "cause": "Commonly caused by viruses or bacteria such as influenza, cold virus, or bacterial pneumonia..."
}
```

**Response (Error - No Symptoms):**
```json
{
  "error": "Please enter symptoms"
}
```

**Response (Error - Unknown Symptom):**
```json
{
  "disease": "There is no data about this symptom: xyz",
  "severity": "0",
  "emergency": "No",
  "treatment": "None",
  "description": "No description",
  "cause": "No cause"
}
```

**Status Codes:**
- 200: Prediction successful
- 400: Bad request (missing or invalid symptoms)
- 500: Server error

---

## Response Fields

| Field | Type | Description |
|-------|------|-------------|
| disease | string | Predicted disease name |
| severity | string | Severity level: "Low", "Medium", "High" |
| emergency | string | Emergency status: "Yes" or "No" |
| treatment | string | Recommended treatment type |
| description | string | Detailed description of the disease/symptoms |
| cause | string | Possible causes of the symptoms |

---

## Severity Levels

- **Low**: Rest and home care recommended
- **Medium**: Doctor consultation recommended
- **High**: Immediate medical attention required

---

## Error Handling

All error responses follow this format:

```json
{
  "error": "Error message describing what went wrong"
}
```

**Common Error Codes:**
- `400 Bad Request`: Missing or invalid parameters
- `500 Internal Server Error`: Server-side error during processing

---

## Rate Limiting

Currently, no rate limiting is implemented. For production deployment, consider adding:
- Rate limiting per IP address
- Request throttling
- Caching for frequent queries

---

## CORS (Cross-Origin Resource Sharing)

The API is configured with CORS enabled, allowing requests from any origin. For production, consider restricting to specific domains:

```python
CORS(app, resources={r"/api/*": {"origins": ["https://yourdomain.com"]}})
```

---

## Authentication (Optional)

For future implementation, add API key authentication:

```python
@app.before_request
def verify_api_key():
    api_key = request.headers.get('X-API-Key')
    if not api_key or api_key != os.environ.get('API_KEY'):
        return jsonify({'error': 'Invalid API key'}), 401
```

---

## Rate Limiting Example

Include in `server.py`:

```python
from flask_limiter import Limiter
from flask_limiter.util import get_remote_address

limiter = Limiter(
    app=app,
    key_func=get_remote_address,
    default_limits=["200 per day", "50 per hour"]
)

@app.route('/api/predict', methods=['POST'])
@limiter.limit("10 per minute")
def predict():
    # ... endpoint code
```

---

## JavaScript Fetch Examples

**Using Fetch API:**
```javascript
const symptoms = "fever, headache, cough";

fetch('/api/predict', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
  },
  body: JSON.stringify({ symptoms: symptoms })
})
.then(response => response.json())
.then(data => {
  console.log('Prediction:', data);
  document.getElementById('disease').textContent = data.disease;
  document.getElementById('severity').textContent = data.severity;
  // ... update other fields
})
.catch(error => console.error('Error:', error));
```

**Using Axios:**
```javascript
axios.post('/api/predict', {
  symptoms: 'fever, headache, cough'
})
.then(response => {
  console.log('Prediction:', response.data);
})
.catch(error => {
  console.error('Error:', error.response.data);
});
```

---

## Python Requests Example

```python
import requests

response = requests.post(
    'http://localhost:5000/api/predict',
    json={'symptoms': 'fever, headache, cough'}
)

if response.status_code == 200:
    data = response.json()
    print(f"Disease: {data['disease']}")
    print(f"Severity: {data['severity']}")
    print(f"Emergency: {data['emergency']}")
else:
    print(f"Error: {response.json()['error']}")
```

---

## Webhook Integration (Future)

To add webhook support for integration with other systems:

```python
@app.route('/api/predict-webhook', methods=['POST'])
def predict_webhook():
    data = request.json
    webhook_url = data.get('webhook_url')
    
    # Process prediction
    result = agent_decision(data['symptoms'])
    
    # Send to webhook
    requests.post(webhook_url, json=result)
    
    return jsonify({'status': 'Processing webhook'})
```

---

## Performance Metrics

Current API Performance:
- Average Response Time: ~200-500ms
- Model Loading Time: ~1-2 seconds (first startup)
- Throughput: ~10-20 requests/second (single server)

**To improve:**
- Implement caching (Redis)
- Load model on startup
- Add request batching
- Use async processing for long-running tasks

---

## Versioning

Current API Version: `v1.0`

For future versioning:
```
GET /api/v1/predict
GET /api/v2/predict
```

---

## Changelog

### v1.0 (Current)
- Initial API release
- Disease prediction endpoint
- Health check endpoint
- CORS enabled

### Future Versions
- API key authentication
- Rate limiting
- Caching
- WebSocket support
- Batch predictions
- Model versioning

---

## Support & Issues

For API issues or feature requests:
- Open an issue on GitHub
- Check the main README.md
- Review DEPLOYMENT.md for setup issues

---

**Last Updated**: April 2026
