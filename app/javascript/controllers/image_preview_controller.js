import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="image-preview"
export default class extends Controller {
  static targets = [ "input", "preview" ]
  connect() {
    alert("Hello from image_preview_controller.js")
    this.inputTarget.addEventListener("change", this.previewImage.bind(this))
  }

  previewImage(event) {
    alert("Hello from image_preview_controller.js")
    const file = event.target.files[0]
    const reader = new FileReader()

    reader.onload = (event) => {
      this.previewTarget.src = event.target.result
    }

    reader.readAsDataURL(file)
  }
}
