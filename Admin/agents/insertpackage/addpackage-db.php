<?php
session_start();
include_once("../../../sql/connect.php");
include_once '../../../includes/domain.php';
$id = $_GET['id'];
$traget = "pack_img/";

    if(isset($_POST['upload'])){
        $packname = $_POST['packname']; 
        $price = $_POST['Price'];
        $priceCharter = $_POST['priceCharter'];
        $priceKid = $_POST['priceKid'];
        $type = $_POST['Type'];
        $deteil = $_POST['deteil'];
        $location = $_POST['location'];
        $date = date("d-m-Y");
        
       if(!empty($priceCharter)){
            if(empty($packname)){
                $_SESSION['error'] = 'Please enter the package name.';
                header("location: {$domain}Admin/agents/insertpackage/addpackage.php");
            }else if(empty($deteil)){
                    $_SESSION['error'] = 'Please enter the package deteil.';
                    header("location: {$domain}Admin/agents/insertpackage/addpackage.php");
            }else if(empty($type)){
                    $_SESSION['error'] = 'Please enter the package type.';
                    header("location: {$domain}Admin/agents/insertpackage/addpackage.php");    
            }else if(empty($location)) {
                    $_SESSION['error'] = 'Please enter the package location.';
                    header("location: {$domain}Admin/agents/insertpackage/addpackage.php");
            }else if(empty($priceCharter)) {
                    $_SESSION['error'] = 'Please enter the package location.';
                    header("location: {$domain}Admin/agents/insertpackage/addpackage.php");
            } else {
                try{
                        $filename = basename($_FILES["file"]["name"]);
                        $new_filename = rand(0, microtime(true)).'-'.$filename;
                        $foder = $traget . $new_filename;
                        $tragetType = pathinfo($foder, PATHINFO_EXTENSION);

                        $allowType = array('jpg', 'png', 'jpeg', 'gif', 'pdf');

                        if(in_array($tragetType, $allowType)){
                            if(move_uploaded_file($_FILES["file"]["tmp_name"], $foder)){
                                $in_pk = $conn->prepare("INSERT INTO packages(packName, packtypeID, packDeteil, agents_ID, create_at, image, location, priceCharter)
                                VALUES (:packname, :type, :deteil, :id, :date, :image, :location, :priceCharter)");
                                $in_pk->bindParam(':packname', $packname);
                                $in_pk->bindParam(':type', $type);
                                $in_pk->bindParam(':deteil', $deteil);
                                $in_pk->bindParam(':id', $id);
                                $in_pk->bindParam(':date', $date);
                                $in_pk->bindParam(':image', $new_filename);
                                $in_pk->bindParam(':location', $location);
                                $in_pk->bindParam(':priceCharter', $priceCharter);
                                $in_pk->execute();

                                $_SESSION['success'] = 'add new package successfully';
                                header("location: {$domain}Admin/agents/insertpackage/insertpackage.php");
                            }else{
                                $_SESSION['error'] = "Something went wrong.";
                                header("location: {$domain}Admin/agents/insertpackage/addpackage.php");
                            }
                        }else{
                            $_SESSION['error'] = "Please enter an image file.";
                            header("location: {$domain}Admin/agents/insertpackage/addpackage.php");
                        }

                }catch(PDOException $e){
                    echo $e->getMessage();
                }
            }
       } else {
            if(empty($packname)){
                $_SESSION['error'] = 'Please enter the package name.';
                header("location: {$domain}Admin/agents/insertpackage/addpackage.php");
        }else if(empty($price)){
                $_SESSION['error'] = 'Please enter the package Ault price.';
                header("location: {$domain}Admin/agents/insertpackage/addpackage.php");
        }else if(empty($deteil)){
                $_SESSION['error'] = 'Please enter the package deteil.';
                header("location: {$domain}Admin/agents/insertpackage/addpackage.php");
        }else if(empty($priceKid)){
                $_SESSION['error'] = 'Please enter the package Ault Child price.';
                header("location: {$domain}Admin/agents/insertpackage/addpackage.php");
        }else if(empty($type)){
                $_SESSION['error'] = 'Please enter the package type.';
                header("location: {$domain}Admin/agents/insertpackage/addpackage.php");    
        }else if(empty($location)) {
                $_SESSION['error'] = 'Please enter the package location.';
                header("location: {$domain}Admin/agents/insertpackage/addpackage.php");
        } else {
            try{
                    $filename = basename($_FILES["file"]["name"]);
                    $new_filename = rand(0, microtime(true)).'-'.$filename;
                    $foder = $traget . $new_filename;
                    $tragetType = pathinfo($foder, PATHINFO_EXTENSION);

                    $allowType = array('jpg', 'png', 'jpeg', 'gif', 'pdf');

                    if(in_array($tragetType, $allowType)){
                        if(move_uploaded_file($_FILES["file"]["tmp_name"], $foder)){
                            $in_pk = $conn->prepare("INSERT INTO packages(packName, packPrice, packtypeID, packDeteil, agents_ID, create_at, image, ticketKid, location)
                            VALUES (:packname, :price, :type, :deteil, :id, :date, :image, :ticketKid, :location)");
                            $in_pk->bindParam(':packname', $packname);
                            $in_pk->bindParam(':price', $price);
                            $in_pk->bindParam(':type', $type);
                            $in_pk->bindParam(':deteil', $deteil);
                            $in_pk->bindParam(':id', $id);
                            $in_pk->bindParam(':date', $date);
                            $in_pk->bindParam(':image', $new_filename);
                            $in_pk->bindParam(':ticketKid', $priceKid);
                            $in_pk->bindParam(':location', $location);
                            $in_pk->execute();
                                $_SESSION['success'] = 'add new package successfully';
                                header("location: {$domain}Admin/agents/insertpackage/insertpackage.php");
                        }else{
                            $_SESSION['error'] = "Something went wrong.";
                            header("location: {$domain}Admin/agents/insertpackage/addpackage.php");
                        }
                    }else{
                        $_SESSION['error'] = "Please enter an image file.";
                        header("location: {$domain}Admin/agents/insertpackage/addpackage.php");
                    }

            }catch(PDOException $e){
                echo $e->getMessage();
            }
        }
       }
    }
?>