<?php

include_once "includes/domain.php";
?>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>AndamanTour</title>
    <link rel="icon" type="image/x-icon" href="includes/img/icon.png">
    <link rel="stylesheet" href="index.css">
    <link
      rel="stylesheet"
      href="https://use.fontawesome.com/releases/v5.14.0/css/all.css"
      integrity="sha384-HzLeBuhoNPvSl5KYnjx0BT+WB0QEEqLprO+NBkkk5gbc67FTaL7XIGa2w1L0Xbgc"
      crossorigin="anonymous"
    />
    <link
      href="https://fonts.googleapis.com/css2?family=Kumbh+Sans:wght@400;700&display=swap"
      rel="stylesheet"
    />
  </head>
  <body>
    <!-- Navbar Section -->
    <nav class="navbar">
      <div class="navbar__container">
        <a href="#" id="navbar__logo"><img src="<?php echo "{$domain}includes/img/logotext.png";?>" alt="logo" class="logo" width="80%" loading="lazy"></a>
        <div class="navbar__toggle" id="mobile-menu">
          <span class="bar"></span> 
          <span class="bar"></span>
          <span class="bar"></span>
        </div>
        <ul class="navbar__menu">
          <li class="navbar__item">
            <a href="<?php echo "{$domain}index.php";?>" class="navbar__links">Home</a>
          </li>
          <li class="navbar__item">
            <a href="<?php echo "{$domain}Admin/login.php"; ?>" class="navbar__links">Login</a>
          </li>
          <li class="navbar__btn">
            <a href="<?php echo "{$domain}Admin/register.php"; ?>" class="button">Sign Up</a>
          </li>
        </ul>
      </div>
    </nav>

    <!-- Hero Section -->
    <div class="main">
      <div class="main__container">
        <div class="main__content">
          <h1 class="typing"></h1>
          <h2>AGENT</h2>
          <p>See what makes up different.</p>
          <button class="main__btn"><a href="<?php echo "{$domain}Admin/register.php"; ?>">Get Started</a></button>
        </div>
        <div class="main__img--container">
          <img id="main__img" src="<?php echo "{$domain}includes/img/App.png";?>" loading="lazy"/>
        </div>
      </div>
    </div>


    <!-- Footer Section -->
    <div class="footer__container">
      <div class="footer__links">
        <div class="footer__link--wrapper">
          <div class="footer__link--items">
            <h2>About Us</h2>
            <a href="<?php echo "{$domain}Admin/register.php"; ?>">How it works</a> <a href="#">Testimonials</a>
            <a href="#">Careers</a> <a href="#">Investments</a>
            <a href="#">Terms of Service</a>
          </div>
          <div class="footer__link--items">
            <h2>Contact Us</h2>
            <a href="#">Contact</a> <a href="#">Support</a>
            <a href="#">Destinations</a> <a href="#">Sponsorships</a>
          </div>
        </div>
        <div class="footer__link--wrapper">
          <div class="footer__link--items">
            <h2>Videos</h2>
            <a href="#">Submit Video</a> <a href="#">Ambassadors</a>
            <a href="#">Agency</a> <a href="#">Influencer</a>
          </div>
          <div class="footer__link--items">
            <h2>Social Media</h2>
            <a href="#">Instagram</a> <a href="https://www.facebook.com/profile.php?id=100040544021655">Facebook</a>
          </div>
        </div>
      </div>
      <section class="social__media">
        <div class="social__media--wrap">
          <div class="footer__logo">
          <a href="#" id="navbar__logo"><img src="<?php echo "{$domain}includes/img/logotext.png";?>" alt="logo" class="logo" width="80%" loading="lazy"></a>
          </div>
          <p class="website__rights">© AndamanTour <span id="yeard"></span>. All rights reserved</p>
          <div class="social__icons">
            <a
              class="social__icon--link"
              href="https://www.facebook.com/profile.php?id=100040544021655"
              target="_blank"
              aria-label="Facebook"
            >
              <i class="fab fa-facebook"></i>
            </a>
            <a
              class="social__icon--link"
              href="#"
              target="_blank"
              aria-label="Instagram"
            >
              <i class="fab fa-instagram"></i>
            </a>
            <a
              class="social__icon--link"
              href="#"
              target="_blank"
              aria-label="Twitter"
            >
              <i class="fab fa-twitter"></i>
            </a>
            <a
              class="social__icon--link"
              href="#"
              target="_blank"
              aria-label="LinkedIn"
            >
              <i class="fab fa-linkedin"></i>
            </a>
          </div>
        </div>
      </section>
    </div>
    <script src="app.js"></script>
    <!-- Cookie Consent by https://www.cookiewow.com -->
    <script type="text/javascript" src="https://cookiecdn.com/cwc.js"></script>
    <script id="cookieWow" type="text/javascript" src="https://cookiecdn.com/configs/BZLzQ7UdAK8D9btTEyNDCfBP" data-cwcid="BZLzQ7UdAK8D9btTEyNDCfBP"></script>
    <script src="https://unpkg.com/typed.js@2.0.16/dist/typed.umd.js"></script>
    <script>
        var typed = new Typed(".typing", {
            strings: ["AndamanTour App"],
            typeSpeed: 150,
            backSpeed:150,
            loop: true,
            showCursor: false,
        })
    </script>
  </body>
</html>
