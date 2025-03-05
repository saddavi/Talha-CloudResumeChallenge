const apiUrl = "https://talha-resume-func-2025.azurewebsites.net/api/counter";

async function getVisitorCount() {
  try {
    console.log("Fetching count from:", apiUrl);
    const response = await fetch(apiUrl);
    console.log("API Response Status:", response.status, response.statusText);

    if (!response.ok) {
      console.error("API Error Status:", response.status, response.statusText);
      throw new Error(
        `API request failed with status ${response.status}: ${response.statusText}`
      );
    }

    const data = await response.json(); // Change to JSON if your API returns JSON
    console.log("API Data:", data);

    // Update based on your actual API response format
    const count = data.count || data.visits || data; // Adapt to your API's response structure
    document.getElementById("visitor-count").textContent = count;
  } catch (error) {
    console.error("Error loading count:", error);
    document.getElementById("visitor-count").textContent =
      "Error loading count";
  }
}

getVisitorCount();
