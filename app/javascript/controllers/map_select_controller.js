import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = {
    apiKey: String,
    marker: Object,
  };

  static targets = [
    "mapContainer",
    "addressField",
    "latitudeField",
    "longitudeField",
  ];

  connect() {
    let lat;
    let lng;
    mapboxgl.accessToken = this.apiKeyValue;
    if (Object.keys(this.markerValue).length === 0) {
      lat = 18.922118888070216;
      lng = -99.23449248624027;
    } else {
      lat = this.markerValue.lat;
      lng = this.markerValue.lng;
    }
    console.log(lat, lng);

    this.map = new mapboxgl.Map({
      container: this.mapContainerTarget,
      style: "mapbox://styles/mapbox/streets-v11",
      center: [lng, lat], // Coordenadas iniciales del mapa
      zoom: 9,
    });

    this.marker = new mapboxgl.Marker({
      draggable: true,
    })
      .setLngLat([lng, lat]) // Coordenadas iniciales del marcador
      .addTo(this.map);

    this.marker.on("dragend", this.onDragEnd.bind(this));

    this.map.on("click", (e) => {
      this.marker.setLngLat(e.lngLat);
      this.onDragEnd();
    });
  }

  onDragEnd() {
    const lngLat = this.marker.getLngLat();
    this.reverseGeocode(lngLat);
    this.longitudeFieldTarget.value = lngLat.lng;
    this.latitudeFieldTarget.value = lngLat.lat;
  }

  reverseGeocode(lngLat) {
    const url =
      "https://api.mapbox.com/geocoding/v5/mapbox.places/" +
      lngLat.lng +
      "," +
      lngLat.lat +
      ".json";
    const accessToken = this.apiKeyValue;
    fetch(url + "?access_token=" + accessToken)
      .then((response) => response.json())
      .then((data) => {
        const placeName = data.features[0].place_name;
        this.addressFieldTarget.value = placeName;
      });
  }
}
