// --
// Header Nav Toggle

const header = document.querySelector('header');
const navToggle = document.querySelector('header button');

let timeOut = null;
const clearTheTimeOut = () => clearTimeout(timeOut);

const toggleMenu = () => {
	clearTheTimeOut();
	header.classList.toggle('nav-visible');
};

const isDesktopNav = () => window.getComputedStyle(header)['align-items'] === 'center';
const getUrlPathDepth = () => location.pathname.replace(/\/$/, '').match(/\//g).length;

try {
	(() => {
		navToggle.addEventListener('click', toggleMenu);

		if (isDesktopNav()) {
			// auto show desktop nav
			toggleMenu();

			// toggle back after a few seconds
			timeOut = setTimeout(toggleMenu, (getUrlPathDepth() <= 1 ? 10 : 3) * 1000);
			// interupt toggle back if nav gets hovered
			document.querySelector('header nav').addEventListener('mouseover', clearTheTimeOut);
		}
	})();
} catch (err) {
	console.error(err);
}
