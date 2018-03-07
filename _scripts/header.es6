// --
// Header Nav Toggle

const header = document.querySelector('header');

let timeOut = null;

const toggleMenu = () => {
	clearTimeout(timeOut);
	header.classList.toggle('nav-visible');
};

const isDesktopNav = () => window.getComputedStyle(header)['align-items'] === 'center';

try {
	(() => {
		document.querySelector('header button').addEventListener('click', toggleMenu);

		// auto show and hide desktop menu for home page
		if (location.pathname.match(/\//g).length <= 2 && isDesktopNav()) {
			toggleMenu();
			// toggle back after a few seconds
			timeOut = setTimeout(toggleMenu, 10 * 1000);
		}
	})();
} catch (err) {
	console.error(err);
}
