function openTab(event, tabName) {
    // Hide all tab contents
    var tabs = document.getElementsByClassName("tab-content");
    for (var i = 0; i < tabs.length; i++) {
        tabs[i].classList.remove("active");
    }

    // Remove the "active" class from all tab links
    var links = document.getElementsByClassName("tab-link");
    for (var i = 0; i < links.length; i++) {
        links[i].classList.remove("active");
    }

    // Show the current tab
    document.getElementById(tabName).classList.add("active");

    // Add the "active" class to the clicked link
    event.currentTarget.classList.add("active");
}

// Set the default tab to be opened
document.addEventListener("DOMContentLoaded", function() {
    openTab(event, 'home');
});
