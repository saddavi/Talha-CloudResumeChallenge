/**
 * Visitor Counter JavaScript
 * This script fetches the visitor count from Azure Function API
 */

<<<<<<< HEAD
// Use the specific Azure Function endpoint with query parameter format
const apiUrl =/**
 * Visitor Counter JavaScript
 * This script fetches the visitor count from Azure Function API
 */
=======
// Use the specific Azure Function endpoint
const apiUrl = "https://talha-resume-func-2025.azurewebsites.net/api/VisitorCounter";
>>>>>>> ce23339179c08b36ad4bd76592d6eb3db94a544b

// Use the specific Azure Function endpoint with query parameter format
const apiUrl =
  "https://talha-resume-func-2025.azurewebsites.net/api/VisitorCounter";

// Function to fetch and display visitor count with enhanced error handling
async function getVisitorCount() {
  try {
    console.log("Fetching visitor count from API...");

    // Display loading state
    const counterElement = document.getElementById("visitor-count");
    if (counterElement) {
      counterElement.innerText = "Loading...";
    } else {
      console.error('Element with ID "visitor-count" not found');
      return; // Exit early if the element is not found
    }

    const response = await fetch(apiUrl);
    console.log("API response status:", response.status);

    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }

    // Get the text response which should be "Visitor count: X"
    const text = await response.text();
    console.log("API response text:", text);

    // Extract just the number from the response
    const countMatch = text.match(/\d+/);
    if (countMatch) {
      const count = countMatch[0];
      counterElement.innerText = count;
      console.log("Visitor count updated:", count);
    } else {
      throw new Error("Could not extract visitor count from response");
    }
  } catch (error) {
    console.error("Error fetching visitor count:", error);
    // Provide a fallback display
    const counterElement = document.getElementById("visitor-count");
    if (counterElement) {
      counterElement.innerText = "--";
    }
  }
}

// Execute when the document is fully loaded
<<<<<<< HEAD
document.addEventListener("DOMContentLoaded", getVisitorCount);

  "https://talha-resume-func-2025.azurewebsites.net/api/VisitorCounter?";

// Function to fetch and display visitor count with enhanced error handling
async function getVisitorCount() {
  try {
    console.log("Fetching visitor count from API...");

    // Display loading state
    const counterElement = document.getElementById("visitor-count");
    if (counterElement) {
      counterElement.innerText = "Loading...";
    }

    const response = await fetch(apiUrl);
    console.log("API response status:", response.status);

    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }

    // Get the text response which should be "Visitor count: X"
    const text = await response.text();
    console.log("API response text:", text);

    // Extract just the number from the response
    const countMatch = text.match(/\d+/);
    if (countMatch) {
      const count = countMatch[0];

      if (counterElement) {
        counterElement.innerText = count;
        console.log("Visitor count updated:", count);
      } else {
        console.error('Element with ID "visitor-count" not found');
      }
    } else {
      throw new Error("Could not extract visitor count from response");
    }
  } catch (error) {
    console.error("Error fetching visitor count:", error);
    // Provide a fallback display
    const counterElement = document.getElementById("visitor-count");
    if (counterElement) {
      counterElement.innerText = "--";
    }
  }
}

// Execute when the document is fully loaded
document.addEventListener("DOMContentLoaded", getVisitorCount);
=======
document.addEventListener('DOMContentLoaded', getVisitorCount);
>>>>>>> ce23339179c08b36ad4bd76592d6eb3db94a544b
/**
 * Visitor Counter JavaScript
 * This script fetches the visitor count from Azure Function API
 */

// Use the specific Azure Function endpoint with query parameter format
const apiUrl =
  "https://talha-resume-func-2025.azurewebsites.net/api/VisitorCounter";

// Function to fetch and display visitor count with enhanced error handling
async function getVisitorCount() {
  try {
    console.log("Fetching visitor count from API...");

    // Display loading state
    const counterElement = document.getElementById("visitor-count");
    if (counterElement) {
      counterElement.innerText = "Loading...";
    } else {
      console.error('Element with ID "visitor-count" not found');
      return; // Exit early if the element is not found
    }

    const response = await fetch(apiUrl);
    console.log("API response status:", response.status);

    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }

    // Get the text response which should be "Visitor count: X"
    const text = await response.text();
    console.log("API response text:", text);

    // Extract just the number from the response
    const countMatch = text.match(/\d+/);
    if (countMatch) {
      const count = countMatch[0];
      counterElement.innerText = count;
      console.log("Visitor count updated:", count);
    } else {
      throw new Error("Could not extract visitor count from response");
    }
  } catch (error) {
    console.error("Error fetching visitor count:", error);
    // Provide a fallback display
    const counterElement = document.getElementById("visitor-count");
    if (counterElement) {
      counterElement.innerText = "--";
    }
  }
}

// Execute when the document is fully loaded
document.addEventListener("DOMContentLoaded", getVisitorCount);
