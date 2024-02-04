<?php
    include_once "domain.php";
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NavBar</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="style/nav.css">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
</head>
<body>
    <header class="header">
        <a href=""><img src="<?php echo "{$domain}includes/img/logo.png";?>" alt="logo" class="logo"></a>
        

        <nav>
            <ul class="nav_links">
                <li><a href="<?php echo "{$domain}index.php";?>">Home</a></li>
                <li><a href="#">Services</a></li>
                <li><a href="#">About</a></li>
                <li><a href="#">Contact</a></li>
            </ul>
        </nav>
        <div class="SignUp-SignIn">
            <a href="<?php echo "{$domain}Admin/login.php"; ?>">Sign In</a>
            <a href="<?php echo "{$domain}Admin/register.php"; ?>" class="Sign-Up"><button>Sign Up</button></a>
        </div>
    </header>
</body>
</html>