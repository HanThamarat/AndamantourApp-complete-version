const menu = document.querySelector('#mobile-menu');
const menuLinks = document.querySelector('.navbar__menu');

menu.addEventListener('click', function() {
  menu.classList.toggle('is-active');
  menuLinks.classList.toggle('active');
});


const dates = new Date();
const years = dates.getFullYear();
console.log(years);
document.getElementById("yeard").innerHTML = years;