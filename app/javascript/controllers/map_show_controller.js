import { Controller } from "@hotwired/stimulus";
export default class extends Controller {
  static values = {
    apiKey: String,
    marker: Object,
  };

  connect() {
    mapboxgl.accessToken = this.apiKeyValue;
    const lat = this.markerValue.lat;
    const lng = this.markerValue.lng;
    console.log(lat, lng);

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v11",
      zoom: 18,
      center: [lng, lat],
    });

    new mapboxgl.Marker().setLngLat([lng, lat]).addTo(this.map);

    const bounds = new mapboxgl.LngLatBounds();
    bounds.extend([lng, lat]);
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
  }
}
