// app/javascript/application.js
import { Application } from "@hotwired/stimulus"
import ClickController from "./click_controller"

const application = Application.start()
application.register("click", ClickController)

export { application }
