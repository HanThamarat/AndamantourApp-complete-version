<?php
    session_start();
    require('../../../../sql/connect.php');
    include_once('../../../../includes/domain.php');


    if($_GET['id']) {
        try {
            $reserveID = $_GET['id'];
            $up_st = $conn->prepare("UPDATE reserve SET status_cancel = '2' , status_refundMoney = '1' WHERE reserveID = $reserveID");
            $up_st->execute();
    
            if($up_st){
                http_response_code(200);
            } else {
                http_response_code(400);
            }
        } catch(PDOException $e) {
            echo http_response_code(500).json_encode($e->getMessage());
        }
    }
?>