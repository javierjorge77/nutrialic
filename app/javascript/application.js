import $ from "jquery";
window.jQuery = $;
window.$ = $;
// Entry point for the build script in your package.json
import "@hotwired/turbo-rails";
import "./controllers";
import "bootstrap";
import "lightbox2";

import { end } from "@popperjs/core";
