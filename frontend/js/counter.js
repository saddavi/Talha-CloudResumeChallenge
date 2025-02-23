async function getVisitorCount() {
  try {
    const response = await fetch("http://localhost:7071/api/VisitorCounter", {
      method: "GET",
      headers: {
        Accept: "text/plain",
      },
    });

    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }

    const text = await response.text();
    // Extract just the number from "Visitor count: X"
    const count = text.split(": ")[1];
    document.getElementById("visitor-counter").innerText = count;
  } catch (error) {
    console.error("Error fetching visitor count:", error);
    document.getElementById("visitor-counter").innerText =
      "Error loading count";
  }
}

// Call the function when the page loads
document.addEventListener("DOMContentLoaded", getVisitorCount);
