<?php
require("../../../sql/connect.php");
require("../../../includes/domain.php");

if(isset($_GET['id'])) {
    $id = $_GET['id'];

    try{
        $delete_pack = $conn->prepare("DELETE FROM packages WHERE packID = $id");
        $delete_pack->execute();
        if($delete_pack){
           http_response_code(200);
        }else{
           http_response_code(400);
        }
    }catch(PDOException $e){
        http_response_code(500);
        echo $e->getMessage();
    }
}


?>