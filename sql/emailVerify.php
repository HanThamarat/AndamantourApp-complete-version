<?php
session_start();
require("connect.php");
include_once("../includes/domain.php");

if(isset($_GET['email']) && isset($_GET['verify_code'])){
    $email = $_GET['email'];
    $verify_code = $_GET['verify_code'];
    $stmt= $conn->query("SELECT * FROM agents WHERE agnetsEmail = '$email' AND verification_code = '$verify_code'");
    $stmt->execute();
    $row = $stmt->fetch(PDO::FETCH_ASSOC);
    if($stmt){
        if($stmt->rowCount() > 0){
            if($row['is_verify'] == 0){
                $up_verify = $conn->prepare("UPDATE agents SET is_verify = '1', status = '1' WHERE agnetsEmail = '$email'");
                $up_verify->execute();
                if($up_verify){
                    $_SESSION['agents_regis'] = $email;
                    header("location: {$domain}Admin/login.php");
                    $_SESSION['verifi'] = "Verification successfully";
                }else{
                    header("location: {$domain}Admin/login.php");
                    $_SESSION['error'] = "Verification error";
                }
            }else{
                $_SESSION['agents_regis'] = $email;
                header("location: {$domain}Admin/login.php");
                $_SESSION['verifi'] = "You have verified your identity.";
            }
        }
    }
}
?>