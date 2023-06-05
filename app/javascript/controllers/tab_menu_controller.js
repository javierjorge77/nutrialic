import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["tabcontent", "tablink"];

  connect() {
    this.tabContentsElements = this.tabcontentTargets;
    this.tabLinks = this.tablinkTargets;
  }

  openTab(event) {
    const tabName = event.target.dataset.tabName;
    //remove all tabcontents
    this.tabContentsElements.forEach((element) => {
      element.style.display = "none";
    });

    // remove tablink active classes
    this.tabLinks.forEach((element) => {
      element.classList.remove("active");
    });

    // add active class on tablink and open it
    event.target.classList.add("active");
    const tabContentElement = this.tabContentsElements.find((element) => {
      if (element.id === tabName) {
        return element;
      }
      return false;
    });

    if (tabContentElement) {
      tabContentElement.style.display = "block";
    }
  }
}
