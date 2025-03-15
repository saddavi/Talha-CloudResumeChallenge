/**
 * Visitor Counter JavaScript
 * This script fetches the visitor count from Azure Function API
 */

// Get the API endpoint from the data attribute
const apiUrl = document.querySelector('body').dataset.apiEndpoint;

// Function to fetch and display visitor count
async function getVisitorCount() {
  try {
    console.log("Fetching visitor count from API...");

    // Display loading state
    const counterElement = document.getElementById("visitor-count");
    if (!counterElement) {
      console.error('Element with ID "visitor-count" not found');
      return;
    }

    counterElement.innerText = "Loading...";

    const response = await fetch(apiUrl);
    console.log("API response status:", response.status, response.statusText);

    if (!response.ok) {
      throw new Error(
        `API request failed with status ${response.status}: ${response.statusText}`
      );
    }

    // Get text response (not JSON)
    const textData = await response.text();
    console.log("API Data:", textData);

    // Extract just the number from "Visitor count: 139"
    const countMatch = textData.match(/\d+/);
    if (countMatch) {
      const count = countMatch[0];
      counterElement.innerText = count;
      console.log("Visitor count updated:", count);
    } else {
      throw new Error("Could not extract visitor count from response");
    }
  } catch (error) {
    console.error("Error fetching visitor count:", error);
    const counterElement = document.getElementById("visitor-count");
    if (counterElement) {
      counterElement.innerText = "--";
    }
  }
}

// Execute when the document is fully loaded
document.addEventListener("DOMContentLoaded", getVisitorCount);
