async function getVisitorCount() {
  try {
    const response = await fetch("http://localhost:7071/api/VisitorCounter");
    const count = await response.text();
    document.getElementById("visitor-counter").innerText = count;
  } catch (error) {
    console.error("Error fetching visitor count:", error);
    document.getElementById("visitor-counter").innerText =
      "Error loading count";
  }
}

// Call the function when the page loads
document.addEventListener("DOMContentLoaded", getVisitorCount);
