const apiUrl = 'https://talha-resume-func-2025.azurewebsites.net/api/VisitorCounter'; // Or wherever your API is

async function getVisitorCount() {
    try {
        const response = await fetch(apiUrl);
        console.log('API Response:', response); // Log the response

        if (!response.ok) {
            const errorData = await response.json(); // Try to parse any error JSON
            console.error('API Error:', errorData); // Log detailed error information
            throw new Error(`API request failed with status ${response.status}: ${errorData?.error || response.statusText}`); 
        }

        const data = await response.text(); // Assuming a simple text response
        console.log('API Data:', data); // Log the data
        const count = parseInt(data.split(':')[1].trim()); // Extract count (adjust as needed)
        document.getElementById('visitor-count').textContent = count;
    } catch (error) {
        console.error('Error loading count:', error); // Log the error
        document.getElementById('visitor-count').textContent = 'Error loading count';
    }
}

getVisitorCount();
