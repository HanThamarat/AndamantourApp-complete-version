<?php
 session_start();
 require_once "../../../sql/connect.php";
 include_once "../../../includes/domain.php";

 if(isset($_GET['id']) || isset($_GET['status'])){
    $id = $_GET['id'];
    $status = $_GET['status'];
     try{
        $up_st = $conn->prepare("UPDATE packages SET status = '$status' WHERE packID = $id");
        $up_st->execute();
        if($up_st){
            $_SESSION['success'] = "Update status successfully";
            header("location: {$domain}Admin/agents/insertpackage/insertpackage.php");
            }else{
            $_SESSION['error'] = "Status update error";
            header("location: {$domain}Admin/agents/insertpackage/insertpackage.php");
            }
        }catch(PDOException $e){
            echo $e->getMessage();
        }
    }else{
        $_SESSION['error'] = "Status update error";
        header("location: {$domain}Admin/agents/insertpackage/insertpackage.php");
    }
?>