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

  initialize() {
    this.connect();
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue;

    let lat;
    let lng;
    if (Object.keys(this.markerValue).length === 0) {
      lat = 18.922118888070216;
      lng = -99.23449248624027;
    } else {
      lat = this.markerValue.lat;
      lng = this.markerValue.lng;
    }

    this.map = new mapboxgl.Map({
      container: this.mapContainerTarget,
      style: "mapbox://styles/mapbox/streets-v11",
      center: [lng, lat],
      zoom: 9,
    });

    this.marker = new mapboxgl.Marker({
      draggable: true,
    })
      .setLngLat([lng, lat])
      .addTo(this.map);

    this.marker.on("dragend", this.onDragEnd.bind(this));
    this.addressFieldTarget.addEventListener(
      "input",
      this.onAddressChange.bind(this)
    );
    this.longitudeFieldTarget.addEventListener(
      "input",
      this.onManualPositionChange.bind(this)
    );
    this.latitudeFieldTarget.addEventListener(
      "input",
      this.onManualPositionChange.bind(this)
    );

    // Actualizar posición en el mapa al hacer clic
    this.map.on("click", (e) => {
      this.marker.setLngLat(e.lngLat);
      this.onDragEnd(); // Llamar a la función para actualizar dirección y coordenadas
    });
  }

  onDragEnd() {
    const lngLat = this.marker.getLngLat();
    this.reverseGeocode(lngLat);
    this.longitudeFieldTarget.value = lngLat.lng;
    this.latitudeFieldTarget.value = lngLat.lat;
  }

  onAddressChange() {
    const address = this.addressFieldTarget.value;

    fetch(
      `https://api.mapbox.com/geocoding/v5/mapbox.places/${encodeURIComponent(
        address
      )}.json?access_token=${this.apiKeyValue}`
    )
      .then((response) => response.json())
      .then((data) => {
        const [lng, lat] = data.features[0].center;
        this.marker.setLngLat([lng, lat]);
        this.map.setCenter([lng, lat]);

        this.longitudeFieldTarget.value = lng;
        this.latitudeFieldTarget.value = lat;
      })
      .catch((error) => {
        console.error("Error fetching geocoding data:", error);
      });
  }

  onManualPositionChange() {
    const lng = parseFloat(this.longitudeFieldTarget.value);
    const lat = parseFloat(this.latitudeFieldTarget.value);

    this.marker.setLngLat([lng, lat]);
    this.map.setCenter([lng, lat]);
    this.reverseGeocode({ lng, lat });

    // Realizar geocodificación inversa y actualizar el campo de dirección
    this.reverseGeocode({ lng, lat });
  }

  reverseGeocode(lngLat) {
    const url = `https://api.mapbox.com/geocoding/v5/mapbox.places/${lngLat.lng},${lngLat.lat}.json`;
    fetch(url + `?access_token=${this.apiKeyValue}`)
      .then((response) => response.json())
      .then((data) => {
        const placeName = data.features[0].place_name;
        this.addressFieldTarget.value = placeName;
      });
  }
}
