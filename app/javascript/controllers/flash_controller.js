import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="flash"
export default class extends Controller {
  connect() {
    this.autoDismissFlash();
  }

  autoDismissFlash() {
    const flashContainer = this.element; // The #flash element
    const flashMessages = flashContainer.querySelectorAll(".flash-message");

    flashMessages.forEach((message) => {
      setTimeout(() => {
        message.classList.add("fade-out");
        setTimeout(() => {
          message.remove();
          if (flashContainer.children.length === 0) {
            flashContainer.style.display = "none"; // Hide the entire #flash element when empty
          }
        }, 500); // Fully remove after fade-out
      }, 4000); // 5-second delay for auto-dismiss

      const closeButton = message.querySelector(".close-button");
      if (closeButton) {
        closeButton.addEventListener("click", () => {
          message.remove();
          if (flashContainer.children.length === 0) {
            flashContainer.style.display = "none";
          }
        });
      }
    });
  }
}
