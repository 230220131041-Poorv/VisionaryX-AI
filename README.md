# VisionaryX-AI
An intelligent web-based healthcare agent that analyzes patient symptoms to predict possible diseases, assess severity and emergency level, and explain symptom causes using machine learning and AI.

🧠 Intelligent Disease & Emergency Analysis Agent

An agentic AI-based healthcare decision support system that analyzes patient symptoms to predict possible diseases, assess severity and emergency level, and generate human-readable explanations of symptom descriptions and causes using machine learning and knowledge-based reasoning through a web interface.

📌 Project Overview

Healthcare systems often struggle with efficient and fast patient assessment due to high patient volume and limited medical staff. This project aims to provide an intelligent, web-based healthcare assistant that performs preliminary symptom analysis and helps identify potential diseases, urgency level, and treatment category.

The system accepts one or more symptoms from the user and performs the following tasks:
• Predicts the most likely disease
• Determines the severity level (Low / Medium / High)
• Identifies whether the condition is an emergency
• Suggests the type of treatment required
• Explains symptom meaning and cause in simple language

For a single symptom, the system provides a detailed description and cause.
For multiple symptoms, it generates a concise, combined explanation using AI-based logic.

This project demonstrates how machine learning and rule-based reasoning can be combined to build an agentic AI system for healthcare assistance.

🎯 Objectives

• To design an AI system that predicts diseases based on symptoms
• To analyze severity and emergency conditions
• To generate explanations of symptoms and causes
• To provide a user-friendly web interface
• To demonstrate agentic AI behavior in healthcare
• To support decision-making for patients and healthcare providers

⚙️ Key Functionalities
1. Disease Prediction

Predicts the most probable disease based on user-entered symptoms using a trained machine learning model.

2. Severity Assessment

Classifies the condition into Low, Medium, or High severity using medical mapping rules.

3. Emergency Detection

Identifies whether immediate medical attention is required based on severity and disease type.

4. Treatment Recommendation

Suggests appropriate treatment category such as home care, doctor consultation, or hospital care.

5. Symptom Description Generator

6. Professional Web Interface

A modern, responsive HTML/CSS/JavaScript frontend that connects to the backend and provides real-time analysis.

## 🚀 Getting Started

### Prerequisites

- Python 3.8 or higher
- pip (Python package manager)
- Git

### Installation

1. Clone the repository:
```bash
git clone https://github.com/230220131041-Poorv/VisionaryX-AI.git
cd VisionaryX-AI
```

2. Create and activate a virtual environment:
```bash
# On Windows
python -m venv venv
venv\Scripts\Activate.ps1

# On macOS/Linux
python3 -m venv venv
source venv/bin/activate
```

3. Install dependencies:
```bash
pip install -r requirements.txt
```

4. Train the model (if needed):
```bash
python model/train_model.py
```

### Running the Application

#### Option 1: Flask Web Server (Recommended for Deployment)
```bash
python server.py
```
Then open your browser and navigate to: **http://localhost:5000**

#### Option 2: Streamlit App (Alternative Interface)
```bash
streamlit run app.py
```
Open: **http://localhost:8501**

## 📁 Project Structure

```
VisionaryX-AI/
├── app.py                    # Streamlit application
├── server.py                 # Flask backend server
├── requirements.txt          # Python dependencies
├── README.md                 # Project documentation
├── disease_model.pkl         # Trained ML model
├── vectorizer.pkl            # TF-IDF vectorizer
│
├── agent/
│   ├── __init__.py
│   └── agent_logic.py        # Core prediction logic
│
├── model/
│   ├── __init__.py
│   ├── agent_logic.py
│   └── train_model.py        # Model training script
│
├── data/
│   └── dataset.csv           # Medical symptom dataset
│
├── templates/
│   └── index.html            # Main HTML interface
│
└── static/
    ├── style.css             # Styling
    └── script.js             # Frontend logic
```

## 🎨 Features

- **Real-time Disease Analysis**: Instant prediction based on input symptoms
- **Severity Assessment**: Low, Medium, or High classification
- **Emergency Detection**: Quick identification of urgent cases
- **Treatment Recommendations**: Guidance on appropriate care type
- **Symptom Explanations**: Detailed descriptions and possible causes
- **Responsive Design**: Works on desktop, tablet, and mobile devices
- **Professional UI**: Modern gradient design with smooth interactions
- **API-based Architecture**: RESTful backend for easy integration

## 📊 Dataset

The project uses a comprehensive symptom dataset (`data/dataset.csv`) containing:
- Symptoms
- Severity weights
- Descriptions
- Causes

## 🤖 Machine Learning Model

- **Algorithm**: Random Forest Regressor
- **Vectorizer**: TF-IDF (Term Frequency-Inverse Document Frequency)
- **Purpose**: Predicting symptom severity scores

## 🌐 Deployment

### Deploy on Heroku

1. Install Heroku CLI
2. Create a `Procfile`:
```
web: gunicorn server:app
```

3. Add `gunicorn` to requirements.txt:
```bash
pip install gunicorn
```

4. Deploy:
```bash
heroku login
heroku create your-app-name
git push heroku main
```

### Deploy on PythonAnywhere

1. Sign up at pythonanywhere.com
2. Upload your project files
3. Create a web app pointing to `server.py`
4. Configure WSGI file to use Flask app

### Deploy on GitHub Pages (Frontend Only)

For static deployment of the frontend, you can use GitHub Pages with a backend API.

### Deploy Locally with Docker

Create a `Dockerfile`:
```dockerfile
FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .
CMD ["python", "server.py"]
```

Build and run:
```bash
docker build -t visionaryx-ai .
docker run -p 5000:5000 visionaryx-ai
```

## 📝 Usage Examples

### Web Interface
1. Open the application in your browser
2. Enter symptoms separated by commas (e.g., "fever, headache, cough")
3. Click "Analyze Patient"
4. View detailed analysis results

### API Usage

```bash
curl -X POST http://localhost:5000/api/predict \
  -H "Content-Type: application/json" \
  -d "{\"symptoms\": \"fever, headache, cough\"}"
```

Response:
```json
{
  "disease": "Respiratory Infection",
  "severity": "Medium",
  "emergency": "No",
  "treatment": "Consult doctor",
  "description": "A serious viral or bacterial infection...",
  "cause": "Commonly caused by viruses or bacteria..."
}
```

## ⚠️ Disclaimer

This AI system is designed for **informational purposes only** and should **not replace professional medical advice**. Always consult with a qualified healthcare professional for accurate diagnosis, treatment, and medical decisions. Use this tool as a preliminary assessment tool only.

## 🔄 API Endpoints

- `GET /` - Serves the main HTML interface
- `POST /api/predict` - Analyzes symptoms and returns predictions
- `GET /api/health` - Health check endpoint

## 🛠️ Technologies Used

- **Frontend**: HTML5, CSS3, JavaScript (Vanilla)
- **Backend**: Python, Flask, Flask-CORS
- **ML/AI**: scikit-learn, pandas, numpy, joblib
- **Alternative UI**: Streamlit
- **Deployment**: Can be deployed on Heroku, PythonAnywhere, AWS, Google Cloud, etc.

## 📄 License

This project is open source and available under the MIT License.

## 👨‍💻 Author

**Poorv** - [GitHub Profile](https://github.com/230220131041-Poorv)

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📞 Contact & Support

For issues, questions, or suggestions, please open an issue on GitHub or contact the project maintainer.

## 🔗 Resources

- [scikit-learn Documentation](https://scikit-learn.org/)
- [Flask Documentation](https://flask.palletsprojects.com/)
- [Streamlit Documentation](https://streamlit.io/)

---

**Last Updated**: April 2026

Made with ❤️ by VisionaryX Team

For a single symptom, displays its meaning in simple terms.

6. Symptom Cause Analyzer

Explains the possible reason behind the symptom.

7. Multi-Symptom Reasoning

For multiple symptoms, produces a short combined description and cause using intelligent logic.

8. Web-Based User Interface

Provides an interactive browser-based interface for easy testing and demonstration.

🏗️ System Architecture
User Input (Symptoms)
        ↓
Web Interface (Streamlit)
        ↓
Symptom Processing Module
        ↓
Machine Learning Model
        ↓
Decision & Rule Engine
        ↓
Explanation Generator
        ↓
Final Output (Disease, Severity, Emergency, Treatment, Description, Cause)

📁 Project Structure
Disease_Agent_Project/
│
├── data/
│   └── dataset.csv              # Main training dataset
│
├── model/
│   ├── train_model.py           # Model training script
│   
├── agent/
│   └── agent_logic.py           # Core decision-making logic
│
├── app.py                       # Web application (frontend)
├── requirements.txt             # Required libraries
├── disease_model.pkl            # Trained model
├── symptom_columns.pkl          # Symptom feature list
└── README.md                    # Project documentation

📊 Dataset

The model is trained using a symptom–disease dataset obtained from Kaggle.
The dataset contains binary symptom indicators mapped to disease labels.

Additionally, a custom knowledge dataset (symptom_info.csv) is used to store:
• Symptom descriptions
• Causes of symptoms

This allows the system to explain symptoms in a human-readable form.

🧪 Technologies Used

• Python
• Pandas
• NumPy
• Scikit-learn
• Streamlit
• Joblib

🚀 Installation & Setup
1. Clone the Repository
git clone https://github.com/PoorvKhatri/VisionaryX-AI
cd Disease_Agent_Project

2. Create Virtual Environment
python -m venv venv
venv\Scripts\activate

3. Install Dependencies
pip install -r requirements.txt

4. Train the Model
python model/train_model.py

5. Run the Web Application
streamlit run app.py


Open browser at:

http://localhost:8501

🧠 How It Works

User enters one or more symptoms

Symptoms are converted into a machine-readable format

ML model predicts the disease

Severity and emergency level are calculated

Symptom meaning and cause are generated

Results are displayed in the browser

🩺 Example Use Case

Input:

high_fever, headache, vomiting


Output:
🦠 Predicted Disease: Migraine or Neurological Issue

⚠ Severity Level: Medium (4.7)

🚨 Emergency: No

💊 Treatment Type: Consult doctor

📝 Description: Combination of symptoms: Elevated body temperature above 101°F; Pain in the head or neck area...

🔍 Possible Causes: Possible causes: Commonly caused by infections, food poisoning, pregnancy, or gastrointestinal issues; Often caused by tension, migraines, dehydration, or infections...

🔐 Ethical Considerations

• This system does not replace a doctor
• It provides preliminary assistance only
• User data should not be stored permanently
• Predictions must be used for educational purposes

🔮 Future Enhancements

• Voice-based symptom input
• Mobile application integration
• Doctor dashboard
• Confidence score display
• PDF patient report generation
• Integration with wearable devices
• Use of large language models for explanations

🏆 Significance

This project demonstrates the application of agentic AI in healthcare by combining machine learning with reasoning and explanation generation. It serves as an effective example of how AI can assist in early-stage medical assessment while remaining interpretable and user-friendly.

👨‍💻 Contributors

• Poorv Khatri
• Nikhil Jani
• Deven Jadav
• Yash Soni
