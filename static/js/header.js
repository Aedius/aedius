class Header extends HTMLElement {
    constructor() {
        super();
        this._pages = ["index", "counter", "page3"]


        this.attachShadow({ mode: 'open' });
        this.shadowRoot.innerHTML = `
        <header role="banner" class="site-header">
            <a class="site-logo" href="http://aedius.fr" rel="home" title="to homepage">
                <h1>
                    <img alt="my logo"
                         src="img/logo.jpg"
                         width="240" height="240"
                    />
                </h1>
            </a>
            <nav>
                <h2>Menu</h2>
                <ul class="menu">
                </ul>
            </nav>
        </header>
        `
    }

    connectedCallback() {
        var _selected = this.getAttribute('page');

        this._menu = this.shadowRoot.querySelector(".menu");
        console.log( this._selected)
        const li = this._pages.map( page => {
            if ( page == _selected){
                return `<li>${page}</li>`
            }else{
               return  `<li><a href="./${page}.html">${page}</a></li>`
            }
        })


        this._menu.innerHTML = li.join('')
    }
}
customElements.define('ae-header',Header);