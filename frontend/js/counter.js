async function getVisitorCount() {
  try {
    const response = await fetch(
      "https://talha-resume-func-2025.azurewebsites.net/api/VisitorCounter",
      {
        method: "GET",
        headers: {
          Accept: "text/plain",
        },
      }
    );

    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }

    const text = await response.text();
    const count = text.split(": ")[1];
    document.getElementById("visitor-counter").innerText = count;
  } catch (error) {
    console.error("Error fetching visitor count:", error);
    document.getElementById("visitor-counter").innerText =
      "Error loading count";
  }
}

document.addEventListener("DOMContentLoaded", getVisitorCount);
