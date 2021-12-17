const inputTest = document.querySelector(".inputTest");
const buttonTest = document.querySelector(".buttonTest");

buttonTest.addEventListener("click", function() {
	if (inputTest.value == 'Haider' || inputTest.value == `haider`) {
		console.log(`Permission Given`)
	} else {
		console.log(`You are not allowed in!`)
	}
});

var i = 0;
var txt = 'Linux developer, 3D artist and Emacs devotee.'; /* The text */
var speed = 50; /* The speed/duration of the effect in milliseconds */

function typeWriter() {
  if (i < txt.length) {
    document.getElementById("demo").innerHTML += txt.charAt(i);
    i++;
    setTimeout(typeWriter, speed);
  }
}

typeWriter();

const whoYou = () => {
	const logo = document.querySelector('.logo');
	const who = document.querySelector('.who');

	logo.addEventListener('click', () => {

		who.classList.toggle('who-toggle');
	});
}
whoYou();
