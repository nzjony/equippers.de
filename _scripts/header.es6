(() => {
	// --
	// Header Nav Toggle

	document
		.querySelector('header button')
		.addEventListener('click', () => document.querySelector('header').classList.toggle('nav-visible'));
})();
