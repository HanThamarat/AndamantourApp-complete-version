<?php
    session_start();
    require("../../../sql/connect.php");
    include("../../../includes/domain.php");

    if ($_GET['id']) {
        $agid = $_GET['id'];
        try{
            $dt_ag = $conn->prepare("DELETE FROM agents WHERE agentsID = $agid");
            $dt_ag->execute();
            if($dt_ag){
                http_response_code(200);
            } else {
                http_response_code(400);
            }
        } catch(PDOException $e) {
            echo $e->getMessage();
        }
    } else {
        http_response_code(500);
    }
    

?>