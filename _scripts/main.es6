//= require header.js

// hover effects on mobile
document.querySelector('body').addEventListener('touchstart', () => {});

// lock hero height which is based on the viewport height (vh) unit
// (for mobile browsers with variable viewport height, e. g. Chrome on iOS)
const hero = document.querySelector('.hero');
if (hero) {
	hero.style.height = hero.offsetHeight + 'px';
}
