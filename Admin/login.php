<?php 
session_start();
require_once "../sql/connect.php";
include_once '../includes/domain.php';

try{
    if(isset($_SESSION['agents_regis'])){
        $email = $_SESSION['agents_regis'];
        if(isset($_SESSION['success']) || isset($_SESSION['verifi'])){
            $check_login = $conn->prepare("SELECT * FROM agents WHERE agnetsEmail = :email");
            $check_login->bindParam(":email" , $email);
            $check_login->execute();
            $row = $check_login->fetch(PDO::FETCH_ASSOC);
            if($check_login->rowCount() > 0){
                if($email == $row['agnetsEmail']){
                    $_SESSION['agents_login'] = $row['agentsID'];
                    header("location:{$domain}Admin/agents/dashboard.php");
                }
            }
        }
    }
}catch(PDOException $e){
    echo $e->GetMessage();
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AndamanTour | Login</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="assets/Styles/login_styles.css">
</head>
<body>
    <section>
        <div class="vdoBx">
            <video autoplay loop muted plays-inline class="back-video">
                <source src="../includes/video/info_smail.mp4" type="video/mp4">
            </video>
        </div>
        <div class="contentBx">
            <div class="back-page">
                <a href="<?php echo "{$domain}"?>"><i class="fa-solid fa-house"></i>Home page</a>
            </div>
            <div class="form">
                <div class="img-title-form">
                    <img src="../includes/img/backlogo.png" alt="">
                </div>
                <H2>Login</H2>
                <form action="check_loginAgent.php" method="POST">
                <div class="alert">
                <?php if(isset($_SESSION['error'])) { ?>
                    <div class="error-alert" role="alert">
                        <?php 
                            echo $_SESSION['error'];
                            unset($_SESSION['error']);
                        ?>
                    </div>
                <?php } ?>
                <?php if(isset($_SESSION['success'])) { ?>
                    <div class="suscess-alert" role="alert">
                        <?php 
                            echo $_SESSION['success'];
                            unset($_SESSION['success']);
                        ?>
                    </div>
                <?php } ?>
                </div>
                    <div class="inputBx">
                        <span>Email</span>
                        <input type="text" name="email" placeholder="Email">
                    </div>
                    <div class="inputBx">
                        <span>Password</span>
                        <input type="password" name="password" placeholder="Password" id="Myinput">
                    </div>
                    <div class="remember">
                        <label><input type="checkbox" name="" onclick="showPass()"> Show Password</label>
                    </div>
                    <div class="inputBx">
                        <input type="submit" value="Sign In" name="login">
                    </div>
                </form>
                <div class="href-regis">
                <center><span>New to AndamantourTour?<a href="<?php echo "{$domain}Admin/register.php"?>"> SignUp Now.</a></span></center>
                </div>
            </div>
        </div>
    </section>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <script>
        function showPass() {
            let Mypass = document.getElementById("Myinput");

            if(Mypass.type === "password") {
                Mypass.type = "text";
            } else {
                Mypass.type = "password";
            }
        }
    </script>
</body>
</html>
