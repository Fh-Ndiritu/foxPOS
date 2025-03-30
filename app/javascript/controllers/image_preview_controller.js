import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="image-preview"
export default class extends Controller {
  static targets = ["input", "preview", 'inputTrigger' ]
  connect() {
    // when file is attached we run previwImage function
    this.inputTarget.addEventListener("change", this.previewImage.bind(this))
    this.inputTriggerTarget.addEventListener('click', () => {
      this.inputTarget.click()
    })
  }

  previewImage(event) {
    const file = event.target.files[0]
    const reader = new FileReader()

    reader.onload = (event) => {
      this.previewTarget.src = event.target.result
    }

    reader.readAsDataURL(file)
  }


}
