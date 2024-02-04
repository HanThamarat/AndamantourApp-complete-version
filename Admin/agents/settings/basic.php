<?php
    session_start();
    include_once '../../../includes/domain.php';
    include_once '../../../sql/connect.php';


    if(!isset($_SESSION['agents_login'])){
        $_SESSION['error'] = "Please login";
        header("location: {$domain}Admin/login.php");
    }

    $id = $_SESSION['agents_login'];


?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AndamanTour | Dashboard</title>
    <link rel="stylesheet" href="basic.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
    <?php include_once("../includes/sidebar.php")?>
    <div class="main-container">
        <div class="header">
            <div class="header-title">
                <?php
                    if(isset($_SESSION['agents_login'])){
                        $agents_id = $_SESSION['agents_login'];
                        $stmt = $conn->query("SELECT * FROM agents WHERE agentsID = $agents_id");
                        $stmt->execute();
                        $row = $stmt->fetch(PDO::FETCH_ASSOC);
                    }
                ?>
                <span><?php echo $row['agentsName'] . ' ' . $row['agentsLastname']?></span>
                <h2>Agent account setting</h2>
            </div>
            <div class="user-info">
                <a href="<?php echo "{$domain}Admin/agents/selectprofile/selectprofile.php?id=" . $row['agentsID']?>"><img src="<?php echo "{$domain}Admin/agents/img/" . $row['image'];?>" alt="profile"></a>
            </div>
        </div>
        <div class="account--setting--container">
            <?php
                $stmt = $conn->query("SELECT * FROM agents WHERE agentsID = $id");
                $stmt->execute();
                $row = $stmt->fetch(PDO::FETCH_ASSOC);
            ?>
           <?php include("sidebar_account.php")?>
            <div class="input-basic-container container">
                <div class="profile--card">
                    <a href=""><img src="<?php echo "{$domain}Admin/agents/img/" . $row['image'];?>" alt=""></a>
                    <div class="fullName">
                        <p><?php echo $row['agentsName']?></p>
                        <p><?php echo $row['agentsLastname']?></p>
                    </div>
                </div>
                <div class="input--wapper">
                    <div class="input--Bx">
                        <p class="main--title">AgentID</p>
                        <input type="text" value="<?php echo $row['agentsID'];?>" readonly>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>