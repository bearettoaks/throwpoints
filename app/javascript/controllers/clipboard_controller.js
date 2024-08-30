// app/javascript/controllers/clipboard_controller.js

import { Controller } from "@hotwired/stimulus"
import Clipboard from "clipboard"
import tippy from "tippy.js"
import "tippy.js/dist/tippy.css"

export default class extends Controller {
  connect() {
    this.clipboard = new Clipboard(this.element, {
      text: (trigger) => {
        return trigger.getAttribute('data-clipboard-text');
      }
    });

    // Set up success and error handlers
    this.clipboard.on('success', (e) => {
      this.showTooltip(e.trigger, 'Copied!');
      e.clearSelection();
    });

    this.clipboard.on('error', (e) => {
      console.log(e);
      this.showTooltip(e.trigger, 'Failed to copy');
    });

    // Initialize Tippy.js
    tippy(this.element, {
      content: "Click to copy",
      trigger: 'mouseenter focus',
      hideOnClick: true,
    });
  }

  disconnect() {
    this.clipboard.destroy();
  }

  showTooltip(trigger, message) {
    const instance = trigger._tippy;
    instance.setContent(message);
    instance.show();
    setTimeout(() => {
      instance.hide();
      instance.setContent("Click to copy");
    }, 1500);
  }
}

