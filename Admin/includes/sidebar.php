<?php
    $domain = "http://127.0.0.1/Andamantour-app/";
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>slide bar</title>
    <link rel="stylesheet" href="<?php echo "{$domain}Admin/includes/slideBar.css"?>">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
    <div class="sidebar">
        <div class="logo--detail">
            <div class="smail--logo">
            <img src="<?php echo "{$domain}includes/img/logo_while.png"?>" alt="logo" loading="lazy">
            </div>
            <img src="<?php echo "{$domain}includes/img/logotext.png"?>" alt="logo" loading="lazy">
        </div>
        <ul class="nav-links">
            <li>
                <a href="<?php echo "{$domain}Admin/pages/dashboard/dashboard.php"?>">
                    <i class='bx bxs-dashboard'></i>
                    <span class="link--name">Dashboard</span>
                </a>
            </li>
            <li>
                <div class="icon-links">
                    <a href="<?php echo "{$domain}Admin/pages/packages/package.php"?>">
                        <i class="fa-solid fa-suitcase"></i>
                        <span class="link--name">Packages</span>
                    </a>
                    <i class="fa-solid fa-chevron-down arrow"></i>
                </div>
                <ul class="sub--menu">
                    <li><a class="link--name" href="<?php echo "{$domain}Admin/pages/packages/package.php"?>">Packages</a></li>
                    <li><a href="<?php echo "{$domain}Admin/pages/packages/package.php"?>">Package Detail</a></li>
                    <li><a href="<?php echo "{$domain}Admin/pages/packages/packageConfirm.php"?>">Package Confirm</a></li>
                </ul>
            </li>
            <li>
                <a href="<?php echo "{$domain}Admin/pages/agents/showAgents.php"?>">
                    <i class='fa-solid fa-users'></i>
                    <span class="link--name">Agents</span>
                </a>
            </li>
            <li>
                <div class="icon-links">
                    <a href="<?php echo "{$domain}Admin/pages/reserve/showReserve.php"?>">
                    <i class="fa-solid fa-person-walking-luggage"></i>
                        <span class="link--name">Bookings</span>
                    </a>
                    <i class="fa-solid fa-chevron-down arrow"></i>
                </div>
                <ul class="sub--menu">
                    <li><a href="<?php echo "{$domain}Admin/pages/reserve/showBooking/showDetailbook.php"?>">Detail bookings</a></li>
                    <li><a href="<?php echo "{$domain}Admin/pages/reserve/showReserve.php"?>">Confirm bookings</a></li>
                    <li><a href="<?php echo "{$domain}Admin/pages/reserve/cancelBooking/calelBooking.php"?>">Cancel bookings</a></li>
                </ul>
            </li>
            <li>
                <div class="logout--btn">
                        <a href="<?php echo "{$domain}Admin/logout.php"?>">
                            <i class="fa-solid fa-right-from-bracket"></i>
                            <span class="link--name">Logout</span>
                        </a>
                </div>
            </li>
        </ul>
    </div>
</div>
<div class="home--section">
        <div class="home-content">
            <i class="fa-solid fa-bars"></i>
        </div>
    <script>
        let arrow = document.querySelectorAll('.arrow');
            for(var i = 0; i < arrow.length; i++) {
                arrow[i].addEventListener("click", (e)=>{
                    let arrowParent = e.target.parentElement.parentElement;
                    console.log(arrowParent);
                    arrowParent.classList.toggle("showMenu");
                });
            }

            let sidebar = document.querySelector('.sidebar');
            let sidebarBtn = document.querySelector('.fa-bars');

            sidebarBtn.addEventListener("click", ()=>{
                sidebar.classList.toggle("close");
            });
    </script>
</body>
</html>