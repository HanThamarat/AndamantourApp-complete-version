<?php
    session_start();
    require_once "../../../sql/connect.php";
    include_once "../../../includes/domain.php";
    

    if(isset($_GET['id']) || isset($_GET['status'])) {
        $ag_id = $_GET['id'];
        $ag_status = $_GET['status'];
        try{
            $up_st = $conn->prepare("UPDATE agents SET status = '$ag_status' WHERE agentsID = $ag_id");
            $up_st->execute();
            if($up_st){
                echo 200;
                $_SESSION['success'] = "Update status successfully";
                header("location: {$domain}Admin/pages/agents/showAgents.php");
                }else{
                echo 404;
                $_SESSION['error'] = "Status update error";
                header("location: {$domain}Admin/pages/agents/showAgents.php");
                }
            }catch(PDOException $e){
                echo $e->getMessage();
            }
        }else{
            echo 404;
            $_SESSION['error'] = "Status update error";
            header("location: {$domain}Admin/pages/agents/showAgents.php");
        }
?>