import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "form" ]

  connect() {
    this.element.addEventListener("submit", this.submitForm.bind(this))
  }

  submitForm(event) {
    event.preventDefault()
    const form = event.target
    const url = form.action
    const formData = new FormData(form)

    fetch(url, {
      method: "POST",
      body: formData,
      headers: {
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
      }
    }).then(response => {
      if (!response.ok) {
        throw new Error("Network response was not ok")
      }
      // The reaction will be added via the broadcast
    }).catch(error => {
      console.error("Error:", error)
    })
  }
}