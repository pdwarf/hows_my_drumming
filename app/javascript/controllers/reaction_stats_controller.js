import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["stat"]

  connect() {
    console.log("Reaction stats controller connected")
    this.previousCounts = new Map()
    this.updatePreviousCounts()
  }

  updatePreviousCounts() {
    this.statTargets.forEach(stat => {
      const emoji = stat.dataset.emoji
      const count = parseInt(stat.dataset.count)
      this.previousCounts.set(emoji, count)
    })
  }

  statTargetConnected(stat) {
    console.log("Stat target connected", stat)
    if (!this.previousCounts) {
      this.previousCounts = new Map()
    }

    const emoji = stat.dataset.emoji
    const newCount = parseInt(stat.dataset.count)
    const oldCount = this.previousCounts.get(emoji) || 0

    console.log(`Emoji: ${emoji}, Old count: ${oldCount}, New count: ${newCount}`)

    if (newCount > oldCount) {
      console.log("Triggering flash animation")
      stat.classList.add('flash-animation')
      setTimeout(() => {
        stat.classList.remove('flash-animation')
      }, 1000)
    }

    this.previousCounts.set(emoji, newCount)
  }
}