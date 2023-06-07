import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["fechaelement", "horaelement"];

  connect() {
    this.fechaElements = this.fechaelementTargets;
    this.horaElements = this.horaelementTargets;
    // Recorrer cada elemento y formatear fecha y hora
    this.fechaElements.forEach((fechaElement) => {
      let fechaValue = fechaElement.innerText;
      let fechaUTC = new Date(fechaValue);
      let fechaLocal = new Date(
        fechaUTC.getTime() + fechaUTC.getTimezoneOffset() * 60000
      );
      let fechaFormateada = fechaLocal.toLocaleDateString("es-ES", {
        day: "2-digit",
        month: "2-digit",
        year: "numeric",
      });
      fechaElement.innerText = fechaFormateada;
    });

    this.horaElements.forEach((horaElement) => {
      let horaValue = horaElement.innerText;
      let horaCorrecta = horaValue.substring(11, 19);
      horaElement.innerText = horaCorrecta;
    });
  }
}
