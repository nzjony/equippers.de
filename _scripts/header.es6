// --
// Header Nav Toggle

const header = document.querySelector('header');
const navToggle = document.querySelector('header button');

let timeOut = null;

const toggleMenu = () => {
	clearTimeout(timeOut);
	header.classList.toggle('nav-visible');
};

const isDesktopNav = () => window.getComputedStyle(header)['align-items'] === 'center';
const getUrlPathDepth = () => location.pathname.replace(/\/$/, '').match(/\//g).length;

try {
	(() => {
		navToggle.addEventListener('click', toggleMenu);

		// auto show desktop nav for home page
		if (getUrlPathDepth() <= 1 && isDesktopNav()) {
			toggleMenu();
			// toggle back after a few seconds
			timeOut = setTimeout(toggleMenu, 10 * 1000);
		}
	})();
} catch (err) {
	console.error(err);
}
