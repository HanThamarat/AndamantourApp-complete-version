<?php 
 $domain = "http://127.0.0.1/Andamantour-app/";
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="sidebar_account.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
<div class="select--menu container--menu">
                <ul class="menu">
                    <li class="sub-menu">
                        <a href="<?php echo "{$domain}Admin/agents/settings/basic.php"?>">
                            <i class="fa-regular fa-user"></i>
                            <span class="text-link">Profile</span>
                        </a>
                    </li>
                    <li class="sub-menu">
                        <a href="">
                            <i class="fa-solid fa-unlock-keyhole"></i>
                            <span class="text-link">Password</span>
                        </a>
                    </li>
                    <li class="sub-menu">
                        <a href="">
                            <i class="fa-regular fa-circle-check"></i>
                            <span class="text-link">Verification</span>
                        </a>
                    </li>
                </ul>
            </div>
</body>
</html>