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

// News toggle
// const foldNews = () => {
// 	const news = document.querySelector('.news h2');
// 	const links = document.querySelector('.old-news a');

// 	news.addEventListener('click', () => {
// 		links.classList.toggle('old-news-active');
// 	});
// }

// foldNews();
navSlide();
