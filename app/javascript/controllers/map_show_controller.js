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
      style: "mapbox://styles/mapbox/streets-v10",
      zoom: 10,
      center: [ this.markerValue.lng, this.markerValue.lat ]
    })
    this.#addMarkersToMap()
    this.#fitMapToMarker()
  }

  #addMarkersToMap() {
      new mapboxgl.Marker()
        .setLngLat([ this.markerValue.lng, this.markerValue.lat ])
        .addTo(this.map)
  }
  #fitMapToMarker() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markerValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }
}
