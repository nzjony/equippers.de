// see https://gist.github.com/simonhaenisch/be44e97f89a4075b0d734cc0240ae6c1
if (window.fetch) {
	(async d => {
		const c = new AbortController(),
			signal = c.signal,
			s = d.createElement('style');
		setTimeout(() => c.abort(), 750);
		s.textContent = await (await fetch('https://use.typekit.net/rzo8uqn.css', { signal })).text();
		d.querySelector('head > *:last-child').after(s);
		d.documentElement.classList.add('wf-active');
	})(document).catch(() => console.warn('Font loading aborted due to slow network.'));
}
