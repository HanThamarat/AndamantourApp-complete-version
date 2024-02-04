<?php
session_status();
require_once("../../../sql/connect.php");
include_once ('../../../includes/domain.php');
$traget = "../pack_img/";
    if(isset($_GET['id'])){
        $pack_id = $_GET['id'];
        if(isset($_POST['save'])){
            $priceCharter = $_POST['priceCharter'];
            $packname = $_POST['packname']; 
            $price = $_POST['Price'];
            $priceKid = $_POST['priceKid'];
            $deteil = $_POST['deteil'];
            $date = date("d-m-Y");
        
            if (!$priceCharter) {
               if(empty($packname)){
                    $_SESSION['error'] = 'Please enter the package name.';
                    header("location:{$domain}Admin/pages/packages/manage_pack.php?id=" . $pack_id);
               }else if(empty($price)){
                    $_SESSION['error'] = 'Please enter the package Audult price.';
                    header("location:{$domain}Admin/pages/packages/manage_pack.php?id=" . $pack_id);
               }else if(empty($deteil)){
                    $_SESSION['error'] = 'Please enter the package deteil.';
                    header("location:{$domain}Admin/pages/packages/manage_pack.php?id=" . $pack_id);
               }else if(empty($priceKid)){
                    $_SESSION['error'] = 'Please enter the package Child.';
                    header("location:{$domain}Admin/pages/packages/manage_pack.php?id=" . $pack_id);
               }else{
                
                try{
                            $up_pk = $conn->prepare("UPDATE packages SET packName = :packName, packPrice = :price, packDeteil = :deteil, update_at = :date, ticketKid = :priceKid WHERE packID = $pack_id");
                            $up_pk->bindParam(':packName', $packname);
                            $up_pk->bindParam(':price', $price);
                            $up_pk->bindParam(':deteil', $deteil);
                            $up_pk->bindParam(':date', $date);
                            $up_pk->bindParam(':priceKid', $priceKid);
                            $up_pk->execute();
    
                            $_SESSION['success'] = "Save package success.";
                            header("location:{$domain}Admin/pages/packages/package.php");
                }catch(PDOException $e){
                    echo $e->getMessage();
                }
               }
            } else {
               if(empty($packname)){
                    $_SESSION['error'] = 'Please enter the package name.';
                    header("location:{$domain}Admin/pages/packages/manage_pack.php?id=" . $pack_id);
               }else if(empty($deteil)){
                    $_SESSION['error'] = 'Please enter the package deteil.';
                    header("location:{$domain}Admin/pages/packages/manage_pack.php?id=" . $pack_id);
               }else if(empty($priceCharter)){
                    $_SESSION['error'] = 'Please enter the package charter.';
                    header("location:{$domain}Admin/pages/packages/manage_pack.php?id=" . $pack_id);
               }else{
                
                try{
                            $up_pk = $conn->prepare("UPDATE packages SET packName = :packName, packDeteil = :deteil, update_at = :date, priceCharter = :Pricecharter WHERE packID = $pack_id");
                            $up_pk->bindParam(':packName', $packname);
                            $up_pk->bindParam(':deteil', $deteil);
                            $up_pk->bindParam(':date', $date);
                            $up_pk->bindParam(':Pricecharter', $priceCharter);
                            $up_pk->execute();
    
                            $_SESSION['success'] = "Save package success.";
                            header("location:{$domain}Admin/pages/packages/package.php");
                }catch(PDOException $e){
                    echo $e->getMessage();
                }
               }
            }
        }else if(isset($_POST['save_image'])){
           try{
                $filename = basename($_FILES["file"]["name"]);
                $new_filename = rand(0, microtime(true)).'-'.$filename;
                $foder = $traget . $new_filename;
                $tragetType = pathinfo($foder, PATHINFO_EXTENSION);

                $allowType = array('jpg', 'png', 'jpeg', 'gif', 'pdf');

                if(in_array($tragetType, $allowType)) {
                    if(move_uploaded_file($_FILES["file"]["tmp_name"], $foder)){
                        $up_img = $conn->prepare("UPDATE packages SET image = :image WHERE packID = $pack_id");
                        $up_img->bindParam(':image', $new_filename);
                        $up_img->execute();

                        $_SESSION['success'] = "Save package success.";
                        header("location:{$domain}Admin/pages/packages/manage_pack.php?id=" . $pack_id);
                    }else{
                        $_SESSION['error'] = "Something went wrong.";
                        header("location:{$domain}Admin/pages/packages/manage_pack.php?id=" . $pack_id);
                    }
                }else{
                    $_SESSION['error'] = "Please enter an image file.";
                    header("location:{$domain}Admin/pages/packages/manage_pack.php?id=" . $pack_id);
                }
           }catch(PDOException $e) {
                echo $e->getMessage();
           }
        } else {
            $_SESSION['error'] = "Something went wrong.";
            header("location:{$domain}Admin/pages/packages/manage_pack.php?id=" . $pack_id);
        }
    }else{
        $_SESSION['error'] = "Something went wrong.";
        header("location:{$domain}Admin/pages/packages/manage_pack.php?id=" . $pack_id);
    }
?>