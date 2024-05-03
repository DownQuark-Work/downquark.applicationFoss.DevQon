import {LitElement, css, html} from 'lit';
import {customElement, property} from 'lit/decorators.js';

@customElement('exploration-scrx')
export class SimpleGreeting extends LitElement {
  // Define scoped styles right with your component, in plain CSS
  static styles = css`
      canvas {
        color: gold;
        position:absolute;
        top:0; left:0;
      }
  `;

  // Declare reactive properties
  @property()
  name?: string = 'mandala exploration?';


  render() {
    return html`<canvas height="600" width="800">UI/UX Exploration!</canvas> ${this.name}`;
  }
}