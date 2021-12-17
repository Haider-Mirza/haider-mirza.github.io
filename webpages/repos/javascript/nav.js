const navSlide = () => {
	const burger = document.querySelector('.burger');
	const nav = document.querySelector('.nav-links');
	const navLinks = document.querySelectorAll('.nav-links li');

	burger.addEventListener('click', () => {

		// Toggle Nav
		nav.classList.toggle('nav-active');

		// Animate Links
		navLinks.forEach((link, index) => {
			if (link.style.animation) {
				link.style.animation = '';
			} else {
				link.style.animation = `navLinkFade 0.5s ease forwards ${index / 7 + 0.4}s`;
			}
		});
		// Burger Animation
		burger.classList.toggle('toggle');
	});
}
navSlide();

const whoYou = () => {
	const logo = document.querySelector('.logo');
	const who = document.querySelector('.who');

	logo.addEventListener('click', () => {

		who.classList.toggle('who-toggle');
	});
}
whoYou();
