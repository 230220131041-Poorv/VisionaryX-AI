// API Base URL
const API_BASE_URL = window.location.origin;

// DOM Elements
const symptomForm = document.getElementById('symptomForm');
const symptomsInput = document.getElementById('symptoms');
const resultsContainer = document.getElementById('resultsContainer');
const errorContainer = document.getElementById('errorContainer');
const submitBtn = symptomForm.querySelector('button[type="submit"]');
const loadingSpan = submitBtn.querySelector('.loading');
const btnText = submitBtn.querySelector('.btn-text');

// Event Listeners
symptomForm.addEventListener('submit', handleFormSubmit);

// Form Submit Handler
async function handleFormSubmit(e) {
    e.preventDefault();
    
    const symptoms = symptomsInput.value.trim();
    
    if (!symptoms) {
        showError('Please enter at least one symptom');
        return;
    }
    
    // Show loading state
    submitBtn.disabled = true;
    loadingSpan.classList.add('active');
    btnText.classList.add('hidden');
    clearError();
    
    try {
        const response = await fetch(`${API_BASE_URL}/api/predict`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ symptoms: symptoms })
        });
        
        if (!response.ok) {
            const errorData = await response.json();
            throw new Error(errorData.error || 'Failed to analyze symptoms');
        }
        
        const result = await response.json();
        displayResults(result);
        
    } catch (error) {
        console.error('Error:', error);
        showError(error.message || 'An error occurred while analyzing symptoms. Please try again.');
    } finally {
        // Reset loading state
        submitBtn.disabled = false;
        loadingSpan.classList.remove('active');
        btnText.classList.remove('hidden');
    }
}

// Display Results
function displayResults(result) {
    // Update result values
    document.getElementById('resultDisease').textContent = result.disease || '-';
    document.getElementById('resultSeverity').textContent = result.severity || '-';
    document.getElementById('resultEmergency').textContent = result.emergency || '-';
    document.getElementById('resultTreatment').textContent = result.treatment || '-';
    document.getElementById('resultDescription').textContent = result.description || '-';
    document.getElementById('resultCause').textContent = result.cause || '-';
    
    // Update severity badge color
    const severityElement = document.getElementById('resultSeverity');
    severityElement.classList.remove('low', 'medium', 'high');
    
    const severity = result.severity.toLowerCase();
    if (severity === 'low') {
        severityElement.classList.add('low');
    } else if (severity === 'medium') {
        severityElement.classList.add('medium');
    } else if (severity === 'high') {
        severityElement.classList.add('high');
    }
    
    // Update emergency status styling
    const emergencyElement = document.getElementById('resultEmergency');
    if (result.emergency === 'Yes') {
        emergencyElement.style.color = '#e74c3c';
        emergencyElement.style.fontWeight = 'bold';
    } else {
        emergencyElement.style.color = '#3498db';
    }
    
    // Show results container
    resultsContainer.classList.remove('hidden');
    
    // Scroll to results
    resultsContainer.scrollIntoView({ behavior: 'smooth', block: 'start' });
}

// Show Error Message
function showError(message) {
    const errorMessageElement = document.getElementById('errorMessage');
    errorMessageElement.textContent = message;
    errorContainer.classList.remove('hidden');
    errorContainer.scrollIntoView({ behavior: 'smooth', block: 'start' });
}

// Clear Error Message
function clearError() {
    errorContainer.classList.add('hidden');
    document.getElementById('errorMessage').textContent = '';
}

// Auto-hide error after 5 seconds
errorContainer.addEventListener('click', function(e) {
    if (e.target.closest('.btn-secondary')) {
        clearError();
    }
});

// Handle Enter key in textarea
symptomsInput.addEventListener('keydown', function(e) {
    if (e.key === 'Enter' && e.ctrlKey) {
        symptomForm.dispatchEvent(new Event('submit'));
    }
});

// Initial page load checks
document.addEventListener('DOMContentLoaded', function() {
    console.log('VisionaryX AI - Disease Analysis Agent loaded');
    
    // Optional: Check if API is available
    checkAPIHealth();
});

// Check API Health
async function checkAPIHealth() {
    try {
        const response = await fetch(`${API_BASE_URL}/api/health`);
        if (response.ok) {
            console.log('API is healthy and ready');
        }
    } catch (error) {
        console.warn('Could not reach API health check:', error);
    }
}

// Add some interactivity to result items
document.addEventListener('DOMContentLoaded', function() {
    const resultItems = document.querySelectorAll('.result-item');
    resultItems.forEach(item => {
        item.addEventListener('click', function() {
            this.style.transform = 'scale(1.02)';
            setTimeout(() => {
                this.style.transform = '';
            }, 200);
        });
    });
});
