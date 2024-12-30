// app/javascript/controllers/click_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  handleClick() {
    console.log("Element Clicked!");
  }
}
