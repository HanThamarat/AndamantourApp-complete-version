<?php
    $domain = "http://127.0.0.1/Andamantour-app/";
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sidebar</title>
    <link rel="stylesheet" href="../assets/Styles/sidebar.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body>
    <div class="sidebar">
        <div class="logo">
        <img src="<?php echo "{$domain}includes/img/logoText.png"?>" alt="logo" loading="lazy">
        </div>
            <ul class="menu">
                <li><a href="<?php echo "{$domain}Admin/pages/dashboard/dashboard.php"?>"><i class="bi bi-speedometer"></i><span>Dashboard</span></a></li>
                <li><a href="<?php echo "{$domain}Admin/pages/packages/package.php"?>"><i class="bi bi-clipboard2-data"></i><span>Packages</span></a></li>
                <li><a href="<?php echo "{$domain}Admin/pages/agents/showAgents.php"?>"><i class="bi bi-people"></i><span>Agents</span></a></li>
                <li><a href="#"><i class="bi bi-speedometer"></i><span>Dashboard</span></a></li>
                <li class="logout">
                    <a href="<?php echo "{$domain}Admin/logout.php"?>"><i class="bi bi-box-arrow-in-right"></i><span>Logout</span></a>
                </li>
            </ul>
    </div>
</body>
</html>