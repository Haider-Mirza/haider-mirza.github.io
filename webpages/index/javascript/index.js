const inputTest = document.querySelector(".inputTest");
const buttonTest = document.querySelector(".buttonTest");

buttonTest.addEventListener("click", function() {
	if (inputTest.value == `squarerootofminusone`) {
		console.log(`Permission Given`)
    window.location.href = "http://www.haider.gq";
	} else {
		console.log(`Incorrect Password!`)
		window.alert(`Incorrect Password! \n please try again.`)
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
