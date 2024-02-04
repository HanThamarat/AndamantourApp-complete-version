<?php
    require("../../../../sql/connect.php");
    include("../../../../includes/domain.php");

    if($_GET['id']){
        $id = $_GET['id'];
        $firstname = $_POST['firstname'];
        $lastname = $_POST['lastname'];
        $phonenumber = $_POST['phonenumber'];
        try{
            $up_ag = $conn->prepare("UPDATE agents SET agentsName = '$firstname', agentsLastname = '$lastname', phone = '$phonenumber' WHERE agentsID = $id");
            $up_ag->execute();
            if($up_ag){
                http_response_code(200);
            } else {
                http_response_code(400);
            }
        }catch(PDOException $e) {
            echo $e->getMessage();
        }
    }
?>