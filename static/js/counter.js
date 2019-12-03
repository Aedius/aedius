class Counter extends HTMLElement {
    constructor() {
        super();
        this._nb = 0
        this._modal;
        this.attachShadow({ mode: 'open' });
        this.shadowRoot.innerHTML = `

        <button>Click me to count</button>
        <div class="result">
          0
        </div>
        `
    }
    connectedCallback() {
        this._nb = 0
        this._result = this.shadowRoot.querySelector(".result");
        this.shadowRoot.querySelector("button").addEventListener('click', this._add_one.bind(this));
    }
    disconnectedCallback() {
        this.shadowRoot.querySelector("button").removeEventListener('click', this._add_one);
    }
    _add_one() {
        this._nb ++
        this._result.innerHTML = this._nb
    }
}
customElements.define('ae-counter',Counter);