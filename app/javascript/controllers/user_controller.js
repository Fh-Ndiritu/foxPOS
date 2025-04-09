import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

// Connects to data-controller="user"
export default class extends Controller {
  connect() {
  document.addEventListener("DOMContentLoaded", () => {
      flatpickr('.birthday-picker', {
        dateFormat: "Y-m-d",
        maxDate: "01.01.2010",
      })

      flatpickr(".time-picker", {
        enableTime: true,
        noCalendar: true,
        dateFormat: "H:i",
        time_24hr: false
      })
    });
  }
}
