<?php
      session_start();
      include_once '../../../sql/connect.php';
      include_once '../../../includes/domain.php';

    if(isset($_GET['id'])){
        $id = $_GET['id'];

        try{
            $del_pack = $conn->prepare("DELETE FROM active_status WHERE packID = $id");
            $del_pack->execute();

            header("location: {$domain}Admin/pages/packages/packageConfirm.php");
        }catch(PDOException $e){
            echo $e->getMessage();
        }
    }

?>