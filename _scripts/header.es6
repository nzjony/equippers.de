// --
// Header Nav Toggle

const header = document.querySelector('header');
const navToggle = document.querySelector('header button');

const toggleMenu = () => {
	header.classList.toggle('nav-visible');
};

try {
	navToggle.addEventListener('click', toggleMenu);
} catch (err) {}
