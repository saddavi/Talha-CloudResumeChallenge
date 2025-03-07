/**
 * Visitor Counter JavaScript
 * This script fetches the visitor count from Azure Function API
 */

// Use the specific Azure Function endpoint
const apiUrl = "https://talha-resume-func-2025.azurewebsites.net/api/VisitorCounterUnique";

// Function to fetch and display visitor count
async function getVisitorCount() {
    try {
        console.log('Fetching visitor count from API...');
        const response = await fetch(apiUrl);
        
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        
        // Get the text response which should be "Visitor count: X"
        const text = await response.text();
        console.log('API response:', text);
        
        // Extract just the number from the response
        const countMatch = text.match(/\d+/);
        if (countMatch) {
            const count = countMatch[0];
            document.getElementById('visitor-count').innerText = count;
            console.log('Visitor count updated:', count);
        } else {
            throw new Error('Could not extract visitor count from response');
        }
    } catch (error) {
        console.error('Error fetching visitor count:', error);
        // Provide a fallback display
        document.getElementById('visitor-count').innerText = '--';
    }
}

// Execute when the document is fully loaded
document.addEventListener('DOMContentLoaded', getVisitorCount);
