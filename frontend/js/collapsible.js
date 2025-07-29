/**
 * Simple Collapsible Functionality for Cloud Resume
 */

// Initialize when DOM is loaded
document.addEventListener('DOMContentLoaded', function() {
  console.log('DOM loaded, setting up collapsibles...');
  
  // Find all collapsible sections
  const sections = document.querySelectorAll('.collapsible-section');
  console.log('Found', sections.length, 'collapsible sections');
  
  sections.forEach(function(section, index) {
    const header = section.querySelector('.collapsible-header');
    const content = section.querySelector('.collapsible-content');
    const toggle = section.querySelector('.collapsible-toggle');
    
    if (!header || !content || !toggle) {
      console.log('Section ' + index + ' missing elements:', {
        header: !!header,
        content: !!content, 
        toggle: !!toggle
      });
      return;
    }
    
    console.log('Setting up section ' + index + ':', section.id);
    
    // Set initial state - collapsed
    content.style.display = 'none';
    toggle.textContent = '+';
    
    // Add click handler to header
    header.addEventListener('click', function() {
      console.log('Toggling section:', section.id);
      
      if (content.style.display === 'none') {
        // Expand
        content.style.display = 'block';
        toggle.textContent = '−';
        console.log('Expanded:', section.id);
      } else {
        // Collapse
        content.style.display = 'none';
        toggle.textContent = '+';
        console.log('Collapsed:', section.id);
      }
    });

    // Also add click handler to just the button
    toggle.addEventListener('click', function(e) {
      e.stopPropagation(); // Prevent double triggering
      header.click();
    });
  });
  
  // Add global controls
  addGlobalControls();
  
  console.log('Collapsible setup complete!');
});

function addGlobalControls() {
  // Find the cloud projects section
  const headings = document.querySelectorAll('h2');
  let cloudSection = null;
  
  for (let h of headings) {
    if (h.textContent.includes('Cloud Projects')) {
      cloudSection = h;
      break;
    }
  }
  
  if (cloudSection) {
    const controls = document.createElement('div');
    controls.className = 'collapsible-controls';
    controls.innerHTML = 
      '<button type="button" class="collapsible-control-btn" onclick="expandAll()">' +
        '<i class="fas fa-chevron-down"></i> Show All Details' +
      '</button>' +
      '<button type="button" class="collapsible-control-btn" onclick="collapseAll()">' +
        '<i class="fas fa-chevron-up"></i> Hide All Details' +
      '</button>';
    
    cloudSection.insertAdjacentElement('afterend', controls);
    console.log('Added global controls');
  }
}

function expandAll() {
  console.log('Expanding all sections');
  document.querySelectorAll('.collapsible-content').forEach(function(content) {
    content.style.display = 'block';
  });
  document.querySelectorAll('.collapsible-toggle').forEach(function(toggle) {
    toggle.textContent = '−';
  });
}

function collapseAll() {
  console.log('Collapsing all sections');
  document.querySelectorAll('.collapsible-content').forEach(function(content) {
    content.style.display = 'none';
  });
  document.querySelectorAll('.collapsible-toggle').forEach(function(toggle) {
    toggle.textContent = '+';
  });
}
