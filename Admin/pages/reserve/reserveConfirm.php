<?php
 session_start();
 require("../../../sql/connect.php");
 include_once("../../../includes/domain.php");

 if(isset($_GET['reserveID'])){
    $reserveID = $_GET['reserveID'];
    try{
        $up_st = $conn->prepare("UPDATE reserve SET status_payment='1' WHERE reserveID = $reserveID");
        $up_st->execute();
        if($up_st){
            $_SESSION['success'] = "confirm booking success";
            header("location: {$domain}Admin/pages/reserve/showReserve.php");
        } else {
            $_SESSION['error'] = "Server Error";
            header("location: {$domain}Admin/pages/reserve/reserveDetail.php");
        }
    }catch(PDOException $e){
        echo $e->getMessage();
    }
 } else {
    $_SESSION['error'] = "Server Error";
    header("location: {$domain}Admin/pages/reserve/reserveDetail.php");
 }
?>