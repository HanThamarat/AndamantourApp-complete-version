<?php
    session_start();
    require_once "../sql/connect.php";
    include_once '../includes/domain.php';

    use PHPMailer\PHPMailer\PHPMailer;
    use PHPMailer\PHPMailer\SMTP;
    use PHPMailer\PHPMailer\Exception;

    
function sendMail($email,$verification_code,$domain){
    require ("PHPMailer/PHPMailer.php");
    require ("PHPMailer/SMTP.php");
    require ("PHPMailer/Exception.php");

    $mail = new PHPMailer(true);

    try {
        //Server settings
        $mail->isSMTP();                                            //Send using SMTP
        $mail->Host       = 'smtp.gmail.com';                     //Set the SMTP server to send through
        $mail->SMTPAuth   = true;                                   //Enable SMTP authentication
        $mail->Username   = 'travelandamantour@gmail.com';                     //SMTP username
        $mail->Password   = 'xxidzbemhsdphaba';                               //SMTP password or app password google gmail
        $mail->SMTPSecure = PHPMailer::ENCRYPTION_SMTPS;            //Enable implicit TLS encryption
        $mail->Port       = 465;                                    //TCP port to connect to; use 587 if you have set `SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS`
    
        //Recipients
        $mail->setFrom('travelandamantour@gmail.com', 'AndamanTour Agency');
        $mail->addAddress($email);     //Add a recipient
    
        //Content
        $mail->isHTML(true);                                  //Set email format to HTML
        $mail->Subject = 'Email verification from AndamanTour';
        $mail->Body    = "Thanks for registration!
                          Click the link below to verify the email address<a href='{$domain}sql/emailVerify.php?email=$email&verify_code=$verification_code'> Verify</a>";
        $mail->AltBody = 'This is the body in plain text for non-HTML mail clients';
    
        $mail->send();
        return true;
    } catch (PDOException $e) {
        return false;
    }
}


    if(isset($_POST['signup'])){
        $email = $_POST['email'];
        $password = $_POST['password'];
        $password_c = $_POST['password_c'];

        
        if(empty($email)){
            $_SESSION['error'] = 'Please enter email.';
            header("location: {$domain}Admin/register.php");
        }else if(!filter_var($email, FILTER_VALIDATE_EMAIL)){
            $_SESSION['error'] = 'Please enter a valid email address.';
            header("location: {$domain}Admin/register.php");
        }else if(empty($password)){
            $_SESSION['error'] = 'Please enter password.';
            header("location: {$domain}Admin/register.php");
        }else if(strlen($_POST['password']) > 20 || strlen($_POST['password']) < 8){
            $_SESSION['error'] = 'Password must be 8 to 20 characters long.';
            header("location: {$domain}Admin/register.php");
        }else if(empty($password_c)){
            $_SESSION['error'] = 'Please confirm your password.';
            header("location: {$domain}Admin/register.php");
        }else if($password != $password_c){
            $_SESSION['error'] = "Passwords don't match";
            header("location: {$domain}Admin/register.php");
        } else {
            try{
                $check_email = $conn->prepare("SELECT agnetsEmail FROM agents WHERE agnetsEmail = :email"); //prepare ป้องกันการเกิด sql injection
                $check_email->bindParam(":email",$email);
                $check_email->execute();
                $row = $check_email->fetch(PDO::FETCH_ASSOC);

                if($row['agnetsEmail'] == $email){
                    $_SESSION['warning'] = "This email is already in the system. <a href='{$domain}login.php'></a>";
                    header("location: {$domain}Admin/register.php");
                }else if(!isset($_SESSION['error'])){
                    $passwordHash = password_hash($password, PASSWORD_DEFAULT);
                    $verification_code = bin2hex(random_bytes(16));
                    $stmt = $conn->prepare("INSERT INTO agents(agnetsEmail, agentsPassword, verification_code)
                                            VALUES(:email, :encryption_pwd, :verification_code)");
                    $stmt->bindParam(':email', $email);
                    $stmt->bindParam(':encryption_pwd', $passwordHash);
                    $stmt->bindParam(':verification_code', $verification_code);
                    $stmt->execute();

                   if($stmt && sendMail($email, $verification_code,$domain)) {
                        $_SESSION['agents_regis'] = $email;
                        $_SESSION['success'] = "สมัครสมาชิกเรียบร้อยแล้ว! <a href='{$domain}login.php' class='alert-link'>คลิ๊กที่นี้</a>เพื่อเข้าสู่ระบบ";
                        header("location: {$domain}Admin/login.php");
                   } else {
                        $_SESSION['error'] = "Server down";
                        header("location: {$domain}Admin/register.php");
                   }
                    // $_SESSION['agents_login'] = $row['agentsID'];
                    // header("location: {$domain}pages/dashboard/dashboard.php");
                }else{
                    $_SESSION['error'] = "มีบางอย่างผิดพลาด";
                    header("location: {$domain}Admin/register.php");
                }
            }catch(PDOException $e){
                echo $e->getMessage();
            }
        }
        
    }

?>