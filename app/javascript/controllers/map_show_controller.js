import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="map-show"
export default class extends Controller {
  static values = {
  apiKey: String,
  marker: Object
  }

  connect() {
     mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })
    this.#addMarkersToMap()
  }

  #addMarkersToMap() {
      new mapboxgl.Marker()
        .setLngLat([ this.markerValue.lng, this.markerValue.lat ])
        .addTo(this.map)

  }
}
