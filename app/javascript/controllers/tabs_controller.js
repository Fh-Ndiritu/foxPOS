import { Controller } from "@hotwired/stimulus"

// # controls how active tabs are switched, currently on categories and order progress
// Connects to data-controller="tabs"
export default class extends Controller {
  connect() {
    this.tabGroup = document.querySelectorAll('.tabs-group')
    this.tabGroup.forEach(group => {
      group.querySelectorAll('.tab').forEach(tab => {
        tab.addEventListener('click', this.switchTab.bind(this))
      })
    })
  }

  switchTab(event) {
    const tab = event.currentTarget
    const tabGroup = tab.closest('.tabs-group')
    tabGroup.querySelectorAll('.tab').forEach(tab => {
      tab.classList.remove('active')
    })
    tab.classList.add('active')
  }
}
