from flask import Flask, render_template, request, jsonify
from flask_cors import CORS
from agent.agent_logic import agent_decision
import os

app = Flask(__name__, template_folder='templates', static_folder='static')
CORS(app)

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/api/predict', methods=['POST'])
def predict():
    try:
        data = request.json
        symptoms = data.get('symptoms', '')
        
        if not symptoms or symptoms.strip() == '':
            return jsonify({'error': 'Please enter symptoms'}), 400
        
        # Call the agent decision function
        disease, severity, emergency, treatment, description, cause = agent_decision(symptoms)
        
        # Convert severity to string if it's numeric
        if isinstance(severity, (int, float)):
            if severity < 3:
                severity_str = "Low"
            elif severity < 5:
                severity_str = "Medium"
            else:
                severity_str = "High"
        else:
            severity_str = severity
        
        return jsonify({
            'disease': disease,
            'severity': severity_str,
            'emergency': emergency,
            'treatment': treatment,
            'description': description,
            'cause': cause
        })
    
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/api/health', methods=['GET'])
def health():
    return jsonify({'status': 'ok'})

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
